### #HashTagHelper by jahswant
### 05/10/2021
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/61808/)

This is a library designed for highlighting hashtags ("#example") and catching click on them.It wraps this github project. [Enjoy](https://github.com/Danylo2006/HashTagHelper.Enjoy) it. <https://github.com/Danylo2006/HashTagHelper>  
**HashTagHelper  
Version:** 0.2  

- **HashTagHelper**
Events:

- **onHashTagClicked** (hashTag As String)

- **Methods:**

- **Handle** (textView As TextView)
*Handles A TextView  
 textView:* - **Initialize** (EventName As String, colorPrimary As Int)
- **IsInitialized As Boolean**

  
Example :  
  

```B4X
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
    'These variables can only be accessed from this module.  
  
    Private HashTagTxt As EditText  
    Dim HashTagObj As HashTagHelper  
    Dim Txt2 As String = "This #system can #also be used #really well to make #shopping #lists. #Generally, you might #remember an item you #have to #pick up and #message your #better half or your #roommate about it. But as you #continue messaging with #each other, #that item gets lost #somewhere in your chat logs. #Next time, #just add a #hashtag to your #message."  
    Dim Txt As String = "A #hashtag can solve that #conundrum. When #someone sends you a #message that you #want to be able to refer to later, just type and send the message #important. #Later, when searching, all you #have to do is look up this tag, #without having to remember any keywords from the #message."  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    'Do not forget to load the layout file created with the visual designer. For example:  
    Activity.LoadLayout("Layout1")  
    HashTagObj.Initialize("Hth",Colors.Blue)  
    HashTagObj.Handle(HashTagTxt)  
    HashTagTxt.Text = Txt&Txt2  
End Sub  
  
Sub HashTag_onHashTagClicked(HashTag As String)  
  ToastMessageShow(HashTag,True)  
End Sub
```

  
![](https://www.b4x.com/android/forum/attachments/40103)