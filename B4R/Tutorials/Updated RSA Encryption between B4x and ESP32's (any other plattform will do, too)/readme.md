### Updated RSA Encryption between B4x and ESP32's (any other plattform will do, too) by KMatle
### 01/30/2022
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/138049/)

Here's an updated example how to  
  
- generate an RSA keypair (Public and Private key) on a ESP32 and on B4x  
- export these keys in PEM format (compatible with any other plattform like B4x, .net, php, python, etc.)  
- exchange the Public Keys (here via WiFi/AsyncStreams)  
- encrypt and decrypt on both sides  
  
Notes:  
  
- RSA should only be used in a session context to exchange an AES-Key and encrypt/decrypt with AES while the sesion is active. This works like an SSL-Session and is very safe.  
- You can encrypt a maximum of 245 Bytes with 2048 Bit RSA keys. This is more than enough for the context (you go on with AES later)  
- Creating keys on the ESP32 side may take some time  
- Maybe you get a "brownout". The ESP32 may consume more power then the USB port may deliver. It will reboot then and try again.  
- at least the C inline code can be optimized a bit. Maybe someone likes to build a library from it.  
  
PEM format:  
  

```B4X
—–BEGIN PUBLIC KEY—–  
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAw1cZ5r5c5pcILION1t4i  
/SIYRlQ36GV0fpCSOqPYfB4rhzBCNK28f+JPZvxu36NTwTpKcN3B8eqyIoihBfhc  
uctjboAYwuaFEurFUHiwBfLTVo2w3l/3TQ2v1BAxCZH+LphQkx3D6Ti1W76VuOWi  
G8UTlNyAZhEZmf1q+/q33N8QI3ikl42XK6maK0Oa3I/Qbb55Mg+xc5WBUzP9YKkH  
RAqRpMo47+DljW2mXHTvP6gXVm0qTYlc2S0v1x7Wb14Y8StU3oj3+CJr1MB3wtJ0  
J8ioj0gcQhJ6KtqyHatkKY8noZbyk0rhqKnWQ8r85faLHLQib0215hUlxp6ay/wY  
rjOx3owZglSEtKWrH4OBvjTzHWCs+yNpg0X+CJl7jNf5U7qvtG5kQgNVv++TuCDm  
CT5I1HWbr5bqE0QX0CjASbechhRAJflsMJCzPoqrYt2SsJFKQGhAmREhMplQSzE/  
x9c1fJxN1Dq6SvB9TuSXJ9RIktYt6dsfvAtWd84WLhTtQbDzo78cD8huMS76MBoR  
rH5mYrz5enf2VVkGVXG5jgAKCpKQMus8Tu84vk1cPVkdLj4stFKeyWcXf9vY8xa1  
9b+VtWL2Z7RGRa87qWIY9LW5LOxbeMzht/BpwHqm6X2CySYiUEsh8I5Dul4+5h48  
pMz434ZzxnrRTUvAPr6tzjkCAwEAAQ==  
—–END PUBLIC KEY—–
```

  
  
This is a public key in PEM format. In B4x we remove the header, footer and all crlf's to get the embedded Base64 string. This is converted to bytes and can the loaded into the KeyPairGenerator in B4x. Quite easy. Vice versa you export the key from B4x in Bytes, convert it to a Base64 string and add headers, footers and crlf's after 64 char each line plus remaining.  
  
PEM keys can be loaded in most plattforms directly  
  
PHP: (the key was stored in a file before) -> One line of code if you will…  

```B4X
if (openssl_public_encrypt($message, $messEN, file_get_contents('ESP32PublicKey.pem')))  
            {  
                $messEN=base64_encode($messEN);  
                return $messEN;  
                 
            }  
        else  
            {  
                return false;  
            }
```

  
  
  
Libs needed:  
  
B4R  
![](https://www.b4x.com/android/forum/attachments/124927)  
  
B4J  
![](https://www.b4x.com/android/forum/attachments/124928)  
  
plus bcprov-jdk15on-1xx (I use 160, maybe there's a newer on the www or an older here to download)  
![](https://www.b4x.com/android/forum/attachments/124929)  
   
Workflow  
  
- On both sides a RSA Keypair is generated  
- The ESP32 saves both keys to SPIFFS (for reuse = faster)  
- The ESP32 connects to Wifi (don't forget to enter your credentials) and acts like a server  
- The B4J app connects to it (change the IP address -> see the B4R log)  
- Both apps exchange their Public Keys (only them, Private Keys are private!)  
- for a test both sides send a short encrypted message via AsyncStreams and decrypt it via their own Private Key  
  
Optimizations  
  
- usually you would use this scenario to safely configure multiple ESP's  
- one would start with Bluetooth and connect from the B4x app TO all uncofigured ESP's and send the SSID & SSID PW, the B4x IP address and exchange the Public Keys  
- after that each ESP connects to the given SSID, stops BT and connects to your B4J app (acting as the server now)  
- each ESP exchanges an AES keys via RSA encryption and after that the ESP is configured using AES encryption from here on  
- the B4x App stores all ESP devices including the idividual AES pw  
- on the ESP32 board you would have a "reset button" and begin from step 1  
  
Same code works in B4a, too.