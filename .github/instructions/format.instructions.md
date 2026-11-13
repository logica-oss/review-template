---
description: "Use when writing Re:VIEW markup, figures, tables, lists, or inline commands. Covers format syntax and image placement."
---

# Re:VIEW Format

- Write Re:VIEW syntax per `doc/format.ja.md` (or `doc/format.md`).
- Place images under `articles/images/<chapid>/`, never directly under `images/`. Do not write the subdirectory name in references.
- To separate print and ebook images, mirror the layout under `articles/images-ebook/` and set `imagedir: images-ebook` in `articles/config-ebook.yml`.
- For print, keep covers out of the PDF and submit the cover source separately. For ebooks, place `cover.png` and `backcover.png` directly under `articles/images-ebook/`.
- For Markdown chapters, write `![Caption](images/fig1.png)`. The file name becomes the image ID.
- Use `png`, `jpg`, `jpeg`, or `gif` for both PDF and EPUB. `svg` is EPUB and Web only.
- See `doc/images.ja.md` (or `doc/images.md`) for placement rules, `doc/format.ja.md` (or `doc/format.md`) for lookup order and extensions.
