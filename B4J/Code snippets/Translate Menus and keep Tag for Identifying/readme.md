### Translate Menus and keep Tag for Identifying by Midimaster
### 09/22/2020
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/122653/)

Here is a fast solution to design Menus and translate them to other languages. When you design the menu, there is no need to add a tags at this moment.  
  
When the app starts it converts all TEXT-properties to TAG-properties and then replace the TEXT with the local translation  
  
then JSON-String can simply look like this:  

```B4X
[  
    {Text: "File", Children:  
        [  
            "New", "Load", "Save",  
            {Text: "Export", Children: ["Zip File", "Tar File"]},  
            "-",  
            "Close"  
        ]  
    },  
    {Text: "Edit", Children:["Cut", "Copy", "Paste"] },  
    {Text: "Help", Children:  
      
            {Text: "Checked Item", Selected: True},  
            {Text: "Disabled Item", Enabled: False},  
            "normal item"  
        ]  
    }  
]
```

  
  
This function will create the tags and the translation  

```B4X
Private Sub IterateMenuItems(Items As List)  
    For Each locItem As MenuItem In Items  
        If locItem Is Menu Then  
            Dim nextStep As Menu = locItem  
            IterateMenuItems( nextStep.MenuItems)  
        Else  
            locItem.Tag=locItem.Text  
        End If  
        locItem.Text=Translate(locItem.Text)  
    Next  
End Sub
```

  
  
  
here is a sample code:  

```B4X
Sub Process_Globals  
…  
    Private Menu As MenuBar  
    Private rand As Int =65 ' for testing short cuts in translation-simulation  
End Sub  
  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("menutest")  
    MainForm.Show  
    IterateMenuItems(Menu.Menus)  
End Sub  
  
  
Private Sub Menu_Action  
    Dim item As MenuItem= Sender  
    Log(item.text & " " & item.tag)  
End Sub  
  
  
Private Sub IterateMenuItems(Items As List)  
    For Each locItem As MenuItem In Items  
        If locItem Is Menu Then  
            Dim nextStep As Menu = locItem  
            IterateMenuItems( nextStep.MenuItems)  
        Else  
            locItem.Tag=locItem.Text  
        End If  
        locItem.Text=Translate(locItem.Text)  
    Next  
End Sub  
  
  
Sub Translate(old As String) As String  
    rand=rand+1  
    Return  "_" & Chr(rand) & "-Translated"  
  
End Sub
```

  
  
  
The only Disadvantage:  
Mnemonics (Shortcuts) in the translated words will work, but throw an error message.