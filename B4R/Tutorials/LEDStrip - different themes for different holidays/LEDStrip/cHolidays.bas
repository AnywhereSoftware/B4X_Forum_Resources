B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3
@EndOfDesignText@


Sub Process_Globals
End Sub


Public	Sub	WhenIsMartinLutherKingDay(Day As Int, DayOfWeek As Int) As Int
			Dim MartinLutherKingDay() 	As Int			= Array As Int(0, 16, 15, 21, 20, 19, 18, 17)	'	  3rd Monday	in 	January
			
			Return WhenIsHoliday(Day, DayOfWeek, MartinLutherKingDay)
End Sub

Public	Sub	WhenIsPresidentsDay(Day As Int, DayOfWeek As Int) As Int
			Dim PresidentsDay()			As Int 			= Array As Int(0, 16, 15, 21, 20, 19, 18, 17)	'	  3rd Monday	in 	February
			
			Return WhenIsHoliday(Day, DayOfWeek, PresidentsDay)
End Sub

Public	Sub	WhenIsMemorialDay(Day As Int, DayOfWeek As Int) As Int
			Dim MemorialDay() 		As Int 			= Array As Int(0, 30, 29, 28, 27, 26, 25, 31)		'  	 Last Monday 	in 	May			
			
			Return WhenIsHoliday(Day, DayOfWeek, MemorialDay)
End Sub

Public	Sub	WhenIsLaborDay(Day As Int, DayOfWeek As Int) As Int
			Dim LaborDay()				As Int 			= Array As Int(0,  2,  1,  7,  6,  5,  4,  3)	'	First Monday 	in 	September
			
			Return WhenIsHoliday(Day, DayOfWeek, LaborDay)
End Sub

Public	Sub	WhenIsColumbusDay(Day As Int, DayOfWeek As Int) As Int
			Dim ColumbusDay()			As Int			= Array As Int(0,  9,  8, 14, 13, 12, 11, 10)	'	  2nd Monday 	in 	October
			
			Return WhenIsHoliday(Day, DayOfWeek, ColumbusDay)
End Sub
			
Public	Sub	WhenIsThanksgivingDay(Day As Int, DayOfWeek As Int) As Int
			Dim Thanksgiving()			As Int 			= Array As Int(0, 26, 25, 24, 23, 22, 28, 27)	'	  4th Thursday 	in 	November
			
			Return WhenIsHoliday(Day, DayOfWeek, Thanksgiving)
End Sub
			
Private Sub WhenIsHoliday(Day As Int, DayOfWeek As Int, HolidayArray() As Int) As Int

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
				Return -1
			End If
			
			'-----------------------------------------------------------------------------------------------			
			'	Now use this day of week as a index into the table passed to get the day
			'		the holiday is on			
			'-----------------------------------------------------------------------------------------------		
			Day	= HolidayArray(DayOfWeek)
			
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
				Day = Day + HolidayArray(0) 
			End If

			Return Day
End Sub
