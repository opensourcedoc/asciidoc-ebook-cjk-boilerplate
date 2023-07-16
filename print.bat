@echo off
rem Compile a PDF ebook for print.


rem Set the input file.
set input=print.adoc
if not exist %input% (
    set input=print.template.adoc
)

rem Check whether AsciiDoctor PDF is available.
where asciidoctor-pdf >nul || (
    echo No AsciiDoctor PDF on the system
    exit /b 1
)

rem Compile AsciiDoc source(s) into a PDF ebook.
asciidoctor-pdf -a pdf-theme=cjk-theme.yml -a pdf-fontsdir=. -o book-print.pdf %input%
