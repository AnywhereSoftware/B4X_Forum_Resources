/*
    ThingSpeak data uploader

     Connect to an access point using Static IP
    Send cell current data to ThingSpeak channel 
     
     (c) Didier Juges, 2022-2024

    ThinkSpeak related code from:
    https://docs.arduino.cc/tutorials/generic/WiFi101ThingSpeakDataUploader/

*/

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>

// D1 mini dht library needs DHT sensor library for ESPx v1.19, which requires Adafruit Unified Sendor library, installed v1.1.14

#define DHTPIN      14
#define DHTTYPE     DHT11     // DHT 11

DHT_Unified dht( DHTPIN, DHTTYPE );

bool DEBUG_HTTP = true;

const char* ssid     = "your ssid";
const char* password = "your password";

// note that I use fixed IP addresses because my NETGEAR router's DHCP server keeps crashing
IPAddress local_IP( 192, 168, 0, 9 );
IPAddress gateway( 192, 168, 0, 1 );
IPAddress subnet( 255, 255, 255, 0 );
IPAddress primaryDNS( 192, 168, 0, 1 ); //optional
IPAddress secondaryDNS( 8, 8, 4, 4 ); //optional


char thingSpeakAddress[] = "api.thingspeak.com";
String APIKey = "your write API key";  
const long updateThingSpeakInterval = 300 * 1000;  //  minutes interval at which to update ThingSpeak
long lastConnectionTime = updateThingSpeakInterval;
boolean lastConnected = false;
WiFiClient thingspeak;

long lastPrintTime = 0;
const int printDelay( 2000 );

void setup(){
  Serial.begin( 115200 );
 
  Serial.println( "\n\n\nChlorine Cell Monitor" );
  delay( 3000 );
  
  if( !WiFi.config( local_IP, gateway, subnet, primaryDNS, secondaryDNS )){
    Serial.println( "STA Failed to configure" );
  }
  delay( 500 );

  Serial.print( "\nChlorine Cell Monitor\n" );
  Serial.print( "Connecting to " );
  Serial.println( ssid );

  WiFi.begin( ssid, password );

  while( WiFi.status() != WL_CONNECTED ){
    delay( 100 );
    Serial.print( "." );
  }
  
  Serial.println( "" );
  Serial.println( "WiFi connected!" );
  Serial.print( "IP address: " );
  Serial.println( WiFi.localIP() );
  Serial.print( "ESP Mac Address: " );
  Serial.println( WiFi.macAddress() );
  Serial.print( "Subnet Mask: " );
  Serial.println( WiFi.subnetMask() );
  Serial.print( "Gateway IP: " );
  Serial.println( WiFi.gatewayIP() );
  Serial.print( "DNS: " );
  Serial.println( WiFi.dnsIP() );

  dht.begin();
  // Print temperature sensor details.
  sensor_t sensor;
  dht.temperature().getSensor( &sensor );
  Serial.println( "------------------------------------" );
  Serial.println( "Temperature Sensor" );
  Serial.print( "Sensor Type: " ); Serial.println( sensor.name );
  Serial.print( "Driver Ver:  " ); Serial.println( sensor.version );
  Serial.print( "Unique ID:   " ); Serial.println( sensor.sensor_id );
  Serial.print( "Max Value:   " ); Serial.print( sensor.max_value ); Serial.println( "°C" );
  Serial.print( "Min Value:   " ); Serial.print( sensor.min_value ); Serial.println( "°C" );
  Serial.print( "Resolution:  " ); Serial.print( sensor.resolution ); Serial.println( "°C" );
  Serial.println(F("------------------------------------"));
  // Print humidity sensor details.
  dht.humidity().getSensor( &sensor );
  Serial.println( "Humidity Sensor" );
  Serial.print( "Sensor Type: " ); Serial.println( sensor.name );
  Serial.print( "Driver Ver:  " ); Serial.println( sensor.version );
  Serial.print( "Unique ID:   " ); Serial.println( sensor.sensor_id );
  Serial.print( "Max Value:   " ); Serial.print( sensor.max_value ); Serial.println( "%" );
  Serial.print( "Min Value:   " ); Serial.print( sensor.min_value ); Serial.println( "%" );
  Serial.print( "Resolution:  " ); Serial.print( sensor.resolution ); Serial.println("%" );
  Serial.println( "------------------------------------" );
} // setup()

void loop(){
  float current, voltage, temp;

  int temperature = 0;
  int humidity = 0;
  int dht_error;

  // print current to Serial Monitor
  if( millis() - lastPrintTime > printDelay ){
    current = analogRead( A0 );
    current = current*6.5/160;
    Serial.print( "Current: " );
    Serial.println( current );
    voltage = 24.5; // this should be an analog input
    temp = 87;     // this should be an analog input
       
    // Get temperature event and print its value.
    sensors_event_t event;
    dht.temperature().getEvent(&event);
    if (isnan(event.temperature)) {
      Serial.println(F("Error reading temperature!"));
    }else{
      Serial.print(F("Temperature: "));
      temperature = event.temperature;
      Serial.print( temperature );
      Serial.println( F("°C") );
    }
    // Get humidity event and print its value.
    dht.humidity().getEvent(&event);
    if (isnan(event.relative_humidity)) {
      Serial.println(F("Error reading humidity!"));
    }else {
      Serial.print(F("Humidity: "));
      humidity = event.relative_humidity;
      Serial.print( humidity );
      Serial.println( F("%") );
    }

    delay( 500 );
    lastPrintTime = millis();

    // Update ThingSpeak
    if( !thingspeak.connected() && (millis() - lastConnectionTime > updateThingSpeakInterval )){
      Serial.println( "Uploading..." );
      delay( 500 );
      updateThingSpeak( "field1=" + String( current ) + "&field2=" + String( voltage ) + "&field3=" + String( temp ) + "&field4=" + String( temperature ) + "&field5=" + String( humidity ));
    }
  } 
} // loop()

void updateThingSpeak( String tsData ){
  if( thingspeak.connect( thingSpeakAddress, 80 )){
    thingspeak.print( "POST /update HTTP/1.1\n" );
    thingspeak.print( "Host: api.thingspeak.com\n" );
    thingspeak.print( "Connection: close\n" );
    thingspeak.print( "X-THINGSPEAKAPIKEY: " + APIKey + "\n" );
    thingspeak.print( "Content-Type: application/x-www-form-urlencoded\n" );
    thingspeak.print( "Content-Length: " );
    thingspeak.print( tsData.length() );
    thingspeak.print( "\n\n" );
    thingspeak.print( tsData );
    lastConnectionTime = millis();
    // wait a bit before disconnecting
    delay( 1000 );
    // Disconnect from ThingSpeak
    thingspeak.stop();
  }
} // updateThingSpeak()
