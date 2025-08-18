### Full responsive ESP8266 settings WebApp with websockets by hatzisn
### 12/26/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/137136/)

Merry Christmass everyone in the Christian community of this forum,  
  
Yesterday I 've had a great crazy idea which turned out to be a working one too.  
  
Normally one would answer to the question if it is possible to create a fully functioning fully responsive ESP8266 settings webapp in the board that this is impossible. And it is (as far as my knowledge goes). So if you can't go through an obstacle just go around it. The solution is to create the web app in B4J and when you reach through your browser to your ESP8266 board it sends you a brief html code with an iFrame pointing to the WebApp passing also an id parameter. The web app is MQTT enabled both as broker and as a client and the board connects through MQTT to it and subscribes to the Topic with a name as the ID. To the same topic subscribes also the WebApp when the socket is connected as it gets it from the parameter passed. This ensures the return path to the board from the WebApp of the settings.  
  
I used the code shown in this thread as a base which I changed a lot.  
  
<https://www.b4x.com/android/forum/threads/long-delay-before-ios-browser-gets-first-page-from-esp-server.137020/>  
  
You can watch the following video to get an idea of how it works (it is watched better maximized). The code follows. Don't forget to open inbound connections in your computer's firewall in ports 51041 and 51042 and also to change the credentials to the WiFi in the B4RWebServer as well as the variables bIP and sIP which must point to the IP of the computer that runs the WebApp. It goes without saying that the board is already connected to the same network as your computer running the B4J WebApp.  
  
[MEDIA=youtube]AnhfK69DtwA[/MEDIA]