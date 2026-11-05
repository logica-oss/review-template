# Re:VIEW カタログファイル ガイド

Re:VIEW のカタログファイル catalog.yml について説明します。

## カタログファイルとは

カタログファイルは、Re:VIEW フォーマットで記述された各ファイルを1冊の本（たとえば PDF や EPUB）にまとめる際に、どのようにそれらのファイルを構造化するかを指定するファイルです。  
現在はカタログファイルと言えば catalog.yml のことを指します。

## catalog.yml を用いた場合の設定方法

catalog.yml 内で、`PREDEF`（前付け）、`CHAPS`（本編）、`APPENDIX`（付録、連番あり）、`POSTDEF`（後付け、連番なし）を記述します。  
CHAPS のみ必須です。

```yaml
PREDEF:
  - intro.re

CHAPS:
  - ch01.re
  - ch02.re

APPENDIX:
  - appendix.re

POSTDEF:
  - postscript.re
```

本編に対して、「部」構成を加えたい場合、`CHAPS` を段階的にして記述します。  
部の指定については、タイトル名でもファイル名でもどちらでも使えます。

```yaml
CHAPS:
  - ch01.re
  - 第1部:
      - ch02.re
      - ch03.re
  - pt02.re:
      - ch04.re
```
