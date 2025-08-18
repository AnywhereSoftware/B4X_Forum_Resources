B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9
@EndOfDesignText@
Sub Class_Globals
	Private Host As String
	Private client As Socket
	Private toServer As Socket
	Private inStream As AsyncStreams
	Private outStream As AsyncStreams
	Private deal As Boolean = False
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Sck As Socket)
	client = Sck
	inStream.Initialize(client.InputStream,client.OutputStream,"inStream")
End Sub

private Sub inStream_NewData (Buffer() As Byte)
	If Not(deal) Then 
		Dim Index As Int = IndexOf(Buffer,Array As Byte(13,10,13,10))
		Dim Header As String = BytesToString(Buffer,0,Index,"UTF-8")
		
		For Each row As String In Regex.Split(Chr(13) & Chr(10),Header)
			If row.ToUpperCase.StartsWith("HOST:") Then 
				Dim Pm() As String = Regex.Split(" ",row)
				Host=Pm(1)
			End If
		Next
		Log($"http: ${Host}"$)
		
		If Host.ToUpperCase.IndexOf("EREL")>-1 Then ' redirect name
			Header=Header.Replace(Host,"www.b4x.com")
			Host="www.b4x.com"
			Buffer=Modify(Buffer,Index,Header.GetBytes("UTF-8"))
		End If
		toServer.Initialize("toServer")
		toServer.Connect(Host,80,4000)
		Wait For toServer_Connected (Successful As Boolean)
		
		If Successful Then
			deal=True
			outStream.Initialize(toServer.InputStream,toServer.OutputStream,"outStream")
			'Sleep(50)
			outStream.Write(Buffer)
		Else
			Log("Wrong protocoll")
			client.Close
		End If
	Else
		' Connect
		' here can sniffer or modify a traffic
		Log("From client: " & Buffer.Length)
		outStream.Write(Buffer)
	End If
End Sub

Private Sub inStream_Terminated
	
End Sub

Private Sub inStream_Error
	
End Sub

private Sub outStream_NewData (Buffer() As Byte)
	' here can sniffer or modify a traffic
	Log("From server: " & Buffer.Length)
	inStream.Write(Buffer)
End Sub

Private Sub outStream_Terminated
	
End Sub

Private Sub outStream_Error
	
End Sub

Private Sub IndexOf(Data() As Byte,SearchData() As Byte) As Int
	For i = 0 To Data.Length - SearchData.Length
		If SearchData(0) = Data(i) Then
			For sindex = 0 To SearchData.Length - 1
				If SearchData(sindex) <> Data(i + sindex) Then
					Exit
				End If
			Next
			If sindex = SearchData.Length Then
				Return i
			End If
		End If
	Next
	Return -1
End Sub

Public Sub Modify(DataSource() As Byte,Index As Int, DataInsert() As Byte) As Byte()
	Dim Fn(DataSource.Length+DataInsert.Length-Index) As Byte
	
	Bit.ArrayCopy(DataInsert,0,Fn,0,DataInsert.Length)
	Bit.ArrayCopy(DataSource,Index,Fn,DataInsert.Length,DataSource.Length-Index)
	
	Return Fn
End Sub