### ESP32: AES256 encrypted & Base64 encoded post message to and from PHP by KMatle
### 02/06/2023
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/145962/)

Example:  
  
- AES256 encrypt a message with IV and Salt  
- Base64 encode it  
- send a http post request to a php script  
- decrypt in php  
- send back a AES256 encrypted and Base64 encoded message to the ESP32  
  
Note:  
  
- change SSID & PW & IP-Address/foldername/scriptname  
- message must be padded to a multiple of 16 (done by code here)  
- Full message contains: ID(8)+Salt(32)+IV(16)+encrypted\_message (16\*x)  
- on the receivers side ID, Salt and IV will be removed from the message (only the raw message can be decrypted). The given IV must be used.  
- Salt and IV are public (not encrypted) and changes every time  
   
  
PHP-Script:  
  

```B4X
<?php  
  
$aes256 = file_get_contents("php://input");  
  
//print "Decrypted: ".AES256_Decrypt($aes256, hex2bin(hash('sha256',"Secret"))); //just for a test  
  
print AES256_Encrypt("Hi from PHP", hex2bin(hash('sha256',"Secret")));  
  
  
  
function AES256_Decrypt($string, $pw)  
{  
    $dec = false;  
    $encrypt_method = "AES-256-CBC";  
    $total=base64_decode($string);  
    $id=substr($total, 0, 8);  
    $salt=substr($total, 8, 32);  
    $iv=substr($total, 40, 16);  
    $string=Base64_Encode(substr($total, 56, strlen($total)-56));  
    $dec = openssl_decrypt($string, $encrypt_method, $pw, 0,$iv);  
    return $dec;  
}  
  
function AES256_Encrypt($string, $pw)  
{  
    $encrypt_method = "AES-256-CBC";  
    $id=openssl_random_pseudo_bytes(8, $securityok);  
    $IV=openssl_random_pseudo_bytes(16, $securityok);  
    $Salt=openssl_random_pseudo_bytes(32, $securityok);  
    $enc = openssl_encrypt($string, $encrypt_method, $pw, 0,$IV);         
    $enc=Base64_encode($id.$Salt.$IV.Base64_decode($enc));  
    return $enc;  
}  
  
?>
```