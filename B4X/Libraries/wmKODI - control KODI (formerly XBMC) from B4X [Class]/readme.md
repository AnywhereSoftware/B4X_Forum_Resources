### wmKODI - control KODI (formerly XBMC) from B4X [Class] by walt61
### 07/15/2023
[B4X Forum - B4X - Libraries](https://www.b4x.com/android/forum/threads/135867/)

The title says it all. The API v10 info on which this class is based can be found at <https://kodi.wiki/view/JSON-RPC_API/v10>. Public methods:  
- Initialize: Initializes the object  
- Application\_GetOneProperty: Retrieves the value of the given property.  
- Application\_GetProperties: Retrieves the values of the given properties.  
- Application\_GetVolume: Get the current volume.  
- Application\_SetMute: Toggle mute/unmute.  
- Application\_SetVolume: Set the current volume.  
- Favourites\_GetFavourites: Retrieve all favourites  
- Favourites\_PlayFavourite: Plays a favourite of type 'media' or 'window'. Does nothing for other favourite types.  
- GUI\_ActivateWindow: Activates the given window  
- Input\_Back: Goes back in GUI  
- Input\_ContextMenu: Shows the context menu  
- Input\_Down: Navigate down in GUI  
- Input\_Home: Goes to home window in GUI  
- Input\_Info: Shows the information dialog (if it is available at that time)  
- Input\_Left: Navigate left in GUI  
- Input\_Right: Navigate right in GUI  
- Input\_Select: Select current item in GUI  
- Input\_ShowOSD: Show the on-screen display for the current player (if an OSD is available for it)  
- Input\_ShowPlayerProcessInfo: Show player process information (if it is available) of the playing item, like video decoder, pixel format, pvr signal strength, …  
- Input\_Up: Navigate up in GUI  
- Arbitrary\_KODI\_call: Call an arbitrary KODI JSON RPC API method  
- JSONRPC\_Version: Retrieve the JSON-RPC protocol version. Can also be used to test the connection.  
- Player\_GetActivePlayers: Returns all active players  
- Player\_GetItem: Retrieves one or more properties of the currently played item  
- Player\_GetItemOneProperty: Retrieves one property of the currently played item  
- Player\_GetOneProperty: Retrieves the value of the given property  
- Player\_GetPlayers: Get a list of available players  
- Player\_GetProperties: Retrieves the values of the given properties  
- Player\_Open\_File: Start playback of a single file  
- Player\_PlayPause: Pauses or unpauses playback  
- Player\_SeekPercentage: Seek through the playing item by specifying a percentage of the item's duration  
- Player\_SetSpeed: Set the speed of the current playback  
- Player\_SetSpeedBackward: Steps through the 'backward' (reverse) speed of the current playback  
- Player\_SetSpeedForward: Steps through the 'forward' speed of the current playback  
- Player\_Stop: Stops playback  
  
B4A-specific notes:  
- You may need to edit the Manifest (see example project)  
- Long-clicking the buttons will show a toast message with a (very) brief description  
  
Non-core library dependencies:  
- B4J: jOkHttpUtils2, Json  
- B4A: OkHttpUtils2, Json  
  
B4A and B4J demo projects attached. I know especially for the B4A app I won't win any UI design awards but that wasn't my objective anyway :)  
  
CHANGES:  
- 2023-07-13: added public methods Application\_GetOneProperty, Application\_GetProperties, Application\_GetVolume, Application\_SetMute, and Application\_SetVolume  
- 2021-11-10: added public method 'Favourites\_PlayFavourite'; the attachments to this here post were updated  
  
Enjoy!  
  
![](https://www.b4x.com/android/forum/attachments/143723)