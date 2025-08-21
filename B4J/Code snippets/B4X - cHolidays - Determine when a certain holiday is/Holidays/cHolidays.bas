B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'------------------------------------------------------------------------------------------------------------------------------------------------------
'  	Version 1.6 - BobVal (Robert Valentino - Bowling Brackets)
'
'	Found these interesting Excel formula's ( https://www.tek-tips.com/faqs.cfm?fid=7549 )for figuring out what holiday was on what day / date 
'
'		So figured I would check them out and kinda converted them to something I could use
'
'	1.4 Added Easter
'   1.5 Added Cinco De Mayo
'	1.6 Fixed Typo Veterans
'
'------------------------------------------------------------------------------------------------------------------------------------------------------
Sub Process_Globals
			Type THolidayIs(IsValid As Boolean, Month As Int, Day As Int, Year As Int, DayOfWeek As Int)
	
			Private const DEFINE_DaysOfWeek()		As String = Array As String("", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
End Sub


Public  Sub ShowHolidays(ForYear As Int)
			
			WhenIs_NewYearsDay(ForYear)
			WhenIs_NewYearsEve(ForYear)
			
			WhenIs_MartinLutherKingDay(ForYear)
			WhenIs_PresidentsDay(ForYear)			
			WhenIs_WashingtonsBirthday(ForYear)
			
			WhenIs_ValentinOsDay(ForYear)			
			WhenIs_SaintPattysDay(ForYear)
			WhenIs_ArborDay(ForYear)
			WhenIs_CincoDeMayo(ForYear)			
			
			WhenIs_MothersDay(ForYear)
			WhenIs_FathersDay(ForYear)
			
			WhenIs_MemorialDay(ForYear)
			WhenIs_IndependenceDay(ForYear)
			WhenIs_LaborDay(ForYear)
			WhenIs_ColumbusDay(ForYear)
			WhenIs_ElectionDay(ForYear)
			WhenIs_VeteransDay(ForYear)
			
			WhenIs_ThanksgivingDay(ForYear)
			WhenIs_BlackFriday(ForYear)			
			
			WhenIs_ChristmasDay(ForYear)			
			WhenIs_EasterDay(ForYear)						
End Sub

#Region WhenIs_NewYearsDay / WhenIs_NewYearsEve
Public	Sub	WhenIs_NewYearsDay(ForYear As Int) As THolidayIs
			Dim JanuaryNextYear		As Long = DateTime.DateParse("01/01/" &NumberFormat2(ForYear+1, 4, 0, 0, False))

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= True
			HolidayIs.Month		= DateTime.GetMonth(JanuaryNextYear)
			HolidayIs.Day		= DateTime.GetDayOfMonth(JanuaryNextYear)
			HolidayIs.Year		= DateTime.GetYear(JanuaryNextYear)			
			HolidayIs.DayOfWeek	= DateTime.GetDayOfWeek(JanuaryNextYear)			

			Log("         New Years Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_NewYearsEve(ForYear As Int) As THolidayIs
			Dim DecemberThisYear		As Long = DateTime.DateParse("12/31/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= True
			HolidayIs.Month		= DateTime.GetMonth(DecemberThisYear)
			HolidayIs.Day		= DateTime.GetDayOfMonth(DecemberThisYear)
			HolidayIs.Year		= DateTime.GetYear(DecemberThisYear)						
			HolidayIs.DayOfWeek	= DateTime.GetDayOfWeek(DecemberThisYear)			

			Log("         New Years Eve Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub
#end region

#region WhenIs_MartinLutherKingDay / WhenIs_PresidentsDay / WhenIs_WashingtonsBirthday
Public	Sub	WhenIs_MartinLutherKingDay(ForYear As Int) As THolidayIs
			Dim MartinLutherKingDay() 	As Int			= Array As Int(0, 16, 15, 21, 20, 19, 18, 17)	'	  3rd Monday	in 	January
			
			Dim JanuaryThisYear			As Long 		= DateTime.DateParse("01/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs				As THolidayIs 	= WhenIs_Holiday(ForYear, DateTime.GetMonth(JanuaryThisYear), DateTime.GetDayOfMonth(JanuaryThisYear), DateTime.GetDayOfWeek(JanuaryThisYear), MartinLutherKingDay)
			
			Log("Martin Luther King Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
                 			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_PresidentsDay(ForYear As Int) As THolidayIs
			Dim PresidentsDay()			As Int 			= Array As Int(0, 16, 15, 21, 20, 19, 18, 17)	'	  3rd Monday	in 	February
			
			Dim FebruaryThisYear		As Long 		= DateTime.DateParse("02/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs				As THolidayIs 	= WhenIs_Holiday(ForYear, DateTime.GetMonth(FebruaryThisYear), DateTime.GetDayOfMonth(FebruaryThisYear), DateTime.GetDayOfWeek(FebruaryThisYear), PresidentsDay)

			Log("        Presidents Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_WashingtonsBirthday(ForYear As Int) As THolidayIs
			Dim FebruaryThisYear		As Long = DateTime.DateParse("02/17/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= True
			HolidayIs.Month		= DateTime.GetMonth(FebruaryThisYear)
			HolidayIs.Day		= DateTime.GetDayOfMonth(FebruaryThisYear)
			HolidayIs.Year		= DateTime.GetYear(FebruaryThisYear)						
			HolidayIs.DayOfWeek	= DateTime.GetDayOfWeek(FebruaryThisYear)			

			Log("  Washingtons Birthday Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub
#end Region

#Region WhenIs_ValentinOsDay / WhenIs_SaintPattysDay / WhenIs_ArborDay / WhenIs_CincoDeMayo
Public	Sub	WhenIs_ValentinOsDay(ForYear As Int) As THolidayIs
			Dim FebruaryThisYear		As Long = DateTime.DateParse("02/14/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= True
			HolidayIs.Month		= DateTime.GetMonth(FebruaryThisYear)
			HolidayIs.Day		= DateTime.GetDayOfMonth(FebruaryThisYear)
			HolidayIs.Year		= DateTime.GetYear(FebruaryThisYear)						
			HolidayIs.DayOfWeek	= DateTime.GetDayOfWeek(FebruaryThisYear)			
			
			Log("        ValentinOs Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_SaintPattysDay(ForYear As Int) As THolidayIs
			Dim MarchThisYear		As Long = DateTime.DateParse("03/17/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= True
			HolidayIs.Month		= DateTime.GetMonth(MarchThisYear)
			HolidayIs.Day		= DateTime.GetDayOfMonth(MarchThisYear)
			HolidayIs.Year		= DateTime.GetYear(MarchThisYear)									
			HolidayIs.DayOfWeek	= DateTime.GetDayOfWeek(MarchThisYear)			
			
			Log("      Saint Pattys Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_ArborDay(ForYear As Int) As THolidayIs
			Dim ArborDay()			As Int 			= Array As Int(0, 27, 26, 25, 24, 30, 29, 28)	'	 Last Friday 	in 	April
			
			Dim AprilThisYear		As Long 		= DateTime.DateParse("04/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs			As THolidayIs 	= WhenIs_Holiday(ForYear, DateTime.GetMonth(AprilThisYear), DateTime.GetDayOfMonth(AprilThisYear), DateTime.GetDayOfWeek(AprilThisYear), ArborDay)
			
			Log("             Arbor Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_CincoDeMayo(ForYear As Int) As THolidayIs
			Dim FebruaryThisYear		As Long = DateTime.DateParse("05/05/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= True
			HolidayIs.Month		= DateTime.GetMonth(FebruaryThisYear)
			HolidayIs.Day		= DateTime.GetDayOfMonth(FebruaryThisYear)
			HolidayIs.Year		= DateTime.GetYear(FebruaryThisYear)						
			HolidayIs.DayOfWeek	= DateTime.GetDayOfWeek(FebruaryThisYear)			
			
			Log("         Cinco De Mayo Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
						  
			Return HolidayIs
End Sub


#end region

#Region WhenIs_MothersDay / WhenIs_FathersDay
Public	Sub	WhenIs_MothersDay(ForYear As Int) As THolidayIs
			Dim MothersDay()		As Int			= Array As Int(0,  8, 14, 13, 12, 11, 10,  9)	'	  2nd Sunday 	in 	May
			
			Dim MayThisYear			As Long 		= DateTime.DateParse("05/01/" &NumberFormat2(ForYear, 4, 0, 0, False))
			
			Dim HolidayIs			As THolidayIs 	= WhenIs_Holiday(ForYear, DateTime.GetMonth(MayThisYear), DateTime.GetDayOfMonth(MayThisYear), DateTime.GetDayOfWeek(MayThisYear), MothersDay)
			
			Log("           Mothers Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_FathersDay(ForYear As Int) As THolidayIs
			Dim FathersDay()		As Int			= Array As Int(0, 15, 21, 20, 19, 18, 17, 16)	'	  3rd Sunday	in 	June
			
			Dim JuneThisYear		As Long 		= DateTime.DateParse("06/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs			As THolidayIs 	= WhenIs_Holiday(ForYear, DateTime.GetMonth(JuneThisYear), DateTime.GetDayOfMonth(JuneThisYear), DateTime.GetDayOfWeek(JuneThisYear), FathersDay)
			
			Log("           Fathers Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))			
			
			Return HolidayIs
End Sub			
#end Region

#Region WhenIs_MemorialDay / WhenIs_IndependenceDay / WhenIs_LaborDay / WhenIs_ColumbusDay / WhenIs_ElectionDay / WhenIs_VetransDay
Public	Sub	WhenIs_MemorialDay(ForYear As Int) As THolidayIs
			Dim MemorialDay() 		As Int 			= Array As Int(0, 30, 29, 28, 27, 26, 25, 31)	'  	 Last Monday 	in 	May			
			
			Dim MayThisYear			As Long 		= DateTime.DateParse("05/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs			As THolidayIs 	= WhenIs_Holiday(ForYear, DateTime.GetMonth(MayThisYear), DateTime.GetDayOfMonth(MayThisYear), DateTime.GetDayOfWeek(MayThisYear), MemorialDay)
			
			Log("          Memorial Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub


Public	Sub	WhenIs_IndependenceDay(ForYear As Int) As THolidayIs
			Dim JulyThisYear		As Long = DateTime.DateParse("07/04/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= True
			HolidayIs.Month		= DateTime.GetMonth(JulyThisYear)
			HolidayIs.Day		= DateTime.GetDayOfMonth(JulyThisYear)
			HolidayIs.Year		= DateTime.GetYear(JulyThisYear)									
			HolidayIs.DayOfWeek	= DateTime.GetDayOfWeek(JulyThisYear)			
			
			Log("      Independence Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_LaborDay(ForYear As Int) As THolidayIs
			Dim LaborDay()				As Int 			= Array As Int(0,  2,  1,  7,  6,  5,  4,  3)	'	First Monday 	in 	September
			
			Dim SeptemberThisYear		As Long 		= DateTime.DateParse("09/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs				As THolidayIs 	= WhenIs_Holiday(ForYear, DateTime.GetMonth(SeptemberThisYear), DateTime.GetDayOfMonth(SeptemberThisYear), DateTime.GetDayOfWeek(SeptemberThisYear), LaborDay)
			
			Log("             Labor Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))			
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_ColumbusDay(ForYear As Int) As THolidayIs
			Dim ColumbusDay()			As Int			= Array As Int(0,  9,  8, 14, 13, 12, 11, 10)	'	  2nd Monday 	in 	October
			
			Dim OctoberThisYear			As Long 		= DateTime.DateParse("10/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs				As THolidayIs	= WhenIs_Holiday(ForYear, DateTime.GetMonth(OctoberThisYear), DateTime.GetDayOfMonth(OctoberThisYear), DateTime.GetDayOfWeek(OctoberThisYear), ColumbusDay)
			
			Log("          Columbus Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_ElectionDay(ForYear As Int) As THolidayIs
			Dim ElectionDay()			As Int			= Array As Int(1,  2,  1,  7,  6,  5,  4,  3)	'	 	  Tuesday after	first monday in November 
			
			Dim NovemberThisYear		As Long 		= DateTime.DateParse("11/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs				As THolidayIs	= WhenIs_Holiday(ForYear, DateTime.GetMonth(NovemberThisYear), DateTime.GetDayOfMonth(NovemberThisYear), DateTime.GetDayOfWeek(NovemberThisYear), ElectionDay)
			
			Log("          Election Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))			
			
			Return HolidayIs
End Sub

Public	Sub	WhenIs_VeteransDay(ForYear As Int) As THolidayIs
			Dim NovemberThisYear		As Long = DateTime.DateParse("11/11/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= True
			HolidayIs.Month		= DateTime.GetMonth(NovemberThisYear)
			HolidayIs.Day		= DateTime.GetDayOfMonth(NovemberThisYear)
			HolidayIs.Year		= DateTime.GetYear(NovemberThisYear)												
			HolidayIs.DayOfWeek	= DateTime.GetDayOfWeek(NovemberThisYear)			

			Log("           Vetrans Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub
#end region
			
#Region WhenIs_ThanksgivingDay / WhenIs_BlackFriday
Public	Sub	WhenIs_ThanksgivingDay(ForYear As Int) As THolidayIs
			Dim Thanksgiving()			As Int 			= Array As Int(0, 26, 25, 24, 23, 22, 28, 27)	'	  4th Thursday 	in 	November
			
			Dim NovemberThisYear		As Long 		= DateTime.DateParse("11/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs				As THolidayIs 	= WhenIs_Holiday(ForYear, DateTime.GetMonth(NovemberThisYear), DateTime.GetDayOfMonth(NovemberThisYear), DateTime.GetDayOfWeek(NovemberThisYear), Thanksgiving)
			
			Log("      Thanksgiving Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub
			
Public	Sub	WhenIs_BlackFriday(ForYear As Int) As THolidayIs
			Dim BlackFriday()			As Int			= Array As Int(1, 26, 25, 24, 23, 22, 28, 27)	'		  Friday  after 4th thursday in November			
			
			Dim NovemberThisYear		As Long 		= DateTime.DateParse("11/01/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs				As THolidayIs 	= WhenIs_Holiday(ForYear, DateTime.GetMonth(NovemberThisYear), DateTime.GetDayOfMonth(NovemberThisYear), DateTime.GetDayOfWeek(NovemberThisYear), BlackFriday)
			
			Log("          Black Friday Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub
#end Region

#Region WhenIs_ChristmasDay
Public	Sub	WhenIs_ChristmasDay(ForYear As Int) As THolidayIs
			Dim DecemberThisYear		As Long = DateTime.DateParse("12/25/" &NumberFormat2(ForYear, 4, 0, 0, False))

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= True
			HolidayIs.Month		= DateTime.GetMonth(DecemberThisYear)
			HolidayIs.Day		= DateTime.GetDayOfMonth(DecemberThisYear)
			HolidayIs.Year		= DateTime.GetYear(DecemberThisYear)												
			HolidayIs.DayOfWeek	= DateTime.GetDayOfWeek(DecemberThisYear)			

			Log("         Christmas Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
			
			Return HolidayIs
End Sub
#end region

#Region WhenIs_EasterDay
Public	Sub WhenIs_EasterDay(ForYear As Int) As THolidayIs

            Dim HolidayIs As THolidayIs
            HolidayIs.Initialize
            HolidayIs.IsValid    = True
                        
            'This Haskell function computes the date of Easter Sunday for a given year, as used by the United States Naval Observatory
            
            Dim C As Long
            Dim N As Long
            Dim K As Long
            Dim I As Long
            Dim J As Long
            Dim L As Long
            Dim M As Long
            Dim D As Long
            
            C = Floor(ForYear / 100)
            N = ForYear - 19 * Floor(ForYear / 19)
            K = Floor((C - 17) / 25)
            I = C - Floor(C / 4) - Floor((C - K) / 3) + 19 * N + 15
            I = I - 30 * Floor(I / 30)
            I = I - Floor(I / 28) * (1 - Floor(I / 28) * Floor(29 / (I + 1)) * Floor((21 - N) / 11))
            J = ForYear + Floor(ForYear / 4) + I + 2 - C + Floor(C / 4)
            J = J - 7 * Floor(J / 7)
            L = I - J
            M = 3 + Floor((L + 40) / 44)
            D = L + 28 - 31 * Floor(M / 4)

            Dim EasterThisYear As Long = DateTime.DateParse($"${NumberFormat2(M, 2, 0, 0, False)}/${NumberFormat2(D, 2, 0, 0, False)}/${NumberFormat2(ForYear, 4, 0, 0, False)}"$)

                    
            HolidayIs.Month        = DateTime.GetMonth(EasterThisYear)
            HolidayIs.Day        = DateTime.GetDayOfMonth(EasterThisYear)
            HolidayIs.Year        = DateTime.GetYear(EasterThisYear)
            HolidayIs.DayOfWeek    = DateTime.GetDayOfWeek(EasterThisYear)

            Log("            Easter Day Is " &NumberFormat2(HolidayIs.Month, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Day, 2, 0, 0, False) &"/" &NumberFormat2(HolidayIs.Year, 4, 0, 0, False) &"  -  " &DEFINE_DaysOfWeek(HolidayIs.DayOfWeek))
            
            Return HolidayIs
End Sub
#end region

#Region WhenIs_Holiday
Private Sub WhenIs_Holiday(ForYear As Int, Month As Int, Day As Int, DayOfWeek As Int, HolidayArray() As Int) As THolidayIs

			Dim HolidayIs As THolidayIs
			
			HolidayIs.Initialize
			HolidayIs.IsValid	= False
			HolidayIs.Month		= Month
			HolidayIs.Year		= ForYear
			
			'-----------------------------------------------------------------------------------------------
			'	Given the Current Day and the Current Day of Week (1 = sunday, ...) we can calculate 
			'		All the holiday dates
			'-----------------------------------------------------------------------------------------------
			'	Changing the DayOfWeek to match
			'-----------------------------------------------------------------------------------------------
			For LoopDay = (Day - 1) To 1 Step -1
				DayOfWeek = DayOfWeek - 1
				
				If  DayOfWeek < 1 Then
					DayOfWeek = 7		
				End If
			Next
			
			
			'-----------------------------------------------------------------------------------------------			
			'	The Current Day and or the Current Day of Week must be wrong
			'-----------------------------------------------------------------------------------------------									
			If  DayOfWeek < 1 Or DayOfWeek > 7 Then
				Return HolidayIs
			End If
			
			'-----------------------------------------------------------------------------------------------			
			'	Now use this day of week as a index into the table passed to get the day
			'		the holiday is on			
			'-----------------------------------------------------------------------------------------------		
			HolidayIs.IsValid		= 	True
			HolidayIs.Day			=	HolidayArray(DayOfWeek)
			
			'-----------------------------------------------------------------------------------------------
			'	When we get here we are at the 1st of the month and 
			'		DayOfWeek contains the Day of Week for the 1st of month
			'-----------------------------------------------------------------------------------------------
			If  HolidayArray(0) <> 0 Then
				'-------------------------------------------------------------------------------------------
				'	The holiday table passed has a offset in first entry
				'		this is for days like BlackFriday which appears 
				'		after the last thursday of November.  
				'		Election day is another that has this offset
				'-------------------------------------------------------------------------------------------
				HolidayIs.Day = HolidayIs.Day + HolidayArray(0) 
			End If

			'-----------------------------------------------------------------------------------------------
			'	Now zip thru the month so we can set the day of week for this holiday
			'-----------------------------------------------------------------------------------------------			
			For Day = 1 To HolidayIs.Day
				If  Day < HolidayIs.Day Then
					DayOfWeek = DayOfWeek + 1
					
					If  DayOfWeek > 7 Then
						DayOfWeek = 1
					End If
					End If
			Next
			
			HolidayIs.DayOfWeek	= DayOfWeek
			
			Return HolidayIs
End Sub
#end Region