# Re:VIEW Template

Re:VIEW用の書籍テンプレート

## 必要な環境

- Bun
- Ruby / Bundler（`Gemfile`参照）
- PDFをビルドする場合はTeX環境、またはDocker / Dev Container

TeXの導入をしない場合でもEPUB・Web・テキストの出力は可能です。

## ビルド

```sh
bun install
bundle install
bun run pdf
```

成果物は`dist/`に出力されます。

```sh
bun run pdf
bun run epub
bun run web
bun run text
```

## 開発用プレビュー

`articles/` の変更を監視して `web` を再ビルドし、Vite で配信します。

```sh
bun run dev
```

`http://localhost:8000` で確認できます。ポート変更は `PORT=3000 bun run dev` です。

### 設定

- 原稿は`articles/chapters/`
- 章立ては`articles/catalog.yml`
- 書誌・紙面設定は`articles/config.yml`

### 校正

文章のLintにはtextlintを用意しています。

```sh
bun run lint
```

文章の執筆・推敲には、Skillsも利用できます。  
依存関係をインストールした後に次を実行すると、外部配布のskillsを`.agents/skills/`に同期できます。

```sh
bun run skills:sync
```

## Dockerを使う

セットアップ済みのDockerイメージを使ったビルドも可能です。

```sh
bun run pdf:docker
```

電子版は次のようにします。

```sh
REVIEW_CONFIG_FILE=config-ebook.yml bun run pdf:docker
```

## 紙面や設定ファイルの切り替え

B5やA5といった紙面サイズ、印刷用・電子用といったメディアの切り替えは、`articles/config.yml`の`texdocumentclass`パラメータで設定しています。

```yaml
# A5の設定(9pt 38文字×37行) - 紙版
texdocumentclass:
  [
    "review-jsbook",
    "media=print,paper=a5,serial_pagination=true,hiddenfolio=nikko-pc,openany,fontsize=9pt,baselineskip=13pt,line_length=38zw,number_of_lines=37,head_space=15mm,headsep=3mm,headheight=5mm,footskip=10mm",
  ]
# A5の設定(9pt 38文字×37行) - 電子版
# texdocumentclass: ["review-jsbook", "media=ebook,paper=a5,serial_pagination=true,openany,fontsize=9pt,baselineskip=13pt,line_length=38zw,number_of_lines=37,head_space=15mm,headsep=3mm,headheight=5mm,footskip=10mm"]
# B5の設定(10pt 40文字×35行) - 紙版
# texdocumentclass: ["review-jsbook", "media=print,paper=b5,serial_pagination=true,hiddenfolio=nikko-pc,openany,fontsize=10pt,baselineskip=15.4pt,line_length=40zw,number_of_lines=35,head_space=30mm,headsep=10mm,headheight=5mm,footskip=10mm"]
# B5の設定(10pt 40文字×35行) - 電子版
# texdocumentclass: ["review-jsbook", "media=ebook,paper=b5,serial_pagination=true,openany,fontsize=10pt,baselineskip=15.4pt,line_length=40zw,number_of_lines=35,head_space=30mm,headsep=10mm,headheight=5mm,footskip=10mm"]
```

デフォルトはA5・印刷用です。  
B5・印刷用にしたい場合はA5のパラメータをコメントアウトし、B5のほうを有効にします。

印刷用と電子用の両方を作りたいときには、設定ファイルの継承機能を利用できます。  
A5電子版の設定例を`articles/config-ebook.yml`として用意しています。

```sh
REVIEW_CONFIG_FILE=config-ebook.yml bun run pdf
```

紙版と電子版では以下のような違いがあります。

- 紙版
  - 印刷用に、トンボ、デジタルトンボを設置
  - いくつかの同人誌印刷所で要求事項となっているノドへの隠しノンブル、大扉からのアラビア数字通し
  - ハイパーリンクは無効化
  - 表紙（cover）は無視
- 電子版
  - 電子配布用に、仕上がり紙面サイズ
  - 大扉からのアラビア数字通し
  - ハイパーリンク有効
  - 表紙（cover）は中央合わせで配置

## 権利

ライセンスは`LICENSE`、由来・第三者ファイルの注記は`NOTICE.md`を参照してください。
