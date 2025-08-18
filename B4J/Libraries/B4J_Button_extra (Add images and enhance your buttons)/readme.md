### B4J_Button_extra (Add images and enhance your buttons) by fernando1987
### 11/21/2021
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/136222/)

![](https://www.b4x.com/android/forum/attachments/122074)  
  
**B4j\_Button\_extra**  
   
  
**Autor:** Fernando Arevalo  
**Version:** 0.01  

- **B4j\_Button\_extra**

- **Functions:**

- **Show** (btn As Button, image As String, color1 As String, color2 As String, width As Int, heigth As Int)

  
**Example:**  
  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Button1 As B4XView  
    Dim s As Button_extra  
    Private Button2 As Button  
    Private Button3 As Button  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
    s.Initialize  
    s.show(Button1, "info.png", "#61a2b1", "#2A5058",48,48)  
    s.show(Button2, "store.png", "#AE8DFB", "#5D49A3",48,48)  
    s.show(Button3, "home.png", "#FF86A4", "#E43846",48,48)  
End Sub  
  
Sub Button1_Click  
    xui.MsgboxAsync("Hello World!", "B4X")  
End Sub
```

  
  
  
**NOTE:**   
  
This library is **not free**, because, it cost a lot of time and gray hair to create such views.  
[Donations](https://www.paypal.com/paypalme/hazlofacil) from 5$ are valid. (You can [donate](https://www.paypal.com/paypalme/hazlofacil) any amount you want :))  
Please **write B4J\_Button\_extra** in the order description, thanks.  
  
**Paypal:** [email]hazlofacil87@gmail.com[/email]  
  
Thanks for your understanding. :)  

1. Donate
2. I will send you an e-mail with the code to decrypt the .zip file
3. Done