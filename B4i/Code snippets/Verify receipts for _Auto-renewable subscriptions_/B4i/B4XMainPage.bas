B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region
'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=ios_subscriptiontest_Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	
	#if b4i
	Public bisu As subscriptions
	Private TextView1 As TextView
	Private TextView2 As TextView
	Private TextView3 As TextView
	#End If
	
End Sub
Public Sub Initialize
End Sub
	

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	
	#if b4i
	Root.LoadLayout("MainPage")
		
	' --- Subscription preps --- --- ---
	' The names of your products and the sharedsecret are found (replace 000 with your appid) here:   https://appstoreconnect.apple.com/apps/000/appstore/addons?m=
	bisu.Initialize(Me, "bisu", Root, _
		"MONTHLY_XYZ01", _
		"YEARLY_XYZ01", _
		"http://yyyyour.owwwwnserveradress.com/recvali.php")  ' 
	#End If
	' --- --- --- --- --- --- --- ---
	
End Sub
 

Private Sub Button1_Click
	#if b4i
	bisu.DialogShow
	#End If
End Sub
public Sub bisu_ActionCompleted(ProductMap As Map)
	#if b4i
	Dim j As JSONGenerator
	j.Initialize(ProductMap)
	TextView1.Text = j.ToPrettyString(2)
	TextView1.ScrollTo(0)
	ShowResult(ProductMap)
	#End If
End Sub

Private Sub Button2_Click
	#if b4i
	TextView2.Text = "..."
	TextView3.Text = "..."
	wait for (bisu.GetActiveProductAppStore) complete (ProductMap As Map)
	Dim j As JSONGenerator
	j.Initialize(ProductMap)
	TextView2.Text = j.ToPrettyString(2)
	TextView2.ScrollTo(0)
	ShowResult(ProductMap)
	#End If
End Sub

private Sub ShowResult(resmap As Map)
	#if b4i
	Dim j As JSONGenerator
	j.Initialize(resmap)
	TextView3.Text = j.ToPrettyString(2) 
	TextView3.ScrollTo(0)
	#End If
End Sub
