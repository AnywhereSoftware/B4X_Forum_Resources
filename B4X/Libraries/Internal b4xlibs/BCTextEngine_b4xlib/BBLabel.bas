B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.51
@EndOfDesignText@
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Public mBase As B4XView 'ignore
	Private xui As XUI 'ignore
	Private Runs As List
	Public Style As BCParagraphStyle
	Private mTextEngine As BCTextEngine
	Private mText As String
	Public ForegroundImageView As B4XView
	Public Paragraph As BCParagraph
	Public Padding As B4XRect
	Public ParseData As BBCodeParseData
	Public Tag As Object
	Public DisableResizeEvent As Boolean
	Public WordWrap As Boolean = True
	Public RTL As Boolean
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	Dim iv As ImageView
	iv.Initialize("")
	ForegroundImageView = iv
	ParseData.Initialize
	Padding.Initialize(2dip, 2dip, 2dip, 2dip)
End Sub

Public Sub DesignerCreateView (Base As Object, Lbl As Label, Props As Map)
	mBase = Base
	Tag = mBase.Tag
	mBase.Tag = Me
	mBase.AddView(ForegroundImageView, 0, 0, mBase.Width, mBase.Height)
	Dim xlbl As B4XView = Lbl
	ParseData.DefaultColor = xlbl.TextColor
	ParseData.DefaultFont = xlbl.Font
	ParseData.ViewsPanel = mBase
	mText = xlbl.Text
	#if B4J
	Dim fx As JFX
	ParseData.DefaultBoldFont = fx.CreateFont(Lbl.Font.FamilyName, ParseData.DefaultFont.Size, True, False)
	#Else If B4A
	ParseData.DefaultBoldFont = xui.CreateFont(Typeface.CreateNew(Lbl.Typeface, Typeface.STYLE_BOLD), xlbl.TextSize)
	#else if B4i
	ParseData.DefaultBoldFont = xui.CreateDefaultBoldFont(xlbl.TextSize)
	#End If
End Sub


Private Sub Base_Resize (Width As Double, Height As Double)
	If DisableResizeEvent Then Return
	If Runs.IsInitialized Then
		If ParseData.NeedToReparseWhenResize Then
			ParseAndDraw
		Else
			Redraw
		End If
	End If
End Sub

Public Sub setTextEngine (b As BCTextEngine)
	mTextEngine = b
	#if B4J
	mTextEngine.TagParser.InternalSetMouseTransparent(ForegroundImageView)
	#End If
	If mText <> "" Then
		setText(mText)
	End If
End Sub

Public Sub getTextEngine As BCTextEngine
	Return mTextEngine
End Sub

Public Sub setText(t As String)
	mText = t
	ParseAndDraw
End Sub

Public Sub getText As String
	Return mText
End Sub

Public Sub ParseAndDraw
	For i = mBase.NumberOfViews - 1 To 1 Step -1
		mBase.GetView(i).RemoveViewFromParent
	Next
	ParseData.NeedToReparseWhenResize = False
	ParseData.Text = mText
	ParseData.Width = (mBase.Width - Padding.Left - Padding.Right)
	If RTL Then mTextEngine.RTLAware = True
	Dim pe As List = mTextEngine.TagParser.Parse(ParseData)
	Runs = mTextEngine.TagParser.CreateRuns(pe, ParseData)
	Redraw
End Sub

Public Sub Redraw
	Dim Style As BCParagraphStyle = mTextEngine.CreateStyle
	Style.Padding = Padding
	Style.MaxWidth = mBase.Width
	Style.HorizontalAlignment = "left"
	Style.WordWrap = WordWrap
	Style.RTL = RTL
	Paragraph = mTextEngine.DrawText(Runs, Style, ForegroundImageView, Null)
	Dim dx As Int = mBase.Width / 2 - ForegroundImageView.Width / 2 - ForegroundImageView.Left
	Dim dy As Int = mBase.Height / 2 - ForegroundImageView.Height / 2 - ForegroundImageView.Top
	For Each v As B4XView In mBase.GetAllViewsRecursive
		v.Left = v.Left + dx
		v.Top = v.Top + dy
	Next
	ForegroundImageView.Visible = Paragraph.Height > 0
End Sub


