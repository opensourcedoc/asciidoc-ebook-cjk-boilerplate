@echo off


rem Get working directory of current batch script.
set cwd=%~dp0
rem Get the root path of the project.
set root=%cwd%

rem Restore the project to its original state.
del /Q /F %root%\epub.adoc %root%\pdf.adoc %root%\print.adoc %root%\parameters.yml
del /Q /F %root%\*.epub %root%\*.mobi %root%\*.pdf
