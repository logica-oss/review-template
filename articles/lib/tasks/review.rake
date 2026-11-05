# Copyright (c) 2006-2021 Minero Aoki, Kenshi Muto, Masayoshi Takahashi, Masanori Kado.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'fileutils'
require 'rake/clean'

BOOK = ENV['REVIEW_BOOK'] || 'ReVIEW-Template'
BOOK_PDF = BOOK + '.pdf'
BOOK_EPUB = BOOK + '.epub'
CONFIG_FILE = ENV['REVIEW_CONFIG_FILE'] || 'config.yml'
CATALOG_FILE = ENV['REVIEW_CATALOG_FILE'] || 'catalog.yml'
WEBROOT = ENV['REVIEW_WEBROOT'] || 'webroot'
TEXTROOT = BOOK + '-text'
IDGXMLROOT = BOOK + '-idgxml'
# Final artifacts live under dist/ (repo root). Builders still emit into
# articles/ first, then each file task moves the result to DISTDIR.
DISTDIR = ENV['REVIEW_DISTDIR'] || '../dist'
BOOK_PDF_OUT = File.join(DISTDIR, BOOK_PDF)
BOOK_EPUB_OUT = File.join(DISTDIR, BOOK_EPUB)
WEBROOT_OUT = File.join(DISTDIR, WEBROOT)
TEXTROOT_OUT = File.join(DISTDIR, TEXTROOT)
IDGXMLROOT_OUT = File.join(DISTDIR, IDGXMLROOT)
PDF_OPTIONS = ENV['REVIEW_PDF_OPTIONS'] || ''
EPUB_OPTIONS = ENV['REVIEW_EPUB_OPTIONS'] || ''
WEB_OPTIONS = ENV['REVIEW_WEB_OPTIONS'] || ''
IDGXML_OPTIONS = ENV['REVIEW_IDGXML_OPTIONS'] || ''
TEXT_OPTIONS = ENV['REVIEW_TEXT_OPTIONS'] || ''

REVIEW_VSCLI = ENV['REVIEW_VSCLI'] || 'vivliostyle'
REVIEW_VSCLI_USESANDBOX = ENV['REVIEW_VSCLI_USESANDBOX'] ? '' : '--no-sandbox'
REVIEW_VSCLI_PDF = ENV['REVIEW_VSCLI_PDF'] || BOOK_PDF_OUT
REVIEW_VSCLI_OPTIONS = ENV['REVIEW_VSCLI_OPTIONS'] || ''

task default: :pdf

desc 'preproc all'
task :preproc do
  Dir.glob('*.re').each do |file|
    sh "review-preproc --replace #{file}"
  end
end

desc 'generate PDF and EPUB file'
task all: %i[pdf epub]

desc 'generate PDF file'
task pdf: BOOK_PDF_OUT

desc 'generate static HTML file for web'
task web: WEBROOT_OUT

desc 'generate text file (without decoration)'
task plaintext: TEXTROOT_OUT do
  sh "review-textmaker #{TEXT_OPTIONS} -n #{CONFIG_FILE}"
  FileUtils.mkdir_p(DISTDIR)
  FileUtils.rm_rf([TEXTROOT_OUT])
  FileUtils.mv(TEXTROOT, TEXTROOT_OUT, force: true)
end

desc 'generate (decorated) text file'
task text: TEXTROOT_OUT do
  sh "review-textmaker #{TEXT_OPTIONS} #{CONFIG_FILE}"
  FileUtils.mkdir_p(DISTDIR)
  FileUtils.rm_rf([TEXTROOT_OUT])
  FileUtils.mv(TEXTROOT, TEXTROOT_OUT, force: true)
end

desc 'generate IDGXML file'
task idgxml: IDGXMLROOT_OUT do
  sh "review-idgxmlmaker #{IDGXML_OPTIONS} #{CONFIG_FILE}"
  FileUtils.mkdir_p(DISTDIR)
  FileUtils.rm_rf([IDGXMLROOT_OUT])
  FileUtils.mv(IDGXMLROOT, IDGXMLROOT_OUT, force: true)
end

desc 'generate EPUB file'
task epub: BOOK_EPUB_OUT

IMAGES = FileList['images/**/*']
OTHERS = ENV['REVIEW_DEPS'] || []
SRC = FileList['./**/*.re', '*.rb'] + [CONFIG_FILE, CATALOG_FILE] + IMAGES + FileList[OTHERS]
SRC_EPUB = FileList['*.css']
SRC_PDF = FileList['layouts/*.erb', 'sty/**/*.sty']

file BOOK_PDF_OUT => SRC + SRC_PDF do
  sh "review-pdfmaker #{PDF_OPTIONS} #{CONFIG_FILE}"
  FileUtils.mkdir_p(DISTDIR)
  FileUtils.mv(BOOK_PDF, BOOK_PDF_OUT, force: true)
end

file BOOK_EPUB_OUT => SRC + SRC_EPUB do
  sh "review-epubmaker #{EPUB_OPTIONS} #{CONFIG_FILE}"
  FileUtils.mkdir_p(DISTDIR)
  FileUtils.mv(BOOK_EPUB, BOOK_EPUB_OUT, force: true)
end

file WEBROOT_OUT => SRC do
  sh "review-webmaker #{WEB_OPTIONS} #{CONFIG_FILE}"
  FileUtils.mkdir_p(DISTDIR)
  FileUtils.rm_rf([WEBROOT_OUT])
  FileUtils.mv(WEBROOT, WEBROOT_OUT, force: true)
end

file TEXTROOT_OUT => SRC do
  FileUtils.rm_rf([TEXTROOT, TEXTROOT_OUT])
end

file IDGXMLROOT_OUT => SRC do
  FileUtils.rm_rf([IDGXMLROOT, IDGXMLROOT_OUT])
end

desc 'preview with vivliostyle'
task 'vivliostyle:preview': BOOK_EPUB_OUT do
  sh "#{REVIEW_VSCLI} preview #{REVIEW_VSCLI_USESANDBOX} #{REVIEW_VSCLI_OPTIONS} #{BOOK_EPUB_OUT}"
end

desc 'build with vivliostyle'
task 'vivliostyle:build': BOOK_EPUB_OUT do
  sh "#{REVIEW_VSCLI} build #{REVIEW_VSCLI_USESANDBOX} #{REVIEW_VSCLI_OPTIONS} -o #{REVIEW_VSCLI_PDF} #{BOOK_EPUB_OUT}"
end

desc 'build with vivliostyle'
task vivliostyle: 'vivliostyle:build'

CLEAN.include([BOOK_PDF, BOOK_EPUB, BOOK + '-pdf', BOOK + '-epub', WEBROOT, 'images/_review_math', 'images/_review_math_text', TEXTROOT, IDGXMLROOT, DISTDIR])
