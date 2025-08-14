B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=2.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
	Dim mPrinterMap As Map
End Sub
'Retrieve the default Printer.
Public Sub GetDefaultPrinter As Printer
	
	Dim Printr As JavaObject
	Printr.InitializeStatic("javafx.print.Printer")
	Dim P As Printer
	P.Initialize
	P.SetObject(Printr.RunMethod("getDefaultPrinter",Null))
	If Not(mPrinterMap.IsInitialized) Then 
		mPrinterMap.Initialize
		mPrinterMap.Put(P.GetObject,P)
	Else
		If Not(mPrinterMap.ContainsKey(P.GetObject)) Then
			mPrinterMap.Put(P.GetObject,P)
		End If
	End If
	Return P
End Sub
'Retrieve the installed printers as a list.
Public Sub GetAllPrinters As List
	If Not(mPrinterMap.IsInitialized) Then mPrinterMap.Initialize
	mPrinterMap.Clear
		
	Dim L As List
	L.Initialize
	Dim JO As JavaObject
	JO.InitializeStatic("javafx.print.Printer")
	Dim OS As JavaObject = JO.RunMethod("getAllPrinters",Null)
	'Get an iterator for the set
    Dim Iterator As JavaObject = OS.RunMethod("iterator",Null)
    'Loop through the Keys Set and add each item to the output list
    Do While Iterator.RunMethod("hasNext",Null)
		Dim P As Printer
		P.Initialize
		P.SetObject(Iterator.RunMethod("next",Null))
        L.Add(P)
		mPrinterMap.Put(P.GetObject,P)
    Loop
    Return L
End Sub

Sub MappedPrinter(Source As Object) As Printer
	If Not(mPrinterMap.IsInitialized) Then GetAllPrinters
	Return mPrinterMap.Get(Source)
End Sub

Public Sub GetPrinterByName(Name As String) As Printer
	Dim Ptr As Printer
	Dim L As List = GetAllPrinters
	For Each P As Printer In L
		If P.GetName = Name Then 
			Ptr = P
			Exit
		End If
	Next
	Return Ptr
End Sub

Public Sub SearchPrinters(SearchStr As String) As List
	Dim Ptrs As List
	Ptrs.Initialize
	Dim L As List = GetAllPrinters
	For Each P As Printer In L
		If P.GetName.ToLowerCase.Contains(SearchStr.ToLowerCase) Then
			Ptrs.Add(P)
		End If
	Next
	Return Ptrs
End Sub