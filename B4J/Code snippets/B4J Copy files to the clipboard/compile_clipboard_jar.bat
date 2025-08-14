@echo off
setlocal

:: Répertoire contenant le fichier Java
set SRC_DIR=src
:: Répertoire de sortie pour les classes compilées
set BIN_DIR=bin
:: Nom du fichier JAR final
set JAR_NAME=ClipboardFileCopier.jar
:: Nom du package + classe principale
set MAIN_CLASS=b4j.helper.ClipboardFileCopier

:: Création des dossiers si nécessaires
if not exist %BIN_DIR% mkdir %BIN_DIR%

:: Compilation de la classe Java
echo Compilation de la classe Java...
javac -encoding UTF-8 -d %BIN_DIR% %SRC_DIR%\b4j\helper\ClipboardFileCopier.java

:: Création du fichier MANIFEST
echo Manifest-Version: 1.0> manifest.txt
echo Main-Class: %MAIN_CLASS%>> manifest.txt

:: Création du fichier JAR
echo Création du fichier JAR...
jar cfm %JAR_NAME% manifest.txt -C %BIN_DIR% .

:: Nettoyage
del manifest.txt

echo.
echo ✅ Terminé ! Le fichier %JAR_NAME% est prêt à être utilisé dans B4J.
pause
