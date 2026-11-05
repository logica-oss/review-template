import { readFile, rm } from "node:fs/promises";
import path from "node:path";

import { $ } from "bun";
import { load } from "js-yaml";

interface BookConfig {
  contentdir?: string | undefined;
}

const ARTICLES_DIR = "articles";
const DIST_DIR = "dist";

const loadBookConfig = async (): Promise<BookConfig> => {
  const raw = await readFile(path.join(ARTICLES_DIR, "config.yml"), "utf8");
  const parsed: unknown = load(raw);
  if (typeof parsed !== "object" || parsed === null || !("contentdir" in parsed)) {
    return {};
  }

  const contentdir: unknown = parsed.contentdir;

  return {
    contentdir: typeof contentdir === "string" ? contentdir : undefined,
  };
};

const runCommand = async (command: string): Promise<void> => {
  await $`${{ raw: command }}`.cwd(ARTICLES_DIR);
};

const preproc = async (contentdir: string): Promise<void> => {
  if (contentdir === "_refiles") {
    console.log("skip preprocess");
    return;
  }

  await runCommand(`bundle exec review-preproc -r --tabwidth=2 ${contentdir}/*.re`);
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
  await preproc(config.contentdir ?? ".");

  await runCommand(command);
};

await main();
