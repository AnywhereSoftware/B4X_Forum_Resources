### PHP: Get oAuth token for Firebase Messaging without using libs by KMatle
### 12/14/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/164627/)

To send Firebase messages from php with the new api from Google you need to retrieve an authorization token. I have several "cheap" hosted servers where I can't install any libs so this just uses some calls and the json file which you have to download an put in any folder on your Apache installation (or even better outside of it).  
  
See Erel's example how to download the json here: [Click](https://www.b4x.com/android/forum/threads/b4x-firebase-push-notifications-2023.148715/)  
  
I've just put it under the same folder where the php script lives. **Warning: Don't do this in a production systems as the file contains your private key!**  
  
![](https://www.b4x.com/android/forum/attachments/159489)  
  
Then just call the script via your browser. Don't use "localhost". May work but in other scenarios it will fails. So use the ip address instead.  
  
The token ist stored in $access\_token and is just displayed in your browser. Will do an example to use it in B4x and to send messages the next time.  
  
**Script:**  
  

```B4X
<?php  
  
// This function is needed, because php doesn't have support for base64UrlEncoded strings  
function base64UrlEncode($text)  
{  
    return str_replace(  
        ['+', '/', '='],  
        ['-', '_', ''],  
        base64_encode($text)  
    );  
}  
  
// Read service account details  
$authConfigString = file_get_contents("server-9e953-firebase-adminsdk-fpbjz-d8d62a2343.json");  
  
// Parse service account details  
$authConfig = json_decode($authConfigString);  
  
// Read private key from service account details  
$secret = openssl_get_privatekey($authConfig->private_key);  
  
// Create the token header  
$header = json_encode([  
    'typ' => 'JWT',  
    'alg' => 'RS256'  
]);  
  
// Get seconds since 1 January 1970  
$time = time();  
  
// Allow 1 minute time deviation between client en server (not sure if this is necessary)  
$start = $time - 60;  
$end = $start + 3600;  
  
// Create payload  
$payload = json_encode([  
    "iss" => $authConfig->client_email,  
    "scope" => "https://www.googleapis.com/auth/firebase.messaging",  
    "aud" => "https://oauth2.googleapis.com/token",  
    "exp" => $end,  
    "iat" => $start  
]);  
  
// Encode Header  
$base64UrlHeader = base64UrlEncode($header);  
  
// Encode Payload  
$base64UrlPayload = base64UrlEncode($payload);  
  
// Create Signature Hash  
$result = openssl_sign($base64UrlHeader . "." . $base64UrlPayload, $signature, $secret, OPENSSL_ALGO_SHA256);  
  
// Encode Signature to Base64Url String  
$base64UrlSignature = base64UrlEncode($signature);  
  
// Create JWT  
$jwt = $base64UrlHeader . "." . $base64UrlPayload . "." . $base64UrlSignature;  
  
//—–Request token, with an http post request——  
$options = array('http' => array(  
    'method'  => 'POST',  
    'content' => 'grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion='.$jwt,  
    'header'  => "Content-Type: application/x-www-form-urlencoded"  
));  
$context  = stream_context_create($options);  
$responseText = file_get_contents("https://oauth2.googleapis.com/token", false, $context);  
  
$response = json_decode($responseText, true);  
  
$access_token=$response['access_token'];  
  
exit($access_token);  
  
?>
```