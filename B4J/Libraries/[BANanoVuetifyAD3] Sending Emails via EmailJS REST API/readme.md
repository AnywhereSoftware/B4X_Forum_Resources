### [BANanoVuetifyAD3] Sending Emails via EmailJS REST API by Mashiane
### 09/06/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/142767/)

Hi there  
  
I needed a simple and quick API to send emails and found [EmailJS](https://www.emailjs.com/). There are a variety of other emails you can find. One of the things I like about this is the ease if creating templates and the 200 emails per month FREE. Just enough to test my ideas around.  
  
The sign up process is also easy. On the email template you can use any field you want e.g {{I\_love\_b4x}} and you can feed it whatever content you want during sending.  
  
For example, in this template below I have used a number of {{ moustache }} variables to make my point.  
  
![](https://www.b4x.com/android/forum/attachments/133380)  
  
The code is fairly straigh forward also with the axios POST, you can also use BANanoFetch for this. After sign up, you can get your service\_id (after you have added a sender service) and your user\_id (from your account) i.e publick key  
  

```B4X
Dim axios As BANanoAxios  
    axios.Initialize("https://api.emailjs.com/api/v1.0/email/send")  
    axios.AddData("service_id", "XXXXXXXXX")  
    axios.AddData("template_id", "XXXXXX")  
    axios.AddData("user_id", "XXXXXXXXXX")  
    axios.AddData("template_params.subject", XXXXXX)  
    axios.AddData("template_params.to_email", XXXXXX)  
    axios.AddData("template_params.from_name", XXXXXX)  
    axios.AddData("template_params.to_name", XXXXXX)  
    axios.AddData("template_params.from_name", XXXXXX)  
    axios.AddData("template_params.message", XXXXXX)  
    axios.AddData("template_params.reply_to", XXXXX)  
    axios.AddData("template_params.cc_to", XXXXXX)  
    axios.SetContentTypeApplicationJSON  
    BANano.Await(axios.PostWait)  
    vuetify.Loading(False)  
    '  
    Select Case axios.StatusText  
    Case "OK"     
        BANano.Await(vuetify.ShowSwalSuccessWait("Challenges", updates.Size & " challenge(s) were sent to The IDP!", "Ok"))  
    Case Else  
        BANano.Await(vuetify.ShowSwalWarningWait("Challenges", axios.StatusText, "Ok"))  
    End Select  
  
Happy BVAD3 Coding!
```