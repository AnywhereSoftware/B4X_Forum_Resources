B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
End Sub

'Determine if the printer is a virtual printer by keywords in the printer name
Public Sub IsVirtualPrinter(Service As PrintService) As Boolean
	Dim Name As String = Service.GetName.ToLowerCase
	Return Name.Contains("pdf") Or Name.Contains("xps")
End Sub
