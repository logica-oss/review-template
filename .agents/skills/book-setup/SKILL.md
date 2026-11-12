---
name: book-setup
description: "Re:VIEW本の執筆開始時の初期設定をする。Use when starting a new book, initializing config.yml, catalog.yml, locale.yml, config-ebook.yml before writing chapters."
---

# Book Setup

本の執筆開始前に、記事本文以外の初期設定を対話で決めてファイルに反映する。

## When to Use

- 新しい本を書き始めるとき
- `articles/config.yml`、`articles/catalog.yml`、`articles/locale.yml`、`articles/config-ebook.yml` の初期値を決めたいとき

## Procedure

1. まず4ファイルを読み込む: `articles/config.yml`、`articles/catalog.yml`、`articles/locale.yml`、`articles/config-ebook.yml`。
2. 下記の質問を上から順に1つずつ聞く。一度に複数聞かない。各回答を受けたら対象ファイルに即時反映してから次に進む。
3. 質問時は現在の設定値を選択肢またはデフォルトとして示す。回答が空・スキップの場合は既存値を維持する。
4. 全回答後に変更差分を要約して報告する。ビルドやLintは実行しない。

## Questions

順序固定。各項目は `対象ファイル: フィールド` に対応する。

1. `config.yml: bookname` — ファイル名になる書籍ID。ASCIIのみ。例: `"my-book"`。
2. `config.yml: booktitle` — `name` (書名) と `file-as` (読み) を聞く。例: `name: "はじめてのRe:VIEW"`。
3. `config.yml: aut` — 著者名と読み。複数可。例: `[{ name: "山田太郎", file-as: "やまだたろう" }]`。
4. `config.yml: edt / pbl` — 編集者と出版社・発行所。不要なら空のままにする。テンプレート値 (`mhidaka` / `TechBooster`) を維持するか確認する。
5. `config.yml: rights` — 権利表記。例: `"(C) 2026 山田太郎"`。
6. `config.yml: date / history` — 刊行日 (`YYYY-M-D`) と版履歴の配列。例: `[["2026-6-1 初版第1刷"]]`。
7. `config.yml: urnid / isbn` — 固有ID。ISBNがある場合のみ `isbn` を設定し、なければ `urnid` を書籍URLまたは既定値にする。
8. `config.yml + config-ebook.yml: texdocumentclass` — 紙面設定。`A5・紙版` / `A5・電子版` / `B5・紙版` / `B5・電子版` から選ばせる。`config.yml` 側は `media=print`、`config-ebook.yml` 側は `media=ebook` の対応する定義を有効化する。
9. `config-ebook.yml: bookname` — 電子版を別ファイル名にする場合のみ設定。不要なら継承のままにする。
10. `config-ebook.yml: coverimage / backcoverimage` — 電子版PDFに表紙・裏表紙を組み込む場合のみ設定（テンプレート独自拡張。`techbooster` 節と `config-local.tex.erb` が解決する）。印刷版は表紙を組み込まず、表紙源（`cover.psd` など）を別ファイルで入稿する。
11. `catalog.yml: PREDEF / CHAPS / APPENDIX / POSTDEF` — 章立て。`articles/chapters/` の `.re` ファイル名を配列で聞く。初期値は `00-preface.re`、`01-article.re`、`99-afterword.re`。
12. `locale.yml: column_head / columnname / memo_head / image / table / list` — 表記名。変更が必要な項目のみ上書きし、他は既定値のままにする。
13. `config.yml: toc / titlepage / colophon` — 目次・大扉・奥付の有無。既定値 (`true`) でよいか最終確認する。

## Rules

- `bookname` に日本語や空白を入れない。
- YAMLのコメントや未使用の選択肢は削除しない。値の変更のみ行う。
- `file-as` (読み) はひらがな・カタカナで書く。
- 章ファイル名は `articles/chapters/` に実在する `.re` ファイルと一致させる。新規章が必要な場合はファイル作成はせず、設定値のみ記録して報告に含める。
