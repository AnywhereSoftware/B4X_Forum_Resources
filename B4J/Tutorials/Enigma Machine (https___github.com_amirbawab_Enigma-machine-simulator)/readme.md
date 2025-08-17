### Enigma Machine (https://github.com/amirbawab/Enigma-machine-simulator) by Johan Schoeman
### 08/17/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/149644/)

This is not intended to take anything away from [USER=27471]@ilan[/USER] 's project [**here**](https://www.b4x.com/android/forum/threads/enigma-machine-source-included.137484/). I have also been reading up about the Enigma Machine recently and then checked what Java projects are available on Github and came across [**this Github project**](https://github.com/amirbawab/Enigma-machine-simulator). It had the Jar available so did not have to download and compile the Java code to a Jar.  
  
  
  
Have done a very "tiny" B4J project to kickstart the Enigma Machine (the Jar) from within B4J. Attached the B4J project and the Jar. Copy the Jar to your additional library folder, download the B4J project and then unzip it and run it.  
  
It has a TextBox, Keyboad, and Wiring display (select from the menu "Display")  
  
If you make changes to the Rotors, Reflector, or Plugboard then click "SAVE" for it to take effect.  
  
Enjoy playing around with it - It will give you a reasonably good idea of how the Enigma Machine worked (rotors, reflectors, and the use of the Plugboard)  
  
"…..the best way for one to keep a secret is not to know the secret…"  
  
![](https://www.b4x.com/android/forum/attachments/144858)  
  
![](https://www.b4x.com/android/forum/attachments/144859)  
  
![](https://www.b4x.com/android/forum/attachments/144860)  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: EnigmaMachine  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
     
    Dim em As JavaObject    
  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
'    MainForm = Form1  
'    MainForm.RootPane.LoadLayout("Layout1")  
'    MainForm.Show  
  
    em.InitializeNewInstance("gui.Machine", Null)  
     
     
End Sub
```