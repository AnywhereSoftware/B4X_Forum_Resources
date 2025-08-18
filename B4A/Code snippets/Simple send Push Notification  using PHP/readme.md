### Simple send Push Notification  using PHP by omarruben
### 02/21/2021
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/127860/)

```B4X
<?php  
                function sendNotification ($title,$body,$ServerKey) {  
                $curl = curl_init();  
                  
                curl_setopt_array($curl, array(  
                CURLOPT_URL => "https://fcm.googleapis.com/fcm/send",  
                CURLOPT_RETURNTRANSFER => true,  
                CURLOPT_ENCODING => "",  
                CURLOPT_MAXREDIRS => 10,  
                CURLOPT_TIMEOUT => 30,  
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,  
                CURLOPT_CUSTOMREQUEST => "POST",  
                CURLOPT_POSTFIELDS => "{\"data\":{\"title\":\"".$title."\",\"body\":\"".$body."\"},\"to\":\"\/topics\/general\"}",  
                  
                CURLOPT_HTTPHEADER => array(  
                        "authorization: key=".$ServerKey,  
                        "content-type: application/json"  
                        ),  
                ));  
                  
                $response = curl_exec($curl);  
                $err = curl_error($curl);  
                  
                curl_close($curl);  
                  
                if ($err) {  
                echo "cURL Error #:" . $err;  
                } else {  
                echo $response;  
                }  
  
                }  
  
  
        sendNotification('Danger','Not really , just be prepared','xxxxxxxxxxxxxxxxxxxxxx' ); // change the xxxxxxxxxx for your Server Key from firebase console  
  
?>
```