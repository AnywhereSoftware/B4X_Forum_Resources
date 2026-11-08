B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=2
@EndOfDesignText@

Sub Process_Globals
	Private Astream As AsyncStreams	
'	Astream.WaitForMoreDataDelay = 100
	Astream.MaxBufferSize = 500
	Private server As WiFiServerSocket
	Private bc As ByteConverter
	Private sr As B4RSerializator
End Sub

Public Sub Start
	If Not(Main.WiFi.IsConnected) Then		
 		Log("StartAP: ", Main.WiFi.StartAccessPoint("esp"))
		Log("My AP ip: ", Main.WiFi.AccessPointIp)
	End If

	server.Initialize(80, "server_NewConnection")
	server.Listen	  
End Sub

Private Sub Server_NewConnection (NewSocket As WiFiSocket) 
	Log("new connexion", NewSocket.RemoteIp)
	Dim ObjectsBuffer(16) As Object
	Dim SSID, PASS As String
	Dim datas() As Byte = Main.GetStoredData
		Dim ObjectsBuffer(2) As Object
		Dim Objects() As Object = sr.ConvertBytesToArray(datas, ObjectsBuffer)
		SSID = bc.StringFromBytes(Objects(0))
		PASS = bc.StringFromBytes(Objects(1))
'		Log("start server memory=", AvailableRAM)
'		Log("stack :",StackBufferUsage)
		Astream.Initialize(NewSocket.Stream, "astream_NewData", "astream_Error")
		Astream.Write("<html lang=""en"" class="" "">")
		Astream.Write(  "<head>")
		Astream.Write("    <meta charset='utf-8'><meta name=""viewport"" content=""width=device-width,initial-scale=1,user-scalable=no""/>")
		Astream.Write("    <style>div,fieldset,input,select{padding:5px;font-size:1em;}fieldset{background:#4f4f4f;}p{margin:0.5em 0;}input{width:100%;box-sizing:border-box;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;background:#dddddd;color:#000000;}input[type=checkbox],input[type=radio]{width:1em;margin-right:6px;vertical-align:-1px;}input[type=range]{width:99%;}select{width:100%;background:#dddddd;color:#000000;}textarea{resize:none;width:98%;height:318px;padding:5px;overflow:auto;background:#1f1f1f;color:#65c115;}body{text-align:center;font-family:verdana,sans-serif;background:#252525;}td{padding:0px;}button{border:0;border-radius:0.3rem;background:#1fa3ec;color:#faffff;line-height:2.4rem;font-size:1.2rem;width:100%;-webkit-transition-duration:0.4s;transition-duration:0.4s;cursor:pointer;}button:hover{background:#0e70a4;}.bred{background:#d43535;}.bred:hover{background:#931f1f;}.bgrn{background:#47c266;}.bgrn:hover{background:#5aaf6f;}a{color:#1fa3ec;text-decoration:none;}.p{float:left;text-align:left;}.q{float:right;text-align:right;}.r{border-radius:0.3em;padding:2px;margin:6px 2px;}</style>")
		Astream.Write("  </head>")
		Astream.Write("  <body>")
		Astream.Write("    <div style='text-align:left;display:inline-block;color:#eaeaea;min-width:340px;'>")
		Astream.Write("    <div style='text-align:center;color:#eaeaea;'>")
		Astream.Write("      <h3>ESP8266 ESP-12F Module</h3>")
		Astream.Write("    </div>")
		Astream.Write("  <fieldset>")
		Astream.Write(" <form action='save' method='get'>")
		Astream.Write(" <div><label For='_nwk'>SSID</label><br><input name='_nwk' id='_nwk' value='").write(SSID).write("'></div>")
		Astream.Write(" <div><label For='_key'>SSID Key</label><br><input name='_key' id='_key' value='").write(PASS).write("'></div>")
'		Astream.Write("	<div><label> automatic reset after 5mn </label></div>")
		Astream.Write("	<div><br><button name='_save'>Save</button></div>")
		Astream.Write("	</form>")
		Astream.Write("<form action='_abort' method='get'>")
	    Astream.Write("<div><button  name='_clear'   >Clear eeprom</button></div>")
		Astream.Write("<div><br><button  name='_reset'   >Reset esp</button></div>")
		Astream.Write("</form>")
		Astream.Write("<button onclick=""location.href='/';"">Reload data</button>")
		Astream.Write("</fieldset>")
		Astream.Write(" </body>")
		Astream.Write("</html>")
End	Sub

Private Sub Astream_NewData (Buffer() As Byte)
'	Log("Astream NewData startB1======>",Buffer,"<======endB1")
	CallSubPlus("CloseConnection",250,0)
	'extract active part of message
    If bc.IndexOf(Buffer,"Connection:".GetBytes) > -1 Then
    	Dim buff() As Byte = bc.SubString2(Buffer,0,bc.IndexOf(Buffer,"Connection:".GetBytes))
	Else
	    Dim buff() As Byte
	End If 		
'	Log("Astream NewData startB2======",buff,"======endB2")
		If bc.IndexOf(buff, "save?_nwk=") <> -1 Then	
			Log("====> save?_nwk=")
			Dim init(2) As Object
 			Dim pt1,pt2 As Int			 
			Dim nb As Int = 0
			Dim nkay() As String = Array As String("&_key=","&_save=")
			pt1 = bc.IndexOf(buff, "save?_nwk=")+10
			
			For Each n As String In nkay
'				Log("stack=",StackBufferUsage)
'				Log("pt1=",pt1)
				pt2 = bc.IndexOf(buff, n)
'				Log("pt2=",pt2)
				Dim temp1() As Byte =bc.substring2(buff,pt1,pt2)
			    	temp1 = ReplaceString(temp1,"+".getbytes,"%20".getbytes)  'recovery of Space
					temp1 = convertunicode(temp1)							
				bc.ObjectSet(temp1, init(nb))
'				Log("value nb=",nb," ",init(nb))
				pt1 = pt2+6		
				nb = nb +1
'				Log("nb=",nb)
			Next
			Main.SaveNetworkDetails(sr.ConvertArrayToBytes(init))
    	Else
    		If bc.IndexOf(buff, "/_abort?_reset=") <> -1 Then
				Log("====> Reset esp")
				Main.esp_reset(0)	
			Else
				If bc.IndexOf(buff, "/_abort?_clear=") <> -1 Then
				Log("====> clear eeprow")
				Main.ClearStoredDataLength
			End If
     	End If
	End If	

End Sub

Private Sub CloseConnection(u As Byte)
'	Log("close web server connection")
	If server.Socket.Connected Then
		server.Socket.Stream.Flush
		server.Socket.Close		
	End If
End Sub

Private Sub AStream_Error
'	Log("web server Disconnected")
	server.Socket.Close
	server.Listen
End Sub

Sub convertunicode(var() As Byte) As Byte()
    Dim char() As Byte = Array As Byte(37)   '%
	Dim indx As Int : Dim unicode() As Byte
'	Log("var AV ",var)
	indx = bc.IndexOf(var,char)
'	Log("indx= ",indx)
	Do While indx > -1
		unicode = bc.SubString2(var,indx+1,indx+3)
'		Log("unicode AV ",unicode)
		unicode = Unitochar(unicode)
'		Log("unicode AP ",unicode)
		var = JoinBytes(Array(bc.SubString2(var,0,indx),unicode,bc.SubString2(var,indx+3,var.length)))
'		Log("var AP ",var)
		indx = bc.IndexOf(var,char)
'		Log("indx= ",indx)
	Loop
	Return var
End Sub

private Sub Unitochar(hex() As Byte) As Byte()
	Dim hexS As String = bc.StringFromBytes(hex)
	Dim z As Byte = Bit.ParseInt(hexS,16)
	Return Array As Byte(z)
End Sub

Private Sub ReplaceString(Original() As Byte, SearchFor() As Byte, ReplaceWith() As Byte) As Byte()
	'count number of occurrences
	Dim bc2 As ByteConverter
	Dim c As Int = 0
	Dim i As Int
	If SearchFor.Length <> ReplaceWith.Length Then
		i = bc2.IndexOf(Original, SearchFor)
		Do While i > -1
			c = c + 1
			i = bc2.IndexOf2(Original, SearchFor, i + SearchFor.Length)
		Loop
	End If
	Dim result(Original.Length + c * (ReplaceWith.Length - SearchFor.Length)) As Byte
	Dim prevIndex As Int = 0
	Dim targetIndex As Int = 0
	i = bc2.IndexOf(Original, SearchFor)
	Do While i > -1
		bc2.ArrayCopy2(Original, prevIndex, result, targetIndex, i - prevIndex)
		targetIndex = targetIndex + i - prevIndex
		bc2.ArrayCopy2(ReplaceWith, 0, result, targetIndex, ReplaceWith.Length)
		targetIndex = targetIndex + ReplaceWith.Length
		prevIndex = i + SearchFor.Length
		i = bc2.IndexOf2(Original, SearchFor, prevIndex)
	Loop
	If prevIndex < Original.Length Then
		bc2.ArrayCopy2(Original, prevIndex, result, targetIndex, Original.Length - prevIndex)
	End If
	Return result
End Sub