:: Made by Philip Tønnessen
:: 20.04.2021 - 16.06.2022

@echo off

:: Sets active code page to unicode,
:: allowing the script to deal with special 
:: characters in filenames.
chcp 65001
echo.

SET /P filetype="Enter the filetype of files to be processed ("srt", "mkv" etc.): "
echo.
SET /P prefix="Enter the desired file prefix: "

IF NOT EXIST processed mkdir processed
Setlocal enabledelayedexpansion

:prefix_position
echo. 
echo Prefix positions:
echo (1) Left of filename
echo (2) Right of filename
echo. 
SET /P pos_q="Enter the desired position: "
IF "%pos_q%" == "1" (
SET active=prefix_to_left
goto prefix_to_left
) ELSE IF "%pos_q%" == "2" (
SET active=prefix_to_right
goto prefix_to_right
) ELSE (
echo.
echo Error: Invalid input
goto prefix_position)

:prefix_to_left
FOR /F "tokens=*" %%G IN ('dir /b *.%filetype%') DO Ren "%%G" "%prefix%%%G" && DEL /F "%%G" && move "%prefix%%%G" processed

:prefix_to_right
FOR /F "tokens=*" %%G IN ('dir /b *.%filetype%') DO Ren "%%G" "%%~nG%prefix%.%filetype%" && DEL /F "%%G" && move "%%~nG%prefix%.%filetype%" processed

:moveback
FOR /F "tokens=*" %%G IN ('dir /b processed\*.%filetype%') DO move "processed\%%G" "%cd%"
rmdir /s /q "processed" && exit