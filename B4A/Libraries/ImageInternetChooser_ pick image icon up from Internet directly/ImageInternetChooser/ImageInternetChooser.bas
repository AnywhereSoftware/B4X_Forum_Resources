B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.5
@EndOfDesignText@
Private Sub Class_Globals
	Private mCallbackModule As Object
	Private mSearchURL As String
	Private su As StringUtils
	Private ph As PhoneEvents
	Private mPnl As Panel
	Private WebViewExtras1 As WebViewExtras
	Private wv As WebView
	Private wvs As WebViewSettings
	'Private dcc As DefaultWebChromeClient
	Private wvc As DefaultWebViewClient
	Private const NoInternetToast As String = "Check Internet connection..."
	Private Vert1, Horiz1, Vert2, Horiz2 As Panel
	Private const LineThickness As Int = 1dip
	Private flagPoint1_set, flagSelected As Boolean
	Private btn As Button, mTarget As Panel
	Private tim As Timer
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(CallbackModule As Object, SearchURL As String, Panel As Panel)
	mCallbackModule = CallbackModule
	mSearchURL = SearchURL
	mPnl.Initialize("pnl")
	mPnl = Panel
	wv.Initialize("wv")
	wvs.setUseWideViewPort(wv, True)
	wvs.setDisplayZoomControls(wv, False)
	wvs.setSupportZoom(wv, True)
	wvs.setLoadsImagesAutomatically(wv, True)
	WebViewExtras1.Initialize(wv)
	'dcc.Initialize("dcc")
	'WebViewExtras1.SetWebChromeClient(dcc)
	wvc.Initialize("wvc")
	WebViewExtras1.SetWebViewClient(wvc)
	
	Vert1.Initialize("")
	Horiz1.Initialize("")
	Vert2.Initialize("")
	Horiz2.Initialize("")
	Vert1.Color = Colors.Red
	Horiz1.Color = Colors.Red
	Vert2.Color = Colors.Blue
	Horiz2.Color = Colors.Blue
	btn.Initialize("btn")
	btn.Typeface = Typeface.FONTAWESOME
	btn.Text = "Select " & Chr(0xF176) & Chr(0xF177)
	btn.TextSize = 8
	btn.Color = Colors.Red
	btn.TextColor = Colors.Yellow
	btn.Width = 70dip
	btn.Height = 40dip
	
	mTarget.Initialize("mTarget")
	mTarget.Color = Colors.Transparent
	tim.Initialize("tim", 500)
End Sub

Public Sub Search_Image(TextToSearch As String)
	mPnl.Visible = False
	ph.Initialize("ph")
	Wait For ph_ConnectivityChanged (NetworkType As String, State As String, Intent As Intent)
	If State = "CONNECTED" Then
		Log("ph_ConnectivityChanged: CONNECTED" & "," & NetworkType)
	Else	'NO INTERNET
		Log("ph_ConnectivityChanged: DISCONNECTED")
		ToastMessageShow(NoInternetToast, False)
		Return
	End If
	
	ProgressDialogShow("")
	Dim a As String = mSearchURL & su.EncodeUrl(TextToSearch, "UTF8")
	mPnl.RemoveAllViews
	wv.ZoomEnabled = True
	wv.JavaScriptEnabled = True
	mPnl.AddView(wv, 0, 0, mPnl.Width, mPnl.Height)
	mPnl.AddView(btn, 0, mPnl.Height - btn.Height, btn.Width, btn.Height)
	wv.LoadUrl(a)
	
	flagPoint1_set = False
	flagSelected = False
	btn.Text = "Select " & Chr(0xF176) & Chr(0xF177)
End Sub

Private Sub wvc_PageFinished (Url As String)
	ProgressDialogHide
	mPnl.Visible = True
	tim.Enabled = True
End Sub

Private Sub wvc_ReceivedError(ErrorCode As Int, Description As String, FailingUrl As String)
	wv.Visible = False
	mPnl.Visible = False
End Sub

Private Sub Get_Picture (Source As Bitmap) As Bitmap
	Dim b As Bitmap
	b.InitializeMutable((Vert2.Left - LineThickness) - (Vert1.Left + LineThickness), (Horiz2.Top - LineThickness) - (Horiz1.Top + LineThickness))
	Dim can As Canvas
	can.Initialize2(b)
		
	Dim SourceRect, DestRect As Rect
	SourceRect.Initialize(Vert1.Left + LineThickness, Horiz1.Top + LineThickness, Vert2.Left - LineThickness, Horiz2.Top - LineThickness)
	DestRect.Initialize(0, 0, b.Width, b.Height)
	can.DrawBitmap(Source, SourceRect, DestRect) 'draws the bitmap to the destination rectangle.

	Return can.Bitmap
End Sub

Private Sub btn_Click
	If flagSelected Then
		mPnl.Visible = False
		flagSelected = False
		btn.RemoveView
		Dim b As Bitmap = wv.CaptureBitmap
		b = Get_Picture(b)
		mTarget.RemoveView
		wv.RemoveView
		mPnl.RemoveAllViews
		CallSubDelayed2(mCallbackModule, "iic_ChosenPicture", b)
		Return
	End If
	mTarget.RemoveAllViews
	mTarget.RemoveView
	mPnl.AddView(mTarget, 0, 0, mPnl.Width, mPnl.Height)
	mTarget.BringToFront
	mTarget.AddView(Vert1, 0,0,0,0)
	mTarget.AddView(Vert2, 0,0,0,0)
	mTarget.AddView(Horiz1, 0,0,0,0)
	mTarget.AddView(Horiz2, 0,0,0,0)
	
	Vert1.Visible = True
	Horiz1.Visible = True
	Vert2.Visible = False
	Horiz2.Visible = False
	
	Vert1.Top = 0
	Vert1.Height = mPnl.Height
	Vert1.Left = 0
	Vert1.Width = LineThickness
	Horiz1.Top = 0
	Horiz1.Height = LineThickness
	Horiz1.Left = 0
	Horiz1.Width = mPnl.Width
	
	Vert2.Top = 0
	Vert2.Height = mPnl.Height
	Vert2.Left = 0
	Vert2.Width = LineThickness
	Horiz2.Top = 0
	Horiz2.Height = LineThickness
	Horiz2.Left = 0
	Horiz2.Width = mPnl.Width
End Sub

Private Sub mTarget_Touch (Action As Int, X As Float, Y As Float)
	Select Action
		Case mPnl.ACTION_MOVE
			If flagPoint1_set = False Then
				Vert2.Visible = False
				Horiz2.Visible = False
				btn.Text = "Select " & Chr(0xF176) & Chr(0xF177)
				Vert1.Top = 0
				Vert1.Left = X
				Horiz1.Top = Y
				Horiz1.Left = 0
				Vert1.Visible = True
				Horiz1.Visible = True
			Else
				btn.Text = "Select " & Chr(0xF175) & Chr(0xF178)
				Vert2.Top = 0
				Vert2.Left = X
				Horiz2.Top = Y
				Horiz2.Left = 0
				Vert2.Visible = True
				Horiz2.Visible = True
				If Vert2.Left < Vert1.Left Then
					Vert2.Left = Vert1.Left
				End If
				If Horiz2.Top < Horiz1.Top  Then
					Horiz2.Top = Horiz1.Top
				End If
			End If
		Case mPnl.ACTION_UP
			If flagPoint1_set = False Then
				flagPoint1_set = True
				Vert2.Visible = True
				Horiz2.Visible = True
				flagSelected = True
				btn.Text = "Select " & Chr(0xF175) & Chr(0xF178)
			Else
				flagPoint1_set = False
				btn.Text = "Save"
			End If
	End Select
End Sub

Private Sub tim_Tick
	tim.Enabled = False
	Dim t As Int = btn.Top
	Dim w As Int = btn.Width
	Dim h As Int = btn.Height
	btn.SetLayoutAnimated(150, btn.Left, btn.Top / 2, btn.Width * 2, btn.Height * 2)
	btn.SetLayoutAnimated(150, btn.Left, t, w, h)
End Sub
