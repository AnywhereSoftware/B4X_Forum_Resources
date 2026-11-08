B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=13
@EndOfDesignText@
'https://www.b4x.com/android/forum/threads/b4x-dse-designer-script-extensions.141312/
Sub Class_Globals
	Private xui As XUI
	Public i_Colors() As Int 'Public, if you also want to change color themes at runtime
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'Define color themes here
	Dim iColors() As Int = Array As Int(xui.Color_Black, xui.Color_Gray, 0x37AFE100, 0x4CC9FE00, 0xF5F4B300, 0xFFFECB00)
	i_Colors = iColors
End Sub

Public Sub GetColor(colorType As Int) As Int
	If colorType = -1 Then Return -1 'no setting
	Return i_Colors(colorType)
End Sub

'Parameters: BackColorID, TextColorID, View(s)
Private Sub SetColor(DesignerArgs As DesignerArgs)
	'In B4i and B4J the script will run multiple times. We want to run this code once.
	If DesignerArgs.FirstRun Then
		Dim iBackColor As Int = GetColor(DesignerArgs.Arguments.Get(0))
		Dim iTextColor As Int = GetColor(DesignerArgs.Arguments.Get(1))
		For i = 2 To DesignerArgs.Arguments.Size - 1
			Dim v As B4XView = DesignerArgs.GetViewFromArgs(i)
			If iBackColor <> -1 Then  v.Color = iBackColor
			If iTextColor <> -1 Then  v.TextColor = iTextColor
		Next
	End If
End Sub

'Parameters: PrimaryColorID, SecondaryColorID, View(s)
Private Sub SetSwiftbuttonColor(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Sleep(10) 'https://www.b4x.com/android/forum/threads/designerargs-with-customview.163903/#post-1005167
		Dim iPrimary As Int = GetColor(DesignerArgs.Arguments.Get(0))
		Dim iSecondary As Int = GetColor(DesignerArgs.Arguments.Get(1))
		For i = 2 To DesignerArgs.Arguments.Size - 1
			Dim v As B4XView = DesignerArgs.GetViewFromArgs(i)
			Dim sbtn As SwiftButton = v.Tag '.mb .Tag.As (SwiftButton) 'tag empty?
			sbtn.SetColors(iPrimary, iSecondary)
		Next
	End If
End Sub



Private Sub SetText(DesignerArgs As DesignerArgs)
	'need translation?
	'https://www.b4x.com/android/forum/threads/b4x-b4xpages-localizator.142775/
	'https://www.b4x.com/android/forum/threads/solved-localization-example-in-b4xpages-how.148649/#post-942204
End Sub



