@echo off
rem Compile a MOBI ebook.


rem Get working directory of current batch script.
set cwd=%~dp0
rem Get the root path of the project.
set root=%cwd%

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

rem Compile AsciiDoc source(s) into a MOBI ebook.
asciidoctor-epub3 -a ebook-format=kf8 -o %root%\ebook.mobi %root%\%input%