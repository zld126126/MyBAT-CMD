@echo off
:: 设置中文不乱码 utf8
chcp 65001

@echo ------------------------------
@echo Project:Zip
@echo Author:Dong
@echo LastTime:20221122
@echo ------------------------------

@set /p ZipPathName=Please Write ZipPathName(test):
@echo You Write ZipPathName %ZipPathName%

@echo ------------------------------
@echo 1.0 init variant
@echo ------------------------------
set "ZipFileName=%ZipPathName%"
set "ZipFileFullName=%ZipFileName%.zip"
set "ZipFileFullPath=%cd%\%ZipFileFullName%"
set ZipTemp=temp

@echo ------------------------------
@echo 1.1 clean temp
@echo ------------------------------
@echo %ZipFileFullPath%
if exist "%ZipFileFullPath%" (
	del %ZipFileFullPath%
    echo.delete success %ZipFileFullPath%
) else (
	echo.not found %ZipFileFullPath%
)

set "TempPath=%cd%\%ZipPathName%%ZipTemp%"
@echo %TempPath%
if exist %TempPath% ( 
	del %TempPath%
    echo delete success %TempPath%
) else (
    echo not found %TempPath%
)

@echo ------------------------------
@echo 2.0 zip
@echo ------------------------------
zip.exe -r %ZipFileFullPath% %ZipPathName%

@echo ------------------------------
@echo 2.1 unzip
@echo ------------------------------
unzip.exe -d %TempPath% %ZipFileFullName%

@echo ------------------------------
@echo 3.0 zip/unzip success
@echo ------------------------------
pause