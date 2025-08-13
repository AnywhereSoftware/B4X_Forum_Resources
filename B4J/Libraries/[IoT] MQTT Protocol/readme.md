### [IoT] MQTT Protocol by Erel
### 09/26/2023
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/59471/)

**What is MQTT?**  
  
"MQTT is a Client Server publish/subscribe messaging transport protocol. It is light weight, open, simple, and designed so as to be easy to implement. These characteristics make it ideal for use in many situations, including constrained environments such as for communication in Machine to Machine (M2M) and Internet of Things (IoT) contexts where a small code footprint is required and/or network bandwidth is at a premium.  
  
The protocol runs over TCP/IP, or over other network protocols that provide ordered, lossless, bi-directional connections." (<http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/mqtt-v3.1.1.html>)  
  
I recommend all developers to learn the main concepts of MQTT. It is quite simple to use and it solves many of the real-world issues that developers need to manage when building network based solutions.  
  
You can find good tutorials about MQTT here:  
<https://www.hivemq.com/mqtt-essentials/>  
  
Some of the differences between MQTT solutions and B4J server (http and websocket) solutions:  

- With MQTT we only need to develop the clients. The server (message broker) is already implemented for us.
- Each client can send messages (publish) and receive messages (subscribe). Note that we can implement a similar solution with WebSockets.
- It is a many to many connection. Clients can listen to messages from other clients.

**Server / Message Broker**  
  
The clients connect to the broker. The broker is responsible for routing the messages and managing the connections.  
You can either run a local broker (for local network solutions) or an online broker.  
  
You can install and run Mosquitto: <http://mosquitto.org/download/>  
Pay attention to the installation instructions as it depends on two additional resources. Follow the links in the installation dialog.  
  
CloudMQTT is an online broker: cloudmqtt.com  
They provide a free plan which you can use during development. Very simple to get started with.  
Edit: You can embed the broker in your app with the new MqttBroker library (B4A + B4J): <https://www.b4x.com/android/forum/threads/mqttbroker.61548/>  
  
**B4X Code**  
  

1. Initialize MqttClient with the server URI and client id.
2. Set the options, including the user name and password, if required.
3. Call MqttClient.Connect
4. The Connected event will be raised. If Success is true then you can subscribe to topics and publish messages.
5. The MessageArrived event will be raised whenever a message is received (based on the subscribed topics).
6. Call MqttClient.Close to close the connection. Make sure to close the connection before you close the app or the process may keep on running in the background.

See the attached example. You will need to set the user name and password based on your CloudMQTT account or change it to connect to a local broker.  
  
You can compile it in release mode and run multiple instances of the application to see how it works.  
See the video here: <https://www.b4x.com/android/forum/threads/mqtt.59346/>  
  
Note that the jMQTT library is compatible with B4A and B4J.  
The library is available here: <https://www.b4x.com/android/forum/threads/jmqtt-official-mqtt-client.59472/>  
B4i - iMQTT library: <https://www.b4x.com/android/forum/threads/imqtt-official-ios-mqtt-client.59516/>  
  
A compiled example is available here: <https://www.b4x.com/android/forum/threads/mqtt.59346/#post-374535>