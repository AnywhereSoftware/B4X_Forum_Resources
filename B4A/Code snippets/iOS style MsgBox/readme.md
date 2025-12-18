### iOS style MsgBox by marcick
### 12/13/2025
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/169720/)

Hi everyone,  
my programming skills are rather modest, but with the help of ChatGPT (and this forum) I managed to create a MsgBox with an iOS-like style. I find it more pleasant visually, and I also needed to keep the same look and feel between the iOS and Android versions of my app.  
Maybe something like this already exists, but I couldn’t find it while searching 🙂  
I’m attaching the class below.  
  
Usage:  
  

```B4X
                Dim Dlg As iOSMsgBox  
                Dlg.Initialize(Root, Me, "Dlg")  
                Dlg.Show(title, message, Array As String("button 1", "button 2", "button 3"))  
                wait for Dlg_Result (Testo As String)
```

  
  
  
![](https://www.b4x.com/android/forum/attachments/168863)