	Function GetPassedText(args)
		Dim text
		If args.length > 0 Then
			If args(0) = "-f" Then
				 text = ReadFile(args(1))
			End If
		Else
			text = ""
		End If
		GetPassedText = text
    	End Function
	
    Function ReadFile(fileName)
		Dim fso, file
		Dim fileContent
	
	 	Set fso = CreateObject("Scripting.FileSystemObject")
	 	If fso.FileExists(fileName) Then
	    	Set file = fso.OpenTextFile(fileName, 1)
	    	fileContent = file.ReadAll
	    	file.Close
	    Else
	    	fileContent = "file not found" & fileName
	    End If
	    ReadFile = fileContent
    End Function
    
    Function WriteFile(args(),data)
    	Dim fileName
    	fileName = args(1)
		If fileName <> "" Then
	    	Dim fso, file
	    	Set fso = CreateObject("Scripting.FileSystemObject")
	    	Set file = fso.OpenTextFile(fileName, 2, True)
	    	file.Write(data)
	    	file.close
    	End If
    	WriteFile = ""
    End Function
    
    Function ReturnText(args(),outText)
   		Dim fileName
   		fileName = args(1)
		Call WriteFile(args,outText)
		WScript.Stdout.Write("-f::"+ fileName)
    End Function
    
    Sub LogMsg(text)
    	WScript.StdOut.Write(vbCrLf & text)
    End Sub
    
        Sub LogError(text)
    	WScript.StdErr.Write(vbCrLf & text)
    End Sub