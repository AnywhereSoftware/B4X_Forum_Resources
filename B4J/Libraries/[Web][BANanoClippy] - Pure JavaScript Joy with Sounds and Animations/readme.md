### [Web][BANanoClippy] - Pure JavaScript Joy with Sounds and Animations by Mashiane
### 05/01/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166813/)

Hi Fam  
  
[Demo](https://ba-nano-clippy.vercel.app/)  
  
[Github Repo](https://github.com/Mashiane/BANanoClippy)  
  
Remember Microsoft Clippy, Merlin, Links, Rocky and Rover and others, year, you can add them to your app and perform some gestures and speak. Have you ever wanted to have one in your website / app? Now it's possible! Yippie!  
  
As it takes time to create these b4xlibs, this one is based on a certificate of appreciation, i.e. DonationWare.   
  
![](https://www.b4x.com/android/forum/attachments/163783)  
  
![](https://www.b4x.com/android/forum/attachments/163784)  
  
![](https://www.b4x.com/android/forum/attachments/163785)  
  
![](https://www.b4x.com/android/forum/attachments/163786)  
  
  
  
![](https://www.b4x.com/android/forum/attachments/163787)  
  
  
  
![](https://www.b4x.com/android/forum/attachments/163788)  
  
![](https://www.b4x.com/android/forum/attachments/163789)  
  
![](https://www.b4x.com/android/forum/attachments/163790)  
  
![](https://www.b4x.com/android/forum/attachments/163791)  
  
![](https://www.b4x.com/android/forum/attachments/163792)  
  
  
**UI Design** - I needed a quick demo so I decided to go thin with a single multi-usable component just to meet this demo based on [MD3](https://www.mdui.org/en/)  
  

```B4X
'Static code module  
Sub Process_Globals  
    Private clippy1 As BANanoClippy  
    Private BANano As BANano  
    Private cboAnimations As MDUComponent  
    Private cboAgents As MDUComponent  
    Private snackBar As MDUComponent  
    Private txtField As MDUComponent  
End Sub  
  
Sub Initialize  
    ' get the body tag  
    Private body As BANanoElement  
    body.Initialize("#body")  
    body.empty  
    '  
    snackBar.Initialize(Me, "body", "snackbar", "mdui-snackbar", "")  
    snackBar.SetOpen(False)  
    snackBar.SetAttr("placement", "top-end")  
      
    Dim lbl As MDUComponent  
    lbl.Initialize(Me, "body", "lbl", "h1", "Clippy Agents")  
    '  
    cboAgents.Initialize(Me, "body", "cboAgents", "mdui-select", "")  
    cboAgents.SetWidth("500px")  
    cboAgents.OnEvent("change")  
      
    Dim lbl1 As MDUComponent  
    lbl1.Initialize(Me, "body", "lbl1", "h1", "Clippy Animations")  
    '  
    cboAnimations.Initialize(Me, "body", "cboAnimations", "mdui-select", "")  
    cboAnimations.SetWidth("500px")  
    cboAnimations.OnEvent("change")  
    '  
    Dim lbl2 As MDUComponent  
    lbl2.Initialize(Me, "body", "lbl2", "h1", "Text To Speech")  
      
    txtField.Initialize(Me, "body", "txtSpeak", "mdui-text-field", "").SetLabel("Text to Speech").SetRows("4")  
    txtField.SetWidth("800px")  
    txtField.SetValue("Add Clippy or his friends to any website for instant nostalgia.")  
    '  
    Dim lbl3 As MDUComponent  
    lbl3.Initialize(Me, "body", "lbl3", "div", "")  
    lbl3.SetHeight("20px")  
      
    Dim btnSpeak As MDUComponent  
    btnSpeak.Initialize(Me, "body", "btnSpeak", "mdui-button", "Speak!")  
    btnSpeak.OnEvent("click")  
    btnSpeak.SetWidth("200px")  
    '  
    clippy1.Initialize(Me, "clippy1", "./assets/agents/")  
    For Each a As String In clippy1.GetAgents  
        cboAgents.AddSelectItem(a, a)  
    Next  
      
End Sub  
  
Sub cboAgents_change(e As BANanoEvent)  
    'get the selected agent  
    Dim thisAgent As String = cboAgents.GetValue  
    snackBar.SetText($"Agent Selected: ${thisAgent}"$)  
    snackBar.SetOpen(True)  
    'hide any existing agent  
    clippy1.Hide(True)  
    'load a new agent  
    clippy1.LoadAgent(thisAgent)  
End Sub  
  
Private Sub clippy1_Loaded  
    'get clippy animations  
    Dim animations As List = BANano.await(clippy1.GetAnimations)  
    cboAnimations.Clear  
    For Each a As String In animations  
        cboAnimations.AddSelectItem(a, a)  
    Next      
    clippy1.show  
End Sub  
  
Sub cboAnimations_change(e As BANanoEvent)  
    Dim thisAnimation As String = cboAnimations.GetValue  
    clippy1.Play(thisAnimation)  
End Sub  
  
Sub btnSpeak_click(e As BANanoEvent)  
    e.PreventDefault  
    Dim s As String = txtField.GetValue  
    s = s.Trim  
    If s = "" Then  
        snackBar.SetText("Please enter text to speech first!").SetOpen(True)  
        Return  
    End If  
      
    clippy1.Speak(txtField.GetValue)  
End Sub
```