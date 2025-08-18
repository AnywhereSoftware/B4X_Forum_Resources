### rAsyncTCP on esp32 / rESPAsyncTCP on esp8266 by candide
### 03/24/2022
[B4X Forum - B4R - Libraries](https://www.b4x.com/android/forum/threads/138893/)

after a question on this forum, i had a look at AsyncTCP and i was looking if a wrapper for this library was possible.  
  
at last, i can propose a wrapper for AsyncTCP on esp32  
  
2 projects B4R with this library are available : Client project and Server project and it seems working  
  
in both cases, B4R projects can be multi-Client.  
 each client is created manually in case of client project  
 each client is created by server at reception of new connection to server in case of server project  
  
in original library, each client is managed by pointer: we have one pointer by client and access to a client is done by this pointer  
  
In B4R, we cannot manage by pointer, and palliative solution is to manage clients by a clientID(ulong) equivalent to pointer of library  
 => on each message from AsyncTCP to B4R, pointer to client is converted to ClientID (ulong)  
 => on each command from B4R to AsyncTCP library, clientID(ulong) is converted to pointer to run command sent on the client to manage  
  
in BAR, with each client, we have a ulong value : clientID, it is our reference for a client  
 => each time we want to run a function in AsyncTCP, we have to provide clientID to indicate client to manage  
  
after, all functions available in AsyncTCP are available in B4R by clientID  
  
we have 7 Call Back available, but only Call Back needed can be created.  
on each Call Back, we have a parameter ardID: it is just a parameter provided at creation of CB and you will recover it at Call Back activation. (it can be clientID)  
  
with the 2 examples provided, you can run a simple client project and a simple server project based on demo of library  
  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
update 2022/03/24 : added rESPAsyncTCP library  
  
this is a wrapper for ESPAsyncTCP on esp8266   
  
original library : <https://github.com/me-no-dev/ESPAsyncTCP>  
  
this library is similar to AsyncTCP but dedicated to esp8266  
  
ESPAsyncTCP must be installed in arduino side for compilation B4R  
   
2 projects B4R with this library are available : Client project and Server project.  
(no SSL possible with this library because ESPAsyncTCP can work with openss1 but in new sdk ESP, openssl is removed (too big)