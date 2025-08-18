### Push messages with Firebase and B4A: Some additional hints and a working example by Frank
### 07/18/2022
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/141832/)

Hi,  
I played around with push notifications based on Firebase Cloud Messaging (FCM).  
I followed the tutorial at <https://www.b4x.com/android/forum/threads/firebasenotifications-push-messages-firebase-cloud-messaging-fcm.67716/>, which is excellent.  
Still, there are some open questions which I'd like to answer in this post. Hope this helps others to get their first App with notifications up and running.  
  
**The problem**  
I run a website (<https://unspontan.com>) where I wanted to add push notifications. I played around with other mechanisms (e.g. web notifications, see e.g. my site <https://c99.chat> where this works), but I wanted real push messages to my android device.  
  
**The solution**  
I built a very simple B4A app which just contains a webview that loads my site.  
  
  
  
Note that you should also load the site on 'resume' which is called when the App is called from a notification; we need that later.  
  
[FONT=courier new]

```B4X
Sub Activity_Resume  
    WebView1.LoadUrl("https://www.unspontan.com/index.php")  
End Sub
```

[/FONT]  
  
I then did all the necessary stuff explained in <https://www.b4x.com/android/forum/threads/firebasenotifications-push-messages-firebase-cloud-messaging-fcm.67716/>  
There were some issues:  
  

- On <https://console.firebase.google.com/>, you need to find the server key on the cloud messaging tab in the settings screen. Contrary to what is shown in the video, the key just doesn't appear. The solution is: Enable the Cloud Messaging API (Legacy) with the three vertical dots next to it; you'll see another Google Cloud screen where you have to activate the feature (API). Then go back to the settings screen, and voila - you see the server key.
- Sending the message via the B4J project obviously requires you to have B4J installed.

  
The real use case, however, is likely: Send a message via a POST request to the Google server. This is explained quite nicely here <https://stackoverflow.com/questions/37490629/firebase-send-notification-with-rest-api> and the full documentation is here: <https://firebase.google.com/docs/cloud-messaging/http-server-ref>. There are a couple of important things:  
  
[INDENT=2]You need to know the client id of the device you want to send the message to. This is contained in [FONT=courier new]fm.Token[/FONT] in the App. So I changed my B4A code to send this client ID to a PHP script which just writes it to my database on server side.[/INDENT]  
[INDENT=2][/INDENT]  

```B4X
Public Sub SubscribeToTopics  
  
    fm.SubscribeToTopic("general") 'you can subscribe to more topics  
  
    Log("Token is this: ")  
  
    Log(fm.Token)  
  
    Dim s As String  
  
    s = "cid=" & fm.Token  
  
    Dim j As HttpJob  
  
    j.Initialize("", Me)  
  
    j.PostString("https://www.unspontan.com/yourserversidescript.php", s)  
  
End Sub
```

  
[INDENT=2][/INDENT]  
[INDENT=2]On server side, just extract the Post parameter cid and store it's value in a table. Obviously, you could also pass a user id etc.[/INDENT]  
[INDENT=2][/INDENT]  
[INDENT=2]When sending a message, just extract all client ids from your table and send messages. In PHP this is easiest done with cURL. Remember to put all the Post parameters into the data tags.[/INDENT]  
[INDENT=2][/INDENT]  

```B4X
    $currenttime = date('d.m.Y, H:i:s');  
  
    $url = 'https://fcm.googleapis.com/fcm/send';  
  
      
  
    # read through all registered devices  
  
    $query = "select cid from table_with_stored_cids";  
  
    $result = mysql_query($query);  
  
    while ($row = mysql_fetch_object($result)) {  
  
        $cid = $row->cid;  
  
        $payload = '{  
  
        "to": "' . $cid . '",  
  
        "data": {  
  
          "title": "Message from unspontan",  
  
          "body": "' . $text . '\nSent at ' . $currenttime . '",  
  
          "mutable_content": true,  
  
          "sound": "Tri-tone",  
  
          "click-action": "https://www.unspontan.com/index.php",  
  
          }  
  
        }  
  
        ';  
  
  
        // open connection  
  
        $ch = curl_init();  
  
        // set the url, number of POST vars, POST data  
  
        curl_setopt($ch, CURLOPT_URL, $url);  
  
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(  
  
        'Content-Type: application/json',  
  
        'Authorization: key=yourserversidekey'  
  
        ));  # key is server key from firebase console   
  
        curl_setopt( $ch, CURLOPT_POSTFIELDS, $payload );  
  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); # This will make curl_exec return the data instead of outputting it.  
  
        // execute post  
  
        $result = curl_exec($ch);  
  
        // close connection  
  
        curl_close($ch);  
  
  
   } # while
```

  
[INDENT=2][/INDENT]  
[INDENT=2]Yes, I know I should used mysqli, but this is just for demo purposes.[/INDENT]  
[INDENT=2]I hope this short example helps others.[/INDENT]