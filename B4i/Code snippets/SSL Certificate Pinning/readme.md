### SSL Certificate Pinning by Erel
### 09/29/2021
[B4X Forum - B4i - Code snippets](https://www.b4x.com/android/forum/threads/134661/)

Certificate pinning is a security feature. When set, the app will only accept the listed, per-domain, certificates. This is usually not needed as certificates must have a valid certificate chain up to the trusted root.  
Starting from iOS 14 it is quite simple to add certificate pinning.  
Full information: <https://developer.apple.com/news/?id=g9ejcf8y>  
  
Steps:  
  
1. Download the **intermediate** **or root** certificate PEM file. In Firefox it looks like this:   
  
![](https://www.b4x.com/android/forum/attachments/119688)  
2. Install OpenSSL: <https://slproweb.com/products/Win32OpenSSL.html>  
  
3. Run: cat ca.pem | openssl x509 -inform pem -noout -outform pem -pubkey | openssl pkey -pubin -inform pem -outform der | openssl dgst -sha256 -binary | openssl enc -base64  
  
4. Add the following code to the main module. Replace the domain and the base64 key.  
  
Example:  

```B4X
#PlistExtra: <key>NSAppTransportSecurity</key>  
#PlistExtra: <dict>  
#PlistExtra:     <key>NSPinnedDomains</key>  
#PlistExtra:     <dict>  
#PlistExtra:         <key>b4x.com</key>  
#PlistExtra:         <dict>  
#PlistExtra:             <key>NSIncludesSubdomains</key>  
#PlistExtra:             <true/>  
#PlistExtra:             <key>NSPinnedCAIdentities</key>  
#PlistExtra:             <array>  
#PlistExtra:                 <dict>  
#PlistExtra:                     <key>SPKI-SHA256-BASE64</key>  
#PlistExtra:                     <string>fL2WqC2l5uf2+UsREkC4vpvX1l1w6N47XmmbDTOPHoM=</string>  
#PlistExtra:                 </dict>  
#PlistExtra:             </array>  
#PlistExtra:         </dict>  
#PlistExtra:     </dict>  
#PlistExtra: </dict>
```

  
  
You can test it by changing the domain to a different one and then make a a request to the new domain.