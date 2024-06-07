@echo off
cls

echo.
echo  [DISCS_POOPER]

IF NOT EXIST "*.VCD" (
goto no_VCD
) 
 
echo.
echo  Challenge accepted !
echo.
dir /b /o:n "*.VCD"> temp1.txt

setlocal DisableDelayedExpansion
set "firstLineReady="
(
    for /F "eol=$ delims=" %%a in (temp1.txt) DO (
        if defined firstLineReady (echo()
        set "firstLineReady=1"
        <nul set /p "=%%a"
    )
) > DISCS.TXT

dir /b /o:n "*.VCD"> temp2.txt

findstr /n /r . temp2.txt | findstr /b "1">> temp3.txt
for /f "tokens=2 delims=:" %%c in (temp3.txt) do echo "%%~nc">>temp4.txt

setlocal DisableDelayedExpansion
set "firstLineReady="
(
    for /F "eol=$ delims=" %%a in (temp4.txt) DO (
        if defined firstLineReady (echo()
        set "firstLineReady=1"
        <nul set /p "=%%a"
    )
) > VMCDIR.TXT

for %%d in ("*.VCD") do (
	if not exist "%%~nd" mkdir "%%~nd"
	copy /Y DISCS.TXT "%%~nd"
	copy /Y VMCDIR.TXT "%%~nd"
)

del temp1.txt
del temp2.txt
del temp3.txt
del temp4.txt
del DISCS.TXT
del VMCDIR.TXT

echo.
echo  Challenge completed !
pause>NUL
exit

:no_VCD
color 0C
echo.
echo  No VCD files found in this folder. Challenge cancelled :[
pause>NUL 
exit



