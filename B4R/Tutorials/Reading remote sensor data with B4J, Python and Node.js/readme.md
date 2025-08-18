### Reading remote sensor data with B4J, Python and Node.js by Martin Larsen
### 03/15/2021
[B4X Forum - B4R - Tutorials](https://www.b4x.com/android/forum/threads/128657/)

I am working on a [little thermometer project](https://www.b4x.com/android/forum/threads/deep-sleep-with-asyncstreams-b4xserializator.128458/) for my greenhouse using an ESP8266 and a temperature sensor. You have [multiple sensors](https://randomnerdtutorials.com/dht11-vs-dht22-vs-lm35-vs-ds18b20-vs-bme280-vs-bmp180/) to choose from such as DHT11/22, BMP180 etc, but no matter which sensor, you need to transmit the readings.  
  
My first attempt was with [AsyncStreams + B4RSerializator](https://www.b4x.com/android/forum/threads/b4x-b4rserializator-send-and-receive-objects-instead-of-bytes.72404/#content) and while this works, it is unnecessary complex for such simple tasks as transmitting a sensor reading. [USER=10828]@monki[/USER] kindly pointed me to [another direction](https://www.b4x.com/android/forum/threads/esp8266-udp-bmp180-simple-weather-station.70243/) using UDP packets. This turned out to be a much better approach.  
  
**Advantages of UDP broadcasts**  
UDP broadcast messages have several advantages:  

- Very lightweight
- No server required. The sensor broadcasts to any listening receiver
- You can have as many receivers as you like. For example, you can build a weather station with displays in both your living room and bedroom
- Very easy to deal with in other platforms

The last point is important. Erel has already shown a simple broadcast receiver using B4J in the [weather station tutorial](https://www.b4x.com/android/forum/threads/esp8266-udp-bmp180-simple-weather-station.70243/):  
  

```B4X
Sub Process_Globals  
    Private usocket As UDPSocket  
End Sub  
  
Sub AppStart (Args() As String)  
    usocket.Initialize2("usocket", 51042, 8192, True, False) 'reuse is set to true  
    Log($"Broadcast address: ${usocket.GetBroadcastAddress}"$)  
    StartMessageLoop  
End Sub  
  
Private Sub usocket_PacketArrived (Packet As UDPPacket)  
    If Packet.Length <> 8 Then  
        Log("Invalid data")  
        Return  
    Else  
        Dim raf As RandomAccessFile  
        raf.Initialize3(Packet.Data, True)  
        raf.CurrentPosition = Packet.Offset  
        Dim temperature, pressure As Float  
        temperature = raf.ReadFloat(raf.CurrentPosition)  
        pressure = raf.ReadFloat(raf.CurrentPosition)  
        Log($"Temperature: $1.1{temperature}°"$)  
        Log($"Pressure: $1.1{pressure} mBar"$)  
    End If  
End Sub
```

  
  
However, I wanted to run the receiver on my Raspberry Pi 3 with limited storage so I didn't want to install Java. Luckily, we have easy alternatives.  
  
First, let's check if there is anything going on on the specific port. On Linux and Mac you can use netcat for this. There is probably also a Windows version.  

```B4X
netcat -lu -p 51042
```

  
  
The output is just garbage since the floating point numbers are represented as their equivalent ascii characters without interpretation. But it will tell us if there are packets broadcast to the given port.  
  
**Python receiver**  
Now let's implement the receiver in Python. It will show the sensor readings from the B4R program in the weather station tutorial:  
  

```B4X
#!/usr/bin/env python  
# coding=UTF-8  
port = 51042  
from socket import *  
import struct  
s=socket(AF_INET, SOCK_DGRAM)  
s.bind(('', port))  
while True:  
   m=s.recvfrom(1024)  
   f1 = m[0][0:4]  
   f2 = m[0][4:8]  
   temperature = struct.unpack('f',f1)[0]  
   pressure = struct.unpack('f',f2)[0]  
   print "%s °C, %s mBar" % (temperature, pressure)
```

  
  
**Node.js receiver**  
I have also node.js installed on my Raspi, and since I do a lot of node work, I prefer that over Python. Here is the node version:  

```B4X
#!/usr/bin/env node  
const PORT = 51042;  
const dgram = require("dgram");  
const socket = dgram.createSocket({ type: "udp4", reuseAddr: true });  
socket.on("message", function(message, info) {  
   const temperature = message.readFloatLE()  
   const pressure = message.subarray(4).readFloatLE()  
   console.log(`${temperature} °C, ${pressure} mBar`)  
});  
socket.bind(PORT);
```

  
  
**Broadcast receiver with web server**  
It is easy to implement a simple web server in node. I wanted the Rasbi to provide a JSON file for my Android app. Thus, the nodejs script on my Rasbi is responsible for collecting the packets from the ESP8266 and my B4XPages app can display the data. This is better than having the phone app receive the broadcasts because this will only work if you're at home.  
  
This simple script will both receive the sensor broadcasts and publish the JSON data on localhost:8001. You can choose any port you like.  

```B4X
#!/usr/bin/env node  
  
const UDP_PORT = 51043  
const HTTP_PORT = 8001  
  
const http = require('http')  
const data = { temperature: "no reading", pressure: "no reading", time: new Date().toLocaleTimeString()}  
  
const dgram = require("dgram")  
  
const socket = dgram.createSocket({ type: "udp4", reuseAddr: true })  
socket.bind(UDP_PORT)  
  
socket.on("message", function(message, info) {  
  data.temperature = message.readFloatLE()  
  data.pressure = message.subarray(4).readFloatLE()  
  data.time = new Date().toLocaleTimeString()  
  console.log(data)  
});  
  
http.createServer(function (req, res) {  
  res.writeHead(200, {'Content-Type': 'application/json; charset=utf-8'})  
  res.end(JSON.stringify(data))  
}).listen(HTTP_PORT)
```

  
  

```B4X
{  
"temperature": 23.60211181640625,  
"pressure": 999.6287841796875,  
"time": "14:50:30"  
}
```

  
**Multiple sensors**  
What if you have multiple sensors? For example a sensor in each room as well as an outdoor sensor?  
  
You have two choices. Either you can use slightly different reading intervals for you sensors, for example every 57 and 61 seconds. This means that they will rarely collide even though they broadcast on the same port. And when they do collide, the next reading will be fine again.  
  
A more robust approach is to use a separate port for each sensor. This example for node shows two receivers listening on separate ports. The *info* parameter in the message function tells us which sensor (IP and port) sent the message, so we never mix up the data even though we use the same message function for multiple sensors.  
  

```B4X
#!/usr/bin/env node  
const PORT1 = 51042;  
const PORT2 = 51043;  
  
const dgram = require("dgram");  
  
const socket1 = dgram.createSocket({ type: "udp4", reuseAddr: true });  
const socket2 = dgram.createSocket({ type: "udp4", reuseAddr: true });  
  
socket1.on("message", message);  
socket2.on("message", message);  
  
socket1.bind(PORT1);  
socket2.bind(PORT2);  
  
function message(msg, info) {  
   const temperature = msg.readFloatLE()  
   const pressure = msg.subarray(4).readFloatLE()  
   console.log(`${info.address}:${info.port} says: ${temperature} °C, ${pressure} mBar`)  
}
```

  
  

```B4X
192.168.1.21:51043 says: 23.665287017822266 °C, 999.4187622070312 mBar  
192.168.1.228:51042 says: 5.898721812782782 °C, 999.6021217711182 mBar
```

  
  
**Sending UDP messages**  
This tutorial mainly deals with the receiving end, but to make it complete, here is the B4R code taken from the weather station tutorial that actually sends the sensor data:  

```B4X
Private Sub Timer1_Tick  
    If Not(bmp180.GetTemperature) Then  
        Log("Error retrieving the temperature.")  
    Else  
        Dim buffer(8) As Byte  
        'double in B4R is 4 bytes  
        Dim raf As RandomAccessFile  
        raf.Initialize(buffer, True)  
        raf.WriteDouble32(bmp180.LastResult, raf.CurrentPosition)  
        Log(bmp180.LastResult)  
        bmp180.GetPressure(0, bmp180.LastResult)  
        Log(bmp180.LastResult)  
        raf.WriteDouble32(bmp180.LastResult, raf.CurrentPosition)  
        usocket.BeginPacket(ip, port)  
        usocket.Write(buffer)  
        usocket.SendPacket  
    End If  
End Sub
```