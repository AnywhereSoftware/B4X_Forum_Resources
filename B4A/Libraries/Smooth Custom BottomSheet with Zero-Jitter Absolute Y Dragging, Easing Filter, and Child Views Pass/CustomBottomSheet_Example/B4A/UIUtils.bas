B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=13.4
@EndOfDesignText@
'Code module: UIUtils
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	' No se necesitan variables globales para esta funciones estáticas
End Sub


' Method for top corners (Ideal for Bottom Sheets)
Public Sub SetTopCorners(v As B4XView, Radius As Float, Color As Int)
	' Array of 8 values: (TopLeft, TopRight, BottomRight, BottomLeft) in X,Y pairs
	Dim Radii() As Float = Array As Float(Radius, Radius, Radius, Radius, 0, 0, 0, 0)
	
	Dim gdw As GradientDrawable
	gdw.Initialize("TOP_BOTTOM", Array As Int(Color, Color))
	
	Dim jo As JavaObject = gdw
	jo.RunMethod("setCornerRadii", Array(Radii))
	
	' Cast to the native Android View to apply the background
	Dim nativeView As View = v
	nativeView.Background = gdw
End Sub

' Completely free method (you decide the radius of each corner independently)
Public Sub SetCustomCorners(v As B4XView, TopLeft As Float, TopRight As Float, BottomRight As Float, BottomLeft As Float, Color As Int)
	Dim Radii() As Float = Array As Float(TopLeft, TopLeft, TopRight, TopRight, BottomRight, BottomRight, BottomLeft, BottomLeft)
	
	Dim gdw As GradientDrawable
	gdw.Initialize("TOP_BOTTOM", Array As Int(Color, Color))
	
	Dim jo As JavaObject = gdw
	jo.RunMethod("setCornerRadii", Array(Radii))
	
	Dim nativeView As View = v
	nativeView.Background = gdw
End Sub

' Simplified method: Rounds all 4 corners identically
' Tip: B4XView has this built-in natively in a very clean way—no JavaObject needed!
Public Sub SetCornerRadius(v As B4XView, Radius As Float, Color As Int)
	' Parameters: Background color, Border width, Border color, Corner radius
	v.SetColorAndBorder(Color, 0, 0, Radius)
End Sub

' Flexible option: useful if you later create a blue, green, or any other custom button
Public Sub SetButtonState(View As B4XView, Pressed As Boolean, NormalColor As Int, PressedColor As Int, Radius As Float)
	If Pressed Then
		View.SetColorAndBorder(PressedColor, 0, 0, Radius)
	Else
		View.SetColorAndBorder(NormalColor, 0, 0, Radius)
	End If
End Sub