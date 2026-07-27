### Edittext verify input by jkhazraji
### 07/22/2026
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/171621/)

Using edittext.setError() and Regex we can verify the input of the user in an edittext box, by identifying the pattern of the input text  
and setting the error flag or discoloring the text whenever it did not comply to the required rule as email and currency. In the same way   
as in the example we can impose the rule of the input, e.g., a date or a phone number.   

```B4X
#Region  Project Attributes  
    #ApplicationLabel: B4A Example  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
        Private xui As XUI  
End Sub  
  
Sub Globals  
      
    Private edtMail As EditText  
    Private edtPrice As EditText  
      
    Private Label2 As Label  
    Private Label1 As Label  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
    Activity.LoadLayout("Layout")  
    edtMail.Initialize("edtMail")  
    Activity.AddView(edtMail, 30dip, 10%y, 90%x, 50dip)  
    edtMail.As(JavaObject).RunMethod("setError",Array("Enter valid email"))  
    edtMail.As(B4XView).SetColorAndBorder(Colors.Transparent,1dip, Colors.Black, 5dip)  
      
    edtPrice.Initialize("edtPrice")  
    Activity.AddView(edtPrice, 30dip, 26%y, 90%x, 50dip)  
    edtPrice.As(JavaObject).RunMethod("setError",Array("Enter valid currency value"))  
    edtPrice.As(B4XView).SetColorAndBorder(Colors.Transparent,1dip, Colors.Black, 5dip)  
End Sub  
  
Sub edtMail_TextChanged (Old As String, New As String)  
    ValidateEmail(New)  
End Sub  
Sub edtPrice_TextChanged (Old As String, New As String)  
    ValidatePrice(New)  
End Sub  
Sub ValidateEmail(Text As String)  
      
    Dim EmailPattern As String = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$"  
      
    ' Check if empty - clear error if empty  
    If Text.Trim.Length = 0 Then  
        edtMail.As(JavaObject).RunMethod("setError", Array(Null))  
        Return  
    End If  
      
    ' Check if matches pattern  
    Dim matcher As Matcher  
    matcher = Regex.Matcher(EmailPattern, Text)  
      
    If matcher.Find Then  
        edtMail.TextColor=Colors.Black  
        edtMail.As(JavaObject).RunMethod("setError", Array(Null))  
    Else  
        ' Invalid email - show error  
        edtMail.TextColor=Colors.Red  
        edtMail.As(JavaObject).RunMethod("setError", Array("Enter valid email, e.g., john.doe@xyz.com"))  
    End If  
End Sub  
Sub ValidatePrice(Text As String)  
    Dim PricePattern As String = "^\$?\d{1,3}(,\d{3})*(\.\d{2})?$|^\$?\d+(\.\d{2})?$"  
      
    If Text.Trim.Length = 0 Then  
        edtPrice.As(JavaObject).RunMethod("setError", Array(Null))  
            Return  
    End If  
      
    Dim matcher As Matcher  
    matcher = Regex.Matcher(PricePattern, Text)  
      
    If matcher.Find Then  
        edtPrice.TextColor=Colors.Black  
        edtPrice.As(JavaObject).RunMethod("setError", Array(Null))  
      
    Else  
        edtPrice.TextColor=Colors.Red  
        edtPrice.As(JavaObject).RunMethod("setError", Array("Enter valid currency value (e.g., $35.00)"))  
    End If  
End Sub  
  
  
Sub Activity_Resume  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub
```