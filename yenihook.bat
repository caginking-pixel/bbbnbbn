@echo off
title RAZE X CORE BOOT SETUP
:: Yönetici yetkisi kontrolü
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [-] Lutfen bu betigi Yonetici olarak calistirin!
    exit /b
)

set DRIVER_NAME=GGWBTW191P
set SOURCE_PATH=%~dp0%DRIVER_NAME%.sys
set TARGET_PATH=%SystemRoot%\System32\drivers\%DRIVER_NAME%.sys

echo [+] Surucu kritik sistem dizinine kopyalaniyor...
copy /Y "%SOURCE_PATH%" "%TARGET_PATH%" >nul

echo [+] Eski servis kayitlari temizleniyor...
sc stop %DRIVER_NAME% >nul 2>&1
sc delete %DRIVER_NAME% >nul 2>&1

echo [+] Surucu BOOT START (0) olarak sisteme kaydediliyor...
:: start= boot parametresi sürücünün Windows logosu gelmeden yuklenmesini saglar
sc create %DRIVER_NAME% binPath= "system32\drivers\%DRIVER_NAME%.sys" type= kernel start= boot
if %errorlevel% neq 0 (
    echo [-] Boot servisi olusturulamadi!
    pause
    exit /b
)

echo.
echo ========================================================
echo [!] RAZE X: BOOT SURUCU BASARIYLA YUKLENDI!
echo [!] Degisikliklerin etkinlesmesi icin PC YENIDEN BASLATILMALIDIR.
echo ========================================================
echo.

:: Kullanıcıya 5 saniye süre ver ve bilgisayarı yeniden başlat
echo [*] Bilgisayar 5 saniye icinde yeniden baslatilacak...
timeout /t 5
shutdown /r /t 0