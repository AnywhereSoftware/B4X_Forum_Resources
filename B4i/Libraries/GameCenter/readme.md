### GameCenter by Erel
### 08/08/2024
[B4X Forum - B4i - Libraries](https://www.b4x.com/android/forum/threads/85766/)

iGameCenter library provides access to Apple's Game Center services. Currently only the leaderboard (high scores) feature is implemented.  
  
![](https://www.b4x.com/basic4android/images/SS-2017-11-05_17.48.23.png)  
  
This service requires some configuration:  
1. You must use an explicit app id (without wildcards).  
2. Must use a development certificate and provision profile during development.  
3. Add this line:  

```B4X
#DeviceCapabilities: gamekit
```

  
4. An app record must be available in iTunes Connect.  
5. Create a leaderboard:  
  
![](https://www.b4x.com/basic4android/images/SS-2017-11-05_17.42.38.png)  
  
6. Enable Game Center in the app version page:  
  
![](https://www.b4x.com/basic4android/images/SS-2017-11-05_17.43.28.png)  
  
The code itself is quite simple. You should initialize the GKGameCenter object when the program starts.  
The AuthenticationStateChanged event will be raised.  
If ShouldShowDialog is True then you need to call Game.ShowDialog.  
  
The AuthenticationStateChanged can be raised in other cases as well so assume that it will be raised and the state will change.  
  
Once authenticated you can submit the current user scores and you can get the top scores.  
See the attached example (make sure to change the board id as needed).  
  
See code in post #8 for showing the built-in leaderboard dialog.  
  
**Update:**  
  
Need to add to main module:  

```B4X
#Entitlement: <key>com.apple.developer.game-center</key><true/>
```