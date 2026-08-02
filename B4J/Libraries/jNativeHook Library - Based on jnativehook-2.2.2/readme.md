### jNativeHook Library - Based on jnativehook-2.2.2 by Peter Simpson
### 07/26/2026
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/171640/)

Hello everyone,  
This is an updated release of the jNativeHook library, built on the latest version 2.2.2. Although older versions are available on the forum, I have now taken the time to publish the version I have been using for the last couple of years for the benefit of the community.  
  
**B4J library tab:**  
![](https://www.b4x.com/android/forum/attachments/172576)  
  
**SS\_jNativeHook  
  
Author:** Peter Simpson  
**Version:** 1.0  

- **NativeHook**

- **Events:**

- **KeyPressed** (EventData As Map)
- **KeyReleased** (EventData As Map)
- **KeyTyped** (EventData As Map)
- **MouseClicked** (EventData As Map)
- **MouseDragged** (EventData As Map)
- **MouseMoved** (EventData As Map)
- **MousePressed** (EventData As Map)
- **MouseReleased** (EventData As Map)
- **MouseWheel** (EventData As Map)

- **Functions:**

- **Initialize** (EventName As String)
*Initialize (EventName)  
 Prepares the NativeHook object and sets the event name prefix.*- **RegisterHook** As Boolean
*RegisterHook As Boolean  
 Registers the global keyboard and mouse hook.  
 Returns True if the hook was successfully registered.*- **UnregisterHook**
*UnregisterHook  
 Removes all listeners and unregisters the global hook.*
- **Properties:**

- **DebugLogging** As Boolean
*GetDebugLogging As Boolean  
 Returns whether debug logging is currently enabled.*- **IsRegistered** As Boolean [read only]
*IsRegistered As Boolean  
 Returns True if the global hook is currently active.*
  
[SPOILER="Test logs - Keypress, mouse click, scrollwheel, and mouse movement"]  
RegisterHook returned: true  
IsRegistered: true  
Native hook registered  
Call B4XPages.GetManager.LogEvents = True to enable logging B4XPages events.  
MousePressed → {Button=1, ClickCount=1, X=1167, Y=513, Modifiers=256}  
MouseReleased → {Button=1, ClickCount=1, X=1167, Y=513, Modifiers=0}  
MouseClicked → {Button=1, ClickCount=1, X=1167, Y=513, Modifiers=0}  
MousePressed → {Button=2, ClickCount=1, X=1167, Y=513, Modifiers=512}  
MouseReleased → {Button=2, ClickCount=1, X=1167, Y=513, Modifiers=0}  
MouseClicked → {Button=2, ClickCount=1, X=1167, Y=513, Modifiers=0}  
MousePressed → {Button=1, ClickCount=1, X=1167, Y=513, Modifiers=256}  
MouseDragged → {X=1170, Y=513, Modifiers=256}  
MouseDragged → {X=1170, Y=514, Modifiers=256}  
MouseDragged → {X=1164, Y=527, Modifiers=256}  
MouseDragged → {X=1164, Y=530, Modifiers=256}  
MouseDragged → {X=1164, Y=539, Modifiers=256}  
MouseDragged → {X=1164, Y=548, Modifiers=256}  
MouseDragged → {X=1164, Y=562, Modifiers=256}  
MouseDragged → {X=1189, Y=607, Modifiers=256}  
MouseDragged → {X=1204, Y=622, Modifiers=256}  
MouseDragged → {X=1219, Y=634, Modifiers=256}  
MouseDragged → {X=1239, Y=646, Modifiers=256}  
MouseDragged → {X=1259, Y=662, Modifiers=256}  
MouseDragged → {X=1284, Y=670, Modifiers=256}  
MouseDragged → {X=1298, Y=670, Modifiers=256}  
MouseDragged → {X=1317, Y=674, Modifiers=256}  
MouseDragged → {X=1347, Y=678, Modifiers=256}  
MouseDragged → {X=1385, Y=678, Modifiers=256}  
MouseDragged → {X=1513, Y=651, Modifiers=256}  
MouseDragged → {X=1516, Y=645, Modifiers=256}  
MouseDragged → {X=1519, Y=640, Modifiers=256}  
MouseDragged → {X=1530, Y=629, Modifiers=256}  
MouseDragged → {X=1533, Y=614, Modifiers=256}  
MouseDragged → {X=1533, Y=605, Modifiers=256}  
MouseDragged → {X=1540, Y=535, Modifiers=256}  
MouseDragged → {X=1535, Y=525, Modifiers=256}  
MouseDragged → {X=1529, Y=522, Modifiers=256}  
MouseDragged → {X=1523, Y=516, Modifiers=256}  
MouseDragged → {X=1520, Y=514, Modifiers=256}  
MouseDragged → {X=1518, Y=511, Modifiers=256}  
MouseDragged → {X=1401, Y=497, Modifiers=256}  
MouseDragged → {X=1387, Y=497, Modifiers=256}  
MouseDragged → {X=1372, Y=503, Modifiers=256}  
MouseDragged → {X=1357, Y=511, Modifiers=256}  
MouseDragged → {X=1347, Y=518, Modifiers=256}  
MouseDragged → {X=1341, Y=518, Modifiers=256}  
MouseDragged → {X=1332, Y=524, Modifiers=256}  
MouseDragged → {X=1330, Y=526, Modifiers=256}  
MouseDragged → {X=1323, Y=536, Modifiers=256}  
MouseDragged → {X=1320, Y=542, Modifiers=256}  
MouseDragged → {X=1313, Y=556, Modifiers=256}  
MouseDragged → {X=1313, Y=562, Modifiers=256}  
MouseDragged → {X=1318, Y=590, Modifiers=256}  
MouseDragged → {X=1325, Y=596, Modifiers=256}  
MouseDragged → {X=1336, Y=611, Modifiers=256}  
MouseDragged → {X=1346, Y=615, Modifiers=256}  
MouseDragged → {X=1360, Y=615, Modifiers=256}  
MouseDragged → {X=1379, Y=618, Modifiers=256}  
MouseDragged → {X=1402, Y=622, Modifiers=256}  
MouseDragged → {X=1449, Y=626, Modifiers=256}  
MouseDragged → {X=1468, Y=626, Modifiers=256}  
MouseDragged → {X=1508, Y=618, Modifiers=256}  
MouseDragged → {X=1508, Y=609, Modifiers=256}  
MouseDragged → {X=1508, Y=606, Modifiers=256}  
MouseDragged → {X=1511, Y=601, Modifiers=256}  
MouseDragged → {X=1511, Y=596, Modifiers=256}  
MouseReleased → {Button=1, ClickCount=0, X=1511, Y=590, Modifiers=0}  
KeyPressed → {KeyCode=48, RawCode=66, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=5, RawCode=52, KeyChar=￿, Modifiers=0}  
KeyReleased → {KeyCode=5, RawCode=52, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=45, RawCode=88, KeyChar=￿, Modifiers=0}  
KeyReleased → {KeyCode=45, RawCode=88, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=52, RawCode=190, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=46, RawCode=67, KeyChar=￿, Modifiers=0}  
KeyReleased → {KeyCode=46, RawCode=67, KeyChar=￿, Modifiers=0}  
KeyReleased → {KeyCode=24, RawCode=79, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=50, RawCode=77, KeyChar=￿, Modifiers=0}  
KeyReleased → {KeyCode=50, RawCode=77, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=42, RawCode=160, KeyChar=￿, Modifiers=1}  
KeyPressed → {KeyCode=48, RawCode=66, KeyChar=￿, Modifiers=1}  
KeyReleased → {KeyCode=48, RawCode=66, KeyChar=￿, Modifiers=1}  
KeyPressed → {KeyCode=5, RawCode=52, KeyChar=￿, Modifiers=1}  
KeyReleased → {KeyCode=5, RawCode=52, KeyChar=￿, Modifiers=1}  
KeyReleased → {KeyCode=42, RawCode=160, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=42, RawCode=160, KeyChar=￿, Modifiers=1}  
KeyPressed → {KeyCode=36, RawCode=74, KeyChar=￿, Modifiers=1}  
KeyReleased → {KeyCode=42, RawCode=160, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=57, RawCode=32, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=2, RawCode=49, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=3, RawCode=50, KeyChar=￿, Modifiers=0}  
KeyPressed → {KeyCode=4, RawCode=51, KeyChar=￿, Modifiers=0}  
MousePressed → {Button=2, ClickCount=1, X=1946, Y=514, Modifiers=512}  
MouseDragged → {X=1944, Y=514, Modifiers=512}  
MouseDragged → {X=1938, Y=509, Modifiers=512}  
MouseDragged → {X=1932, Y=506, Modifiers=512}  
MouseDragged → {X=1921, Y=499, Modifiers=512}  
MouseDragged → {X=1907, Y=495, Modifiers=512}  
MouseDragged → {X=1888, Y=488, Modifiers=512}  
MouseDragged → {X=1825, Y=468, Modifiers=512}  
MouseDragged → {X=1811, Y=468, Modifiers=512}  
MouseDragged → {X=1792, Y=468, Modifiers=512}  
MouseDragged → {X=1769, Y=468, Modifiers=512}  
MouseDragged → {X=1751, Y=468, Modifiers=512}  
MouseDragged → {X=1732, Y=468, Modifiers=512}  
MouseDragged → {X=1709, Y=468, Modifiers=512}  
MouseDragged → {X=1686, Y=468, Modifiers=512}  
MouseDragged → {X=1667, Y=471, Modifiers=512}  
MouseDragged → {X=1647, Y=479, Modifiers=512}  
MouseDragged → {X=1645, Y=481, Modifiers=512}  
MouseDragged → {X=1627, Y=493, Modifiers=512}  
MouseDragged → {X=1624, Y=499, Modifiers=512}  
MouseDragged → {X=1621, Y=509, Modifiers=512}  
MouseDragged → {X=1621, Y=514, Modifiers=512}  
MouseDragged → {X=1618, Y=527, Modifiers=512}  
MouseDragged → {X=1618, Y=532, Modifiers=512}  
MouseDragged → {X=1618, Y=534, Modifiers=512}  
MouseDragged → {X=1618, Y=543, Modifiers=512}  
MouseDragged → {X=1618, Y=545, Modifiers=512}  
MouseDragged → {X=1708, Y=558, Modifiers=512}  
MouseDragged → {X=1722, Y=558, Modifiers=512}  
MouseDragged → {X=1740, Y=558, Modifiers=512}  
MouseDragged → {X=1763, Y=558, Modifiers=512}  
MouseDragged → {X=1792, Y=558, Modifiers=512}  
MouseDragged → {X=1821, Y=558, Modifiers=512}  
MouseDragged → {X=1859, Y=558, Modifiers=512}  
MouseDragged → {X=1882, Y=558, Modifiers=512}  
MouseDragged → {X=1901, Y=555, Modifiers=512}  
MouseDragged → {X=1938, Y=523, Modifiers=512}  
MouseDragged → {X=1938, Y=513, Modifiers=512}  
MouseDragged → {X=1938, Y=504, Modifiers=512}  
MouseDragged → {X=1938, Y=494, Modifiers=512}  
MouseDragged → {X=1938, Y=489, Modifiers=512}  
MouseDragged → {X=1938, Y=473, Modifiers=512}  
MouseDragged → {X=1879, Y=451, Modifiers=512}  
MouseDragged → {X=1856, Y=451, Modifiers=512}  
MouseDragged → {X=1833, Y=451, Modifiers=512}  
MouseDragged → {X=1823, Y=451, Modifiers=512}  
MouseDragged → {X=1814, Y=451, Modifiers=512}  
MouseDragged → {X=1795, Y=454, Modifiers=512}  
MouseDragged → {X=1788, Y=461, Modifiers=512}  
MouseDragged → {X=1767, Y=482, Modifiers=512}  
MouseDragged → {X=1761, Y=488, Modifiers=512}  
MousePressed → {Button=2, ClickCount=1, X=2419, Y=574, Modifiers=512}  
MousePressed → {Button=1, ClickCount=1, X=2601, Y=667, Modifiers=256}  
MouseReleased → {Button=1, ClickCount=1, X=2601, Y=667, Modifiers=0}  
MouseClicked → {Button=1, ClickCount=1, X=2601, Y=667, Modifiers=0}  
MousePressed → {Button=1, ClickCount=1, X=2282, Y=980, Modifiers=256}  
[/SPOILER]  
  
**PLEASE NOTE:  
TO RUN THE ATTACHED EXAMPLE, YOU NEED TO DOWNLOAD THE THIRD-PARTY **JAVA DEPENDENCY** LINKED BELOW, AS WELL AS USING THE ATTACHED POST LIBRARY.  
[CLICK HERE](https://www.dropbox.com/scl/fi/8ajla9ubrk3hw9ec2f9ca/Modbus-Serial-RTU-Dependencies.zip?rlkey=qo3f1qa99g5c7ehnminv7y6k4&dl=0)**[- Download Dependency](https://www.dropbox.com/scl/fi/n63h8wmvsqc7b2goslcsy/jnativehook-2.2.2.zip?rlkey=6f0bkthq4t60u7u8lobrm14pe&dl=0) <<<<<<<<<<<<<<<<<<<<<<<<  
  
  
**Enjoy…**