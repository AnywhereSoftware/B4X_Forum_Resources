### [PyBridge] Text to Speech with pyttsx3 by Erel
### 03/16/2025
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/166148/)

<https://pyttsx3.readthedocs.io/en/latest/index.html>  
  
Dependency:  
pip install pyttsx3  
  
![](https://www.b4x.com/android/forum/attachments/162622)  
  

```B4X
Private Sub CreateEngine As ResumableSub  
    Ttsx3Engine = Py.ImportModule("pyttsx3").Run("init")  
    Dim voices As PyWrapper = Ttsx3Engine.Run("getProperty").Arg("voices")  
    'Get the voices names:  
    Dim VoicesNames As PyWrapper = Py.Map_(Py.Lambda("v: v.name"), voices).ToList  
    Wait For (VoicesNames.Fetch) Complete (voices As PyWrapper)  
    For Each Voice As String In voices.Value.As(List)  
        ListView1.Items.Add(Voice)  
    Next  
    Wait For (Py.Flush) Complete (Success As Boolean)  
    Return Success  
End Sub  
  
Private Sub ListView1_SelectedIndexChanged(Index As Int)  
    Dim voices As PyWrapper = Ttsx3Engine.Run("getProperty").Arg("voices")  
    Ttsx3Engine.Run("setProperty").Arg("voice").Arg(voices.Get(Index).GetField("id"))  
End Sub  
  
Private Sub Say(Text As String)  
    Button1.Enabled = False  
    Ttsx3Engine.Run("say").Arg(Text)  
    Ttsx3Engine.Run("runAndWait")  
    Ttsx3Engine.Run("stop")  
    Wait For (Py.Flush) Complete (Success As Boolean)  
    Button1.Enabled = True  
End Sub
```