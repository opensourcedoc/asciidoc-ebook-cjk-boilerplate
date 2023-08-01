@echo off
rem Compile an EPUB ebook.


rem Get working directory of current batch script.
set cwd=%~dp0
rem Get the root path of the project.
set root=%cwd%

rem Set the input file.
set input=epub.adoc
if not exist %root%\%input% (
    set input=epub.template.adoc
)

rem Check whether AsciiDoctor EPUB is available.
where asciidoctor-epub3 >nul || (
    echo No AsciiDoctor EPUB on the system
    exit /b 1
)

rem Compile AsciiDoc source(s) into a EPUB ebook.
asciidoctor-epub3 -o %root%\book.epub %root%\%input%