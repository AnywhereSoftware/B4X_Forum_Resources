### Multi Language helper by pliroforikos
### 04/05/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/129405/)

A small library for multilingual applications for newcomers.   
It uses a text file with name: **translation.txt** which must always be installed in **File.DirAssets** folder.   
**translation.txt**  

```B4X
key;english;french;greek;  
button1;File;Déposer;Αρχείο;  
button2;Edit;Éditer;Επεξεργασία;  
button3;Exit;Sortir;Έξοδος;  
msg_hello_world;Hello World;Bonjour le monde;Γεια σου κόσμε;
```

  
   

- The first line includes the key word as first column and the names of the languages to be used. You can use as many languages as you want by entering their name separated by the character ";" . Don't forget to close with ";" last language as in example file.
- The first column of the translation file refers to the keyword that you will use to call the corresponding translation.
- Each word is separated by the previous one with the character ";"

  
How to use: Install library and define a variable as Translation Class  
  

```B4X
Sub Class_Globals  
    Private Root As B4XView  
    Private xui As XUI  
    Private lang As Translation  
    Private Button1 As Button  
    Private Button2 As Button  
    Private Button3 As Button  
End Sub  
  
Public Sub Initialize  
    lang.Initialize  
End Sub  
  
Private Sub B4XPage_Created (Root1 As B4XView)  
    Root = Root1  
    Root.LoadLayout("MainPage")  
    Button1.Text = lang.getWord("button1","greek")  
    Button2.Text = lang.getWord("button2","english")  
    Button3.Text = lang.getWord("button3","french")  
End Sub  
  
Private Sub Button1_Click  
    xui.MsgboxAsync(lang.getWord("msg_hello_world", "greek"), "B4X")  
End Sub  
  
Private Sub Button2_Click  
    xui.MsgboxAsync(lang.getWord("msg_hello_world", "english"), "B4X")  
End Sub  
  
Private Sub Button3_Click  
    xui.MsgboxAsync(lang.getWord("msg_hello_world", "french"), "B4X")  
End Sub
```

  
  
**Language  
Version: 0.1 beta  
  
Class: Translation  
  
Methods**:  

- **Initialize** Initialize and do all the job loading a map with key and values of each line
- **languages** Returns a list of languages written in translation.txt file
- **getWord**("key as string", "language name as shown in translation.txt file"). Returns a string with the word in chosen language

  
The library is not checking for errors in translation.txt file so it is your responsibilty to write it as the example above.  
  
This is my first library so be kind!