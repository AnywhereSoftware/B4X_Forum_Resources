###  BroadcastBuddy B4X Lib - Simplified Messaging and Notifications by Claude Obiri Amadu
### 01/06/2025
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/164970/)

Hello B4X Community,  
  
We’re thrilled to introduce the **BroadcastBuddy B4X SDK**, a powerful library that integrates with the BroadcastBuddy API to streamline messaging, notifications, and other communication features for your applications.  
  
[HEADING=2]**What is BroadcastBuddy?**[/HEADING]  
BroadcastBuddy is a unified communication platform that provides businesses and developers with tools for managing messaging, notifications, and email campaigns. It supports multiple communication channels, including WhatsApp, SMS, and email, allowing you to build feature-rich applications with ease.  
  

---

  
  
[HEADING=2]**Key Features**[/HEADING]  

- **WhatsApp Messaging**: Send text, media, documents, locations, polls, and contacts to WhatsApp users.
- **SMS Management**: Send single or bulk SMS messages and check your balance.
- **Email Communication**: Compose and send professional emails directly from your app.
- **OTP Services**: Generate and verify OTPs for secure authentication.
- **Account Management**: Manage your subscription and contacts.
- **Push Notifications**: Deliver real-time notifications to your users.

  

---

  
  
[HEADING=2]**Library Overview**[/HEADING]  
Below is a summary of the available classes and their functionalities:  
  
[HEADING=3]**BroadcastBuddyEmail**[/HEADING]  

- Public Sub Initialize(apiKey As String)
- Public Sub ComposeEmail(recipient As String, subject As String, message As String) As ResumableSub

[HEADING=3]**BroadcastBuddyOTP**[/HEADING]  

- Public Sub Initialize(apiKey As String)
- Public Sub GenerateOTP As ResumableSub
- Public Sub VerifyOTP(code As String) As ResumableSub

[HEADING=3]**BroadcastBuddyAccount**[/HEADING]  

- Public Sub Initialize(apiKey As String)
- Public Sub AddContact(first\_name As String, last\_name As String, email As String, birthday As String, group\_id As String, contact As String) As ResumableSub

[HEADING=3]**BroadcastBuddySMS**[/HEADING]  

- Public Sub Initialize(apiKey As String)
- Public Sub CheckBalance As ResumableSub
- Public Sub BulkSMS(recipients As String, message As String, senderId As String) As ResumableSub
- Public Sub SendSMS(recipient As String, message As String, senderId As String) As ResumableSub

[HEADING=3]**BroadcastBuddyWhatsApp**[/HEADING]  

- Public Sub Initialize(apiKey As String)
- Public Sub SessionStatus As ResumableSub
- Public Sub SendMessage(recipient As String, message As String) As ResumableSub
- Public Sub SendMedia(recipient As String, caption As String, media\_url As String) As ResumableSub
- Public Sub SendDocument(recipient As String, caption As String, media\_url As String) As ResumableSub
- Public Sub SendLocation(recipient As String, message As String, latitude As String, longitude As String) As ResumableSub
- Public Sub SendPoll(recipient As String, poll\_name As String, poll\_options As String, allow\_multiple\_answers As String) As ResumableSub
- Public Sub SendContact(recipient As String, contact As String) As ResumableSub

---

  
  
[HEADING=2]**How to Get Started**[/HEADING]  
  

1. Create an account on [Broadcast Buddy](https://portal.broadcastbuddy.app/register)
2. Head to Settings > API Configuration for API Keys
3. Add the B4X Lib to your project and use API keys to initialize

  
[HEADING=3]Example[/HEADING]  

```B4X
Sub Process_Globals  
  
    Private buddyWhatsApp As BroadcastBuddyWhatsApp  
  
    Private buddySMS As BroadcastBuddySMS  
  
End Sub  
  
  
  
Sub AppStart (Args() As String)  
  
    Dim SMSapiKey As String = "your_api_key_here"  
  
    Dim whaApiKey As String = "your_api_key_here"  
  
  
  
    ' Initialize WhatsApp  
  
    buddyWhatsApp.Initialize(apiKey)  
  
    Wait For (buddyWhatsApp.SessionStatus) Complete (response As Map)  
  
    If response <> Null Then Log("WhatsApp Status: " & response)  
  
  
  
    ' Initialize SMS  
  
    buddySMS.Initialize(SMSapiKey)  
  
    Wait For (buddySMS.CheckBalance) Complete (response As Map)  
  
    If response <> Null Then Log("SMS Balance: " & response)  
  
End Sub
```

  
  
  

---

  
  
[HEADING=2]**Documentation**[/HEADING]  
  

- [BroadcastBuddy API Documentation](https://docs.broadcastbuddy.app)
- [Get Started](https://broadcastbuddy.app)

  

---

  
  
  
![](https://www.b4x.com/android/forum/attachments/160473)