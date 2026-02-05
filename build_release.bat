@echo off
REM NoteHax - Build Script for Android Release (Windows)
REM This script automates the build process for the NoteHax Flutter application

setlocal EnableDelayedExpansion

echo ==================================
echo   NoteHax - Android Build Script  
echo ==================================
echo.

REM Check if we're in the right directory
if not exist pubspec.yaml (
    echo [ERROR] pubspec.yaml not found. Please run this script from the project root directory.
    exit /b 1
)

echo [SUCCESS] Found pubspec.yaml - We're in the right directory
echo.

REM Check Flutter installation
echo [INFO] Checking Flutter installation...
where flutter >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Flutter is not installed or not in PATH
    echo.
    echo Please install Flutter from: https://flutter.dev/docs/get-started/install/windows
    echo After installation, make sure to add Flutter to your PATH
    exit /b 1
)

echo [SUCCESS] Flutter is installed
flutter --version
echo.

REM Check Android SDK
echo [INFO] Checking Android SDK...
if "%ANDROID_HOME%"=="" (
    if "%ANDROID_SDK_ROOT%"=="" (
        echo [WARNING] ANDROID_HOME or ANDROID_SDK_ROOT not set
        
        REM Check if local.properties exists
        if not exist android\local.properties (
            echo [ERROR] android\local.properties not found
            echo.
            echo Please create android\local.properties with:
            echo sdk.dir=C:\\Users\\YourUsername\\AppData\\Local\\Android\\Sdk
            echo flutter.sdk=C:\\flutter
            exit /b 1
        ) else (
            echo [SUCCESS] Found android\local.properties
        )
    ) else (
        echo [SUCCESS] Android SDK found at: %ANDROID_SDK_ROOT%
    )
) else (
    echo [SUCCESS] Android SDK found at: %ANDROID_HOME%
)
echo.

REM Check Java
echo [INFO] Checking Java installation...
where java >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Java is not installed or not in PATH
    echo.
    echo Please install Java JDK 11 or higher
    exit /b 1
)

echo [SUCCESS] Java is installed
java -version 2>&1 | findstr /i "version"
echo.

REM Check signing key
echo [INFO] Checking signing configuration...
if not exist android\key.jks (
    echo [ERROR] Signing key android\key.jks not found
    exit /b 1
)

if not exist android\key.properties (
    echo [ERROR] Key properties android\key.properties not found
    exit /b 1
)

echo [SUCCESS] Signing configuration found
echo.

REM Ask user what to build
echo What would you like to build?
echo 1) Release APK (for testing/sideloading)
echo 2) Release App Bundle - AAB (for Play Store)
echo 3) Split APKs (smaller size, per architecture)
echo 4) All of the above
echo 5) Just clean and get dependencies
echo.
set /p choice="Enter your choice (1-5): "

REM Clean previous builds
echo.
echo [INFO] Cleaning previous builds...
call flutter clean
if errorlevel 1 (
    echo [ERROR] Clean failed
    exit /b 1
)
echo [SUCCESS] Clean complete
echo.

REM Get dependencies
echo [INFO] Getting dependencies...
call flutter pub get
if errorlevel 1 (
    echo [ERROR] Failed to get dependencies
    exit /b 1
)
echo [SUCCESS] Dependencies fetched
echo.

REM Check if we need to run build_runner
findstr /C:"build_runner" pubspec.yaml >nul 2>&1
if not errorlevel 1 (
    echo [INFO] Running code generation (Hive adapters)...
    call flutter pub run build_runner build --delete-conflicting-outputs
    if errorlevel 1 (
        echo [WARNING] Code generation had some issues, but continuing...
    ) else (
        echo [SUCCESS] Code generation complete
    )
    echo.
)

REM Build based on user choice
if "%choice%"=="1" goto build_apk
if "%choice%"=="2" goto build_aab
if "%choice%"=="3" goto build_split
if "%choice%"=="4" goto build_all
if "%choice%"=="5" goto done
echo [ERROR] Invalid choice
exit /b 1

:build_apk
echo [INFO] Building release APK...
call flutter build apk --release
if errorlevel 1 (
    echo [ERROR] APK build failed
    exit /b 1
)
echo [SUCCESS] APK build complete!
echo.
echo Output: build\app\outputs\flutter-apk\app-release.apk
goto verify

:build_aab
echo [INFO] Building release App Bundle (AAB)...
call flutter build appbundle --release
if errorlevel 1 (
    echo [ERROR] App Bundle build failed
    exit /b 1
)
echo [SUCCESS] App Bundle build complete!
echo.
echo Output: build\app\outputs\bundle\release\app-release.aab
goto verify

:build_split
echo [INFO] Building split APKs...
call flutter build apk --release --split-per-abi
if errorlevel 1 (
    echo [ERROR] Split APKs build failed
    exit /b 1
)
echo [SUCCESS] Split APKs build complete!
echo.
echo Outputs:
echo   - build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk
echo   - build\app\outputs\flutter-apk\app-arm64-v8a-release.apk
echo   - build\app\outputs\flutter-apk\app-x86_64-release.apk
goto verify

:build_all
echo [INFO] Building all variants...
echo.

echo [INFO] 1/3: Building release APK...
call flutter build apk --release
if errorlevel 1 (
    echo [ERROR] APK build failed
    exit /b 1
)

echo [INFO] 2/3: Building release App Bundle (AAB)...
call flutter build appbundle --release
if errorlevel 1 (
    echo [ERROR] App Bundle build failed
    exit /b 1
)

echo [INFO] 3/3: Building split APKs...
call flutter build apk --release --split-per-abi
if errorlevel 1 (
    echo [ERROR] Split APKs build failed
    exit /b 1
)

echo [SUCCESS] All builds complete!
echo.
echo Outputs:
echo   APK:  build\app\outputs\flutter-apk\app-release.apk
echo   AAB:  build\app\outputs\bundle\release\app-release.aab
echo   Split APKs:
echo     - build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk
echo     - build\app\outputs\flutter-apk\app-arm64-v8a-release.apk
echo     - build\app\outputs\flutter-apk\app-x86_64-release.apk
goto verify

:verify
echo.
echo [INFO] Build verification...

if exist build\app\outputs\flutter-apk\app-release.apk (
    for %%A in (build\app\outputs\flutter-apk\app-release.apk) do set APK_SIZE=%%~zA
    set /a APK_MB=!APK_SIZE! / 1048576
    echo [SUCCESS] APK verified - Size: !APK_MB! MB
)

if exist build\app\outputs\bundle\release\app-release.aab (
    for %%A in (build\app\outputs\bundle\release\app-release.aab) do set AAB_SIZE=%%~zA
    set /a AAB_MB=!AAB_SIZE! / 1048576
    echo [SUCCESS] AAB verified - Size: !AAB_MB! MB
)

REM Summary
echo.
echo ==================================
echo          Build Complete! 🚀       
echo ==================================
echo.
echo Next steps:
echo 1. Test the APK on a physical device:
echo    adb install build\app\outputs\flutter-apk\app-release.apk
echo.
echo 2. For Play Store submission:
echo    - Upload: build\app\outputs\bundle\release\app-release.aab
echo    - Follow: play_console_assets\submission_checklist.md
echo.
echo 3. For more information, see:
echo    - SETUP_COMPLETE.md
echo    - BUILD_VERIFICATION.md
echo.
echo [SUCCESS] All done!
goto end

:done
echo [SUCCESS] Dependencies ready! You can now build manually.

:end
endlocal
