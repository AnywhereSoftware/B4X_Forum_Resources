Type=Class
Version=3.6
ModulesStructureVersion=1
B4i=true
@EndOfDesignText@
'Custom View class 
#DesignerProperty: Key: InitialColor, DisplayName: Initial Color, FieldType: Color, DefaultValue: 0xFFFF0000
Sub Class_Globals
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mBase As WeakRef
	Private Const DefaultColorConstant As Int = -984833 'ignore
	Private noColorPicker As NativeObject
	Private cp As View
	
End Sub

Public Sub Initialize (Callback As Object, EventName As String)
	mEventName = EventName
	mCallBack = Callback
	
End Sub

Public Sub DesignerCreateView (Base As Panel, Lbl As Label, Props As Map)
	mBase.Value = Base
	Dim w As Int = Base.Width
	Dim h As Int = Base.Height - 10
	noColorPicker = noColorPicker.Initialize("ColorPicker.SwiftHSVColorPicker").RunMethod("alloc", Null).RunMethod("initWithFrame:", _
		Array(noColorPicker.MakeRect(0, 0, w, h)))
	cp = noColorPicker
	noColorPicker.RunMethod("setViewColor:", Array(noColorPicker.ColorToUIColor(Props.Get("InitialColor"))))
	Base.AddView(cp, 0, 0, w, h)
End Sub

Private Sub Base_Resize (Width As Double, Height As Double)
	
End Sub


Public Sub getColor As Int
	Dim nm As NativeObject = Me
	Return nm.RunMethod("UIColorToColor:", Array(noColorPicker.GetField("color"))).AsNumber
End Sub
#if OBJC
- (int) UIColorToColor: (UIColor*) clr {
	 CGFloat r, g, b, a;
    [clr getRed:&r green:&g blue:&b alpha:&a];
    return ((int)(fmin(1, fmax(0, a)) * 255) & 0xff) << 24 |
	 ((int)(fmin(1, fmax(0, r)) * 255) & 0xff) << 16 | 
	 ((int)(fmin(1, fmax(0, g)) * 255) & 0xff) << 8 | 
	 ((int)(fmin(1, fmax(0, b)) * 255) & 0xff);
}
#End If

Public Sub GetBase As Panel
	Return mBase.Value
End Sub