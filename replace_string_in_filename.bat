:: Made by Philip Tønnessen
:: 03.04.2021 - 20.04.2021

@echo off

:: Sets active code page to unicode,
:: allowing the script to deal with special 
:: characters in filenames.
chcp 65001
echo.

Setlocal enabledelayedexpansion

SET /P filetype="Enter the filetype of files to be processed ("srt", "mkv" etc.): "
echo.
SET /P pattern="Enter string to be found in filename: "
echo.
SET /P replace="Enter string to be replaced in filename: "

Set "Pattern=%pattern%"
Set "Replace=%replace%"

For %%a in (*.%filetype%) Do (
    Set "File=%%~a"
    Ren "%%a" "!File:%Pattern%=%Replace%!"
)
