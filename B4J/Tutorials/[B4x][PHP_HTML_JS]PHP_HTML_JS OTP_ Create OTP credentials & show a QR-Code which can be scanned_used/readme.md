### [B4x][PHP/HTML/JS]PHP/HTML/JS OTP: Create OTP credentials & show a QR-Code which can be scanned/used with Authenticator apps by KMatle
### 04/29/2021
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/130256/)

Here's an PHP/HTML example:  
  
- create OTP credentials (including Base32 encoding)  
- show a html page with these credentials and a generated QR-Code  
- this code can be scanned and used with all Authenticator-Apps  
  
What is it good for?  
  
- the Authenticator is generating a time and pwasword based 6 digit pin number  
- when you have an app in which a user can log in, you can use this pin to add more security  
- here the user opens the authenticator app and gets a 6-digit pin which changes every 30 secs  
- beneath a username & password, the user types in the pin  
- in your app you check username, password and the pin = succesful login  
  
Notes:  
  
- as it uses php you need to run it under Apache (Webserver). No additional ressources will be needed, jut the contents of the zip-file.  
  
Other examples:  
  
<https://www.b4x.com/android/forum/threads/b4x-use-otp-in-your-apps-php-code-also-included.130169/>  
<https://www.b4x.com/android/forum/threads/b4x-google-authenticator-otp-others-will-do-too-complete-example-with-code.119479/#content>