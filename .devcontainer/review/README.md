# Re:VIEW Feature (local)

`vvakame/review:5.9` (`vvakame/docker-review` `review-5.9/Dockerfile`) 相当の執筆環境を、devcontainer系イメージ上に再現するためのローカルFeature。

## 内容

- 日本語TeXLive一式 (`texlive-lang-japanese` 他、`kanji-config-updmap-sys haranoaji`)
- `mecab`, `pandoc`, `plantuml`, `ghostscript`, `poppler`
- `bundler` のみグローバル導入。`review`・`rake`・`pandoc2review`・`playwright-runner` 等は `Gemfile` が正本 (`bun install` → `prepare` → `bundle install` で導入)
- 任意: Noto CJK/emoji + Playwright (Chromium) + ブラウザ依存ライブラリ

## 使い方

`.devcontainer/devcontainer.json` から相対参照する:

```json
{
  "features": {
    "./review": {}
  }
}
```

Re:VIEWのgemバージョンは `Gemfile` が正 (`bundle install` で導入)。
Feature側ではバージョンを指定せず、システム依存のみを導入する。

`installsAfter` で `bun` の後に実行されるため、Playwrightの `bun install -g playwright` が利用可能。
