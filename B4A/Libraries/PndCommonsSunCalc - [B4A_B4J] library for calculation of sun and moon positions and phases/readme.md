### PndCommonsSunCalc - [B4A/B4J] library for calculation of sun and moon positions and phases. by Pendrush
### 11/04/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/143944/)

Lightweight, only requires Java 8 or higher, no other dependencies. Android compatible, requires **API level 26 (Android 8.0 "Oreo") or higher**.  
  
**Accuracy**  
Astronomical calculations are far more complex than throwing a few numbers into an obscure formula and then getting a fully accurate result. There is always a tradeoff between accuracy and computing time.  
This library has its focus on getting acceptable results at low cost, so it can also run on mobile devices, or devices with a low computing power. The results have an accuracy of about a minute, which should be good enough for common applications (like sunrise/sunset timers), but is probably not sufficient for astronomical purposes.  
If you are looking for the highest possible accuracy, you are looking for a different library.  
  
Original library: <https://github.com/shred/commons-suncalc>  
Wrapper is based on v3.5 version.  
  
![](https://www.b4x.com/android/forum/attachments/135640)![](https://www.b4x.com/android/forum/attachments/135639)  
  
> **PndCommonsSunCalc  
>   
> Author:** Author: Richard Körber - B4A/B4J Wrapper: Pendrush  
> **Version:** 1.0  
>
> - **PndCommonsSunCalc**
>
> - **Fields:**
>
> - **MOONPHASE\_PHASE\_FIRST\_QUARTER** As org.shredzone.commons.suncalc.MoonPhase.Phase
> *Waxing half moon*- **MOONPHASE\_PHASE\_FULL\_MOON** As org.shredzone.commons.suncalc.MoonPhase.Phase
> *Full moon*- **MOONPHASE\_PHASE\_LAST\_QUARTER** As org.shredzone.commons.suncalc.MoonPhase.Phase
> *Waning half moon*- **MOONPHASE\_PHASE\_NEW\_MOON** As org.shredzone.commons.suncalc.MoonPhase.Phase
> *New moon*- **MOONPHASE\_PHASE\_WANING\_CRESCENT** As org.shredzone.commons.suncalc.MoonPhase.Phase
> *Waning crescent moon*- **MOONPHASE\_PHASE\_WANING\_GIBBOUS** As org.shredzone.commons.suncalc.MoonPhase.Phase
> *Waning gibbous moon*- **MOONPHASE\_PHASE\_WAXING\_CRESCENT** As org.shredzone.commons.suncalc.MoonPhase.Phase
> *Waxing crescent moon*- **MOONPHASE\_PHASE\_WAXING\_GIBBOUS** As org.shredzone.commons.suncalc.MoonPhase.Phase
> *Waxing gibbous moon*- **TWILIGHT\_ASTRONOMICAL** As org.shredzone.commons.suncalc.SunTimes.Twilight
> *Astronomical twilight*- **TWILIGHT\_BLUE\_HOUR** As org.shredzone.commons.suncalc.SunTimes.Twilight
> *Transition from Golden Hour to Blue Hour*- **TWILIGHT\_CIVIL** As org.shredzone.commons.suncalc.SunTimes.Twilight
> *Civil twilight*- **TWILIGHT\_GOLDEN\_HOUR** As org.shredzone.commons.suncalc.SunTimes.Twilight
> *Transition from daylight to Golden Hour*- **TWILIGHT\_HORIZON** As org.shredzone.commons.suncalc.SunTimes.Twilight
> *The moment when the center of the sun crosses the horizon.*- **TWILIGHT\_NAUTICAL** As org.shredzone.commons.suncalc.SunTimes.Twilight
> *Nautical twilight*- **TWILIGHT\_NIGHT\_HOUR** As org.shredzone.commons.suncalc.SunTimes.Twilight
> *Transition from Blue Hour to night*- **TWILIGHT\_VISUAL** As org.shredzone.commons.suncalc.SunTimes.Twilight
> *The moment when the visual upper edge of the sun crosses the horizon. This is the default.*- **TWILIGHT\_VISUAL\_LOWER** As org.shredzone.commons.suncalc.SunTimes.Twilight
> *The moment when the visual lower edge of the sun crosses the horizon.*
> - **Functions:**
>
> - **Initialize**
> *Initialize PndCommonsSunCalc*- **MoonIllumination** (Year As Int, Month As Int, Day As Int) As Double
> *MoonIllumination - Calculates the illumination of the moon in percent.  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month*- **MoonPhase** (Year As Int, Month As Int, Day As Int, HowManyToFind As Int, MoonPhaseConst As org.shredzone.commons.suncalc.MoonPhase.Phase) As List
> *MoonPhase - Calculates the date and time when the moon reaches the desired phase.  
>  Note: Due to the simplified formulas used in suncalc, the returned time can have an error of several minutes.  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month  
>  HowManyToFind - How many result you want to be returned in the List  
>  MoonPhaseConst - Use on of the MOONPHASE\_PHASE constants*- **MoonPhaseMicroMoon** (Year As Int, Month As Int, Day As Int, HowManyToFind As Int) As List
> *MoonPhaseMicroMoon - Checks if the moon is in a MicroMoon position.  
>  Note that there is no official definition of micromoon.  
>  Suncalc will assume a micromoon if the center of the moon is farther than 405,000 km from the center of Earth.  
>  Usually only full moons or new moons are candidates for micromoons.  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month  
>  HowManyToFind - How many result you want to be returned in the List*- **MoonPhaseSuperMoon** (Year As Int, Month As Int, Day As Int, HowManyToFind As Int) As List
> *MoonPhaseSuperMoon - Checks if the moon is in a SuperMoon position.  
>  Note that there is no official definition of supermoon.  
>  Suncalc will assume a supermoon if the center of the moon is closer than 360,000 km to the center of Earth.  
>  Usually only full moons or new moons are candidates for supermoons.  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month  
>  HowManyToFind - How many result you want to be returned in the List*- **MoonRise** (Latitude As Double, Longitude As Double, Year As Int, Month As Int, Day As Int) As Long
> *MoonRise - Moonrise time.  
>  Latitude - Latitude, in degrees  
>  Longitude - Longitude, in degrees  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month*- **MoonSet** (Latitude As Double, Longitude As Double, Year As Int, Month As Int, Day As Int) As Long
> *MoonSet - Moonset time.  
>  Latitude - Latitude, in degrees  
>  Longitude - Longitude, in degrees  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month*- **Sunrise** (Latitude As Double, Longitude As Double, Year As Int, Month As Int, Day As Int) As Long
> *Compute the sunrise.  
>  Latitude - Latitude, in degrees  
>  Longitude - Longitude, in degrees  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month*- **Sunset** (Latitude As Double, Longitude As Double, Year As Int, Month As Int, Day As Int) As Long
> *Compute the sunset times.  
>  Latitude - Latitude, in degrees  
>  Longitude - Longitude, in degrees  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month*- **TwilightRise** (Latitude As Double, Longitude As Double, Year As Int, Month As Int, Day As Int, Twilight As org.shredzone.commons.suncalc.SunTimes.Twilight) As Long
> *Twilight Rise  
>  The twilight angles use a geocentric reference, by definition.  
>  However, VISUAL and VISUAL\_LOWER are topocentric, and take the spectator's height and the atmospheric refraction into account.  
>  Latitude - Latitude, in degrees  
>  Longitude - Longitude, in degrees  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month  
>  Twilight - use one of the TWILIGHT constant*- **TwilightSet** (Latitude As Double, Longitude As Double, Year As Int, Month As Int, Day As Int, TwilightConst As org.shredzone.commons.suncalc.SunTimes.Twilight) As Long
> *Twilight Set  
>  The twilight angles use a geocentric reference, by definition.  
>  However, VISUAL and VISUAL\_LOWER are topocentric, and take the spectator's height and the atmospheric refraction into account.  
>  Latitude - Latitude, in degrees  
>  Longitude - Longitude, in degrees  
>  Year - Year  
>  Month - Month (1 = January, 2 = February, …)  
>  Day - Day of month  
>  Twilight - use one of the TWILIGHT constant*