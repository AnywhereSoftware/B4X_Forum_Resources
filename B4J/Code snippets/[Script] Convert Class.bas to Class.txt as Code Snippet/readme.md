### [Script] Convert Class.bas to Class.txt as Code Snippet by aeric
### 06/19/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171325/)

[HEADING=2]Convert Class.bas to Class.txt (also works for CodeModule.bas)[/HEADING]  
This script converts file with .bas extension to .txt and place it inside /Snippets folder to be included into B4X library or B4X template as code snippets.  
  
The following lines are not visible inside B4J Code Editor but are visible if you open the .bas file using a text editor.  

```B4X
B4J=true  
Group=Handlers  
ModulesStructureVersion=1  
Type=Class  
Version=10.5  
@EndOfDesignText@
```

  
  
In order to create a Code Snippet, line of code as seen above need to be removed.  
Different from Class template, we also want to remove the first line of Sub Class\_Globals and last line of End Sub.  
With this, we can start typing 'Code' in the IDE to invoke the **Code Snippets**.  
This script will remove the lines for us so we don't need to edit the files one by one.  
  
[HEADING=2]How to use create Class.txt[/HEADING]  

1. Download the attached **create\_snippets.bat.txt** and then remove the **.txt** extension.
2. Put the file at the same path as **.b4j** project file.
3. The command to run it:

```B4X
create_snippets.bat class1.bas class2.bas
```

4. We can use #Macro to call this batch file.

```B4X
#Macro: Title, Create Template, ide://run?File=%PROJECT%\create_snippets.bat&Args=..\Model.bas&Args=..\View.bas
```


[HEADING=2]How to apply Code Snippets[/HEADING]  

1. Create a standard class from menu **Add New Module** > **Class Module** > **Standard Class**.
2. If your Code Snippet starts from **Class\_Global** sub then remove the Initialize sub. This is the assumption I made for this script.
3. Put the cursor in between Sub Class\_Globals and End Sub
4. Start typing code.
5. Code Snippets will be listed if any is available.
6. Use arrow key up/down and press Enter or use mouse to select the Snippet you want.

[HEADING=2]Note[/HEADING]  

1. Code Snippets may contains invalid symbols such as $key$ and $end$.
2. Add the class to the project
3. Make modification to the code and save it.
4. Remove the file from the project so it won't interfere with the compilation.

[HEADING=2]Assumption[/HEADING]  

1. My Code Snippet starts from **Class\_Global** sub so I need to remove the Initialize sub when applying the Code Snippet.
2. If your Code Snippet doesn't have any variable declaration in the class then (I think) you can replace 'Sub Class\_Globals' with 'Public Sub Initialize' in the script.
3. If your Code Snippet is in the middle of code then (I think) you need to replace the starting marker 'Sub Class\_Globals' with something else in the script. I am not sure it works.