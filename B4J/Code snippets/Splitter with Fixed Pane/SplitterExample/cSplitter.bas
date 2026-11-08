B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private xui As XUI

  Public Const splDefault As Int = -1
	Public Const splLeft As Int = 0
	Public Const splRight As Int = 1  
	Public Const splTop As Int = 2
	Public Const splBottom As Int = 3
	  
	Private OptKey As String = ""	
	Private FSplitterType As Int = splDefault
	Private FMinFixedSize As Int = 30
	Private FMinFlexSize As Int = 30
	Private Sizing As Boolean = False
	
	Private Parent As B4XView
	Private panBase As B4XView
	Public FixedPanel As B4XView
	Public FlexPanel As B4XView
	Public Sizer As B4XView
End Sub

'Splitter type in Apk, Key is OptKey to save pos.
Public Sub Initialize(AParent As B4XView, SplitterType As Int, Key As String)	
	Parent = AParent
	OptKey = Key
	Parent.LoadLayout("StretchPanel")
	panBase.LoadLayout("Splitter")
	setSplitterType(IIf(SplitterType = splDefault, splLeft, SplitterType))
	RestorePos
End Sub

Public Sub RestorePos
	setDiv(B4XPages.MainPage.KVS.GetDefault($"${OptKey}Pos"$, 250))
End Sub

#Region Properties

'Const: splLeft, splRight, splTop, splBottom
Public Sub getSplitterType As Int
  Return FSplitterType	
End Sub

'Const: splLeft, splRight, splTop, splBottom
Public Sub setSplitterType(Value As Int)
	Dim OldType As Int = FSplitterType
	FSplitterType = Value
	Dim joCursors As JavaObject
	joCursors.InitializeStatic("javafx.scene.Cursor")
	Sizer.As(Pane).MouseCursor = joCursors.GetField(IIf(Horizontal, "H_RESIZE", "V_RESIZE"))
	If HorizontalType(OldType) <> Horizontal Then Restructure		
	Select FSplitterType
		Case splLeft
			FixedPanel.Left = 0
			Sizer.Left = panBase.Width / 2
			FlexPanel.Left = Sizer.Left + Sizer.Width
		Case splRight
			FlexPanel.Left = 0
			Sizer.Left = panBase.Width / 2
			FixedPanel.Left = Sizer.Left + Sizer.Width
		Case splTop
			FixedPanel.Top = 0
			Sizer.Top = panBase.Height / 2
			FlexPanel.Top = Sizer.Top + Sizer.Height			
		Case Else
			FlexPanel.Top = 0
			Sizer.Top = panBase.Height / 2
			FixedPanel.Top = Sizer.Top + Sizer.Height
	End Select
	panBase_Resize(panBase.Width, panBase.Height)
End Sub

Public Sub getMinFixedSize As Int
  Return FMinFixedSize	
End Sub

Public Sub setMinFixedSize(Size As Int)
	FMinFixedSize = Size
End Sub

Public Sub getMinFlexSize As Int
  Return FMinFixedSize	
End Sub

Public Sub setMinFlexSize(Size As Int)
	FMinFixedSize = Size
End Sub

Public Sub setDiv(Pos As Int)
	SetSizer(Pos - Sizer.Left, Pos - Sizer.Top)
End Sub

Public Sub SetDivPerCent(pos As Int)
	Select FSplitterType
		Case splLeft, splRight
			setDiv(pos * 100 / panBase.Width)
		Case Else
			setDiv(pos * 100 / panBase.Height)
	End Select
End Sub

Private Sub Horizontal As Boolean
	Return HorizontalType(FSplitterType)
End Sub

Private Sub HorizontalType(AType As Int) As Boolean
	If AType = splLeft Then Return True
	If AType = splRight Then Return True
	If AType < 0 Then Return True
	Return False
End Sub

Public Sub Restructure
	If Horizontal Then
		FixedPanel.Top = 0
		FixedPanel.Height = panBase.Height
		Sizer.Top = 0
		Sizer.Width = Sizer.Height
		Sizer.Height = panBase.Height
		FlexPanel.Top = 0
		FlexPanel.Height = panBase.Height
	Else
		FixedPanel.Left = 0
		FixedPanel.Width = panBase.Width
		Sizer.Left = 0
		Sizer.Height = Sizer.Width
		Sizer.Width = panBase.width
		FlexPanel.Left = 0
		FlexPanel.Width = panBase.Width
	End If
End Sub

#End Region

#Region Size

Private Sub Sizer_MousePressed (EventData As MouseEvent)
	If EventData.ClickCount > 1 Then Return
	Sizing = True
	Dim StartX As Double = EventData.X
	Dim StartY As Double = EventData.Y
	Do While Sizing
		Wait For(Sizer) Sizer_MouseDragged(EventData As MouseEvent)
		SetSizer(EventData.X - StartX, EventData.Y - StartY)
	Loop
End Sub

Private Sub SetSizer(X As Int, Y As Int)
	Select FSplitterType
		Case splLeft
			Sizer.Left = Max(Min(Sizer.Left + X, panBase.Width - FMinFlexSize), FMinFixedSize)
			FlexPanel.Left = Sizer.Left + Sizer.Width
			FlexPanel.Width = Max(FlexPanel.Parent.Width - FlexPanel.Left, FMinFlexSize)
			FixedPanel.Width = Max(Sizer.Left - FixedPanel.Left, FMinFixedSize)
		Case splRight
			Sizer.Left = Max(Min(Sizer.Left + X, panBase.Width - FMinFlexSize), FMinFixedSize)
			FlexPanel.Left = Sizer.Left + Sizer.Width
			FlexPanel.Width = FlexPanel.Parent.Width - FlexPanel.Left
			FixedPanel.Width = Sizer.Left - FixedPanel.Left
		Case splTop
			Sizer.Top = Max(Min(Sizer.Top + Y, panBase.Height - FMinFlexSize), FMinFixedSize)
			FlexPanel.Top = Sizer.Top + Sizer.Height
			FlexPanel.Height = FlexPanel.Parent.Height - FlexPanel.Top
			FixedPanel.Height = Sizer.Top - FixedPanel.Top
		Case Else
			Sizer.Top = Max(Min(Sizer.Top + Y, panBase.Height - FMinFlexSize), FMinFixedSize)
			FlexPanel.Top = Sizer.Top + Sizer.Height
			FlexPanel.Height = FlexPanel.Parent.Height - FlexPanel.Height
			FixedPanel.Height = Sizer.Top - FixedPanel.Top
	End Select
End Sub

Private Sub Sizer_MouseReleased (EventData As MouseEvent)
	Sizing = False
	B4XPages.MainPage.KVS.Put($"${OptKey}Pos"$, IIf(Horizontal, Sizer.Left, Sizer.Top))
End Sub

Private Sub panBase_Resize (Width As Double, Height As Double)
	If Horizontal Then
		FixedPanel.Height = Height
		Sizer.Height = Height
		FlexPanel.Height = Height
	Else
		FixedPanel.Width = Width
		Sizer.Width = Width
		FlexPanel.Width = Width
	End If
	Select FSplitterType
		Case splLeft
			FlexPanel.Width = Max(Width - FlexPanel.Left, FMinFlexSize)
		Case splRight
			FlexPanel.Width = Max(Width - Sizer.Left, FMinFlexSize)
		Case splTop
			FlexPanel.Height = Max(Height - FlexPanel.Top, FMinFlexSize)
		Case Else
			FlexPanel.Height = Max(Height - Sizer.Top, FMinFlexSize)
	End Select
End Sub

#End Region