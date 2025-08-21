### [B4x]Google Authenticator OTP (others will do, too) complete example with code by KMatle
### 06/26/2020
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/119479/)

Wikipedia: [Google Authenticator](https://en.wikipedia.org/wiki/Google_Authenticator)  
  
Most websites where you have to log in offer to protect your account by using a [multi-factor authentication](https://en.wikipedia.org/wiki/Multi-factor_authentication). Here you can use an app like Google Authenticator (GA) which shows a 6 or 8 digit number which you have to type in when you log in.  
  
How it works:  
  

- The website generates a secrect key for every user (stored with the user credentials)
- This key is then Base32 encoded (not a typo and I have no clue, why because it's not really used, except to display it to the user)
- With some other tags and the key a URL is formed (tags are user, lable, issuer and the secret)

```B4X
otpauth://totp/B4xLogin:B4xUser?secret=KNSWG4TFORIGC43TO5XXEZA=&issuer=B4X.com
```

  

- The complete URL string is then presented to the user as a QRCode which can then be scanned by the GA app (or any other app to generate OTP's)
- Another way is to enter the tags by hand (which is not that user friendly but here you don't need a device which can scan QR codes)
- This is done ONE time. There's no connection between the OTP app and your website
- All tags (see above) can be chosen like you want, but should identify your website/organization)
- The app creates a new account and shows a 6 digit number
- This number is calculated from the unixtime in ticks devided by the seconds the number is valid (here: 30),
- So every 30 seconds a new number is calculated
- Calculation (see the www for details): Hash the timestamp with the secret key (SHA1 -> others are possible to get a longer number), do some bit shifting and there you have the 6 digit number
- When loggin in, the server knows the secret key and the time and calculates the number, too
- If both match, everything is good
- As it is time based, both sides have the same time set

Note: If the user looses the phone or gets a new one, he/she must copy the tags (the account) to the new device. I forgot about that last year and had to talk to my bank to get new credentials. Another way is to let the user print the tags or offer a download in a file with the tags.  
  
  
What the example does:  
  
- Generate the auth URL inlc. Base32 encoding.  
- Show a QR-Code (can be scanned by the GA app). You can this QR for a quick test.  
- Save it to a file (just for fun).  
![](https://www.b4x.com/android/forum/attachments/96234)  
  
- show the OTP number (changes every 30 secs)  
- open the GA app and start the B4J app to see the numbers changing (and hopefully match)   
  
  
  
PS: The code could be optimized (like the Base32 encoding or the Bit shifting).  
  
Libs used:  
![](https://www.b4x.com/android/forum/attachments/96233)