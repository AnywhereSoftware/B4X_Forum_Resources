B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals

	Public XWPFParagraph As JavaObject
	Public mDocument As WordDocument
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (Paragraph As JavaObject, Document As WordDocument)
	XWPFParagraph = Paragraph
	mDocument = Document
	
End Sub


