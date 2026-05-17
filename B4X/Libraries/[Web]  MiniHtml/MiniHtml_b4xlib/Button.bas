B4J=true
Group=Modules
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@

Private Sub Process_Globals
	Private Const tagname As String = "button"
End Sub

Public Sub init As Tag
	Return Html.create(tagname)
End Sub

Public Sub attr (key As String, value As String) As Tag
	Return init.attr(key, value)
End Sub

Public Sub attr2 (keyvals As Map) As Tag
	Return init.attr2(keyvals)
End Sub

'(same as AddTo)
'Add to Parent and return current tag (child)
Public Sub up (Parent As Tag) As Tag
	Return init.up(Parent)
End Sub

Public Sub text (value As String) As Tag
	Return init.text(value)
End Sub

'Set id attribute
Public Sub id (value As String) As Tag
	Return init.attr("id", value)
End Sub

'Set type attribute
Public Sub typeOf (value As String) As Tag
	Return init.typeOf(value)
End Sub

'Set form attribute
Public Sub formOf (value As String) As Tag
	Return init.formOf(value)
End Sub

'Add a class
Public Sub cls (value As String) As Tag
	Return init.cls(value)
End Sub

'Add one or more styles separated by semicolon
Public Sub sty (value As String) As Tag
	Return init.sty(value)
End Sub

Public Sub hxGet (url As String) As Tag
	Return init.hxGet(url)
End Sub

Public Sub hxPost (url As String) As Tag
	Return init.hxPost(url)
End Sub

Public Sub hxPatch (url As String) As Tag
	Return init.hxPatch(url)
End Sub

Public Sub hxDelete (url As String) As Tag
	Return init.hxDelete(url)
End Sub

'e.g <code>hxOn("click", "alert('You clicked me!')")</code>
'output <code>hx-on:click="alert('You clicked me!')"</code>
'e.g <code>hxOn(":after-request", "if(event.detail.successful) this.reset()")</code>
'output <code>hx-on::after-request="if(event.detail.successful) this.reset()"</code>
Public Sub hxOn (event As String, value As String) As Tag
	Return init.hxOn(event, value)
End Sub