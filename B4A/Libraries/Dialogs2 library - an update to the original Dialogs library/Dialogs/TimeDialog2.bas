B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.01
@EndOfDesignText@
Private Sub Class_Globals
	Private cd As CustomDialog2
	Private pnl As Panel
	Private spinMins As Spinner
	Private spinHours As Spinner
End Sub

'Initializes the TimeDialog2 object. The time is always in 24 hour format.
'The Hour and Minute properties can be set with initial values before showing the dialog.
'The TimeDialog2 may be shown modally with Show or non-modally with ShowAsync.
'Returns a DialogResponse with the Hour and Minute properties set to the user entered values.
'Note that event raised by ShowAsyncComplete is 'Complete' not 'Dialog_result'
Public Sub Initialize
	pnl.Initialize("pnl")
	cd.AddView(pnl, 300dip, 100dip) 
	spinHours.Initialize("")
	spinHours.TextSize = 30
	For i = 0 To 23
		spinHours.Add(NumberFormat(i, 2, 0))
	Next
	spinMins.Initialize("")
	spinMins.TextSize = 30
	For i = 0 To 59
		spinMins.Add(NumberFormat(i, 2, 0))
	Next
	
	Dim lbl1 As Label
	lbl1.Initialize("")
	lbl1.Text = "Hours"
	
	Dim lbl2 As Label
	lbl2.Initialize("")
	lbl2.Text = "Minutes"
	Dim lbl3 As Label
	lbl3.Initialize("")
	lbl3.TextSize = 30
	lbl3.Text = " : "
	
	Dim w As Int = pnl.Width
	
	pnl.AddView(lbl1, w/9, 20dip, w/3, 40dip)
	pnl.AddView(lbl2, w*5/9, 20dip, w/3, 40dip)
	pnl.AddView(lbl3, w*4/9, 50dip, w/9, 60dip)
	
	pnl.AddView(spinHours, w/9, 50dip, w/3, 50dip)
	pnl.AddView(spinMins, w*5/9, 50dip, w/3, 50dip)	
End Sub

Public Sub Show(Title As String, Positive As String, Cancel As String, Negative As String, icon As Bitmap) As Int
	Dim ret As Int = cd.Show(Title, Positive, Cancel, Negative, icon) 'ignore
	Return ret
End Sub

Public Sub ShowAsyncComplete(Title As String, Positive As String, Cancel As String, Negative As String, Icon As Bitmap, Cancelable As Boolean) As ResumableSub
	Dim fda As Object = cd.ShowAsync(Title, Positive, Cancel, Negative, Icon, Cancelable) 'ignore
	Wait For (fda) Dialog_Result(ret As Int)
	Return ret
End Sub

Public Sub getHour As Int
	Return spinHours.Selecteditem
End Sub

Public Sub setHour(Hours As Int)
	spinHours.SelectedIndex = Hours
End Sub

Public Sub getMinute As Int
	Return spinMins.Selecteditem
End Sub

Public Sub setMinute(Minutes As Int)
	spinMins.SelectedIndex = Minutes
End Sub


