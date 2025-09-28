### Rename result.jar using #Macro or #CustomBuildAction by aeric
### 09/24/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/168616/)

Method 1: rename existing jar  

```B4X
#Macro: Title, Rename, ide://run?file=%COMSPEC%&Args=/c&Args=ren&Args=result.jar&Args=libget-non-ui.jar
```

  
You can also check if the file exists before rename  
or you will get an error "The system cannot find the file specified." (Exit code 1)  

```B4X
#Macro: Title, Rename, ide://run?file=%COMSPEC%&Args=/c&Args=IF+EXIST+result.jar&Args=ren&Args=result.jar&Args=libget-non-ui.jar
```

  
  
Method 2: keep result.jar but copy to Additional Libraries folder  

```B4X
#CustomBuildAction: 2, %COMSPEC%, /c copy result.jar %ADDITIONAL%\..\B4X\libget-non-ui.jar
```

  
  
Method 3: build the jar without running  
<https://www.b4x.com/android/forum/threads/b4abuilder-b4jbuilder-command-line-compilation.50154/>  

```B4X
#Macro: Title, Build only, ide://run?File=%B4X%\B4JBuilder.exe&Args=-Task%3DBuild&Args=-BaseFolder%3D..&Args=-Output%3Dlibget_non_ui
```

  
Note: dash or hyphen in the output filename resulted the filename back to result.jar