### Firebase Email/Password authentication by Enrico Fuoti
### 02/25/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/114208/)

[SIZE=5]Wrap to integrate firebase auth email/password authentication.   
This library is partially copied from DonManfred authex lib.  
Since there is no other working wrap of firebase email/password authentication I decided to challenge myself on creating my first library.  
It may not be perfect, but it looks like working.  
for reference visit: <https://firebase.google.com/docs/auth/android/password-auth?authuser=4>[/SIZE]  
[INDENT][/INDENT]  
[SIZE=5]**FirebaseAuthEmail  
Version:** 1.4[/SIZE]  
  
**[SIZE=5]Events: [/SIZE]**  
[INDENT]

- **[SIZE=5]usercreated [/SIZE]**[SIZE=5](success As Boolean, User As FirebaseAuthEmailUser, info As String)[/SIZE]
- [SIZE=5]**createfailure** (success As Boolean, info As String)[/SIZE]
- **[SIZE=5]signedin [/SIZE]**[SIZE=5](success As Boolean, User As FirebaseAuthEmailUser, info As String) [/SIZE]
- [SIZE=5]**signedinfailure** (success As Boolean, info As String)[/SIZE]
- **[SIZE=5]passwordreset [/SIZE]**[SIZE=5](success As Boolean, info As String)[/SIZE]
- **[SIZE=5]passwordresetfailure[/SIZE]**[SIZE=5] (success As Boolean, info As String)[/SIZE]
- [SIZE=5]**userupdated** (success As Boolean, info As String) <— new[/SIZE]
- [SIZE=5]**userdeleted** (success As Boolean, info As String) <— new[/SIZE]
- **[SIZE=5]gettoken [/SIZE]**[SIZE=5](success As Boolean, token As String, info As String)[/SIZE]

[/INDENT]  
[SIZE=5]**Methods**: [/SIZE]  
[INDENT]

- **[SIZE=5]Initialize[/SIZE]**[SIZE=5] (eventName As String)[/SIZE]
- **[SIZE=5]createUserWithEmailAndPassword [/SIZE]**[SIZE=5](email As String, password As String, [SIZE=5]displayName As String, photoUrl As String[/SIZE]**[SIZE=5])[/SIZE]**[/SIZE]) [SIZE=4]<— modified - displayName and photoUrl parameters. added in 1.4 version [/SIZE]
- [SIZE=5]**signInWithEmailAndPassword** (email As String, password As String)[/SIZE]
- [SIZE=5]**sendPasswordResetEmail** (email As String)[/SIZE]
- **[SIZE=5]currentToken ()[/SIZE]**
- **[SIZE=5]updateProfile ([/SIZE]**[SIZE=5]displayName As String, photoUrl As String[/SIZE]**[SIZE=5]) [/SIZE]**[SIZE=5]<— new[/SIZE]
- **[SIZE=5]deleteuser () [/SIZE]**[SIZE=5]<— new[/SIZE]
- [SIZE=5]**SignOut**[/SIZE]

[/INDENT]  
  
**[SIZE=5]Properties[/SIZE]:**  

- **[SIZE=5]CurrentUser As [/SIZE]**[SIZE=5]FirebaseAuthEmailUserWrapper[/SIZE][SIZE=5] *[read only]*[/SIZE]

  
  
**[SIZE=5]FirebaseAuthUser[/SIZE]**  
  
[SIZE=5]**Methods:**[/SIZE]  

- [SIZE=5]**delete**[/SIZE]
- [SIZE=5]**sendEmailVerification**[/SIZE]
- [SIZE=5]**updateEmail** (email As String)[/SIZE]
- [SIZE=5]**updatePassword** (password As String)[/SIZE]

[SIZE=5]**Properties:**[/SIZE]  

- [SIZE=5]**Anonymous As Boolean** *[read only]*[/SIZE]
- [SIZE=5]**DisplayName As String** *[read only]*[/SIZE]
- [SIZE=5]**Email As String** *[read only]*[/SIZE]
- [SIZE=5]**EmailVerified As Boolean** *[read only]*[/SIZE]
- **[SIZE=5]IsInitialized **As Boolean** *[read only]*[/SIZE]**
- [SIZE=5]**PhotoUrl As String** *[read only]*[/SIZE]
- [SIZE=5]**ProviderData As List** *[read only]*[/SIZE]
- [SIZE=5]**ProviderId As String** *[read only]*[/SIZE]
- [SIZE=5]**Providers As List** *[read only]*[/SIZE]
- [SIZE=5]**Uid As String** *[read only]*[/SIZE]