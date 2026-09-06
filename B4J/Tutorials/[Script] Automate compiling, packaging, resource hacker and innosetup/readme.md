### [Script] Automate compiling, packaging, resource hacker and innosetup by aeric
### 08/30/2026
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/171941/)

GitHub: <https://github.com/pyhoon/automate-build-installer>  
  
Tested with B4J v10.5, Resource Hacker v5.1.8, InnoSetup 6.2.0  
  
Clone from GitHub repo link above or download all attachments then rename the files without .txt extensions.  
Put them inside **\Objects** folder (or your prefer path) of a B4J Windows desktop project.  
  
Files:  

1. **automate-build.bat** (main script)

1. Extract properties from B4J project (e.g #PackagerProperty: AssemblyVersion)
2. Compile B4J project to JAR
3. Inject B4J properties into packager.json
4. Run B4JPackager11 to create standalone build directory
5. Inject Custom Icon into Standalone EXE (Resource Hacker)
6. Inject Custom Manifest (Resource Hacker)
7. Inject Synced Version Info (Resource Hacker)
8. Compile Inno Setup Installer

2. **app.manifest** (for Resource Hacker)

1. Similar to content in Manifest tab
2. You can change the name, version and description

```B4X
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0" xmlns:asmv3="urn:schemas-microsoft-com:asm.v3">  
    <assemblyIdentity name="MyApp.exe" version="1.00.0.0" processorArchitecture="X86" type="win32"></assemblyIdentity>  
    <description>Create using B4J</description>  
</assembly>
```


3. **version\_template.rc** (for Resource Hacker)

1. Similar to content in Version Info tab

4. **packager.json** (for B4JPackager11)

1. Use for building standalone package

5. **installer.iss** (for Inno Setup)

1. Use for building Windows installer

Modify all the files to your needs.  
Call the **automate-build.bat** script using Command Prompt or B4J Macro  

```B4X
#Macro: Title, Build, ide://run?file=%PROJECT%\Objects\automate-build.bat
```