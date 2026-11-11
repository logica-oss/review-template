# 画像の置き方ガイド

合同誌運用で使う画像配置の約束をまとめます。探索の仕組み自体は `format.ja.md` の「画像ファイルの探索」を参照してください。

## 置き場所

`articles/images/<章ID>/` に置きます。他の章との名前衝突を避けるため、直下には置かないでください。

```text
articles/images/02-nanakusa/fig1.png   ← chapters/02-nanakusa.md 用
```

- `<章ID>` は章ファイル名から拡張子を除いたものです。`02-nanakusa.md` なら `02-nanakusa` です。
- 参照するときはサブディレクトリ名を書きません。Re:VIEW が章IDのディレクトリを自動で探します。

## 印刷版と電子版で画像を分ける

印刷版をモノクロ、電子版をフルカラーにする運用では、`articles/images-ebook/` に電子版用の画像を同じ章ID構成で置き、`articles/config-ebook.yml` で次の行を有効にします。

```yaml
imagedir: images-ebook
```

```text
articles/images/02-nanakusa/fig1.png          ← 印刷版（モノクロ）
articles/images-ebook/02-nanakusa/fig1.png   ← 電子版（フルカラー）
```

## 参照の書き方

Re:VIEW（`.re`）:

```review
//image[fig1][キャプション][scale=0.8]{
//}
```

Markdown（`.md`）:

```markdown
![キャプション](images/fig1.png)
```

- Markdown は [pandoc2review](https://github.com/kmuto/pandoc2review) で Re:VIEW に変換されます。`images/fig1.png` のファイル名から ID `fig1` が作られます。
- `.md` の章も `catalog.yml` には拡張子 `.re` で登録します。例: `02-nanakusa.md` → `02-nanakusa.re`。

## 使える拡張子

PDF と EPUB の両方で使う場合は `png`、`jpg`、`jpeg`、`gif` を使います。

- `svg` は EPUB・Web 用です。PDF（LaTeX）では使えません。
- PDF で使える拡張子の全体は `format.ja.md` の「画像ファイルの探索」を参照してください。
- ID（`//image[〜]` の最初の `[〜]`）には日本語や空白を使わないでください。
