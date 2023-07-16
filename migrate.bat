@echo off
rem Migrate the project.


rem Get working directory of current batch script.
set cwd=%~dp0
rem Get the root path of the project.
set root=%cwd%

copy %root%\epub.template.adoc %root%\epub.adoc
copy %root%\pdf.template.adoc %root%\pdf.adoc
copy %root%\print.template.adoc %root%\print.adoc
copy %root%\parameters.template.yml %root%\parameters.yml