B4A=true
Group=CLASSES\B4X
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
End Sub

'This code creates a label with the text and returns a snapshot of the label.
'AUTHOR: Erel
'<code>
''This code creates a label with the text and returns a snapshot of the label.
'Sub TextToBitmap (Width As Int, Fnt As B4XFont, Clr As Int, Text As Object) As B4XBitmap
'	Dim lbl As Label
'	lbl.Initialize("")
'	Dim x As B4XView = lbl
'	x.Font = Fnt
'	x.TextColor = Clr
'	x.SetLayoutAnimated(0, 0, 0, Width, 0)
'	Dim su As StringUtils
'	x.Height = su.MeasureMultilineTextHeight(x, Text)
'	x.Text = Text
'	Return x.Snapshot
'End Sub
'</code>
Public Sub TextToBitmapSnippet
End Sub


'AUTHOR: Erel
'<code>
''Change the view's alpha level - transparency
''Level between 0 (transparent) to 1 (opaque)
'Public Sub SetAlpha (View As B4XView, Level As Float)
'    #if B4A
'	Dim jo As JavaObject = View
'	Dim alpha As Float = Level
'	jo.RunMethod("setAlpha", Array(alpha))
'    #Else If B4J
'    Dim n As Node = View
'    n.Alpha = Level
'    #else if B4i
'    Dim v As View = View
'    v.Alpha = Level
'    #End If
'End Sub
'</code>
Public Sub SetAlphaSnippet
End Sub