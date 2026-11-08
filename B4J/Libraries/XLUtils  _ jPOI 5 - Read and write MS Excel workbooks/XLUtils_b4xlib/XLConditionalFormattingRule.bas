B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.9
@EndOfDesignText@
Sub Class_Globals
	Public jRule As JavaObject
End Sub

'Don't use. Call Sheet.CreateConditionalFormattingRule instead.
Public Sub Initialize (Rule As JavaObject)
	jRule = Rule
End Sub

'Sets the cell fill color.
'Color - one of the xl.COLOR constants.
Public Sub ForegroundColor (Color As Short) As XLConditionalFormattingRule
	Dim patternformatting As JavaObject = jRule.RunMethod("createPatternFormatting", Null)
	patternformatting.RunMethod("setFillBackgroundColor", Array(Color))
	Dim solid As Short = 1
	patternformatting.RunMethod("setFillPattern", Array(solid)) 'SOLID_FOREGROUND
	Return Me
End Sub
'Sets the font style:
'Italic / Bold - True to set the style. False to keep it as-is.
'Color - 0 to keep the style or one of the xl.COLOR constants.
Public Sub FontStyle (Italic As Boolean, Bold As Boolean, Color As Short) As XLConditionalFormattingRule
	Dim FontFormatting As JavaObject = jRule.RunMethod("createFontFormatting", Null)
	FontFormatting.RunMethod("setFontStyle", Array(Italic, Bold))
	If Color > 0 Then
		FontFormatting.RunMethod("setFontColorIndex", Array(Color))
	End If
	Return Me
End Sub





