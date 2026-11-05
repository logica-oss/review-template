---
description: "Use when editing book settings, paper size, ebook config, or locale strings. Covers config.yml, config-ebook.yml, and locale.yml."
---

# Book Config

- Book settings live in `articles/config.yml`. Ebook overrides live in `articles/config-ebook.yml`. Display strings live in `articles/locale.yml`.
- Keep `bookname` ASCII-only with no spaces or Japanese characters.
- Do not delete YAML comments or unused options. Change values only.
- Paper size and print/ebook media are set by `texdocumentclass`. See `README.md` for A5/B5 and print/ebook combinations.
- For new books, follow the `book-setup` skill to ask each item one by one.
