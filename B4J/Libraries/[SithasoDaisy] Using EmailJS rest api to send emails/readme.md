### [SithasoDaisy] Using EmailJS rest api to send emails by Mashiane
### 03/18/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/146902/)

Hi there  
  
The purpose of this tutorial is showing the functionality of sending emails using EmailJS.  
  
This was discussed on this link:  
  
<https://www.b4x.com/android/forum/threads/bananovuetifyad3-sending-emails-via-emailjs-rest-api.142767/#content>  
  
Now we have a Sithaso class to do this.  
  
What you will learn  
  
1. Using SDUITable to define a property bag (e.g. preference dialog/form)  
2. Adding a button to the property bag.  
3. Setting default values to the property bag  
4. reading values from the property bag  
5. Initializing the SDUIEmailJS class to send an email  
  
![](https://www.b4x.com/android/forum/attachments/140372)  
  

- Open an account, 200 emails per month. <https://www.emailjs.com/>
- Get your service id from Email Services
- Get your public key from your account.
- Create a template that you will use for your email.

  
1. Building the property bag  
  

```B4X
tbEmail.ClearPropertyBag  
    tbEmail.AddPropertyTextBox("ServiceId", "Service Id", "", "", True, "")  
    tbEmail.AddPropertyTextBox("UserId", "Public Key", "", "", True, "")  
    tbEmail.AddPropertyTextBox("TemplateId", "Template Id", "", "", True, "")  
    tbEmail.AddPropertyTextBox("FromName", "From Name", "", "", False, "")  
    tbEmail.AddPropertyTextBox("ReplyTo", "Reply To", "", "", False, "")  
    tbEmail.AddPropertyTextBox("ToEmail", "To Email", "", "", True, "")  
    tbEmail.AddPropertyTextBox("ToName", "To Name", "", "", False, "")  
    tbEmail.AddPropertyTextBox("CcTo", "Cc To", "", "", False, "")  
    tbEmail.AddPropertyTextArea("Subject", "Subject", "", "", True, "")  
    tbEmail.AddPropertyTextArea("Message", "Message", "", "", False, "")  
      
    tbEmail.AddPropertyActionButton("btnSend", "Send Email", app.COLOR_CYAN)
```

  
  
2. Getting the bag content and sending an email.  
  

```B4X
Sub tbEmail_btnSend (e As BANanoEvent)  
    tbEmail.SetPropertyActionButtonLoading("btnSend", True)  
    Dim pbag As Map = tbEmail.GetPropetyBag  
    Log(pbag)  
      
    SDUIEmailJS1.CcTo = tbEmail.GetPropertyValue("CcTo")  
    SDUIEmailJS1.FromName = tbEmail.GetPropertyValue("FromName")  
    SDUIEmailJS1.Message = tbEmail.GetPropertyValue("Message")  
    SDUIEmailJS1.ReplyTo = tbEmail.GetPropertyValue("ReplyTo")  
    SDUIEmailJS1.ServiceId = tbEmail.GetPropertyValue("ServiceId")  
    SDUIEmailJS1.Subject = tbEmail.GetPropertyValue("Subject")  
    SDUIEmailJS1.TemplateId = tbEmail.GetPropertyValue("TemplateId")  
    SDUIEmailJS1.ToEmail = tbEmail.GetPropertyValue("ToEmail")  
    SDUIEmailJS1.ToName = tbEmail.GetPropertyValue("ToName")  
    SDUIEmailJS1.PublicKey = tbEmail.GetPropertyValue("UserId")  
    Dim x As String = banano.Await(SDUIEmailJS1.SendEmail)  
    tbEmail.SetPropertyActionButtonLoading("btnSend", False)  
    app.ShowSwal(x)  
End Sub
```