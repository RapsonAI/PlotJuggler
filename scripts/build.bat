@echo off
REM Usage: build.bat [Debug|Release|RelWithDebInfo]
REM Default: Release

set BUILD_TYPE=%1
if "%BUILD_TYPE%"=="" set BUILD_TYPE=Release

set CMAKE_TOOLCHAIN=C:\humda\vcpkg\scripts\buildsystems\vcpkg.cmake
set INSTALL_DIR=%cd%/install/%BUILD_TYPE%

echo Building configuration: %BUILD_TYPE%
echo Install directory: %INSTALL_DIR%

cmake -G "Visual Studio 16" ^
      -S src/PlotJuggler -B build/PlotJuggler ^
      -DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN%  ^
      -DCMAKE_INSTALL_PREFIX=%INSTALL_DIR% ^
      -DCMAKE_PREFIX_PATH="C:/Qt/5.15.2/msvc2019_64/lib/cmake"

cmake --build build/PlotJuggler --config %BUILD_TYPE% --target install

REM Deploy Qt5 DLLs to both build and install directories
set BUILD_DIR=%cd%\build\PlotJuggler\bin\%BUILD_TYPE%

if /I "%BUILD_TYPE%"=="Debug" (
    echo Deploying Qt5 DLLs for Debug...
    C:\Qt\5.15.2\msvc2019_64\bin\windeployqt.exe --debug %BUILD_DIR%\plotjuggler.exe
    C:\Qt\5.15.2\msvc2019_64\bin\windeployqt.exe --debug %INSTALL_DIR%\bin\plotjuggler.exe
) else (
    echo Deploying Qt5 DLLs for Release...
    C:\Qt\5.15.2\msvc2019_64\bin\windeployqt.exe --release %BUILD_DIR%\plotjuggler.exe
    C:\Qt\5.15.2\msvc2019_64\bin\windeployqt.exe --release %INSTALL_DIR%\bin\plotjuggler.exe
)