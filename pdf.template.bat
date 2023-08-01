@echo off
rem Compile a PDF ebook.


rem Get working directory of current batch script.
set cwd=%~dp0
rem Get the root path of the project.
set root=%cwd%

rem Set the input file.
set input=pdf.adoc
if not exist %root%\%input% (
    set input=pdf.template.adoc
)

rem Check whether AsciiDoctor PDF is available.
where asciidoctor-pdf >nul || (
    echo No AsciiDoctor PDF on the system
    exit /b 1
)

rem Compile AsciiDoc source(s) into a PDF ebook.
asciidoctor-pdf -a pdf-theme=cjk-theme.yml -a pdf-fontsdir=. -o %root%\book.pdf %root%\%input%