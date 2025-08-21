B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private BANano As BANano
	Private body As BANanoElement
End Sub

Sub Init
	'get the body of the page
	body = BANano.GetElement("#body")
	'empty the element
	body.Empty
	'create a div to hold the pdf document
	body.Append($"<div id="basic"></div>"$)
	'initialize the viewer
	Dim view As PDFView
	'use the id of the iframe
	view.Initialize("basic")
	'set the path of the pdf file to view
	view.SetHREF("./assets/themash.pdf")
	'set the height
	view.SetHeight(800)
	'set the width
	view.SetWidth(800)
	'process the viewing action
	view.View
End Sub
