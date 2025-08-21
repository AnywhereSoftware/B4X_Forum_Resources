B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.01
@EndOfDesignText@
Sub Class_Globals
	Type TARGB(Alpha As Byte, Red As Byte, Green As Byte, Blue As Byte)
	
	Private dialog As CustomLayoutDialog
	Private cvsColors As Canvas
	Private cvsOverlay As Canvas
	Private pnlColors As Panel
	Private pnlOverlay As Panel
	Public ColorResult As Int
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

Public Sub ShowAsync(CallBack As Object, Title As String)
	Dim sf As Object = dialog.ShowAsync(Title, "Ok", "Cancel", "", Null, True)
	dialog.SetSize(400dip, 550dip)
	Wait For (sf) Dialog_Ready (DialogPanel As Panel)
	DialogPanel.LoadLayout("WheelPicker")
	cvsColors.Initialize(pnlColors)
	cvsOverlay.Initialize(pnlOverlay)
	Wait For (sf) Dialog_Result (Result As Int)
	CallSubDelayed2(CallBack, "Color_Result", Result = DialogResponse.POSITIVE)
End Sub

Sub pnlColors_Touch (Action As Int, X As Float, Y As Float)
	Dim cx = pnlColors.Width / 2, cy = pnlColors.Height / 2 As Float
	If Sqrt(Power(x - cx, 2) + Power(y - cy, 2)) > pnlColors.Width / 2 Then Return
	ColorResult = cvsColors.Bitmap.GetPixel(X, Y)
	cvsOverlay.DrawColor(Colors.Transparent)
	cvsOverlay.DrawCircle(X, Y, 20dip, Colors.Black, False, 3dip)
	pnlOverlay.Invalidate
End Sub

Public  Sub GetARGB(color As Int) As TARGB
	
			Dim ARGB As TARGB
	
			ARGB.Initialize
			ARGB.Alpha 	= Bit.UnsignedShiftRight(Bit.And(color, 0xff0000), 						24)
			ARGB.Red  	= Bit.And(0x00FFFFFF, Bit.UnsignedShiftRight(Bit.And(color, 0xff0000), 	16))
			ARGB.Green	= Bit.UnsignedShiftRight(Bit.And(color, 0xff00), 						 8)
			ARGB.Blue	= Bit.And(color, 0xff)
			
	
			Return ARGB
End Sub

Public  Sub GetColorResult As TARGB
			Return GetARGB(ColorResult)
End Sub