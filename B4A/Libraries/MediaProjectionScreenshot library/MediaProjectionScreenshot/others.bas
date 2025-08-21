B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.5
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim RealWidth, RealHeight, SoftButtonsBarHeight As Int
End Sub

'optional, not required
Sub NavigationBarExists As Boolean
	Dim jo As JavaObject
	jo.InitializeStatic("android.view.KeyCharacterMap")
	Dim hasBackKey As Boolean = jo.RunMethod("deviceHasKey", Array (KeyCodes.KEYCODE_BACK))
	Dim hasHomeKey As Boolean = jo.RunMethod("deviceHasKey", Array (KeyCodes.KEYCODE_HOME))
	Return Not(hasBackKey And hasHomeKey)
End Sub
