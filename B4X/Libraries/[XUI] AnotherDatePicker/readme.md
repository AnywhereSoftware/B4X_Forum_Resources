###  [XUI] AnotherDatePicker by Erel
### 09/13/2020
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/85160/)

**Edit: don't use this library. Use B4XDialog + B4XDateTemplate from XUI Views library instead.**  
  
This is a cross platform version of AnotherDatePicker custom view based on XUI library.  
  
![](https://www.b4x.com/basic4android/images/SS-2017-10-18_18.02.02.png) ![](https://www.b4x.com/basic4android/images/SS-2017-10-18_18.02.37.png) ![](https://www.b4x.com/basic4android/images/SS-2017-10-18_18.03.11.png)  
  
Designer properties:  
![](https://www.b4x.com/basic4android/images/SS-2017-10-18_18.06.23.png)  
  
The user can enter the date directly into the field. The field border color will change to red when the value is invalid.  
  
Notes:  
  
- B4J buttons raise the Action event. This is handled in the code with:  

```B4X
#if B4J  
Private Sub btnCancel_Action  
#Else  
Private Sub btnCancel_Click  
#End If  
   Hide  
End Sub
```

  
  
Click event will be added in the next version of B4J.  
  
- It depends on XUI v1.3+.  
- If you are using a B4i version before 4.4 (stable) then you need to remove the reference to iDateUtils library and add the DateUtils code module instead. This is related to a bug fixed in B4i v4.4.  
- You might see a warning while debugging about a missing RaiseSynchronousEvent attribute. You can ignore it. It is related to changing the text programmatically while handling the TextChanged event.  
- This is quite a complicated custom view and it is a good example of using XUI library to write cross platform code.  
  
**Versions**  
  
1.03 - Fixes an issue with CloseAllDialogs always returning True (<https://www.b4x.com/android/forum/threads/b4x-xui-anotherdatepicker.85160/page-2#post-581920>).  
1.02 - Fixes an issue with dates before 1970.  
1.01 - Sets the elevation of the dialog panel.  
  
Latest version is attached separately.