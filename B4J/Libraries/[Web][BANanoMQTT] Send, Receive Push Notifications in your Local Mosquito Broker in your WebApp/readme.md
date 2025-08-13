### [Web][BANanoMQTT] Send, Receive Push Notifications in your Local Mosquito Broker in your WebApp. by Mashiane
### 03/11/2025
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/166059/)

Hi Fam  
  
Well, here it is..  
  
**Why?**  
  
I need a way to receive MQTT push notifications on my webapp. I didnt want to use Firebase but MQTT. The problem is the B4x Broker does not support websockets, so one can use something else and I didnt want an online broker either, but something I can have control over.  
  
***Windows Install***  
  
1. Install [Mosquitto](https://mosquitto.org/download/) locally in your server machine. By default this works on port 1833  
  
***Setup MQTT broker to work with WebApps i.e. enable websockets***  
  
2. Enable Mosquito to send / receive messages via **websockets.** This enabled your web app to access the messages  
  
Update the **conf** file of mosquitto, you might find it under program files/mosquito  
  

```B4X
listener 9001  
protocol websockets
```

  
  
As I am new to this, I also had to set this   
  

```B4X
allow_anonymous true
```

  
  
For the MQTTX app to be connected and run tests.  
  
If you have installed this as a service, you will need to stop it, update the file and then restart the service.  
  
Set this to your port you want and open it on your firewall. Run your MQTT broker.  
  
3. You will need a toolbox to test your MQTT installation etc. I used [MQTTX](https://mqttx.app/)  
  
For more learning materials on MQTT, you can see [these guides](http://www.steves-internet-guide.com/)