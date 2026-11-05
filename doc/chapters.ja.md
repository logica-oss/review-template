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
  - preface.re

CHAPS:
  - article.re

APPENDIX:

POSTDEF:
  - afterword.re
```

## 新しい章の追加手順

1. `articles/chapters/<名前>.re` か `articles/chapters/<名前>.md` を作ります。
2. `articles/catalog.yml` の該当区分にファイル名を追記します。
3. `bun run pdf` などでビルドして確認します。

`.md` の場合も `catalog.yml` には拡張子 `.re` で登録します。

```yaml
CHAPS:
  - article.re # chapters/article.re
  - nanakusa.re # chapters/nanakusa.md
```

## 章ID

章IDは章ファイル名から拡張子を除いたものです。`nanakusa.md` なら `nanakusa` です。

- 画像の探索（`images/<章ID>/`）に使います。詳しくは `images.ja.md` を参照してください。
- 他章の図表参照（`@<img>{nanakusa|fig1}` など）に使います。詳しくは `format.ja.md` の「図」を参照してください。

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
