### IOS like Spinner by Guenter Becker
### 11/19/2020
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/124649/)

Version: 1.5  
Name: **IOSspinner**  
Language: B4A  
(C) TechDoc G.Becker, Royalty Free for personel and commercial Use only for Forum Members.  
  
***IOSspinner*** is a custom control with designer support.  
  
![](https://www.b4x.com/android/forum/attachments/103091)  
The control mimicks the spinner used by IOS/Apple. The controls features are:  

- simply to use
- simply to parametrize by custom properties
- modern look
- select one ore more items
- choose between None, CheckBox and RadioButton to attach
- choose Text size and color
- choose Item row height
- open, hide, abort spinner with button click
- change background image
- inbuild scroll view

**Attached Files - updated Version 1.6: **‼*New*****   

- IOSspinner.B4Xlib - the library
- IOSspinner.ZIP - Example B4A Project
- IOSspinnerRessources.ZIP - set of background images
- Screenshot

  
To use the control copy the attached file ***IOSspinner.b4xlib*** into your addional libraries folder. If done check the needed libraries in the libraries tab:  

- B4XCollections
- Core
- Phone
- XUI
- XUIViews
- IOSspinner

Next open the designer and place the custom control *IOSspinner* from customviews tab at your desired place. Set the Basic and custom Properties as you like.  
  
**Custom Properties:  
ID ‼*New***  
A String value to help to identify which spinner is clicked if there are more than one on the layout.  
***Only One***  
If checked you can only one item select, If unchecked multiple items can be selected by checking a checkbox or radio button.  
***Type***  
*None* = use only a label, *CheckBox* = use a checkbox, *RadioButton* = use a Radiobutton all right next to the lable.  
***Image***  
The Filename of the spinners background image loaded from the \Files Folder.  
***Row Height***  
The height of the item row.  
***Text color***  
The color of the item text.  
***Text Size***  
The Size of the item text.  
  

```B4X
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
  
    ' set Spinner items  
    ' (ID, Text)  
    IOSspinner1.SpinnerItems.Put("A","Text A")  
    IOSspinner1.SpinnerItems.Put("B","Text B")  
    IOSspinner1.SpinnerItems.Put("C","Text C")  
    IOSspinner1.SpinnerItems.Put("D","Text D")  
    IOSspinner1.SpinnerItems.Put("E","Text E")  
    IOSspinner1.Spinner_build  
End Sub
```

  
  

```B4X
' get spinner click result/s  
' Result Map Key = ID, Value = checked  
Sub IOSspinner_ItemClicked(ID as String, Result as Map)  '‼New   
    If Result.Size= 1 Then ' only one item selected  
        Select Result.GetKeyAt(0)  
            Case "A"  
                Log ("A")  
            Case "B"  
                Log ("B")  
            Case "C"  
                Log ("C")  
            Case "D"  
                Log ("D")  
            Case "E"  
                Log ("E")  
        End Select  
    Else If Result.Size > 1 Then ' multiple items selected/checked  
        For Each k As String In Result.Keys  
            If Result.Get(k) = True Then  
                Select k  
                    Case "A"  
                        Log ("A")  
                    Case "B"  
                        Log ("B")  
                    Case "C"  
                        Log ("C")  
                    Case "D"  
                        Log ("D")  
                    Case "E"  
                        Log ("E")  
                End Select  
            End If  
        Next  
    End If  
End Sub
```

  
  
**Notice**: In your Designer please check the property 'Event'. **IOSspinner is correct and not IOSspinner1!** If neccessary correct it.  
  
As you see in the code a MAP Variable is returned by the item click event.  
If you have choosen 'Only one' Property as *True* the MAP has one key the value is always false and may be ignored.  
If you have choosen 'Only One' as *False* then the MAP has as much Key entries as you selected in the Spinner.  
Te MAP key is the ID from the Spinner items setup (see first code window above).  
  
**Notice:**  
IF you choose 'Only one' as *True* then no Checkbox or RadioButton is shown. If you click on the desired item (label) then the Spinner is closed and the item ID is returned.  
IF you choose 'Only one' as *False* you have to choose a value of the 'Type' Property (None , CheckBox , RadioButton) for example see the screenshot image on top.  
In this case the spinner is not closed by clicking on an item! Please check all the items you desire. If ready click on any of the item labels and hold mouse button down for long click. This closes the spinner and returns the results.  
  

```B4X
' open/close spinner  
Sub Button1_Click  
    IOSspinner1.mBase.Visible=Not(IOSspinner1.mBase.Visible)  
    If IOSspinner1.mBase.Visible=False Then IOSspinner1.reset  
End Sub
```

  
  
**Notice:**  
If you have open the spinner with the button and you click the button again then this is like an abort. The spinner is closed and all checked/selected items are resetted.