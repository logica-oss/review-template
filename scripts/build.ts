import { readFile, rm } from "node:fs/promises";
import path from "node:path";

import { $ } from "bun";
import { load } from "js-yaml";

interface BookConfig {
  bookName?: string | undefined;
  contentDir?: string | undefined;
}

const ARTICLES_DIR = "articles";
const DIST_DIR = "dist";

const isRecord = (value: unknown): value is Record<string, unknown> =>
  typeof value === "object" && value !== null && !Array.isArray(value);

const loadRawConfig = async (configFile: string): Promise<Record<string, unknown>> => {
  const raw = await readFile(path.join(ARTICLES_DIR, configFile), "utf8");

  const parsed: unknown = load(raw);
  if (!isRecord(parsed)) {
    return {};
  }
  const record: Record<string, unknown> = { ...parsed };

  const inherit: unknown = record["inherit"];
  if (!Array.isArray(inherit)) {
    delete record["inherit"];
    return record;
  }

  const parents = inherit.filter(
    (parent): parent is string => typeof parent === "string" && parent.trim() !== "",
  );
  const resolved = await Promise.all(parents.map((parent) => loadRawConfig(parent.trim())));
  const merged: Record<string, unknown> = {};
  for (const item of resolved) {
    Object.assign(merged, item);
  }

  delete record["inherit"];
  return { ...merged, ...record };
};

const loadBookConfig = async (): Promise<BookConfig> => {
  const configFile = process.env["REVIEW_CONFIG_FILE"] ?? "config.yml";
  const record = await loadRawConfig(configFile);

  const bookname: unknown = record["bookname"];
  const contentdir: unknown = record["contentdir"];

  return {
    bookName: typeof bookname === "string" && bookname.trim() !== "" ? bookname : undefined,
    contentDir: typeof contentdir === "string" ? contentdir : undefined,
  };
};

const runCommand = async (command: string): Promise<void> => {
  await $`${{ raw: command }}`.cwd(ARTICLES_DIR).env(process.env);
};

const preProc = async (contentDir: string): Promise<void> => {
  if (contentDir === "_refiles") {
    console.log("skip preprocess");
    return;
  }

  await runCommand(`bundle exec review-preproc -r --tabwidth=2 ${contentDir}/*.re`);
};

const main = async (): Promise<void> => {
  const command = process.argv.slice(2).join(" ");
  if (command.length === 0) {
    console.error("No command specified");
    console.error('Example: bun scripts/build.ts "bundle exec rake pdf"');
    process.exitCode = 1;
    return;
  }

  const config = await loadBookConfig();
  await rm(DIST_DIR, { recursive: true, force: true });
  await preProc(config.contentDir ?? ".");

  if (config.bookName !== undefined) {
    process.env["REVIEW_BOOK"] = config.bookName;
  }
  await runCommand(command);
};

await main();
