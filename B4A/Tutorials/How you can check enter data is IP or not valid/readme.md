### How you can check enter data is IP or not valid by modiran_ghaneipour
### 05/06/2025
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/166891/)

How you can check enter data is IP or not valid  
  
when user input Ip in textbox, you must check this.  
one way is using **Regex  
  
for this i have source code. i test it and work true:**  

```B4X
Sub ValidateIP(ip As String) As Boolean  
    If ip.EqualsIgnoreCase("localhost") Then Return True  
      
    Dim pattern As String  
    pattern = "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"  
      
    Dim matcher As Matcher  
    matcher = Regex.Matcher(pattern, ip)  
      
    Return matcher.Find  
End Sub
```

  
  
  
  
in pattern :  
25[0-5] : it is 3 char then start via 25 and right char only between 0 to 5 (250-251-252-253-254-255)  
2[0-4][0-9] : it is 3 char then start with 2 and center char is between 0 to 4 and right char between 0 to 9 (200-201-202-…-243-244-245-…-248-249)  
[01]?[0-9][0-9] : it is 0 char to 3 char then first only 0 or 1 and center char is between 0 to 9 and right char is between 0 to 9 (0-1-2-3-…9-10-11-…99-100-101-102-…-199)  

```B4X
Dim userInput As String  
userInput = EditText1.Text.Trim 'Ip is not valid  
  
If ValidateIP(userInput) Then  
    ToastMessageShow("IP is Valid", True)  
Else  
    ToastMessageShow("IP is not valid. try again or call Ghaneipour", True)  
End If
```

  
   
  
for local host use this code at first of function: If ip.EqualsIgnoreCase("localhost") Then Return True