@echo off
:: Admin yetkisi kontrolü
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Bu script yönetici izni gerektiriyor...
    exit /b
)

setlocal
set "SCRIPT_DIR=%~dp0"
set "system32Dir=C:\Windows\System32"

:: Eski sürücüyü temizle (Gerekirse)
sc stop ca2 >nul 2>&1
sc delete ca2 >nul 2>&1

:: Dosyaları System32'ye kopyala
copy /y "%SCRIPT_DIR%drvcore.sys" "%system32Dir%\" >nul 2>&1
copy /y "%SCRIPT_DIR%netshim.sys" "%system32Dir%\" >nul 2>&1
copy /y "%SCRIPT_DIR%winverred.sys" "%system32Dir%\" >nul 2>&1

:: Yeni sürücüleri servis olarak kaydet
:: Not: Her birini ayrı servis olarak veya tek bir yapılandırmada kullanabilirsin.
:: Aşağıdaki örnek drvcore üzerinden kaydedilmiştir.
sc create ca2 binPath= "%system32Dir%\drvcore.sys" DisplayName= "Raze X System Core" start= boot type= kernel >nul 2>&1

:: Servisi başlat
sc start ca2 >nul 2>&1

exit