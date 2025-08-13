cd %1
md Lib
md Lib\Files
del ./*.b4xlib
del /Q Lib\Files\*.*
del /Q Lib\*.* 
copy *.* Lib
copy B4A\Files\*.* Lib\Files
copy B4i\Files\*.* Lib\Files
copy B4J\Files\*.* Lib\Files
cd Lib
%2\jar.exe -cMf %3 .\*.* .\Files
move %3 ..
cd ..
del /Q Lib\Files\*.*
del /Q Lib\*.* 
rd Lib\Files
rd Lib
"C:\Program Files\WinRAR\winrar.exe" ./%3

