### rEspalexa library by candide
### 08/02/2022
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/128053/)

it is a wrapper for Espalexa library from Christian Schwinne : <https://github.com/Aircoookie/Espalexa>  
  
with this library, we can create/modify 1<10 devices, 5 types are possible and management after is done by Alexa  
 - EspalexaDeviceType::dimmable   
 - EspalexaDeviceType::whitespectrum   
 - EspalexaDeviceType::color   
 - EspalexaDeviceType::extendedcolor  
 - EspalexaDeviceType::eek:noff (experimental)  
  
this wrapper provide an interface for all functions in B4R.  
 - in original library, each device is identified by a pointer, in B4R by an index  
 - commands from Alexa are provided to B4R interface by a CallBack  
  
an example of B4R project is included in zip file  
  
22/08/02 new version based on library ESPAlexa v2.7.0 and with correction of type of file for espalexa.h