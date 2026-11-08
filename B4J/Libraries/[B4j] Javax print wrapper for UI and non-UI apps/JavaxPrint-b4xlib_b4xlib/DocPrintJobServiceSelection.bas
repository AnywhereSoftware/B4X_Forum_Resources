B4J=true
Group=PrintJobs
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private mService As PrintService
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize

End Sub

'To print to the system default pinter add a printername attribute to the PrintServiceAttributeSet with the name "default"
Public Sub FindService (PrintServiceAttSet As PrintServiceAttributeSet,PrintRequestAttSet As PrintRequestAttributeSet,Flavor As Object)As ResumableSub
	Dim Message As String 
	
	If PrintServiceAttSet.IsInitialized And PrintServiceAttSet.ContainsKey(Attribute_Classes.PrinterName) Then
		
		If PrintServiceAttSet.Get(Attribute_Classes.PrinterName).GetValue.As(String).ToLowerCase = "default" Then
			mService = PrintServiceLookup.LookupDefaultPrintService
			PrintServiceAttSet.Remove2(Attribute_Classes.PrinterName)
		Else
		
			Dim Services As List = PrintServiceLookup.GetPrintServices(Flavor,PrintServiceAttSet)
			If Services.Size > 0 Then
				mService = Services.Get(0)
			Else
				Message = "No print services found"
			End If
		End If
	Else
		Dim Services As List
		If PrintServiceAttSet.IsInitialized And PrintServiceAttSet.IsEmpty = False Then
			Services = PrintServiceLookup.GetPrintServices(Flavor,PrintServiceAttSet)
		Else
			Services = PrintServiceLookup.GetPrintServices(Flavor,Null)
		End If
		
		If Services.Size > 0 Then
			
			Dim Default As PrintService = PrintServiceLookup.LookupDefaultPrintService
			If Default.IsInitialized = False Then Default = Services.Get(0)
			Dim SUI As ServiceUI
			SUI.Initialize
			Dim RS As ResumableSub
			If PrintRequestAttSet.IsInitialized = False Then
				PrintRequestAttSet = NewInstanceJavax.PrintRequestAttributeSet
			End If
			PrintRequestAttSet.Add(Attributes.DIALOGTYPESELECTION_NATIVE)
			RS = SUI.PrintDialog(100,100,Services,Default,Flavor, PrintRequestAttSet)

			Wait For(RS) Complete (Service As PrintService)
			mService = Service
			
		Else
			Message = "No print services found"
		End If
		
	End If
	
	If mService.IsInitialized = False Then
		Message = "No printer selected"
	End If
	
	Return Message
End Sub
'To print to the system default pinter add a printername attribute to the PrintServiceAttributeSet with the name "default"
Public Sub FindService_NoThread (PrintServiceAttSet As PrintServiceAttributeSet,PrintRequestAttSet As PrintRequestAttributeSet,Flavor As Object)As String
	Dim Message As String 
	
	If PrintServiceAttSet.IsInitialized And PrintServiceAttSet.ContainsKey(Attribute_Classes.PrinterName) Then
		
		If PrintServiceAttSet.Get(Attribute_Classes.PrinterName).GetValue.As(String).ToLowerCase = "default" Then
			mService = PrintServiceLookup.LookupDefaultPrintService
			PrintServiceAttSet.Remove2(Attribute_Classes.PrinterName)
		Else
		
			Dim Services As List = PrintServiceLookup.GetPrintServices(Flavor,PrintServiceAttSet)
			If Services.Size > 0 Then
				mService = Services.Get(0)
			Else
				Message = "No print services found"
			End If
		End If
	Else
		Dim Services As List
		If PrintServiceAttSet.IsInitialized And PrintServiceAttSet.IsEmpty = False Then
			Services = PrintServiceLookup.GetPrintServices(Flavor,PrintServiceAttSet)
		Else
			Services = PrintServiceLookup.GetPrintServices(Flavor,Null)
		End If
		
		If Services.Size > 0 Then
			
			Dim Default As PrintService = PrintServiceLookup.LookupDefaultPrintService
			If Default.IsInitialized = False Then Default = Services.Get(0)
			Dim SUI As ServiceUI
			SUI.Initialize
			If PrintRequestAttSet.IsInitialized = False Then
				PrintRequestAttSet = NewInstanceJavax.PrintRequestAttributeSet
			End If
			PrintRequestAttSet.Add(Attributes.DIALOGTYPESELECTION_NATIVE)
			mService = SUI.PrintDialog_NoThread(100,100,Services,Default,Flavor, PrintRequestAttSet)
		Else
			Message = "No print services found"
		End If
		
	End If
	
	If mService.IsInitialized = False Then
		Message = "No printer selected"
	End If
	
	Return Message
End Sub

Public Sub getService As PrintService
	Return mService
End Sub