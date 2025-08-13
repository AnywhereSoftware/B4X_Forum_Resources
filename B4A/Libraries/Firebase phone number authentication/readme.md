### Firebase phone number authentication by Enrico Fuoti
### 12/18/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/114218/)

[SIZE=5]Here is my second lib, a wrap to integrate firebase auth phone number authentication.  
It is working nicely on my app.   
for reference visit: [Authenticate with Firebase on Android using a Phone Number](https://firebase.google.com/docs/auth/android/phone-auth?authuser=4)  
  
**FirebaseAuthPhone  
  
Version: 1.9   
  
  
Events:**[/SIZE]  

- [SIZE=5]**phoneverification** (success As Boolean, info As String)[/SIZE]
- [SIZE=5]**phonesignedin** (success As Boolean, User As FirebaseAuthPhoneUser, info As String)[/SIZE]
- [SIZE=5]**oncodesent** (success As Boolean, verificationid As String)[/SIZE]
- **[SIZE=5]gettoken [/SIZE]**[SIZE=5](success As Boolean, token As String, info As String)[/SIZE]

[SIZE=5]**Methods**:[/SIZE]  

- [SIZE=5]**Initialize** (eventName As String)[/SIZE]
- [SIZE=5]**startPhoneNumberVerification** (phoneNumber As String)[/SIZE]
- [SIZE=5]**verifyPhoneNumberWithCode** (verificationId As String, code As String)[/SIZE]
- **[SIZE=5]currentToken ()[/SIZE]**
- [SIZE=5]**SignOut**[/SIZE]

  
[SIZE=5]**Properties:**[/SIZE]  

- [SIZE=5]**CurrentUser As** FirebaseAuthPhoneUserWrapper *[read only]*[/SIZE]

  
  
[SIZE=5]**FirebaseAuthPhoneUser  
  
Properties:**[/SIZE]  

- [SIZE=5]**Anonymous As Boolean** *[read only]*[/SIZE]
- [SIZE=5]**IsInitialized As Boolean *[read only]***[/SIZE]
- [SIZE=5]**ProviderData As List** *[read only]*[/SIZE]
- [SIZE=5]**ProviderId As String** *[read only]*[/SIZE]
- [SIZE=5]**Providers As List** *[read only]*[/SIZE]
- [SIZE=5]**Uid As String** [/SIZE]*[SIZE=5][read only][/SIZE]*

  
**Version1.8** released. It has been compiled with latest Firebase SDK and works with B4A 12.0+  
**Version1.9** released.Fixes a bug that caused application to crash when a wrong or expired code was entered.