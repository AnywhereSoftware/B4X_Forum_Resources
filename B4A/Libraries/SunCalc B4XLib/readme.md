### SunCalc B4XLib by John Naylor
### 01/27/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/137957/)

SunCalc is a tiny BSD-licensed library originally written in JavaScript for calculating sun position, sunlight phases (times for sunrise, sunset, dusk, etc.), moon position and lunar phase for the given location and time, created by Vladimir Agafonkin (@mourner) as a part of the SunCalc.net project. This is my conversion to B4X of that project. Please see spoiler for license  
  
[SPOILER="License"]  
SunCalc-B4X Is ported from suncalc.js under the BSD-2-Clause license.  
Copyright © 2014, Vladimir Agafonkin  
All rights reserved.  
  
Redistribution And use in source And binary forms, with Or without modification, are  
permitted provided that the following conditions are met:  
 1. Redistributions of source code must retain the above copyright notice, this list of  
 conditions And the following disclaimer.  
 2. Redistributions in binary form must reproduce the above copyright notice, this list  
 of conditions And the following disclaimer in the documentation And/Or other materials  
 provided with the distribution.  
  
THIS SOFTWARE Is PROVIDED BY THE COPYRIGHT HOLDERS And CONTRIBUTORS "AS IS" And ANY  
EXPRESS Or IMPLIED WARRANTIES, INCLUDING, BUT Not LIMITED To, THE IMPLIED WARRANTIES OF  
MERCHANTABILITY And FITNESS For A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE  
COPYRIGHT HOLDER Or CONTRIBUTORS BE LIABLE For ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,  
EXEMPLARY, Or CONSEQUENTIAL DAMAGES (INCLUDING, BUT Not LIMITED To, PROCUREMENT OF  
SUBSTITUTE GOODS Or SERVICES; LOSS OF USE, DATA, Or PROFITS; Or BUSINESS INTERRUPTION)  
HOWEVER CAUSED And ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, Or  
TORT (INCLUDING NEGLIGENCE Or OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS  
SOFTWARE, EVEN If ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  
[/SPOILER]  
  
[HEADING=2]SunCalc[/HEADING]  

- [HEADING=2]Classes[/HEADING]

- [SunCalc](https://www.b4x.com/android/forum/#0)



- [HEADING=2]SunCalc[/HEADING]
[HEADING=2]Functions:[/HEADING]

- **addTime** (angle As Double, riseName As String, setName As String)
*Allows additional Rise/Set angles to be added*- **Initialize**
*Initializes the object.*- **MoonCoords** (date As Double) As Object
*Geocentric ecliptic coordinates of the moon  
 Returns Right ascension, declination & distance*- **MoonIllumination** (date As Double) As Object
*Illumination of the moon on given date  
 Returns Fraction, phase & angle*- **MoonPosition** (date As Double, lat As Double, lng As Double) As Object
*Position of the moon at a given date viewed from lat / lon  
 Returns azimuth, altitude, distance & parallacticAngle*- **SunPosition** (date As Double, lng As Double, lat As Double) As Object
*Returns the Azimuth & altitude of the sun at the selected date, lat & lon*- **TimesList** (date As Long, lat As Double, lng As Double) As Object
*Returns a list of Rise/Set times.  
 Sunrise / sunset (The moment the sun starts to appear / vanishes)  
 Sunrise End / Sunset Start (the moment the sun completely appears / starts to vanish)  
 Dawn / Dusk (First light can be detected / last light is lost)  
 Nautical Dawn / Nautical Dusk (as above, adjusted for being at sea)  
 Night End / Night (Hours of night)  
 Golden Hour / Blue Hour (Half way point between times of best light)*
- [HEADING=2]Converted By: John Naylor[/HEADING]
- [HEADING=2]Version: 1.00[/HEADING]