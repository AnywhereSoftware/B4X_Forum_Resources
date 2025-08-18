### Running B4JBuilder from the browser... by Mashiane
### 05/06/2022
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/140369/)

Ola  
  
Off course, you would not use this outside of controlled environments… So how?  
  
Well, if you want to explore something like this, you can do it also using php besides jShell, I think. The php call below, when done returns the output of the call and B4J log result and I have fed it to a code block in my UI.  
  

```B4X
function BuildApp ($path) {  
        echo shell_exec($path." 2>&1");  
    }
```

  
![](https://www.b4x.com/android/forum/attachments/128882)  
What I did was just create a basic b4j app with skeleton content that I needed to test, then fired the B4JBuilder by using the **shell\_exec** command above, so that it also receives the output generated.  
  
This is an example path I pushed through, where my b4j app is.  
  

```B4X
C:\Program Files\Anywhere Software\B4J\B4JBuilder.exe" -task=Build -obfuscate=False -BaseFolder="C:\laragon\www\bvad3storybook\assets\projects\app1\B4J
```

  
  
Did I try to run the built jar file? Of course..  
  
Using the same shell\_exec and pushing it this path.  
  

```B4X
C:\jdk-11.0.1\bin\javaw.exe -Xdebug -Xbatch –module-path C:\jdk-11.0.1\javafx\lib –add-modules ALL-MODULE-PATH -jar "C:\laragon\www\bvad3storybook\assets\projects\app1\B4J\Objects\BVAD3Code.jar"
```

  
  
I was kinda amazed…  
  
Good luck!