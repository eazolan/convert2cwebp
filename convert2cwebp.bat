:: Converts every .jpg and .png in a folder this is run in, and subfolders to .cwebp
:: If it fails to convert an image, it moves that image into the \err directory
:: After successfully converting an image, it deletes the original source image.
:: After it's finished, it prints a total. 

@echo off
setlocal enabledelayedexpansion

set count=0
set err_folder="%~dp0err"

if not exist %err_folder% (
  mkdir %err_folder%
)

for /R %%f in (*.jpg, *.png) do (
    cwebp.exe -q 90 -m 6 "%%f" -o "%%~dpnf.webp"
    if errorlevel 1 (
        echo Conversion of "%%f" failed. Moving to error folder.
        move "%%f" "%err_folder%"
    ) else (
        del "%%f"
        set /a count+=1
    )
)

echo Converted and deleted !count! files.