@echo off
:: 设置中文不乱码 utf8
chcp 65001

echo ------------------------------
echo Project:Launch
echo Author:Dong
echo LastTime:20221122
echo ------------------------------

echo ------------------------------
echo 1.1 MaxClientCount(1~9999) 设置最大客户端数量
echo ------------------------------
set /p MaxClientCount=Please Write MaxClientCount(1~9999) And Enter:
echo You Write MaxClientCount: %MaxClientCount%

echo ------------------------------
echo 1.2 ClientStartIndex(1~9999) 设置客户端启动Index
echo ------------------------------
set /p ClientStartIndex=Please Write ClientStartIndex(1~9999) And Enter:
echo You Write ClientStartIndex: %ClientStartIndex%

echo ------------------------------
echo 1.3 CleanOldApp(1清理2不清理) 设置是否需要清理旧的exe
echo ------------------------------
set /p CleanOldApp=Please Write CleanOldApp(1/2) And Enter:
echo You Write CleanOldApp: %CleanOldApp%

echo ------------------------------
echo 1.4 InitVariable 初始化变量
echo ------------------------------
::初始变量
set TargetFilePath=%cd%
set SourceFileName=test
set FileTypeName=.exe
set SourceFileFullName=%SourceFileName%%FileTypeName%
set SourceFilePath=%TargetFilePath%\%SourceFileFullName%

::客户端开始Index
::set ClientStartIndex=100
::客户端数量
set ClientCount=%ClientStartIndex%
::最大客户端数量
::set MaxClientCount=3
::设置最大客户端Index
set /a MaxClientIndex+=%ClientStartIndex%
set /a MaxClientIndex+=%MaxClientCount%
::是否清理旧APP 1清理
::set CleanOldApp=1

::清理原先的exe程序
if %CleanOldApp%==1 (
	echo ------------------------------
	echo 2.0 CleanOldApp - 可跳过 
	echo ------------------------------

	@echo start clean oldapp
	for /r %%i in (*.exe) do (
		echo %%i| findstr %SourceFileFullName% >nul && (
			echo continue %SourceFileFullName%
		) || (
			del %%i
		)
	)
	@echo clean success
)

echo ------------------------------
echo 2.1 CopyClient 复制客户端
echo ------------------------------
::批量复制客户端
@echo start copy
:copyif
set /a ClientCount+=1
if %ClientCount% leq %MaxClientIndex% (
	copy %SourceFilePath% %TargetFilePath%\%SourceFileName%%ClientCount%%FileTypeName%
	goto copyif
)
@echo copy success

echo ------------------------------
echo 2.2 RunClient 启动客户端
echo ------------------------------
::批量启动客户端
@echo start run
:runif
set /a clientstartindex+=1
if %clientstartindex% leq %maxclientindex% (
	start cmd /k %targetfilepath%\%sourcefilename%%clientstartindex%%filetypename%
	goto runif
)
@echo run success

echo ------------------------------
echo 3.0 RunSuccess 启动完成...
echo ------------------------------
pause