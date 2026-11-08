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
	Private xui As XUI
End Sub

Sub Globals
	Private CustomListView1 As CustomListView
	'Private Image As ImageView 
	Private Img_Preview As ImageView
	Private Lbl_lessonName,Lbl_lessonDur,Lbl_subject,Lbl_courseName,Lbl_courseDetailes As Label
	Private Ico_Back , Ico_bookmark As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	SetStatusBarAndNavigationColor(0xFF1C7ED5)
	'TransStatBar
	Activity.LoadLayout("CoursePage")
	''Add Course Details Panel to CustomeListView
	Dim Details As B4XView = xui.CreatePanel("")
	Details.SetLayoutAnimated(0, 0, 0, 100%x , 500dip)
	Details.LoadLayout("CourseDetailes")
	CustomListView1.Add(Details,"")
	''Init Data From Main Activity
	Img_Preview.Bitmap = Main.SomeVar.SomeBitmap
	Lbl_subject.Text = Main.SomeVar.SomeSubject
	Lbl_courseName.Text =  Main.SomeVar.SomeStr
	Lbl_courseDetailes.Text =  Main.SomeVar.SomeAuthor & "  |  25 Lessons "
	''Add Some Random Lessons Panel to CustomListView
	For i = 1 To 8
		Dim Footer As B4XView = xui.CreatePanel("")
		Footer.SetLayoutAnimated(0, 0, 0, 100%x , 100dip)
		Footer.LoadLayout("CourseLessons")
		CustomListView1.Add(Footer,"")
		Lbl_lessonName.Text = "0"&i & "  |  " & "Lesson " & i
		Lbl_lessonDur.Text = "0"&Rnd(4,9) & ":" & Rnd(10,59) & " mins"
	Next
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


Private Sub Ico_Back_Click
	Activity.Finish
	StartActivity(Main)
End Sub


Private Sub Ico_bookmark_Click
	If Ico_bookmark.Text = "" Then
		Ico_bookmark.Text = ""
	Else
		Ico_bookmark.Text = ""
	End If
End Sub
