### Updated B4R-AES256 example (compatible with B4x, php and all other platforms) by KMatle
### 05/03/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/130386/)

This is an updated example how to en-/decrypt data with AES256.   
  
Libs needed: jRandomAccessFile only  
  
Notes:  
  
- As far as I know, the ESP32 doesn't support padding like PKCS5/7, so I had to do it on my own  
- Other Cyphers support padding  
- AES is a block cipher, so we have to build one block with a length of a multiple of 16  
- To build a block, padding ist used  
- e.g. if the data contains "hello" (5 chars), the next block size is 16  
- if the size of the data is equal to a multiple of 16 (e.g. 16,32,48, …) it is padded to the next block size (e.g. 16 will be 32, 32 will be 48)  
- padding means adding data (different regulated values are possible). The last byte contains the count of values added including the counter  
- example: "hello" (5 chars) will be padded to 16 chars. 16-5=11 chars/values have to be added. Last byte/value is therefor 11. 10 bytes are filled with other values (see the pad sub)  
- after decryption, the data is "depadded"  
- this works because the last byte of the added (padded) values contains the amount. So depadding means removing the filled values/bytes.  
  
Wikipedia about PKCS#5 or PKCS#7:  
  
Here the value is equal to the total amount of added/padded values. Quite simple. In our example from above, 11 is added 11 times  
![](https://www.b4x.com/android/forum/attachments/112732)  
  
See how to pad/depad in B4x here: <https://www.b4x.com/android/forum/threads/b4x-padding-depadding-pkcs7-5-and-other.130258/>  
  
  
The B4R-Example takes care of anything  
  
- data will be padded (see the sub, comes with parms to set the padding, values, etc)  
- IV and SALT will be generated for each encryption  
- Password will be hashed to 32 bytes (SHA256/AES256)  
- Data will be encrypted (AES256, using the IV)  
- the final message contains Salt+IV+encrypted message  
  
When decrypting:  
- Salt & IV are extracted (these values are public)  
- the message is decrypted and depadded  
  
In B4x (via Agraham's encryption lib) use:  
  

```B4X
C.Initialize("AES/CBC/NoPadding")
```

  
  
plus the padding example (link) from above. PKCS5/7 should work, too (if you set the parms to fill with the amount of filled values)  
  
Extract the Salt & IV from the message, set this IV and decrypt the rest. After that depad the message.