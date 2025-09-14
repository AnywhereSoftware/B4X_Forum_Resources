B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Private p As Panel
	Private iHighlight As Int
	Private lColor As Long
	Private tbColor As Long
	Private rColor As Long
	Private navTColor As Long
	Private navBColor As Long
	Private iMargin As Long
	Private iNavFontSize As Int
	
	Private sNext As String = "Next"
	Private sBack As String = "Back"
	Private sHide As String = "Hide"
	Type WNViews(ViewToExplain As View, TextToExplainView As String, Left As Long, Top As Long, Width As Long, Height As Long)
	Type BttnVisible(tag As String, Visible As Boolean)
	
	Dim lButtons As List
	
	
	
	Private lv As List
	
	Private iPointer As Int
	Private lNext As Label
	Private lBack As Label
	Private lExplain As Label
	Dim lb4xNext As B4XView
	Dim lb4xBack As B4XView
	Dim lb4xExplain As B4XView
	
	Private ParentPanel As Panel
	Private Diagonal As Long
	
	Private XUI As XUI
	
	Private cnv As B4XCanvas
End Sub


'Initializes the What's new class
Public Sub Initialize(Parent As Panel, LeftQuarterColor As Long, _
	TopAndBottomQuartersColor As Long, RightQuarterColor As Long, _
	ExplanationTextColor As Long, ExplanationTextBackgroundColor As Long, ExplanationFontSize As Int, _
	NavigationTextColor As Long, NavigationTextBackColor As Long, NavigationFontSize As Int, _
	Margin As Int)
	lv.Initialize
	lButtons.Initialize
	
	ParentPanel = Parent
	
	p.Initialize("")
	p.Color = Colors.Transparent
	p.Height = 100%y
	p.Width = 100%x
	
	lNext.Initialize("lNext")
	lNext.Tag = "Next"
	lBack.Initialize("lBack")
	lBack.Tag = "Back"
	lExplain.Initialize("")
	
	p.AddView(lNext,0, 0, 10, 10)
	p.AddView(lBack, 0, 0, 10, 10)
	p.AddView(lExplain, 0, 0, 10, 10)
	
	lb4xBack = lBack
	lb4xNext = lNext
	lb4xExplain = lExplain
	
	p.Visible = False
	ParentPanel.AddView(p, 0, 0, 100%x, 100%y)
	lColor = LeftQuarterColor
	tbColor = TopAndBottomQuartersColor
	rColor = RightQuarterColor
	
	navTColor = NavigationTextColor
	navBColor = NavigationTextBackColor
	iNavFontSize = NavigationFontSize
	
	lb4xNext.Color = navBColor
	lb4xBack.Color = navBColor
	lb4xNext.TextColor = navTColor
	lb4xBack.TextColor = navTColor
	lb4xExplain.Color = ExplanationTextBackgroundColor
	lb4xExplain.TextColor = NavigationTextColor
	
	
	
	
	#if b4a 
	lExplain.SingleLine = False
	#else if b4i
	lExplain.Multiline = True
	#End If
	
	lb4xBack.Font = XUI.CreateDefaultBoldFont(iNavFontSize)
	lb4xNext.Font = XUI.CreateDefaultBoldFont(iNavFontSize)
	lb4xExplain.Font = XUI.CreateDefaultFont(ExplanationFontSize)
	
	
	iMargin = Margin
	iNavFontSize = NavigationFontSize
	
	#if b4a
	SetDimensions(100%x, 100%y)
	#End If
	
End Sub


#Region Functionaliy

'Adds a view to explain
'Set Left, Right, Width, Height of explanation text to 0 
'for the class to handle automatically the position and dimensions
Public Sub AddViewToExplain(ViewToHighlightAndExplain As View, TextOfExplanation As String, _
		LeftOfLabelOfExplanationText As Long, TopOfLabelOfExplanationText As Long, _
		WidthOfLabelOfExplanationText As Long, HeightOfLabelOfExplanationText As Long)
	
	Dim wnv As WNViews
	wnv.ViewToExplain = ViewToHighlightAndExplain
	wnv.TextToExplainView = TextOfExplanation
	wnv.Left = LeftOfLabelOfExplanationText
	wnv.Top = TopOfLabelOfExplanationText
	wnv.Width = WidthOfLabelOfExplanationText
	wnv.Height = HeightOfLabelOfExplanationText
	
	lv.Add(wnv)
End Sub

Public Sub SetDimensions(xDim As Int, yDim As Int)
	p.Left = 0
	p.Top = 0
	p.Width = xDim
	p.Height = yDim
	Log("*")
	Log(yDim)
	cnv.Initialize(p)
	
End Sub

Public Sub SetViewToExplainTextDimensions(ViewToHighlightAndExplain As View, _
		LeftOfLabelOfExplanationText As Long, TopOfLabelOfExplanationText As Long, _
		WidthOfLabelOfExplanationText As Long, HeightOfLabelOfExplanationText As Long)
	
		
	
	Dim wnv As WNViews
	
	For ii = 0 To lv.Size - 1
		wnv = lv.Get(ii)
		If wnv.ViewToExplain = ViewToHighlightAndExplain Then
'			LogColor("L:" & wnv.Left, Colors.Red)
'			LogColor("T:" & wnv.Top, Colors.Red)
'			LogColor("W:" & wnv.Width, Colors.Red)
'			LogColor("H:" & wnv.Height, Colors.Red)
			
			wnv.Left = LeftOfLabelOfExplanationText
			wnv.Top = TopOfLabelOfExplanationText
			wnv.Width = WidthOfLabelOfExplanationText
			wnv.Height = HeightOfLabelOfExplanationText
			
'			LogColor("L:" & wnv.Left, Colors.Blue)
'			LogColor("T:" & wnv.Top, Colors.Blue)
'			LogColor("W:" & wnv.Width, Colors.Blue)
'			LogColor("H:" & wnv.Height, Colors.Blue)
			
			lv.Set(ii, wnv)			
			Exit 
		End If
	Next

End Sub 


Sub SetViewsVisible(bVisible As Boolean)
'	For ii = 0 To lv.Size
'		Dim wnv As WNViews
'		wnv.ViewToExplain.Visible = bVisible
'	Next
	Dim iCountBttn As Int = 0

	For Each v As View In ParentPanel.GetAllViewsRecursive
			
		If v Is Button Then
			iCountBttn = iCountBttn + 1
			If bVisible = True Then
				Dim s As String = v.Tag
				Dim kk As Int
				For kk = 0 To lButtons.Size - 1
					Dim btv As BttnVisible = lButtons.Get(kk)
					If btv.tag = v.Tag Then
						Dim b As Button = v
						Log(b.Left)
						LogColor(b.Top, Colors.Green)
						b.Visible = btv.Visible
						Exit
					End If
				Next
				If s.StartsWith("WhNew~~") Then
					v.Tag = ""
				End If
			Else
				If v.Tag = "" Then
					v.Tag = "WhNew~~" & iCountBttn
				End If
				'Krata poio einai kai thn katastash tou
				lButtons.Add(CreateBttnVisible(v.Tag, v.Visible))
				'Kane to visible=false
				v.Visible = False
			End If
		End If
		
	Next
	
	If bVisible = True Then 
		lButtons.Clear
	End If
	
End Sub

Sub CreateBttnVisible(tag As String, visible As Boolean) As BttnVisible
	Dim btv As BttnVisible
	btv.tag = tag
	btv.Visible = visible
	Return btv
End Sub



'Remove a view from the views to explain
Public Sub RemoveViewToExplain(ViewToHighlightAndExplain As View)
	
	Dim ii As Int
	Dim iCount As Int = 0
	Dim bFound As Boolean = False
	For ii = 0 To lv.Size - 1
		Dim wnv As WNViews
		wnv = lv.Get(ii)
		iCount = ii
		
		If wnv.ViewToExplain = ViewToHighlightAndExplain Then
			bFound = True
			Exit
		End If
		
	Next
	Try
		If bFound = True Then
			lv.RemoveAt(iCount)
		End If
	Catch
		Log(LastException)
	End Try
End Sub


'The what's new presentation appears and starts the explaining of views
Public Sub StartExplainingWhatsNew
	iPointer = 0
	p.Visible = True
	CreateStep
End Sub

'Clears the cached views to explain
Public Sub ClearCache
	iPointer = 0
	lv.Clear
End Sub

'Checks to see if it has shown this version of what's new in the
'Activity (for B4A) or in the Page (for B4i).
'Send the Name of the Activity or the Name of the Page (String),
'the WhatsNewVersion (Int) and the SQL (conncurrent) to save the latest 
'what's new version shown for the given Activity/Page name.
'The Function Returns a Boolean - True=Show this what's new version/False=Do not show this what's new version
Public Sub CheckToShowWhatsNew(ActivityOrPageName As String, WhatsNewVersion As Int, conncurrent As SQL) As Boolean
	
	ActivityOrPageName = ActivityOrPageName.ToLowerCase
	Dim cur As ResultSet
	
	Try
		cur = conncurrent.ExecQuery("SELECT * FROM [WhatsNew]")
	Catch
		conncurrent.ExecNonQuery($"CREATE TABLE [WhatsNew](
  										[ActivityOrPageName] TEXT PRIMARY KEY ON CONFLICT ABORT, 
  										[VersionShowed] TEXT);"$)
		Log(LastException)
	End Try
	
	
	cur = conncurrent.ExecQuery("SELECT * FROM [WhatsNew] WHERE [ActivityOrPageName]='" & ActivityOrPageName & "'")
	
	Dim iCount As Int = 0
	Do While cur.NextRow
		If cur.GetInt("VersionShowed") = WhatsNewVersion Then
			Return False
		Else
			conncurrent.ExecNonQuery2("UPDATE [WhatsNew] SET [VersionShowed]=? WHERE [ActivityOrPageName] = ?", Array As Object(WhatsNewVersion, ActivityOrPageName))
			Return True
		End If
		iCount = iCount + 1
		Exit '1 row
	Loop
	
	If iCount = 0 Then
		conncurrent.ExecNonQuery2("INSERT INTO [WhatsNew] ([ActivityOrPageName], [VersionShowed]) VALUES (?, ?)", Array As Object(ActivityOrPageName, WhatsNewVersion))
		Return True
	End If
End Sub



Private Sub CreateStep

	SetViewsVisible(False)
	
	lb4xExplain.Visible = False
	lb4xBack.Text = "< " & sBack
	
	Select Case iPointer
		Case 0
			If lv.Size = 1 Then
				lb4xNext.Tag = "Hide"
				lb4xNext.Text = sHide
			Else
				lb4xNext.Tag = "Next"
				lb4xNext.Text = sNext & " >"
			End If
			
			lb4xBack.Visible = False
		Case lv.Size - 1
			lb4xNext.Tag = "Hide"
			lb4xNext.Text = " " & sHide & " "
			lb4xBack.Visible = True
		Case Else
			lb4xNext.Tag = "Next"
			lb4xNext.Text = sNext & " >"
			lb4xBack.Visible = True
	End Select
	
	
	
	
	'DrawBackGround
	cnv.DrawRect(cnv.TargetRect, Colors.Transparent, True,1)
	
	
	Dim xm As Long, ym As Long

	
	Dim wnv As WNViews
	wnv = lv.Get(iPointer)
	
	Dim v As View = wnv.ViewToExplain
	Dim lngCurrentViewsLeft As Long = GetCurrentViewsLeft(v)
	Dim lngCurrentViewsTop As Long = GetCurrentViewsTop(v)
	
	xm = lngCurrentViewsLeft + (wnv.ViewToExplain.Width/2)
	ym = lngCurrentViewsTop + (wnv.ViewToExplain.Height/2)
	Diagonal = Sqrt(Power((xm - lngCurrentViewsLeft), 2) + Power((ym - lngCurrentViewsTop), 2))
	wnv.ViewToExplain.Visible = True
	
	
	Dim ql As B4XPath
	ql.Initialize(0, 0)
	ql.LineTo(xm, ym)
	ql.LineTo(0, p.Height)
	ql.LineTo(0, 0)
	
	Dim qt As B4XPath
	qt.Initialize(0, 0)
	qt.LineTo(xm,ym)
	qt.LineTo(p.Width, 0)
	qt.LineTo(0,0)
	
	Dim qb As B4XPath
	qb.Initialize(0, p.Height)
	qb.LineTo(xm,ym)
	qb.LineTo(p.Width, p.Height)
	qb.LineTo(0, p.Height)
	
	Dim qr As B4XPath
	qr.Initialize(p.Width, 0)
	qr.LineTo(xm,ym)
	qr.LineTo(p.Width, p.Height)
	qr.LineTo(p.Width, 0)
	
	cnv.DrawPath(ql, lColor, True, 1)
	cnv.DrawPath(qt, tbColor, True, 1)
	cnv.Drawpath(qb, tbColor, True, 1)
	cnv.DrawPath(qr, rColor, True, 1)
	
	If iHighlight = 1 Then
		Dim rect As B4XRect
		rect.Initialize(lngCurrentViewsLeft - iMargin, lngCurrentViewsTop - iMargin, _
			lngCurrentViewsLeft + wnv.ViewToExplain.Width + iMargin, _
			lngCurrentViewsTop + wnv.ViewToExplain.Height + iMargin)
		cnv.DrawRect(rect, Colors.Transparent, True, 1)
	Else
		cnv.DrawCircle(xm, ym, Diagonal+iMargin, Colors.Transparent, True, 1)
	End If
		
	
	lb4xNext.Width = cnv.MeasureText(lb4xNext.Text, lb4xNext.Font).Width * 1.15
	lb4xNext.Height = cnv.MeasureText(lb4xNext.Text, lb4xNext.Font).Height * 2
	lb4xBack.Width  = cnv.MeasureText(lb4xBack.Text, lb4xBack.Font).Width * 1.15
	lb4xBack.Height = cnv.MeasureText(lb4xBack.Text, lb4xBack.Font).Height * 2
	
	lb4xNext.SetTextAlignment("CENTER","CENTER")
	lb4xBack.SetTextAlignment("CENTER","CENTER")
	lb4xExplain.SetTextAlignment("CENTER","CENTER")
	
		
	Dim iNavTop As Long
	Dim dimensionY As Long = 100%y
	If dimensionY - lb4xBack.Height < lngCurrentViewsTop + wnv.ViewToExplain.Height Then
		iNavTop = 0
	Else
		iNavTop = 100%y - (lb4xNext.Height)
	End If
	
	lb4xBack.Top = iNavTop
	lb4xNext.Top = iNavTop
	lb4xNext.Left = 100%x - lb4xNext.Width
	lb4xBack.Left = 0
	
	
	
	Dim lMargins() As Long = Array As Long(wnv.Left, wnv.Top, wnv.Width, wnv.Height )
	If lMargins(0) = 0 And lMargins(1) = 0 And lMargins(2) = 0 And lMargins(3) = 0 Then
		lMargins = AutoCalculateMarginsOfExplainLabel(wnv, xm, ym, iNavTop, iNavTop + lb4xBack.Height)
	End If
	
	lb4xExplain.Visible = False
	
	
	lb4xExplain.Left = lMargins(0)
	lb4xExplain.Top = lMargins(1)
	lb4xExplain.Width = lMargins(2)
	lb4xExplain.Height = lMargins(3)
	lb4xExplain.Text = wnv.TextToExplainView
	
	#if B4a
	Dim su As StringUtils
	Dim iHeight As Long = su.MeasureMultilineTextHeight(lb4xExplain, lb4xExplain.Text)*1.40
	#else if b4i
	Dim iHeight As Long = lb4xExplain.Height
	lb4xExplain.Height = MeasureTextHeight(lb4xExplain.Text, lb4xExplain.Font, True, lb4xExplain.Width)
	#End If
	lb4xExplain.Height = Min(iHeight,lb4xExplain.Height)
	
	
	If lMargins(0) = 0 And lMargins(1) = 0 And lMargins(2) = 0 And lMargins(3) = 0 Then
		If ym < 50%y Then
			'Το βάζουμε κάτω
			lb4xExplain.Top = 75%y - lb4xExplain.Height/2
		Else
			'Το βάζουμε πάνω
			lb4xExplain.Top = 25%y - lb4xExplain.Height/2
		End If
	End If
	
	
	lb4xExplain.Visible = True
	cnv.Invalidate
	
End Sub


Private Sub GetCurrentViewsLeft(v As View) As Long
	Dim lngLeft As Long = v.Left
	Dim v2 As View = v
	
	Do While True
		If v2.Parent <> Null Then
			Try
				Dim k23 As Panel 
				k23.Initialize("")
				k23 = v2.Parent
				Dim pLeft As Long = k23.Left
				lngLeft = lngLeft + pLeft
				v2 = k23
			Catch
				Log(LastException)
				Exit
			End Try
		Else
			Exit
		End If
	Loop
	Return lngLeft
End Sub

Private Sub GetCurrentViewsTop(v As View) As Long
	Dim lngTop As Long = v.Top
	Dim v2 As View = v
	
	Do While True
		If v2.Parent <> Null Then
			Try
				Dim k23 As Panel
				k23.Initialize("")
				k23= v2.Parent
				Dim pTop As Long = k23.Top
				lngTop = lngTop + pTop
				v2 = k23
			Catch
				Log(LastException)
				Exit
			End Try
		Else
			Exit
		End If
	Loop
	Return lngTop
End Sub


Private Sub AutoCalculateMarginsOfExplainLabel(wnv As WNViews, xm As Long, ym As Long, NavTop As Long, NavBottom As Long) As Long()
	Dim lMargins() As Long
	Dim bLeft As Boolean
	Dim bTop As Boolean
	
	Dim lvl As LayoutValues = GetDeviceLayoutValues
	
	
	
	bLeft = (xm < (0.5 * lvl.Width))
	bTop = (ym < (0.5 * lvl.Height))
	Dim lngConflictingX As Long
	Dim lngConflictingY As Long
	
	Dim iMargin2 As Long = (0.5 * lvl.Width)/10
	
	Dim v As View = wnv.ViewToExplain
	Dim lngCurrentViewsLeft As Long = GetCurrentViewsLeft(v)
	Dim lngCurrentViewsTop As Long = GetCurrentViewsTop(v)
	
	Select Case bLeft
		Case True
			Select Case bTop
				Case True
					'Είναι στο πάνω αριστερά
					
					Select Case iHighlight
						Case 1 'Rectangle
							If lngCurrentViewsLeft + wnv.ViewToExplain.Width + iMargin > (0.5 * lvl.Width) Then 'Αν το δεξί του μέρος περνάει το (0.5 * lvl.Width)
								lngConflictingX = lngCurrentViewsLeft + wnv.ViewToExplain.Width + iMargin
							Else
								lngConflictingX = (0.5 * lvl.Width) + iMargin2
							End If
							If lngCurrentViewsTop + wnv.ViewToExplain.Height + iMargin > (0.5*lvl.Height) Then 'Αν το κάτω του μέρος περνάει το (0.5*lvl.Height)
								lngConflictingY = lngCurrentViewsTop + wnv.ViewToExplain.Height + iMargin
							Else
								lngConflictingY = (0.5*lvl.Height) + iMargin2
							End If
						Case 2 'Circle
							If xm + Diagonal + iMargin > (0.5 * lvl.Width) Then 'Αν το δεξί του μέρος περνάει το (0.5 * lvl.Width)
								lngConflictingX = xm + Diagonal + iMargin
							Else
								lngConflictingX = (0.5 * lvl.Width) + iMargin2
							End If
							If ym + Diagonal + iMargin > (0.5*lvl.Height) Then 'Αν το κάτω του μέρος περνάει το (0.5*lvl.Height)
								lngConflictingY = ym + Diagonal + iMargin
							Else
								lngConflictingY = (0.5*lvl.Height) + iMargin2
							End If
					
					End Select
					
					
					
					
					lMargins = Array As Long(lngConflictingX, Min(NavTop, lngConflictingY), _
							(lvl.Width) - lngConflictingX - iMargin2, (lvl.Height) - lngConflictingY - iMargin2)
				Case False
					'Είναι στο κάτω αριστερά
					
					Select Case iHighlight
						Case 1'Rectangle
							If lngCurrentViewsLeft + wnv.ViewToExplain.Width + iMargin > (0.5 * lvl.Width) Then 'Αν το δεξί του μέρος περνάει το (0.5 * lvl.Width)
								lngConflictingX = lngCurrentViewsLeft + wnv.ViewToExplain.Width + iMargin
							Else
								lngConflictingX = (0.5 * lvl.Width) + iMargin2
							End If
							If lngCurrentViewsTop - iMargin  < (0.5*lvl.Height) Then 'Αν το πάνω του μέρος μικρότερο του (0.5*lvl.Height)
								lngConflictingY = lngCurrentViewsTop - iMargin
							Else
								lngConflictingY = (0.5*lvl.Height) - iMargin2
							End If
						Case 2'Circle
							If xm + Diagonal + iMargin > (0.5 * lvl.Width) Then 'Αν το δεξί του μέρος περνάει το (0.5 * lvl.Width)
								lngConflictingX = xm + Diagonal + iMargin
							Else
								lngConflictingX = (0.5 * lvl.Width) + iMargin2
							End If
							If ym - Diagonal - iMargin < (0.5*lvl.Height) Then 'Αν το πάνω του μέρος μικρότερο του (0.5*lvl.Height)
								lngConflictingY = ym - Diagonal - iMargin
							Else
								lngConflictingY = (0.5*lvl.Height) - iMargin2
							End If
					End Select
					
					
					
					
					lMargins = Array As Long(lngConflictingX, Min(iMargin2,lngConflictingY), _
							(lvl.Width) - lngConflictingX - iMargin2, (lvl.Height) - lngConflictingY - iMargin2)
			End Select
		Case False
			Select Case bTop
				Case True
					'Είναι στο πάνω δεξιά

					Select Case iHighlight
						Case 1'Rectangle
							If lngCurrentViewsLeft - iMargin  < (0.5 * lvl.Width) Then 'Αν το αριστερό του μέρος μικρότερο του (0.5 * lvl.Width)
								lngConflictingX = lngCurrentViewsLeft - iMargin
							Else
								lngConflictingX = (0.5 * lvl.Width) - iMargin2
							End If
							If lngCurrentViewsTop + wnv.ViewToExplain.Height + iMargin > (0.5*lvl.Height) Then 'Αν το κάτω του μέρος περνάει το (0.5*lvl.Height)
								lngConflictingY = lngCurrentViewsTop + wnv.ViewToExplain.Height + iMargin
							Else
								lngConflictingY = (0.5*lvl.Height) + iMargin2
							End If
						Case 2'Circle
							If xm - Diagonal - iMargin  < (0.5 * lvl.Width) Then 'Αν το αριστερό του μέρος μικρότερο του (0.5 * lvl.Width)
								lngConflictingX = xm - Diagonal - iMargin
							Else
								lngConflictingX = (0.5 * lvl.Width) - iMargin2
							End If
							If ym + Diagonal + iMargin > (0.5*lvl.Height) Then 'Αν το κάτω του μέρος περνάει το (0.5*lvl.Height)
								lngConflictingY = lngCurrentViewsTop + wnv.ViewToExplain.Height
							Else
								lngConflictingY = (0.5*lvl.Height) + iMargin2
							End If
					End Select

					
					
					
					lMargins = Array As Long(iMargin2, Min(lngConflictingY, NavTop), _
							(lvl.Width) - lngConflictingX - iMargin2, (lvl.Height) - lngConflictingY - iMargin2)
				Case False
					'Είναι στο κάτω δεξιά
					
					
					Select Case iHighlight
						Case 1'Rectangle
							If lngCurrentViewsLeft - iMargin   < (0.5 * lvl.Width) Then 'Αν το αριστερό του μέρος μικρότερο του (0.5 * lvl.Width)
								lngConflictingX = lngCurrentViewsLeft - iMargin
							Else
								lngConflictingX = (0.5 * lvl.Width) - iMargin2
							End If
							If lngCurrentViewsTop - iMargin < (0.5*lvl.Height) Then 'Αν το πάνω του μέρος μικρότερο του (0.5*lvl.Height)
								lngConflictingY = lngCurrentViewsTop - iMargin
							Else
								lngConflictingY = (0.5*lvl.Height) - iMargin2
							End If
							
						Case 2'Circle
							If xm - Diagonal - iMargin  < (0.5 * lvl.Width) Then 'Αν το αριστερό του μέρος μικρότερο του (0.5 * lvl.Width)
								lngConflictingX = xm - Diagonal - iMargin
							Else
								lngConflictingX = (0.5 * lvl.Width) - iMargin2
							End If
							If ym - Diagonal - iMargin < (0.5*lvl.Height) Then 'Αν το πάνω του μέρος μικρότερο του (0.5*lvl.Height)
								lngConflictingY = lngCurrentViewsTop - iMargin
							Else
								lngConflictingY = (0.5*lvl.Height) - iMargin2
							End If
							
					End Select
					
					
					
					
					lMargins = Array As Long(iMargin2, Min(iMargin2, lngConflictingY), _
							(lvl.Width) - lngConflictingX - iMargin2, (lvl.Height) - lngConflictingY - iMargin2)

					
			End Select
	End Select
	
	Return lMargins
End Sub



Private Sub lNext_Click
	If lb4xNext.Tag = "Hide" Then
		p.Visible = False
		SetViewsVisible(True)
	Else
		If iPointer < lv.Size - 1 Then
			iPointer = iPointer + 1
			CreateStep
		End If
	End If
End Sub

Private Sub lBack_Click
	If iPointer <> 0 Then
		iPointer = iPointer - 1
		CreateStep
		lb4xNext.Tag = "Next"
		lb4xNext.Text = sNext & " >"
	End If
End Sub


#End Region


#Region B4iMeasureMultilineText

#if b4i
Private Sub MeasureTextHeight(Text As String,UseFont As Font,Multiline As Boolean, Width As Double) As Double
	Return MeasureText(Text, UseFont, Multiline, Width)(1)
End Sub
Private Sub MeasureTextWidth(Text As String,UseFont As Font,Multiline As Boolean, Width As Double) As Double
	Return MeasureText(Text, UseFont, Multiline, Width)(0)
End Sub
Private Sub MeasureText(Text As String,UseFont As Font,Multiline As Boolean, Width As Double) As Double()
	Dim L As Label
	L.Initialize("")
	L.Font = UseFont
	L.Text = Text
	If Multiline = True Then L.Width = Width
	L.Multiline = Multiline
	L.SizeToFit
	Dim Result(2) As Double
	Result(0) = L.Width
	Result(1) = L.Height
	Return Result
End Sub
#End If

#End Region



#Region Fields

'Use to set the highter to a rectangle
Public Sub getHighlighterRectangle As Int
	Return 1
End Sub

'Use to set the highter to a cirlce
Public Sub getHighlighterCircle As Int
	Return 2
End Sub

'Use to set the translation of 'Next' label
Public Sub setNextText(sNextMessage As String)
	sNext = sNextMessage
End Sub

'Use to set the translation of 'Back' label
Public Sub setBackText(sBackMessage As String)
	sBack = sBackMessage
End Sub

'Use to set the translation of 'Hide' label
Public Sub setHideText(sHideMessage As String)
	sHide = sHideMessage
End Sub

Public Sub setHighLigher(ShapeOfHighligher As Int)
	iHighlight = ShapeOfHighligher
End Sub

#End Region

