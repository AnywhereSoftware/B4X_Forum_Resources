### [PyBridge] PyWorks: a Class to Facilitate Running Python Code by William Lancee
### 01/21/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/170072/)

This class arose from my experience with PyBridge. PyBridge is a powerful interface to Python.  
With PyBridge you can use Python code in the way Python was intended: as a Command Line tool - commands are send to Python.  
  
It can also be used to register Python "Subs" (called "def" in Python), then call that Sub with arguments, and expect a return value.  
This is the method I prefer, it is similar to B4X and it feels 'more' synchronous: call => wait for results => use results  
  
I wrote PyWorks to make this task easier for me. I post it here because there may be others who could use this.  
If you don't have the PyBridge-related problems as I do, or if you think this is a bad idea, please ignore this post.  
  
Most of my work with Python is calling a method of a Library that has computational and algorithmically complex tasks.  
The calling part is usually just a step in a sequence (not a loop). I want Python to do the heavy lifting, then give me a result.  
Therefore a very convenient approach is to use a Smart String of python code lines:  

```B4X
    Dim script As String = $"  
Python line 1  
Python line 2  
…  
"$
```

  
This places the code where I use it. So far so good!  
  
So here is the core of the problem. I am a long-time user of B4X and have been spoiled by its syntax.  
It is easy to take it for granted, but (1) B4X is case-insensitive and (2) B4X is indent-insensitive.  
Python requires exact caseness and indentation to work. I need something to convert my (to my eyes) perfectly good code  
to correct Python syntax. Hence 'PyWorks' (Private pw As PyWorks).  

```B4X
    Wait For (pw.clean(script)) Complete (script As String)
```

  
What does 'clean' clean?  
 1. indentation inconsistencies (TAB vs spaces) and starting offset  
 2. caseness of all python keywords and python user variable names  
 3. checks for duplicate def names in a Python session  
 4. does a dry run 'compile' prior to trying to run a script to catch errors  
 5. adds a standard Script Id header - derived from the script itself - used in call to PyBridge  

```B4X
'This example has 4 Python syntax errors - can you spot them? They are all fixed by 'clean'  
    Dim script As String = $"  
    Def TryThis():  
        Print("Hello World #2")  
        TheTruth = true  
"$  
    Wait For (pw.clean(script)) Complete (script As String)  
    Wait For (pw.call(script, Array())) Complete (obj As Object)  
  
'CLEANED SCRIPT - the indents are TABs  
'#__________ TryThis __________  
'def TryThis():  
'    print("Hello World #2")  
'    TheTruth = True
```

  
I could just share the clean method as a Sub here, but it is not in my nature to leave well-enough alone.  
(If you want just the Sub, it is readily available in the attached class)  
  
I added other methods to the class:  
**connect** - initializes PyBridge and reports the location of the Python kernel (Global, Default, Local)  
**call** - calls the def in the script - uses script ID header created by 'clean'  
**exec** - executes a series of python lines - adds a dummy def to aid in getting a synchronous response  
**show** - logs a numbered view of the script  
**clipboard** - puts the commented script on the clipboard (commented to make paste easier)  
**install** - installs a package in the Python kernel environment without having to go to command shell  
**names** - return a list of global variables declared by your scripts in this session  
**blogs** - B4X logs the accumulated set of lines produce by: the PyWorks defined Python function 'blog(String)'  
  
Notes:  
1. I recommend disabling "Auto Format when Pasting" in Tools->IDE Options. You can always use Alt F to format all B4X code without altering Smart Strings.  
   
2. This class is relatively small and easy to understand. Take a look, use or change it anyway you like.  
 If you don't like the name, change it and its instantiation.  
 If you find ways to improve it, post your result in this thread.  
  
3. Global or Local Python? PyWorks works with both or with Default Python (without any extra packages - you should not change Default Python).  
 The attached .zip file assumes you have a Global Python reference in Tools->Configure Paths.  
 If you don't, then use the commented link at the top of the B4XMainPage module in the attached to Create a local Python runtime.  
 I can't post a Local version because it is in the Object folder, which is not zipped- but it is already in your Anywhere B4J installation.  
 In any case it would be too large to attach to this post. The link will copy it to your project Object folder.  
  
4. I have also attached two code snippets that can save some typing and shows how to use call and exec.  
 Copy these snippets to your additional/Snippets folder. Invoke snippets by start typing coex or cocal  
  
5. The first time you run the demo, it will clean all the scripts and check them for syntax errors.  
 There is one erroneous script in the demo project. Fix it and run the demo again.  
  
If you have problems running the demo, get back to me here.