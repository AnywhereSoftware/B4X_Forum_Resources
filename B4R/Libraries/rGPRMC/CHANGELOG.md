# Changelog B4R Library rGPRMC

## v1.45 (20210705)
* FIX: Distance_Between_Positions and Course_To if position not changed then result 0.
* NEW: Distance_Between_TimeStamps calcualted using avg speed and seconds between two GPS timestamps.
* UPD: LCD Display Example - Mini Dashboard - using Distance_between_Positions; Distance with 2 digits; Redesigned layout.
* UPD: Reworked and renamed Distance_Between to Distance_Between_Positions.

### v1.41 (Build 20210704)
* NEW: Example LCDDisplay - Mini dashboard showing Lat/Lon position, Speed, Distance, Duration, Actual Time.
* NEW: Field UTCOffset - Set local time UTC offset - parameter sub Initialize.
* NEW: Field SpeedMinThreshold - Speed Kmh is set to 0, if below threshold - parameter sub Initialize.
* NEW: Sub Kmh_To_Knots - Convert Kmh to Knots.
* NEW: Sub Knots_To_Kmh - Convert Knots to Kmh.
* NEW: Sub Time_Difference - Calculate time difference HH MM SS between two time stamps. Used for duration calculations.
* UPD: Changed module type names T... to TGPRMC... (i.e. TDate to TGPRMCDate) to ensure Type uniqueness in list of variables/types/constants (avoid clash with other modules).
* UPD: Changed function names to separate from variable names. All function have underscores: Parse_RMC_Sentence, Distance_Between, Bearing renamed to Course_To.
* UPD: Changed Type Member TGPRMCTime.Hour to TGPRMCTime.Hours.
* UPD: All Examples.

### v1.00 (Build 20210702)
* NEW: First version, published on Anywhere Software B4R Forum Libraries [Link](https://www.b4x.com/android/forum/threads/rgprmc.132183/#post-834247).
