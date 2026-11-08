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
	Private Img_House,Img_HouseOwner As B4XImageView
	Private Lbl_Price,Lbl_HouseName,Ico_Bookmark As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	SetStatusBarAndNavigationColor(0xFF32463F)
	Activity.LoadLayout("House_Layout")
	
	Img_HouseOwner.RoundedImage = True
	Img_HouseOwner.Bitmap = LoadBitmap(File.DirAssets,"XTools!.jpg")
	
	Img_House.Bitmap = Main.SomeVar.SomeBitmap
	Img_House.ResizeMode = "FILL"
	
	Lbl_HouseName.Text = Main.SomeVar.SomeStr
	Lbl_Price.Text = Main.SomeVar.SomePrice
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

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

Private Sub Ico_Bookmark_Click
	If Ico_Bookmark.Text = "" Then
		Ico_Bookmark.Text = ""
	Else
		Ico_Bookmark.Text = ""
	End If
End Sub

Private Sub Ico_Back_Click
	StartActivity(Main)
	Activity.Finish
End Sub