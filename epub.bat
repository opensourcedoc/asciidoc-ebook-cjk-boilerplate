@echo off
rem Compile an EPUB ebook.


rem Set the input file.
set input=epub.adoc
if not exist %input% (
    set input=epub.template.adoc
)

rem Check whether AsciiDoctor EPUB is available.
where asciidoctor-epub3 >nul || (
    echo No AsciiDoctor EPUB on the system
    exit /b 1
)

rem Compile AsciiDoc source(s) into a EPUB ebook.
asciidoctor-epub3 -o book.epub %input%