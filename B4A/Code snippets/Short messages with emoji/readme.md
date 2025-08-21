### Short messages with emoji by nwhitfield
### 08/16/2020
[B4X Forum - B4A - Code snippets](https://www.b4x.com/android/forum/threads/121271/)

In searches, I've come across a fair few people wondering how to detect if a message is just emoji so that, like WhatsApp, it can be displayed in a larger font if necessary. So I thought I'd share my solution to this.  
  
Background: all the messaging between apps and site users goes through the website database. The database stores everything in UTF8, but for emoji, we convert them to shortcodes and store those, so a smiley may be represented in the database as "?"  
  
We use [JoyPixels](https://www.joypixels.com/emoji) to provide emoji support on the website, and depending on what app (we have some old Windows & Mac ones with no emoji support), it can convert between the shortcodes and either unicode, links to web images, or even ascii versions.  
  
So, in the next app update I want to detect short messages containing emoji and display them in a bigger font. Rather than try and do this client-side, it's done on the server using PHP's multibyte string support. First I check if the message is in ASCII, if it not, then it's probably got emoji, so if it's less than 10 chars long (pick your own length), a flag is added to the message:  
  

```B4X
<?php  
    
    // initialise the JoyPixels tools  
    $client = new \JoyPixels\Client(new \JoyPixels\Ruleset());  
    
    // $msg is the message data from the database  
    $utf = $client->shortnameToUnicode($msg['content']) ;  
    if ( ! mb_check_encoding($utf, 'ASCII') && ( mb_strlen($utf,'UTF-8') <= 10)) {  
        $msg['bigemoji'] = true ;  
    }  
  
    // for the B4X client apps, convert shortcodes to Unicode  
    $msg['content'] = $client->shortnameToUnicode($msg['content']) ;  
  
    // send the message to the client  
  
?>
```

  
  
Then in B4A when processing the message all I have to do is a quick check  
  

```B4X
' each message is a map (m) in the B4x code  
' msgtext is a label  
  
msgtext.text = m.get("content")  
  
If m.ContainsKey("bigemoji") then msgtext.TextSize = 32
```

  
  
This gets me where I want to get today, but at the cost of the server analysing each message as it's retrieved, which might happen multiple times. So step two will be adding a 'bigemoji' field to the message database and running the detection code on the stored messages to flag each one up, and checking each message at creation time, so it only has to be done once, and the key can just be retrieved with the rest of the message metadata