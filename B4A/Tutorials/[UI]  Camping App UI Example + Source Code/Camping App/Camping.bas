B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=11
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: False
#End Region

Sub Process_Globals
End Sub

Sub Globals
	Private Back,Location_Lbl,LocaName_Lbl As Label
	Private BookNow_Btn As Button
	Private Person1_Img,Person2_Img,Person3_Img,Person4_Img,B4XImageView2 As B4XImageView
	Private Panel1 As Panel
	Private bmp(4) As Bitmap
End Sub

Sub Activity_Create(FirstTime As Boolean)
	SetStatusBarAndNavigationColor(0xFF03051A)
	Activity.LoadLayout("Camp")
	For i = 0 To 3
		bmp(i) = LoadBitmap(File.DirAssets,"Person" & i & ".jpg")
	Next
	Person1_Img.RoundedImage = True
	Person1_Img.Bitmap = bmp(0)
	
	Person2_Img.RoundedImage = True
	Person2_Img.Bitmap = bmp(1)
	
	Person3_Img.RoundedImage = True
	Person3_Img.Bitmap = bmp(2)
	
	Person4_Img.RoundedImage = True
	Person4_Img.Bitmap = bmp(3)
	
	B4XImageView2.Bitmap = Main.SomeVar.SomeBitmap
	Location_Lbl.Text = Main.SomeVar.SomeLocation
	LocaName_Lbl.Text = Main.SomeVar.SomeStr
	B4XImageView2.CornersRadius = 30dip
	Panel1.Enabled = False
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Private Sub Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub

Sub SetStatusBarAndNavigationColor(clr As Int)
	Try
		Dim jo As JavaObject
		jo.InitializeContext
		Dim window As JavaObject = jo.RunMethodJO("getWindow", Null)
		window.RunMethod("addFlags", Array (0x80000000))
		window.RunMethod("clearFlags", Array (0x04000000))
		window.RunMethod("setStatusBarColor", Array(clr))
		Dim jo2 As JavaObject
		jo2.InitializeContext
		jo2.RunMethodJO("getWindow", Null).RunMethod("setNavigationBarColor", Array(clr))
	Catch
		ToastMessageShow("Some error with your android version ( <5 )",True)
	End Try
End Sub

Private Sub BookNow_Btn_Click
	Log("You've Booked Your Camp :) ")
End Sub