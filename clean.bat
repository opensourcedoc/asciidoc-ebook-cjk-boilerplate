@echo off


rem Get working directory of current batch script.
set cwd=%~dp0
rem Get the root path of the project.
set root=%cwd%

rem Clean all ebook(s).
del /Q /F %root%\*.epub %root%\*.mobi %root%\*.pdf
