# 章分けガイド

複数の原稿ファイルを1冊にまとめる章分けの約束をまとめます。カタログの書式自体は `catalog.ja.md` を参照してください。

## 置き場所と形式

- 原稿は `articles/chapters/` に置きます。1ファイルが1章です。
- 拡張子は `.re`（Re:VIEW）か `.md`（Markdown）です。
- このテンプレートでは `config.yml` の `contentdir: _refiles` により、`.md` は自動で Re:VIEW に変換されます。
- ファイル先頭の `= 章タイトル` が章見出しになります。

## catalog.yml の区分

`articles/catalog.yml` で出力順と区分を決めます。書いた順ではなく、登録順が出力順です。

| 区分       | 意味         | 採番 |
| ---------- | ------------ | ---- |
| `PREDEF`   | 前付け       | なし |
| `CHAPS`    | 本編（必須） | あり |
| `APPENDIX` | 付録         | あり |
| `POSTDEF`  | 後付け       | なし |

テンプレートの初期値は次のとおりです。

```yaml
PREDEF:
  - 00-preface.re

CHAPS:
  - 01-article.re

APPENDIX:

POSTDEF:
  - 99-afterword.re
```

## 新しい章の追加手順

1. `articles/chapters/<番号>-<名前>.re` か `articles/chapters/<番号>-<名前>.md` を作ります。
2. `articles/catalog.yml` の該当区分にファイル名を追記します。
3. `bun run pdf` などでビルドして確認します。

`.md` の場合も `catalog.yml` には拡張子 `.re` で登録します。

```yaml
CHAPS:
  - 01-article.re # chapters/01-article.re
  - 02-example.re # chapters/02-example.md
```

## 章ID

章IDは章ファイル名から拡張子を除いたものです。`02-example.md` なら `02-example` です。

- 画像の探索（`images/<章ID>/`）に使います。詳しくは `images.ja.md` を参照してください。
- 他章の図表参照（`@<img>{02-example|fig1}` など）に使います。詳しくは `format.ja.md` の「図」を参照してください。

## 部構成

`CHAPS` を入れ子にすると部が作れます。部名はタイトル名でもファイル名でもかまいません。

```yaml
CHAPS:
  - ch01.re
  - 第1部:
      - ch02.re
      - ch03.re
```

詳しくは `catalog.ja.md` を参照してください。

## 名付けの約束

- ファイル名とIDには ASCII のみを使います。日本語や空白は避けてください。
- ファイル名は重複させないでください。
- 章ファイル名の先頭には出力順を示す2桁番号を付けます（`00-` は前付け、`99-` は後付けの慣例）。番号付きの名前がそのまま章IDになり、画像探索や他章参照に使われます。
