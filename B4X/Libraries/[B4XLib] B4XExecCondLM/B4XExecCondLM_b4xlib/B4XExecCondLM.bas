B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.1
@EndOfDesignText@
'ExecCond - Static code module
Sub Process_Globals
End Sub

#Region PUBLIC METHODS 

'Runs the first Sub whose corresponding condition is true.
'
'Conditions - List of conditions (Boolean)
'SubNames - List of routine names. Conditions and SubNames size must match.
'Params - List of parameters to pass to the routine that will be executed. In B4X they can be at most 2 (but even a single Map or List - collection)
'ReturnsResult - Set it to True if SubNames return a result (are functions).
'CallBack - The target whose routine will be executed (code module, class, object).
Public Sub ExecIf(Conditions As List, SubNames As List, Params As List, ReturnsResult As Boolean, Callback As Object) As Object
	Dim Result As Object = ""
	
	For i = 0 To Conditions.Size - 1
		If Conditions.Get(i) Then
			If Params <> Null And Params.IsInitialized Then
				Select Params.Size
					Case 1
						If ReturnsResult Then
							Result = CallSub2(Callback, SubNames.Get(i), Params.Get(0))
						Else
							CallSub2(Callback, SubNames.Get(i), Params.Get(0))
						End If
					Case 2
						If ReturnsResult Then
							Result = CallSub3(Callback, SubNames.Get(i), Params.Get(0), Params.Get(1))
						Else
							CallSub3(Callback, SubNames.Get(i), Params.Get(0), Params.Get(1))
						End If
				End Select
			Else
				If ReturnsResult Then
					Result = CallSub(Callback, SubNames.Get(i))
				Else
					CallSub(Callback, SubNames.Get(i))
				End If
			End If
			Exit
		End If
	Next
	
	Return Result
End Sub

'Runs ALL the Subs whose corresponding condition is true.
'
'Conditions - List of conditions (Boolean)
'SubNames - List of routine names. Conditions and SubNames size must match.
'Params - List of parameters to pass to the routines that will be executed.
'			 Of course, all routines to run must require the same number of parameters.
'			 In B4X they can be at most 2 (but even a single Map or List - collection)
'CallBack - The target whose routine will be executed (code module, class, object).
Public Sub ExecIfAll(Conditions As List, SubNames As List, Params As List, Callback As Object)
	For i = 0 To Conditions.Size - 1
		If Conditions.Get(i) Then
			If Params <> Null And Params.IsInitialized Then
				Select Params.Size
					Case 1
						CallSub2(Callback, SubNames.Get(i), Params.Get(0))
					Case 2
						CallSub3(Callback, SubNames.Get(i), Params.Get(0), Params.Get(1))
				End Select
			Else
				CallSub(Callback, SubNames.Get(i))
			End If
		End If
	Next
End Sub

'Runs the Indexth routine.
'
'SubNames - List of routine names.
'Params - List of parameters to pass to the routine that will be executed. In B4X they can be at most 2 (but even a single Map or List - collection)
'ReturnsResult - Set it to True if SubNames return a result (are functions).
'CallBack - The target whose routine will be executed (code module, class, object).
Public Sub ExecOnIndex(Index As Int, SubNames As List, Params As List, ReturnsResult As Boolean, Callback As Object) As Object
	Dim Result As Object = ""
	
	If Params <> Null And Params.IsInitialized Then
		Select Params.Size
			Case 1
				If ReturnsResult Then
					Result = CallSub2(Callback, SubNames.Get(Index), Params.Get(0))
				Else
					CallSub2(Callback, SubNames.Get(Index), Params.Get(0))
				End If
			Case 2
				If ReturnsResult Then
					Result = CallSub3(Callback, SubNames.Get(Index), Params.Get(0), Params.Get(1))
				Else
					CallSub3(Callback, SubNames.Get(Index), Params.Get(0), Params.Get(1))
				End If
		End Select
	Else
		If ReturnsResult Then
			Result = CallSub(Callback, SubNames.Get(Index))
		Else
			CallSub(Callback, SubNames.Get(Index))
		End If
	End If
	
	Return Result
End Sub

#End Region
