### Generate QR-Code w. RSA Public Key and scan/load it by KMatle
### 04/27/2020
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/116926/)

Here's an example how to generate a QR code containing a RSA Public Key (can be any data you need) in B4J and scan/load the key in B4A (based on the B4x QR code examples from Erel).  
  
Some apps (like Threema) exchange encryption keys by scanning a QR code containing the key which is showed on the phone's screen of the person you want to add to your contacts. Benefit: It is not transmitted thru a network and kept secret.   
  
For a better handling I've used B4J to display the QR code as it is easier for an example (otherwise you need two Android devices).  
  
Needed libs:  
  
B4A  
![](https://www.b4x.com/android/forum/attachments/92711)  
  
B4J  
![](https://www.b4x.com/android/forum/attachments/92712)  
   
  
In B4J:  
  
- a RSA Private/Public Key pair is generated  
- the Public Key is converted to a Base64 string (from Bytes). "PubKey:" is added as a header (helpful to check later if the scanned code is containing a Public Key)  
- a QR code is shown with the Public key  
  
In B4A:  
  
- the QR code scanner is initialized with "QR\_CODE" only (so it's faster only scanning for QR codes) and is scanning the camera's live picture for a QR code  
- If the content starts with "PubKey:" it's converted back to Bytes and loaded.  
  
**This is just a basic example**. Use the search function if you need further details of RSA or other encryption methods and how to use them.  
  
You can use any data you need to exchange. Just convert it to a Base64 string (if it's a Byte array).