B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=7.3
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals

End Sub

Sub Globals
	Dim lblInteger, lblIntegerPos, lblNumber, lblNumberPos As Label
	Dim whlInteger, whlIntegerPos, whlNumber, whlNumberPos As ClsWheel
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("Numbers")

	whlInteger.Initialize(Me, Activity, "Enter integer", 4, Null, 24, 5, False)
	whlIntegerPos.Initialize(Me, Activity, "Enter positive integer", 8, Null, 24, 6, False)
	whlNumber.Initialize(Me, Activity, "Enter number", 4, Null, 24, 7, True)
'	whlNumberPos.Initialize(Me, Activity, "Enter positive number", 6, Null, 24, 8, False)
	whlNumberPos.Initialize(Me, Activity, "Enter frequency [MHz]", 6, Null, 24, 8, False)
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub lblInteger_Click
	whlInteger.Show(lblInteger, lblInteger.Text)
End Sub

Sub lblIntegerPos_Click
	whlIntegerPos.Show(lblIntegerPos, lblIntegerPos.Text)
End Sub

Sub lblNumber_Click
	whlNumber.SetFixedFormat(2, False, False)
	whlNumber.Show(lblNumber, lblNumber.Text)
End Sub

Sub lblNumberPos_Click
	whlNumberPos.SetFixedFormat(3, True, False)
	whlNumberPos.Show(lblNumberPos, lblNumberPos.Text)
End Sub
