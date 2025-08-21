B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3
@EndOfDesignText@


Sub Process_Globals
			Type TColorFadeScheme(DoingScheme As Int, NumberSchemes As Int, DoingColor As Int, DoingColorEnd As Int, DoBackstep As Boolean, DoingBackstep As Boolean)
			
			Type TColorFadeSchemeColor(ColorStart As Byte, ColorEnd As Byte)
			
			Private Const	DEFINE_LongDelay			As Int 		= 2000
			Private Const	DEFINE_ShortDelay			As Int		=  750
			Private Const	DEFINE_FireworksDelay		As Int		=  225
			Private Const	DEFINE_FireworksFastDelay	As Int		=   75
			
  			Private mThemeTimer							As Timer
			Private mThemeTimerInterval					As Int  
			
			Private mWhichCall							As Int  	= -1

			Private mWhichTheme							As Int

			Private Const	DEFINE_NoThemeSet			As Int		=  0
			Private Const	DEFINE_Normal				As Int		=  1
			Private Const	DEFINE_NewYears				As Int  	=  2			
			Private Const	DEFINE_NewYears_Fast		As Int  	=  3
			Private Const	DEFINE_Christmas			As Int  	=  4
			Private Const	DEFINE_Patriot				As Int  	=  5
			Private Const	DEFINE_ValentinOsDay		As Int  	=  6
			Private Const	DEFINE_StPattysDay			As Int  	=  7
			Private Const	DEFINE_Halloween			As Int  	=  8
												
			Private Const	DEFINE_FirstTheme			As Int		=  1
			Private Const	DEFINE_MaxThemes			As Int		=  9

			Private Const	DEFINE_DayColors_Max		As Int		= 50
			
			Private mDayColors(DEFINE_DayColors_Max)	As ULong
			Private mDayColors_Max						As Int		= DEFINE_DayColors_Max
			
			Private mBackStep							As Boolean 	= False

			Private mColorFadeScheme					As TColorFadeScheme
			Private mColorFadeSchemeColors(10)			As TColorFadeSchemeColor
			
			Private mColorStart							As Byte
			Private mColorEnd							As Byte

			Private mFan_All							As Byte			
End Sub

#Region MaxThemes / Bum[Theme / CurrentTheme / StopTheme / SetTheme
Public  Sub MaxThemes As Int
			Return DEFINE_MaxThemes
End Sub

Public  Sub BumpTheme
			mWhichTheme = mWhichTheme + 1
			
			If  mWhichTheme > MaxThemes Then
				mWhichTheme = DEFINE_FirstTheme
			End If
			
			CallSubPlus("DoTheme", 0, 0)
End Sub

Public  Sub CurrentTheme As Int
			Return mWhichTheme	
End Sub

Public  Sub StopThemes
			mThemeTimer.Enabled = False
End Sub

Public  Sub SetTheme(RunTheme As Int)
			mWhichTheme = RunTheme
			
			If  mWhichTheme > MaxThemes Then
				mWhichTheme = DEFINE_FirstTheme
			End If
			
			CallSubPlus("DoTheme", 0, 0)
End Sub
#end Region

#Region SetThemeBasedOn
'-----------------------------------------------------------------------------------------------------------------------------------
'	Pick a theme based on what date it is
'-----------------------------------------------------------------------------------------------------------------------------------
Public  Sub SetThemeBasedOn(Month As Int, Hour As Int, Minutes As Int, Day As Int, DayofWeek As Int, DaysInMonth As Int)
	
#if DebugX
			Log("SetBasedOn - Debug mode ALL times valid")
#else
			'-----------------------------------------------------------------------------------------------------------------------
			'	These lights are on a manual timer and light sensor. 
			'-----------------------------------------------------------------------------------------------------------------------
			'	We Shouldn't be on are all normally before 4pm and after 1am but in case some manually filled the switch
			'		we will make sure not to display anything until the proper time
			'-----------------------------------------------------------------------------------------------------------------------		
			If  Hour > 1 And Hour < 16 Then
				Log("Too Early or Too Late to run a Theme")
				
				StopThemes				
				SetTheme(DEFINE_NoThemeSet)
				Return
			End If
#End If

			Dim UseTheme 	As Byte = DEFINE_Normal
			
			Dim Date		As Int
			
			Select 	Month
					Case	12, 1			' December / January
							'----------------------------------------------------------------------------------------------
							'	Check for New Years Eve and New Years Day
							'----------------------------------------------------------------------------------------------
							If  (Month = 12 And Day = 31) Or (Month = 1 And Day = 1 And Hour < 2)  Then
								UseTheme = DEFINE_NewYears
								
								If  (Month = 12 And Day = 31 And Hour = 23) Or (Month = 1 And Day = 1 And Hour <= 1) Then
									UseTheme = DEFINE_NewYears_Fast
								End If
							Else							
								If  (Month = 12 And Day >= 15) Or (Month = 1 And Day < 5) Then
									UseTheme = DEFINE_Christmas
								End If
							End If
							
					Case	2				' February
							'-------------------------------------------------------------------------------------------------						
							'	I was only doing ValentinOs Day around ValentinOs Day but my wife says its our month 
							'		and I should do the theme all month.  Hey after 43 years of being married...
							'
							'		NOTE:  	We 	live in Virginia - State Motto "Land of Lovers" 
							'					live in the Town of Valentines and our last name is Valentino
							'-------------------------------------------------------------------------------------------------						
'							If  Day >= 13 And Day <= 15 Then
								UseTheme = DEFINE_ValentinOsDay
'							End If

							If  Day > 15 And Day < 25 Then
								Dim PresidentsDay As Int = cHolidays.WhenIsPresidentsDay(Day, DayofWeek)								
								
								If  (Day + 3) >= PresidentsDay Or (Day - 3) <= PresidentsDay Then
									If  Day <> 14 Then				'  Make sure we are not overriding ValentinOs Day
										UseTheme = DEFINE_Patriot
									End If
								End If
							End If
						
					Case	3				' March
							If  Day >= 14 And Day <= 20 Then
								UseTheme = DEFINE_StPattysDay
							End If
							
					Case	4				' April
						
					Case 	5		 		' May 
							'---------------------------------------------------------------------
							'  Check for Memorial Day
							'---------------------------------------------------------------------							
							Date = cHolidays.WhenIsMemorialDay(Day, DayofWeek)						
							
							If  (Day - 2) >= Date Then
    							UseTheme = DEFINE_Patriot
							Else 
								If  (Date + 2) <= DaysInMonth Then
									If  (Day - 2) <= Date Then
		    							UseTheme = DEFINE_Patriot
									End If
								End If
							End If
					
					Case	6				' June
						
							
					Case 	7				' July
							'---------------------------------------------------------------------
							'  Check for July 4th
							'---------------------------------------------------------------------													
							If  Day >= 1 And Day <= 7 Then
								UseTheme = DEFINE_Patriot
							End If
							
					Case	8				' August
													
					Case	9				' September
							'---------------------------------------------------------------------
							'  Check for Labor Day
							'---------------------------------------------------------------------																				
							If  Day < 8  Then
								Dim LaborDay As Int = cHolidays.WhenIsLaborDay(Day, DayofWeek)
														
								If  (Day + 3) >= LaborDay Or (Day - 3) <= LaborDay Then																
    								UseTheme = DEFINE_Patriot
								End If								
							End If

					Case 	10, 11			' October / November
							'---------------------------------------------------------------------
							'  Check for Halloween
							'---------------------------------------------------------------------
							If  (Month = 10 And Day >= 26) Or (Month = 11 And Day <= 3) Then
								UseTheme = DEFINE_Halloween 
							Else							
								'-----------------------------------------------------------------
								'  Check for Veterans Day
								'-----------------------------------------------------------------
								If  (Month = 11 And Day >= 8) Or  (Month = 11 And Day <= 14) Then
									UseTheme = DEFINE_Patriot
								Else							
									'-------------------------------------------------------------
									'  Need to come up with theme for Thanksgiving
									'	RIGHT now using the Halloween Orangie colors
									'-------------------------------------------------------------
									If  (Month = 11 And Day > 20) Then						
										Dim Thanksgiving As Int = cHolidays.WhenIsThanksgivingDay(Day, DayofWeek)
								
										If  (Day + 3) >= Thanksgiving Or (Day - 3)  <= Thanksgiving Then
											UseTheme = DEFINE_Halloween 
										End If
									End If
								End If
							End If

			End Select
			
			If  mWhichTheme <> UseTheme Then
				SetTheme(UseTheme)
			End If
End Sub
#end Region

#Region DoTheme
Public  Sub DoTheme(Nothing As Byte)

			mThemeTimer.Initialize("ThemeTimer_Tick", 0)	
			mThemeTimer.Enabled = False			

			cColors.ShowColor(cColors.Black)

			Select 	mWhichTheme 
					Case 	0
							Log("WhichTheme is Zero - No Theme Selected")

					Case	DEFINE_NewYears, DEFINE_NewYears_Fast
							Log("DoTheme: NewYears")						
							SetColorTheme(mWhichTheme, cColors.NewYears)
							
							If  mWhichTheme = DEFINE_NewYears Then
								mThemeTimerInterval = DEFINE_LongDelay
							Else
								mThemeTimerInterval = DEFINE_FireworksDelay
							End If
							
							mThemeTimer.Interval = mThemeTimerInterval																														
							
					Case 	DEFINE_Christmas
							Log("DoTheme: Christmas")
							SetColorTheme(DEFINE_Christmas, cColors.Christmas)

					Case 	DEFINE_Patriot
							Log("DoTheme: Patriot")
							SetColorTheme(DEFINE_Patriot, cColors.RedWhiteBlue)
							
					Case 	DEFINE_ValentinOsDay
							Log("DoTheme: ValentinO's Day")
'							SetColorTheme(DEFINE_ValentinOsDay, cColors.ValentinOsDay)
							ValentinOsDay
							
					Case 	DEFINE_StPattysDay
							Log("DoTheme: Saint Pattys Day")
							SetColorTheme(DEFINE_StPattysDay, cColors.StPattysDay)
							
					Case 	DEFINE_Halloween
							Log("DoTheme: Halloween")
							Halloween							
							
					Case 	Else
							Log("DoTheme: Unknown[", mWhichTheme, "]")
			End Select
End Sub
#end Region

#Region ThemeTimer_Tick
Private Sub ThemeTimer_Tick
'			Log("LightTime_Tick - ", mWhichCall)
			
			Select 	mWhichTheme 
					Case 	0
							Log("WhichTheme is Zero")

					Case 	DEFINE_NewYears, DEFINE_NewYears_Fast
#Region NewYears
							If  mWhichCall >= 0 And mWhichCall < mDayColors_Max Then
								cColors.ShowColor(mDayColors(mWhichCall))
							Else
								mWhichCall = 0
								
								If  mWhichTheme = DEFINE_NewYears_Fast Then
									If  mThemeTimerInterval = DEFINE_FireworksDelay Then
										mThemeTimerInterval = DEFINE_FireworksFastDelay
									else if mThemeTimerInterval = DEFINE_FireworksFastDelay Then
											mThemeTimerInterval = DEFINE_ShortDelay
									Else
										mThemeTimerInterval = DEFINE_FireworksDelay
									End If
									
									mThemeTimer.Interval = mThemeTimerInterval
								End If
							End If
#end Region

					Case 	DEFINE_Christmas, DEFINE_Patriot
#Region Christmas / Patriot						
							If  mWhichCall >= 0 And mWhichCall < mDayColors_Max Then
								cColors.ShowColor(mDayColors(mWhichCall))
							Else
								mWhichCall = 0
								
								If  mThemeTimerInterval = DEFINE_LongDelay Then
									mThemeTimerInterval = DEFINE_ShortDelay
								Else
									mThemeTimerInterval = DEFINE_LongDelay
								End If
								
								mThemeTimer.Interval	= mThemeTimerInterval																
								Return
							End If
#end Region
							
					Case 	DEFINE_StPattysDay
#Region SaintPattysDay						
							If  mWhichCall >= 0 And mWhichCall < mDayColors_Max Then
								cColors.ShowColor(mDayColors(mWhichCall))
							Else
								If  mBackStep Then 
									mBackStep = False
								Else
									mWhichCall = mWhichCall - 1
									mBackStep  = True
								End If
									
								If  mThemeTimerInterval = DEFINE_LongDelay Then
									mThemeTimerInterval = DEFINE_ShortDelay
								Else
									mThemeTimerInterval = DEFINE_LongDelay
								End If
								
								mThemeTimer.Interval = mThemeTimerInterval																								
							End If
#end Region

					Case    DEFINE_ValentinOsDay
#Region ValentinOsDay						
							If  mColorFadeScheme.DoingScheme 	= -1 Then								
								mColorFadeScheme.DoingScheme 	= 0
								mColorFadeScheme.DoingColor  	= mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorStart								
								mColorFadeScheme.DoingColorEnd  = mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorEnd
								
'								Log("  ")
'								Log("Doing Scheme:", mColorFadeScheme.DoingScheme)								
							End If

							Select 	mColorFadeScheme.DoingScheme
#if Debug
									Case 0	:	cColors.ShowRGBColor_Cnts(255 - mColorFadeScheme.DoingColor, mColorFadeScheme.DoingColor, 	   0,							mColorFadeScheme.DoingScheme, mColorFadeScheme.DoingColor)								
									Case 1	:	cColors.ShowRGBColor_Cnts(mColorFadeScheme.DoingColor, 		255 - mColorFadeScheme.DoingColor, 0,							mColorFadeScheme.DoingScheme, mColorFadeScheme.DoingColor)  
									Case 2	:	cColors.ShowRGBColor_Cnts(255 - mColorFadeScheme.DoingColor, 0,	 							   mColorFadeScheme.DoingColor,	mColorFadeScheme.DoingScheme, mColorFadeScheme.DoingColor)								
#else
									Case 0	:	cColors.ShowRGBColor(255 - mColorFadeScheme.DoingColor, mColorFadeScheme.DoingColor, 	   0)								
									Case 1	:	cColors.ShowRGBColor(mColorFadeScheme.DoingColor, 		255 - mColorFadeScheme.DoingColor, 0)  
									Case 2	:	cColors.ShowRGBColor(255 - mColorFadeScheme.DoingColor, 0,	 							   mColorFadeScheme.DoingColor)
#end if									
							End Select																		
							
							If  mColorFadeScheme.DoingBackstep Then
								mColorFadeScheme.DoingColor = mColorFadeScheme.DoingColor - 1
																
								If  mColorFadeScheme.DoingColor < mColorFadeScheme.DoingColorEnd Then													
									If  mColorFadeScheme.DoingScheme > 0 Then										
										mColorFadeScheme.DoingScheme = mColorFadeScheme.DoingScheme - 1
										
										mColorFadeScheme.DoingColor  	= mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorEnd
										mColorFadeScheme.DoingColorEnd  = mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorStart
									Else
										mColorFadeScheme.DoingBackstep	= False
										
										mColorFadeScheme.DoingScheme 	= 0
										mColorFadeScheme.DoingColor  	= mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorStart								
										mColorFadeScheme.DoingColorEnd  = mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorEnd
									End If
								End If
							Else
								mColorFadeScheme.DoingColor = mColorFadeScheme.DoingColor + 1
								
								If  mColorFadeScheme.DoingColor > mColorFadeScheme.DoingColorEnd Then													
									If  (mColorFadeScheme.DoingScheme + 1) > mColorFadeScheme.NumberSchemes Then										
										If  mColorFadeScheme.DoBackstep Then
											mColorFadeScheme.DoingBackstep	= True
																				
											mColorFadeScheme.DoingColor  	= mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorEnd							
											mColorFadeScheme.DoingColorEnd  = mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorStart											
										Else
											mColorFadeScheme.DoingScheme	= 0
											
											mColorFadeScheme.DoingColor  	= mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorStart
											mColorFadeScheme.DoingColorEnd  = mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorEnd
										End If
									Else
										mColorFadeScheme.DoingScheme 	= mColorFadeScheme.DoingScheme + 1
										mColorFadeScheme.DoingColor  	= mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorStart								
										mColorFadeScheme.DoingColorEnd  = mColorFadeSchemeColors(mColorFadeScheme.DoingScheme).ColorEnd
										
'										Log("  ")
'										Log("Doing Scheme:", mColorFadeScheme.DoingScheme)																		
									End If
								End If
							End If
#end Region
							
					Case    DEFINE_Halloween
#Region Halloween						
#if Debug
					  		cColors.ShowRGBColor_Cnts(mFan_All, 255 - mFan_All, 0, mFan_All, mFan_All)  
#else							
					  		cColors.ShowRGBColor(mFan_All, 255 - mFan_All, 0)  
#End If

							
							If  mBackStep Then
								mFan_All = mFan_All - 1
								
								If  mFan_All <= mColorStart Then
									mBackStep = False
								End If
							Else
								mFan_All = mFan_All + 1
								
								If  mFan_All >= mColorEnd Then
									mBackStep = True
								End If
							End If
#end Region
							
					Case 	Else
							Log("DoTheme: Unknown[", mWhichTheme, "]")
			End Select			
			
			If  mBackStep Then
				mWhichCall = mWhichCall - 1
			Else
				mWhichCall = mWhichCall + 1			
			End If
End Sub
#end Region

#Region SetColorTheme
Private Sub SetColorTheme(ThemeID As Int, Colors() As ULong)
			mWhichTheme				= ThemeID
			
			mWhichCall 				= 0
			mThemeTimerInterval		= DEFINE_LongDelay
			
			mBackStep				= False
			
			mThemeTimer.Interval 	= mThemeTimerInterval
			mThemeTimer.Enabled  	= True
			
			CopyColors(Colors)						
End Sub
#end Region

#Region ValentinOsDay
Private Sub ValentinOsDay
			Log("ValentinOsDay")	

			mWhichTheme								= DEFINE_ValentinOsDay
			
			mColorFadeScheme.DoingColor				=  -1
			mColorFadeScheme.DoingScheme			=  -1
			mColorFadeScheme.NumberSchemes			=   3
			mColorFadeScheme.DoBackstep				= True
			mColorFadeScheme.DoingBackstep			= False
			
			mColorFadeSchemeColors(0).ColorStart	=   0
			mColorFadeSchemeColors(0).ColorEnd		=  20
						
			mColorFadeSchemeColors(1).ColorStart	= 235
			mColorFadeSchemeColors(1).ColorEnd		= 255
			
			mColorFadeSchemeColors(2).ColorStart	=   0
			mColorFadeSchemeColors(2).ColorEnd		=  55
							
			mThemeTimerInterval						=  75
			
			mThemeTimer.Interval 					= mThemeTimerInterval
			mThemeTimer.Enabled  					= True			
End Sub
#end region

#Region Halloween
Private Sub Halloween
			Log("Halloween")	

			
			mWhichTheme				= DEFINE_Halloween
			
			mBackStep				= False
						
			mWhichCall	 			= 0
			
			mColorStart			 	= 175
			mColorEnd			 	= 215
			
			mFan_All	 		 	= mColorStart
			
			mThemeTimerInterval	 	= 10
				
			mThemeTimer.Interval 	= mThemeTimerInterval
			mThemeTimer.Enabled  	= True
			
End Sub
#end Region

#Region CopyColors
Private Sub CopyColors(Colors() As ULong)
			
			For i = 0 To Colors.Length-1
				If  i >= DEFINE_DayColors_Max Then 
					mDayColors_Max = DEFINE_DayColors_Max
					Return
				End If
				
				mDayColors(i) = Colors(i)
			Next
			
			mDayColors_Max	= Colors.Length				
End Sub
#end Region