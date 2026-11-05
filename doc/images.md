# Image Placement Guide

This guide covers the image placement convention for multi-author books. For the lookup mechanism itself, see "Finding image pathes" in `format.md`.

## Location

Place images under `articles/images/<chapid>/`. Do not place them directly under `images/` to avoid name collisions with other chapters.

```text
articles/images/nanakusa/fig1.png   ← for chapters/nanakusa.md
```

- `<chapid>` is the chapter file name without its extension. `nanakusa.md` becomes `nanakusa`.
- Do not write the subdirectory name in references. Re:VIEW finds the chapter-ID directory automatically.

## How to Reference

Re:VIEW (`.re`):

```review
//image[fig1][Caption][scale=0.8]{
//}
```

Markdown (`.md`):

```markdown
![Caption](images/fig1.png)
```

- Markdown files are converted to Re:VIEW by [pandoc2review](https://github.com/kmuto/pandoc2review). The file name `images/fig1.png` becomes the ID `fig1`.
- Register `.md` chapters in `catalog.yml` with the `.re` extension. Example: `nanakusa.md` → `nanakusa.re`.

## Supported Extensions

Use `png`, `jpg`, `jpeg`, or `gif` when the image is used in both PDF and EPUB.

- `svg` is for EPUB and Web only. It does not work in PDF (LaTeX).
- For the full list of PDF extensions, see "Finding image pathes" in `format.md`.
- Do not use Japanese characters or spaces in the ID (the first `[〜]` of `//image[〜]`).
