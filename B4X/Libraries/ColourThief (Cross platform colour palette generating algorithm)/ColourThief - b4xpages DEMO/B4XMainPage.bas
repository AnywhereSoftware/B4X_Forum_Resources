B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'The MIT License (MIT)
'
'Copyright (c) 2015 Lokesh Dhakar
'
'Permission Is hereby granted, free of charge, To any person obtaining a copy
'of this software And associated documentation files (the "Software"), To deal
'in the Software without restriction, including without limitation the rights
'To use, copy, modify, merge, publish, distribute, sublicense, And/Or sell
'copies of the Software, And To permit persons To whom the Software Is
'furnished To Do so, subject To the following conditions:
'
'The above copyright notice And this permission notice shall be included in all
'copies Or substantial portions of the Software.
'
'THE SOFTWARE Is PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS Or
'IMPLIED, INCLUDING BUT Not LIMITED To THE WARRANTIES OF MERCHANTABILITY,
'FITNESS For A PARTICULAR PURPOSE And NONINFRINGEMENT. IN NO EVENT SHALL THE
'AUTHORS Or COPYRIGHT HOLDERS BE LIABLE For ANY CLAIM, DAMAGES Or OTHER
'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT Or OTHERWISE, ARISING FROM,
'OUT OF Or IN CONNECTION WITH THE SOFTWARE Or THE USE Or OTHER DEALINGS IN THE
'SOFTWARE.


'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True

Sub Class_Globals

	#if b4j
		Private fx As JFX
	#End If
	
	Private Root As B4XView
	Private xui As XUI
	Private Button1 As B4XView
	Private CustomListView1 As CustomListView
	Private pic_num As Int = 1
	Private B4XImageView1 As B4XImageView
	Private EditText1 As B4XView
	Private Button2 As B4XView
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	B4XImageView1.Load (File.DirAssets, "photo" & pic_num & ".jpg")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	
	CustomListView1.Clear
	
	Dim bc As BitmapCreator
	bc.Initialize (1,1)
	
	Dim CF As ColourThief
	CF.Initialize
	
	Dim m As Map = CF.getPalette (B4XImageView1.GetBitmap, EditText1.Text)
	
	#if b4i or b4a
		Dim x As Int
	#End If
	
	For Each c As ARGBColor In m.Values
		Dim pnl As B4XView = xui.CreatePanel ("")

		Dim DispColour As Int = bc.ARGBToColor (c)
		
		#if b4j
			pnl.Height = 45dip
		#else
			pnl.SetLayoutAnimated (0,0,x*45dip,100%x,45dip)
			x=x+1
		#End If
	
		pnl.Color = DispColour
		CustomListView1.Add (pnl, 0)
	Next

End Sub

Private Sub Button2_Click
	pic_num = pic_num + 1
	If pic_num = 4 Then pic_num = 1
	B4XImageView1.Load (File.DirAssets, "photo" & pic_num & ".jpg")
End Sub