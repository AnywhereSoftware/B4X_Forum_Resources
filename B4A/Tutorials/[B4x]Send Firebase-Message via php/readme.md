### [B4x]Send Firebase-Message via php by KMatle
### 09/15/2019
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/69066/)

UPDATE  
  
Please ensure you use https:// to call the Google fcm api. "Out of the sudden" one of my apps didn't work anymore :rolleyes:  
  

```B4X
$ch = curl_init();  
        curl_setopt( $ch,CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send' );  
        curl_setopt( $ch,CURLOPT_POST, true );  
        curl_setopt( $ch,CURLOPT_HTTPHEADER, $headers );  
        curl_setopt( $ch,CURLOPT_RETURNTRANSFER, true );  
        curl_setopt( $ch,CURLOPT_SSL_VERIFYPEER, false );  
        curl_setopt( $ch,CURLOPT_POSTFIELDS, json_encode( $fields ) );  
        $result = curl_exec($ch );  
        curl_close( $ch );
```

  
  
  
  
I use php for all my server stuff so here is an updated tutorial how to use php to send messages to devices.  
  
**1. Follow Erel's instructions to set up Firebase Messaging and download the example.**  
  
<https://www.b4x.com/android/forum/threads/firebasenotifications-push-messages-firebase-cloud-messaging-fcm.67716/#content>  
  
**2. Add the log line to the example to see the device's token (you need to copy it later)**  
  

```B4X
Public Sub SubscribeToTopics  
   fm.SubscribeToTopic("general") 'you can subscribe to more topics  
   Log (fm.Token)  
End Sub
```

  
  
Inside the logs you'll see a long string (=token) like this:  
  

```B4X
dzHOKKmwoaeihf98482hfoih0h29hfifh092hfoifhohf309hffh2hfi3209t92hf2gn2dm2jd4029fj24fj29fj24f………..
```

  
  
By subscribing every device will get a unique token which is used to send a message to THIS device.  
  
**3. Copy the php script into an own folder (I've called mine "FCM") inside the htdocs folder of your php installation. I use XAMPP for my tests (no production server is needed). Change "API\_ACCESS\_KEY" to the one of your project (see Erel's tutorial).**  
  
In the array  
  

```B4X
$msg = array  
        (  
            'title'     => $t,  
            'message'     => $m,  
            'MyKey1'       => 'MyData1',  
            'MyKey2'       => 'MyData2',  
           
        );
```

  
  
you can use key/value pairs like you want to. Add more if needed.  
  

```B4X
<?php  
  
$action=$_GET["Action"];  
  
  
switch ($action) {  
    Case "M":  
         $r=$_GET["r"];  
        $t=$_GET["t"];  
        $m=$_GET["m"];  
        
        $j=json_decode(notify($r, $t, $m));  
        
        $succ=0;  
        $fail=0;  
        
        $succ=$j->{'success'};  
        $fail=$j->{'failure'};  
        
        print "Success: " . $succ . "<br>";  
        print "Fail   : " . $fail . "<br>";  
        
        break;  
    
    
default:  
        print json_encode ("Error: Function not defined ->" . $action);  
}  
  
function notify ($r, $t, $m)  
    {  
    // API access key from Google API's Console  
        if (!defined('API_ACCESS_KEY')) define( 'API_ACCESS_KEY', 'AIzasogs94sgjsjsg04……… );  
        $tokenarray = array($r);  
        // prep the bundle  
        $msg = array  
        (  
            'title'     => $t,  
            'message'     => $m,  
            'MyKey1'       => 'MyData1',  
            'MyKey2'       => 'MyData2',  
            
        );  
        $fields = array  
        (  
            'registration_ids'     => $tokenarray,  
            'data'            => $msg  
        );  
         
        $headers = array  
        (  
            'Authorization: key=' . API_ACCESS_KEY,  
            'Content-Type: application/json'  
        );  
         
        $ch = curl_init();  
        curl_setopt( $ch,CURLOPT_URL, 'fcm.googleapis.com/fcm/send' );  
        curl_setopt( $ch,CURLOPT_POST, true );  
        curl_setopt( $ch,CURLOPT_HTTPHEADER, $headers );  
        curl_setopt( $ch,CURLOPT_RETURNTRANSFER, true );  
        curl_setopt( $ch,CURLOPT_SSL_VERIFYPEER, false );  
        curl_setopt( $ch,CURLOPT_POSTFIELDS, json_encode( $fields ) );  
        $result = curl_exec($ch );  
        curl_close( $ch );  
        return $result;  
    }  
  
  
?>
```

  
  
**4. Start Erel's example (debug), set a breakpoint at "fm\_MessageArrived", copy the token to the clipboard. Open your browser and call the php like this:**  
  

```B4X
http://192.168.178.23/fcm/fcm.php?Action=M&t=Title&m=Message&r=dzHOKKmwsaj9a0e4jafja9jf49ajfa……..
```

  
  
Change the ip-address, too (can be a regular website when you use it in production)  
  
Insert the copied token after "r=" and your app will receive the message at once:  
  

```B4X
Message arrived  
Message data: {MyKey1=MyData1, MyKey2=MyData2, title=Title, message=Message}
```

  
  
As you can see, our key/value pairs arrive as a map. To get the contents of "message":  
  

```B4X
Dim mess As String = Message.GetData.Get("message")
```

  
  
**5. Improvements**  
  
Just call the php via httputils to send a message.  
  
Usually you have more than one device and you do't know the tokens. So you need to store the token and some other unique identifier (email address/name/imei -> alias) into a database. So you can add to the script to store update the tokens. In another function you just call the script with the alias.  
  
In one of my apps I store all messages to a table to check the status (sent, received). After the message arrives on the device I call the php to update the status to "received".  
  
**Hints:**  
  
There is no security here. Don't use this example 1:1 on your production server(s)! (use Google to search for how to secure a php script/MySql).