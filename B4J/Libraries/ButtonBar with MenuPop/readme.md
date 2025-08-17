### ButtonBar with MenuPop by ANTONIO ALBEIRO VALENCIA
### 06/06/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/167273/)

Hi everyone,  
  
I developed a library to build a button bar with popup menu, it does not require the designer.  

---

  
  
![](https://www.b4x.com/android/forum/attachments/164547)  
  
[MEDIA=youtube]1B48T-tMwx8[/MEDIA]  
  

---

  
[HEADING=3]CLASS BarButton[/HEADING]  
  
[HEADING=3]METHODS[/HEADING]  

- Initialize( pane As Pane )
- AddButtonMenu( text As String, filePng As String, eventName As String, menu As List )
- AddButton( text As String, filePng As String, eventName As String )
- SetColorBar( styleFXString As String )
- SetItemFontSize( sizeFont As Int )
- SetButtonFontSize( sizeFont As Int )

[HEADING=3]DATAS[/HEADING]  

- widthButton = size As Int
- heightButton = size As Int

  

```B4X
Sub Class_Globals  
   
    Public Root As B4XView  
    Private xui As XUI  
    Private fx As JFX  
   
End Sub  
  
Public Sub Initialize  
'    B4XPages.GetManager.LogEvents = True  
   
End Sub  
  
'This event will be called once, before the page becomes visible.  
Private Sub B4XPage_Created (Root1 As B4XView)  
   
    Root = Root1  
   
    TestBtnWrapper  
   
End Sub  
  
Private Sub TestBtnWrapper  
   
    ' https://www.flaticon.com/free-icon-font/user_3917688?related_id=3917688  
    Dim path As String = "E:\\java examples  JavaSwing- JavaFX\\test javaFX\\src\\images\\"  
   
    Dim btn As BarButton  
    btn.initialize(Root)  
    btn.SetColorBar( "-fx-background-color:rgb(200, 207, 211);" )  
    btn.SetItemFontSize( 16 )  
    btn.SetButtonFontSize( 14 )  
    btn.widthButton = 150  
    btn.heightButton = 80  
   
    Dim list As List  
    list.Initialize  
    list.Add("menu 1.1")  
    list.Add("menu 1.2")  
    list.Add("menu 1.3")  
    btn.AddButtonMenu("BTN-1", path & "home.png", "menu1", list)  
   
    Dim list2 As List  
    list2.Initialize  
    list2.Add("menu 2.1")  
    list2.Add("menu 2.2")  
    list2.Add("menu 2.3")  
    btn.AddButtonMenu("BTN-2", path & "cart.png", "menu2", list2)  
   
    Dim list3 As List  
    list3.Initialize  
    list3.Add("menu 3.1")  
    list3.Add("menu 3.2")  
    list3.Add("menu 3.3")  
    btn.AddButtonMenu("BTN-3", path & "user.png", "menu3", list3)  
   
    btn.AddButton("BTN4", path & "logout.png", "button3")  
   
End Sub  
  
  
'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.  
  
Private Sub menu1_OnClickMenu( index As Int, value As String )  
   
    Log("Item menu click = " & index & ", Text = " & value)  
   
End Sub  
  
Private Sub menu2_OnClickMenu( index As Int, value As String )  
   
    Log("Item menu click = " & index & ", Text = " & value)  
   
End Sub  
  
Private Sub menu3_OnClickMenu( index As Int, value As String )  
   
    Log("Item menu click = " & index & ", Text = " & value)  
   
End Sub  
  
Private Sub button3_OnClickButton  
   
    Log("Click en Button")  
   
End Sub
```

  
  

---

  
[HEADING=2][PayPal](https://www.paypal.com/paypalme/valenciaim5)[/HEADING]  
[HEADING=2][WhatsApp](https://wa.me/584245808056)[/HEADING]  
[HEADING=1][/HEADING]