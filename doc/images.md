# Image Placement Guide

This guide covers the image placement convention for multi-author books. For the lookup mechanism itself, see "Finding image pathes" in `format.md`.

## Location

Place images under `articles/images/<chapid>/`. Do not place them directly under `images/` to avoid name collisions with other chapters.

```text
articles/images/02-nanakusa/fig1.png   ← for chapters/02-nanakusa.md
```

- `<chapid>` is the chapter file name without its extension. `02-nanakusa.md` becomes `02-nanakusa`.
- Do not write the subdirectory name in references. Re:VIEW finds the chapter-ID directory automatically.

## Separating print and ebook images

To use monochrome images for print and full-color images for ebooks, place the ebook images under `articles/images-ebook/` with the same chapter-ID layout and enable the following line in `articles/config-ebook.yml`.

```yaml
imagedir: images-ebook
```

```text
articles/images/02-nanakusa/fig1.png          ← print (monochrome)
articles/images-ebook/02-nanakusa/fig1.png   ← ebook (full color)
```

## Cover images

For print, do not embed the cover in the PDF. Place the cover source (such as `cover.psd`) under `articles/images/` and submit it as a separate file. For ebooks, embed the front and back covers in the PDF. Enable `imagedir: images-ebook` and the cover example in `articles/config-ebook.yml`, and place `cover.png` and `backcover.png` directly under `articles/images-ebook/`.

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
- Register `.md` chapters in `catalog.yml` with the `.re` extension. Example: `02-nanakusa.md` → `02-nanakusa.re`.

## Supported Extensions

Use `png`, `jpg`, `jpeg`, or `gif` when the image is used in both PDF and EPUB.

- `svg` is for EPUB and Web only. It does not work in PDF (LaTeX).
- For the full list of PDF extensions, see "Finding image pathes" in `format.md`.
- Do not use Japanese characters or spaces in the ID (the first `[〜]` of `//image[〜]`).
