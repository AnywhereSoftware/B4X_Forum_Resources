B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=3
@EndOfDesignText@

Sub		Process_Globals
		Public  Black			    	       	As ULong 	= 	0xFF000000
		Public  Blue    			        	As ULong 	= 	0xFF0000FF
'		Public  CarneyYellow					As ULong	 = 	0xFFFFFF84
'		Public  Cyan		            		As ULong 	= 	0xFFAEF4FF
'		Public  DarkBlue			        	As ULong 	= 	0xFF000080
'		Public  DarkGray						As ULong 	= 	0xFFA9A9A9
'		Public  DarkGreen			       		As ULong 	= 	0xFF006400
'		Public  DarkOrchid       				As ULong 	= 	0xFF9932CC
'		Public  DarkRed				       		As ULong 	= 	0xFF8B0000
'		Public  DodgerBlue			       		As ULong 	= 	0xFF1E90FF
'		Public  Gainsboro						As ULong 	= 	0xFFDCDCDC
'		Public  Gold							As ULong 	= 	0xFFFFD700
'		Public  GoldenRod						As ULong 	= 	0xFFDAA520
'		Public  Gray							As ULong 	= 	0xFF808080
		Public  Green							As ULong 	= 	0xFF00FF00
		Public	HotPink							As ULong 	= 	0xFFFF69B4
'		Public  Khaki							As ULong 	= 	0xFFF0E68C
'		Public  LightGray						As ULong 	= 	0xFFD3D3D3
'		Public  Orange							As ULong 	= 	0xFFFFA500
'		Public  PaleBlue						As ULong 	= 	0xFFAEF4FF
'		Public  Pink							As ULong 	= 	0xFFFFC0CB
'		Public  PowderBlue						As ULong 	= 	0xFFAEE0E6
'		Public  Purple							As ULong 	= 	0xFF800080
		Public  Red		 	      	    	  	As ULong 	= 	0xFFFF0000
'		Public  Transparent 			    	As ULong 	= 	0x00FFFFFF
		Public  White		        		   	As ULong 	= 	0xFFFFFFFF
'		Public  Yellow							As ULong 	=	0xFFFFFF00

'		Public	Plum							As ULong 	= 	0xFFDDA0DD
'  		Public	Violet 							As ULong 	= 	0xFFEE82EE
'  		Public	Fuchsia			 				As ULong 	= 	0xFFFF00FF
'  		Public	Orchid 							As ULong 	= 	0xFFDA70D6
'  		Public	Violet 							As ULong 	= 	0xFFC71585
'  		Public	PaleViolet		 				As ULong 	= 	0xFFDB7093
'  		Public	DeepPink 						As ULong 	= 	0xFFFF1493
'		Public	LightPink 						As ULong 	= 	0xFFFFB6C1
'  		Public 	Pink		 					As ULong 	= 	0xFFFFC0CB
		
		Public  StPattysDay()					As ULong	= 	Array As ULong(0xFF088008, 0xFF08C008, 0xFF08FF08, 0xFF7CFC00, 0xFF00C000, _
																			   0xFF084008, 0xFF006400, 0xFF008000, 0xFF7FFF00, 0xFF008000, _
																			   0xFF001000, 0xFF00FF00, 0xFF002000, 0xFF004000, 0xFF10FF10)
		
		Public  NewYears()						As ULong	=   Array As ULong(0xFF800000, 0xFFFFFFFF, 0xFF000080, 0xFF008000, _
																			   0xFFFF0000, 0xFFFEE7B3, 0xFF0000FF, 0xFF00FF00, _
																			   0xFFFFF2C9, _ 
																			   0xFF004000, _
																			   0xFFFFB600, 0xFF3A1AFE, 0xFF0000FE, 0xFFFE3313)
' was 9 0xFFFFE692,
' was 10 0xFFB487FE
' was 11 0xFF65FF00
'		Public  NewYears()						As ULong	=   Array As ULong(0xFFFF0000, 0xFFFFFFFF, 0xFF0000FF, 0xFF004000, 			   _
'																			   0xFFFFB600, 0xFF3A1AFE, 0xFF0000FE, 0xFFFE3313)
																			   
		
		Public  RedWhiteBlue()					As ULong 	= 	Array As ULong(Red, White, Blue,  Black)
		Public	Christmas()						As ULong	= 	Array As ULong(Red, Green, White, Black)
		
		
'		Public  Pinks()							As ULong	= 	Array As ULong(0xFFC60036, 0xFF980036, 0xFFFF0000)
'		Public  Pinks()							As ULong	= 	Array As ULong(0xFFC60036, 0xFFFF0000)

		
		
		Private mCommonAnode					As Boolean	= False
		
#if Debug_RGBValues		
		Private mByteConverter					As ByteConverter
#end if

		Private mRandomAccessFile				As RandomAccessFile
		Private mBuffer(4)		 				As Byte			
End Sub

Public  Sub IsCommonAnodeSet As Boolean
			Return mCommonAnode
End Sub

Public  Sub SetCommonAnode(SetTo As Boolean)
			Log("SetCommonAnode", SetTo)
			mCommonAnode	= SetTo
End Sub

Public  Sub ShowColor(Color As ULong)
	
			mRandomAccessFile.Initialize(mBuffer, False) 'big endian
		   	mRandomAccessFile.WriteULong32(Color, 0)

'#if Debug_RGBValue
'			Log("ShowColor - R:", mBuffer(1), "  G:", mBuffer(2), "  B:", mBuffer(3), "  Hex:", mByteConverter.HexFromBytes(mBuffer))
'#end if
			
			If 	mCommonAnode Then
				Main.gRPin.AnalogWrite(255 - mBuffer(1))
				Main.gGPin.AnalogWrite(255 - mBuffer(2))
				Main.gBPin.AnalogWrite(255 - mBuffer(3))
			Else
				Main.gRPin.AnalogWrite(mBuffer(1) * 4)
				Main.gGPin.AnalogWrite(mBuffer(2) * 4)
				Main.gBPin.AnalogWrite(mBuffer(3) * 4)
			End If
End Sub

Public  Sub ShowRGBColor(RLed As Byte, GLed As Byte, BLed As Byte)

#if Debug_RGBValues
			'---------------------------------------------------------------------------------------
			'	The only reason we are doing the code below is to be able to log out
			'		the values both as decimals and hex	- goes away when not using DebugRGBValues
			'---------------------------------------------------------------------------------------
			mBuffer(1) = RLed
			mBuffer(2) = GLed
			mBuffer(3) = BLed

			Log("ShowRGBColor - R:", NumberFormat(RLed, 3, 0), "  G:", NumberFormat(GLed, 3, 0), "  B:", NumberFormat(BLed, 3, 0), "  Hex:", mByteConverter.HexFromBytes(mBuffer))
#end if

			If 	mCommonAnode Then
				Main.gRPin.AnalogWrite(255 - RLed)
				Main.gGPin.AnalogWrite(255 - GLed)
				Main.gBPin.AnalogWrite(255 - BLed)
			Else
				Main.gRPin.AnalogWrite(RLed)
				Main.gGPin.AnalogWrite(GLed)
				Main.gBPin.AnalogWrite(BLed)
			End If
End Sub

Public  Sub ShowRGBColor_Cnts(RLed As Byte, GLed As Byte, BLed As Byte, Cnt As Int, SubCnt As Byte)

#if Debug_RGBValues
			'---------------------------------------------------------------------------------------
			'	The only reason we are doing the code below is to be able to log out
			'		the values both as decimals and hex	- goes away when not using DebugRGBValues
			'---------------------------------------------------------------------------------------
			mBuffer(1) = RLed
			mBuffer(2) = GLed
			mBuffer(3) = BLed
				
			Log("ShowRGBColor - R:", RLed, "  G:", GLed, "  B:", BLed, "  Hex:", mByteConverter.HexFromBytes(mBuffer), "  Cnt:", NumberFormat(Cnt, 5, 0), "-", NumberFormat(SubCnt, 3, 0))
#end if

			If 	mCommonAnode Then
				Main.gRPin.AnalogWrite(255 - RLed)
				Main.gGPin.AnalogWrite(255 - GLed)
				Main.gBPin.AnalogWrite(255 - BLed)
			Else
				Main.gRPin.AnalogWrite(RLed)
				Main.gGPin.AnalogWrite(GLed)
				Main.gBPin.AnalogWrite(BLed)
			End If
End Sub