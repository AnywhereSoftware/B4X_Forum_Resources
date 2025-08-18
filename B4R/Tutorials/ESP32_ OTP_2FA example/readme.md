### ESP32: OTP/2FA example by KMatle
### 02/16/2022
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/138484/)

This example generates a OTP/2FA ("One Time Password") as you know it when you login to a website and you get a 6 digit code via sms. It changes every 30 seconds.  
  
How it works:  
  
- as it is time based, you need a internet connection. Please add your wifi/router credentials  
- time is retrieved from pool.ntp.org (please change the time offset to your country/timezone)  
- the time is converted in a unixtimestamp  
- it is converted to hex and filled up with leading zeroes giving a total length of 16  
- these 16 bytes are HMAC-SHA1 hashed with a secret (both sides must use the same secret)  
- with the help of some bit operations (shift/and/or) plus a power/modulus calculation we finally get the OTP code  
  
B4x example with integration in Google Authenticator: [OTP](https://www.b4x.com/android/forum/threads/b4x-google-authenticator-otp-others-will-do-too-complete-example-with-code.119479/)  
  
  

```B4X
#Region Project Attributes  
    #AutoFlushLogs: True  
    #CheckArrayBounds: True  
    #StackBufferSize: 1000  
  
#End Region  
'Ctrl+Click to open the C code folder: ide://run?File=%WINDIR%\System32\explorer.exe&Args=%PROJECT%\Objects\Src  
  
Sub Process_Globals  
    Public Serial1 As Serial  
      
    Private bc As ByteConverter  
      
    Private WiFi As ESP8266WiFi  
    Private SSID As String=""  
    Private SSIDPW As String=""  
  
    Private hmackey(255) As Byte  
    Private hmackey_len As ULong  
    Private hmacpayload(255) As Byte  
    Private hmacpayload_len As ULong  
    Private hmacbytessha1(20) As Byte  
    Private hmacbytessha256(64) As Byte  
      
    Private TimeVar(100) As Byte  
    Private unixtimestamp As Long  
    Private uthex(20) As Byte  
      
    Dim p1,p2,p3,p4, OTP As ULong  
    Dim pt As Long  
      
End Sub  
  
Private Sub AppStart  
      
      
    Serial1.Initialize(115200)  
      
    Log("AppStart")  
      
  
    If SSID.Length>0 And SSIDPW.Length>0 Then  
        Log("Connecting to ",SSID)  
        For i=1 To 10  
            Log(i)  
              
            If WiFi.Connect2(SSID,SSIDPW) Then  
                Log("Connected to ",SSID)  
                Log("My ip: ", WiFi.LocalIp)  
                Exit  
            Else  
                Log("Could not connect to WiFi. Please check SSID and PW…")  
            End If  
        Next  
    Else  
        Log("Please define SSID + SSID-PW…")  
    End If  
      
      
    GetOTP  
      
End Sub  
  
Sub GetOTP  
    RunNative("GetTime", Null)  
    Dim utshex16 As String = JoinStrings(Array As String("000000000",bc.StringFromBytes(uthex)))  
          
    Dim s As String="Secret"  
    bc.ArrayCopy2(s,0,hmackey,0,s.Length)  
    hmackey_len=s.Length  
    Dim pl() As Byte=bc.HexToBytes(utshex16)  
      
    bc.ArrayCopy2(pl,0,hmacpayload,0,pl.Length)  
    hmacpayload_len=pl.Length  
      
    RunNative("GetHmacSHA1", Null)  
          
    Dim Offs As UInt= Bit.And(hmacbytessha1(19),15)  
      
    p1=Bit.ShiftLeft(Bit.And(hmacbytessha1(Offs+0),127),24)  
    p2=Bit.ShiftLeft(Bit.And(hmacbytessha1(Offs+1),255),16)  
    p3=Bit.ShiftLeft(Bit.And(hmacbytessha1(Offs+2),255),8)  
    p4=Bit.And(hmacbytessha1(Offs+3),255)  
      
    RunNative("DoOr", Null) 'Did not manage it in B4R ;-)  
  
    Dim d As ULong=Power(10,6)  
    OTP = pt Mod d  
  
    Log("OTP: ",NumberFormat(OTP,6,0))  
  
End Sub  
  
#if c  
  
void DoOr (B4R::Object* o) {  
  
    long pt;  
      
    pt=b4r_main::_p1 | b4r_main::_p2;  
    pt=pt | b4r_main::_p3;  
    pt=pt | b4r_main::_p4;  
      
    b4r_main::_pt = pt;  
  
}  
  
  
#End If  
  
  
  
#if c  
  
#include "mbedtls/md.h"  
  
void GetHmacSHA1 (B4R::Object* o) {  
   
  mbedtls_md_context_t ctx;  
  mbedtls_md_type_t md_type = MBEDTLS_MD_SHA1;  
  
  mbedtls_md_init(&ctx);  
  mbedtls_md_setup(&ctx, mbedtls_md_info_from_type(md_type), 1);  
  mbedtls_md_hmac_starts(&ctx, (unsigned char *)b4r_main::_hmackey->data, b4r_main::_hmackey_len);  
  mbedtls_md_hmac_update(&ctx, (unsigned char *)b4r_main::_hmacpayload->data, b4r_main::_hmacpayload_len);  
  mbedtls_md_hmac_finish(&ctx, (unsigned char *)b4r_main::_hmacbytessha1->data);  
  mbedtls_md_free(&ctx);  
}  
#End If  
  
  
#if c  
  
#include "time.h"  
#include <inttypes.h>  
#include <math.h>  
void GetTime (B4R::Object* o) {  
  
    const char* ntpServer = "pool.ntp.org";  
    const long  gmtOffset_sec = 3600;  
    const int   daylightOffset_sec = 3600;  
  
    configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);  
  
    struct tm timeinfo;  
      if(!getLocalTime(&timeinfo)){  
        Serial.println("Failed to obtain time");  
          
      }  
    else  
    {  
          Serial.println(&timeinfo, "%A, %B %d %Y %H:%M:%S");  
    }  
      
      
    struct timeval tv_now;  
    gettimeofday(&tv_now, NULL);  
  
    int64_t time_ms = (int64_t)tv_now.tv_sec * 1000LL + (int64_t)tv_now.tv_usec / 1000LL;  
    int t1=floor(time_ms / 1000/ 30);  
      
    b4r_main::_unixtimestamp=t1;  
    String tuthex = String(t1, HEX);  
      
    memcpy(b4r_main::_uthex->data,&tuthex, tuthex.length());  
      
}  
  
#End If
```