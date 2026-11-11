# Chapter Guide

This guide covers the chapter-splitting convention for combining multiple manuscripts into one book. For the catalog syntax itself, see `catalog.md`.

## Location and Format

- Place manuscripts under `articles/chapters/`. One file is one chapter.
- Use the `.re` (Re:VIEW) or `.md` (Markdown) extension.
- In this template, `contentdir: _refiles` in `config.yml` converts `.md` files to Re:VIEW automatically.
- The `= Chapter Title` line at the top of the file becomes the chapter heading.

## catalog.yml Sections

`articles/catalog.yml` decides the output order and sections. The registration order, not the writing order, is the output order.

| Section    | Meaning               | Numbering |
| ---------- | --------------------- | --------- |
| `PREDEF`   | Frontmatter           | None      |
| `CHAPS`    | Bodymatter (required) | Numbered  |
| `APPENDIX` | Appendix              | Numbered  |
| `POSTDEF`  | Backmatter            | None      |

The template default is as follows.

```yaml
PREDEF:
  - 00-preface.re

CHAPS:
  - 01-article.re

APPENDIX:

POSTDEF:
  - 99-afterword.re
```

## Adding a New Chapter

1. Create `articles/chapters/<number>-<name>.re` or `articles/chapters/<number>-<name>.md`.
2. Add the file name to the matching section in `articles/catalog.yml`.
3. Build with `bun run pdf` or similar to verify.

Register `.md` chapters in `catalog.yml` with the `.re` extension.

```yaml
CHAPS:
  - 01-article.re # chapters/01-article.re
  - 02-nanakusa.re # chapters/02-nanakusa.md
```

## Chapter ID

The chapter ID is the chapter file name without its extension. `nanakusa.md` becomes `nanakusa`.

- It is used for image lookup (`images/<chapid>/`). See `images.md` for details.
- It is used for cross-chapter references (`@<img>{nanakusa|fig1}` and similar). See "Figure" in `format.md` for details.

## Parts

Nesting `CHAPS` creates parts. A part name can be either a title or a file name.

```yaml
CHAPS:
  - ch01.re
  - TITLE_OF_PART1:
      - ch02.re
      - ch03.re
```

See `catalog.md` for details.

## Naming Rules

- Use ASCII only for file names and IDs. Avoid Japanese characters and spaces.
- Do not duplicate file names.
- Prefix chapter file names with a two-digit output number (`00-` for frontmatter, `99-` for backmatter by convention). The numbered name becomes the chapter ID used for image lookup and cross-chapter references.
