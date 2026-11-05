<!-- DO NOT EDIT: Generated from /.github/instructions/book-build.instructions.md. Edit /.github/instructions/book-build.instructions.md instead. -->

# Book Build

- Build with `bun run pdf`, `bun run epub`, `bun run web`, or `bun run text`. Outputs go to `dist/`.
- Preview with `bun run dev` (`http://localhost:8000`).
- Without a TeX environment, use `bun run pdf:docker` or set `REVIEW_CONFIG_FILE=config-ebook.yml`.
- See `doc/pdfmaker.ja.md` (or `doc/pdfmaker.md`) for PDF and TeX layout, `doc/customize_epub.ja.md` (or `doc/customize_epub.md`) for EPUB store rules.
- See `doc/writing_vertical.ja.md` (or `doc/writing_vertical.md`) for vertical writing, `doc/makeindex.ja.md` (or `doc/makeindex.md`) for indexes.
