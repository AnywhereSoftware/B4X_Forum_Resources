###  Code snippets by Erel
### 09/26/2023
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/152450/)

B4J v10.00 includes support for "code snippets". This feature will be added to the other tools in the next updates.  
A code snippet is a piece of code that can be added to your code in very few clicks.  
The snippet can include any number of variables or placeholders that will be highlighted and edited right after the snippet is inserted.  
  
OkHttpUtils2 includes two simple snippets.  
In its simplest form, it looks like this:  
  
![](https://www.b4x.com/basic4android/images/B4J_czkcESZ48U.gif)  
  
Another example, this time with placeholders:  
  
![](https://www.b4x.com/basic4android/images/B4J_xlS2e4jXPn.gif)  
Note that once we changed the value of "MediaManager", it was changed in two places. All placeholders with the same id will be replaced automatically.  
  
There are two ways to add new snippets:  

1. Inside a b4xlib library. Simply add a folder named Snippets and put the snippets files in that folder. Each snippet in its own text file.
2. Under the Snippets folder in the additional libraries folder. Each snippet in a separate txt file.
![](https://www.b4x.com/android/forum/attachments/146391)
The snippet text file is as simple as the text that should be added when the snippet is selected.  
The snippet can include placeholders and can include a description.  
For example to create a snippet for iterating over the keys and values of a Map:  

```B4X
'Iterate over keys and values  
For Each key As Object In $map$.Keys  
    Dim value As Object = $map$.Get(key)  
    $end$  
Next
```

  
Note that the special $end$ marking sets the cursor position after the developer set the placeholders.  
  
![](https://www.b4x.com/android/forum/attachments/146137)  
  
![](https://www.b4x.com/basic4android/images/B4J_TgdenXgH64.gif)  
  
Tip: In order to force the IDE to reload snippets - Library tab -> right click -> Refresh