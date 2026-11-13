---
description: "Use when writing or editing Re:VIEW chapters, sections, or catalog order. Covers chapter files, catalog sections, and chapter IDs."
---

# Chapter Writing

- One file in `articles/chapters/` is one chapter. Use `.re` or `.md`.
- Register chapters in `articles/catalog.yml`. Registration order is output order.
- Prefix chapter files with a two-digit catalog number (`00-preface.re`, `01-article.re`, `99-afterword.re`). Numbers keep filesystem order aligned with output order.
- Register `.md` chapters with the `.re` extension (`02-example.md` → `02-example.re`).
- The chapter ID is the file name without extension. It is used for image lookup and cross-chapter references.
- See `doc/chapters.ja.md` (or `doc/chapters.md`) for placement and naming rules, `doc/catalog.ja.md` (or `doc/catalog.md`) for catalog syntax.
