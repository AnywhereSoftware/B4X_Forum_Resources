###  B4J/B4A: AES-GCM 256-bit encryption (Optional 128‑bit Salt) by Peter Simpson
### 02/10/2026
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/170268/)

Hello Everyone,  
Here is a B4J/B4A AES-GCM Encryption library, I created it for a project. Hopefully the B4X community will find this library extremely useful.  
  
**About AES‑GCM:**  
AES‑GCM (Advanced Encryption Standard with Galois/Counter Mode) is a symmetric‑key authenticated encryption algorithm that provides both data confidentiality and integrity. It uses AES‑256 in Counter (CTR) mode for encryption and a Galois Message Authentication Code (GMAC) to generate an authentication tag, making it ideal for high‑speed, secure applications like network traffic (MACsec) and data‑at‑rest encryption.  
  
**B4J library tab:**  
![](https://www.b4x.com/android/forum/attachments/169863)  
  
**B4J Images:**  
![](https://www.b4x.com/android/forum/attachments/169790)  
  
**B4A library tab:**  
![](https://www.b4x.com/android/forum/attachments/169864)  
  
**B4A Images:**  
![](https://www.b4x.com/android/forum/attachments/169791)  
  

```B4X
    Enc.PutString("UserName", TxtName.Text)  
    Enc.PutInt("Age", TxtAge.Text)  
    Enc.PutBoolean("IsPro", ChkPro.Value)
```

  
  

```B4X
    Log(Enc.GetString("UserName"))  
    Log(Enc.GetString("Age"))  
    Log(Enc.GetString("IsPro"))
```

  
  
**SS\_AESGCMEncryption  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **AESGCMEncryption**
*AESGCMEncryption  
 AES‑256 GCM encrypted preferences engine for B4A and B4J.  
 Features:  
 - AES/GCM/NoPadding authenticated encryption  
 - AES‑256 key derived from SHA‑256(password)  
 - Optional 128‑bit salt for strengthened key derivation  
 - Optional custom 128‑bit salt set via Base64 string  
 - Full JSON support (objects, arrays, numbers, booleans, null)  
 - Can also Stores and loads Maps and Lists*

- **Events:**

- **Error** (Message As String, Tag As Object)

- **Fields:**

- **SetSaltBase64** As String
*Processes the SetSaltBase64 property if it has been assigned.  
 If SetSaltBase64 is not empty:  
 - Decodes Base64  
 - Validates that the decoded salt is exactly 16 bytes  
 - On success, stores it in customSalt  
 - On failure, raises the Error event  
 Clears SetSaltBase64 after processing*
- **Functions:**

- **ChangePassword** (OldPassword As String, NewPassword As String) As Boolean
*Changes the encryption password and re‑encrypts the stored data using AES‑256 key.  
 Returns True if the Password changed successfully  
 Returns False if the Old password was incorrect or re‑encryption failed*- **Clear**
*Clears all stored values and writes to file.*- **GetBoolean** (Key As String) As Boolean
*Returns a stored boolean value.  
 Returns False if missing or invalid.*- **GetDouble** (Key As String) As Double
*Returns a stored double value.  
 Returns 0.0 if missing or invalid.*- **GetInt** (Key As String) As Int
*Returns a stored integer value.  
 Returns 0 if the key does not exist or cannot be parsed.*- **GetList** (Key As String) As List
*Returns a stored List.  
 Returns an empty List if missing or invalid.*- **GetLong** (Key As String) As Long
*Returns a stored long value.  
 Returns 0 if missing or invalid.*- **GetMap** (Key As String) As Map
*Returns a stored Map.  
 Returns an empty Map if missing or invalid.*- **GetString** (Key As String) As String
*Returns a stored string value.  
 Returns an empty string if the key does not exist.*- **Initialize** (Dir As String, FileName As String, Password As String)
*Initialise the encrypted preferences engine.  
 Dir is the Directory where the encrypted file is stored  
 FileName is the Name of the encrypted file  
 Password is the Password used to derive the AES‑256 key*- **Keys** As List
*Returns a List of all stored keys.*- **PutBoolean** (Key As String, Value As Boolean)
*Stores a boolean value and writes to file.*- **PutDouble** (Key As String, Value As Double)
*Stores a double value and writes to file.*- **PutInt** (Key As String, Value As Int)
*Stores an integer value and writes to file.*- **PutList** (Key As String, Value As List)
*Stores a List and writes to file.*- **PutLong** (Key As String, Value As Long)
*Stores a long value and writes to file.*- **PutMap** (Key As String, Value As Map)
*Stores a Map and writes to file.*- **PutString** (Key As String, Value As String)
*Stores a string value and writes to file.*- **Remove** (Key As String)
*Removes a key and writes to file.*
  
  
 **Enjoy…**