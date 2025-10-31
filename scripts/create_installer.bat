@echo off
REM Copy installer files and Release build to installer directory
xcopy src\PlotJuggler\installer installer\ /Y /S /f /z
xcopy install\Release\bin\*.* installer\io.plotjuggler.application\data /Y /S /f /z

REM Qt DLLs are already deployed by build.bat, so no need to run windeployqt again

C:\Qt\Tools\QtInstallerFramework\4.10\bin\binarycreator.exe --offline-only -c installer\config.xml -p installer  PlotJuggler-Windows-installer.exe