###  B4X Programming Technics + Track Changes Tool by hatzisn
### 01/11/2020
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/112452/)

Hi every one and season's greetings,  
  
***(11-1-2020) New version of the tool with timestamp and "Transfered <Checkbox>"***  
  
  
When I program I am used to keep notes in my code to know when I have to do something or if I have changed something in one of the apps in case of parallel app developing (B4A - B4i).  
  
Here are two technics and a tool for supporting the second one:  
  
1) When I plan to do something but I leave it for later I usually add a "'TODO:" rem tag in the code  
  
f.e.  
  

```B4X
Sub DoThis  
     'TODO: I have to do this  
  
  
     'TODO: Also I have to do that  
  
  
End Sub
```

  
  
Then when it's time you just search for "'TODO:" and the IDE gets you automatically to the point where you wrote down your note to do later.  
  
  
2) When Developing in parallel (f.e. B4A and B4i) I usually have a main app selection of the two apps that I develop. There, I do all the changes and track the changes using a "CHD:#" rem tag in the code and then copy/edit them in the other app. The same way as before with a search for "CHD:" the IDE gets you to the point of the change.  
  
f.e.  
  

```B4X
Sub DoThis  
     'CHD:1  
  
End Sub
```

  
  
I used to do this by hand but today I developed a tool for me to automate this task and I would like to share it with you. Here is a video on how it is used. Erel, a useful thing to add to the B4X IDE would be a menu to add and run hand made tools like this tool and B4XViewer f.e.  
  
[MEDIA=youtube]DeTvg2dXNpk[/MEDIA]  
  
Cheers to all of you