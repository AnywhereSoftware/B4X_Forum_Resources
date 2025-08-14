### wmSMA - read data from an SMA Sunny Boy inverter [Class] by walt61
### 07/08/2025
[B4X Forum - B4X - Tutorials](https://www.b4x.com/android/forum/threads/167690/)

**Purpose:**  
To connect to and read data (such as the current solar power production) from an [SMA Sunny Boy inverter](https://www.sma.de/en/products/solarinverters/sunny-boy-30-36-40-50-60). The Sunny Boy must have been added to your LAN or WLAN - see <https://www.sma-sunny.com/en/service-tip-how-to-connect-a-sunny-boy-inverter-with-built-in-wifi-to-a-local-wireless-network/> for instructions.  
  
Code ported from Python to B4X: <https://github.com/Dymerz/SMA-SunnyBoy#>  
B4Xlib and demo project attached.  
  
**Public methods (all of them contain IDE help and examples):**  
- Initialize: initialises the class  
- B4XLibInfo: only document dependencies, additional jars, etc  
- Connect: establishes a new connection  
- Disconnect: logs out and clears the connection  
- IsConnected: returns whether or not we are connected to the Sunny Boy  
- GetValue: fetches one of the DATA… values (see below)  
- GetUnit: fetches the unit of measurement for one of the DATA… values  
- GetAllValues: fetches ALL the DATA… values  
- GetLogger: fetches the solar production within a DateTime range  
  
**Properties:**  
SerialNumber: returns the Sunny Boy's serial number (after successfully having used one of the Get… methods)  
  
**DATA… values:**  
- device\_error  
- device\_state  
- device\_warning  
- ethernet\_counter\_status  
- ethernet\_dns  
- ethernet\_gateway  
- ethernet\_ip  
- ethernet\_netmask  
- ethernet\_status  
- injection\_time  
- power\_ab  
- power\_amp  
- power\_b  
- power\_current  
- power\_total  
- productivity\_day  
- productivity\_total  
- server\_dns  
- server\_gatewy  
- server\_ip  
- server\_netmask  
- service\_time  
- tide\_ab  
- voltage\_ab  
- wlan\_dns  
- wlan\_gateway  
- wlan\_ip  
- wlan\_netmask  
- wlan\_scan\_status  
- wlan\_status  
- wlan\_strength  
  
**Library dependencies (all are internal libraries):**  
JavaObject, [j]OkHttpUtils2, Json  
  
**Notes:**  
- IMPORTANT FOR B4J NON-UI APPS, AS PER <https://www.b4x.com/android/forum/threads/resumablesub-dont-work.89719> : see 'StartMessageLoop' and 'StopMessageLoop' in the demo program.  
- Tested with B4A and B4J, assumed to be B4I-compatible as well (but not tested or even tried).  
  
**MIT License for the original Python code:**  
Copyright © 2020 Urbain Corentin  
  
Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:  
  
The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.  
  
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  
SOFTWARE.