### [B4x] Use OTP in your apps (php code also included) by KMatle
### 04/27/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/130169/)

OTP is a one time pin (here: 6 digits) depending on a given password and the actual time.  
  
Usage:   
  
- additional security when a user does a login  
- take care of server requests (a request can be intercepted and repeated). As it depends on the date/time with OTP this isn't possible  
- some sort of a "signature" as only the user/app with the correct OTP pin is accepted  
  
Notes:  
  
- take care that all instances (= apps, servers, etc.) use the same date/time ("time zones")  
- accept the actual otp pin and the one 30 secs before (if a request arrives in the next 30-second-slot)  
  
B4x code (Libs needed: ByteConverter and Encryption). The "30" defines the duartion of the pin (30 secs)  
  

```B4X
Sub GetOTP (key() As Byte) As String 'key/pw as bytes  
  
    BC.LittleEndian=False  
      
    Dim unixtimestamp As Int = Floor(DateUtils.TicksToUnixTime(DateTime.Now)/30)  
      
    Dim utshex As String=Bit.ToHexString(unixtimestamp)  
    Do While utshex.Length<16  
        utshex="0" & utshex  
    Loop  
      
    Dim m As Mac  
    Dim k As KeyGenerator  
    k.Initialize("HMACSHA1")  
    k.KeyFromBytes(key)  
    m.Initialise("HMACSHA1", k.Key)  
      
    BC.LittleEndian=True  
    m.Update(BC.HexToBytes(utshex))  
      
    Dim b() As Byte  
    b = m.Sign  
      
    Dim BC As ByteConverter  
  
    Dim Offs As Int= Bit.And(b(19),15)  
      
    Dim OTP,p1,p2,p3,p4,pt As Int  
      
    p1=Bit.ShiftLeft(Bit.And(b(Offs+0),127),24)  
    p2=Bit.ShiftLeft(Bit.And(b(Offs+1),255),16)  
    p3=Bit.ShiftLeft(Bit.And(b(Offs+2),255),8)  
    p4=Bit.And(b(Offs+3),255)  
    pt=Bit.Or(p1,p2)  
    pt=Bit.Or(pt,p3)  
    OTP=Bit.Or(pt,p4) Mod Power(10,6)  
      
    Return NumberFormat2(OTP,6,0,0,False)  
End Sub
```

  
  
In PHP ($otpsecret = PW as Base64 string, can be a simple string, too. Use random bytes if possible.)  
  

```B4X
function GetOTP($otpsecret)  
{  
      
    $secret_seed = bin2hex(Base64_Decode($otpsecret)) ;  
    //$secret_seed = bin2hex('Test');  
  
    // Determine the time window  
    $time_window = 30;  
  
    // Get the exact time from the server  
    //$exact_time = 48958981; //microtime(true);  
    $exact_time = time(); //microtime(true);  
  
    // Round the time down to the time window  
    $rounded_time = floor($exact_time/$time_window);  
  
    // Pack the counter into binary  
    $packed_time = pack("N", $rounded_time);  
  
    // Make sure the packed time is 8 characters long  
    $padded_packed_time = str_pad($packed_time,8, chr(0), STR_PAD_LEFT);  
  
    // Pack the secret seed into a binary string  
    $packed_secret_seed = pack("H*", $secret_seed);  
  
    // Generate the hash using the SHA1 algorithm  
    $hash = hash_hmac ('sha1', $padded_packed_time, $packed_secret_seed, true);  
  
    // Extract the 6 digit number fromt the hash as per RFC 6238  
    $offset = ord($hash[19]) & 0xf;  
    $otp = (  
        ((ord($hash[$offset+0]) & 0x7f) << 24 ) |  
        ((ord($hash[$offset+1]) & 0xff) << 16 ) |  
        ((ord($hash[$offset+2]) & 0xff) << 8 ) |  
        (ord($hash[$offset+3]) & 0xff)  
    ) % pow(10, 6);  
  
    // Add any missing zeros to the left of the numerical output  
    $otp = str_pad($otp, 6, "0", STR_PAD_LEFT);  
  
     
    return $otp;  
  
}
```