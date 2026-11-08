B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=2
@EndOfDesignText@

Sub Process_Globals
	Private Astream As AsyncStreams	
'	Astream.WaitForMoreDataDelay = 100
	Astream.MaxBufferSize = 1000
	Private server As WiFiServerSocket
	Private bc As ByteConverter
	Private sr As B4RSerializator
	Public WiFi As ESP8266WiFi
End Sub

Public Sub Start
	Log("Starte AP: ", Main.WiFi.StartAccessPoint2("Placa_Controle","12345678"))
	Log("Meu IP AP: ", Main.WiFi.AccessPointIp)
	'Log("Meu IP Local: ", Main.WiFi.LocalIp)
	server.Initialize(80, "server_NewConnection")
	server.Listen
	'scanNetworks
End Sub

'Private Sub scanNetworks
'	Dim numberofnetwork As Byte = wifi.Scan
'	Log( "Redes. ",numberofnetwork)
'	For i = 0 To numberofnetwork - 1
'		Log(wifi.ScannedSSID(i))
'	Next
'End Sub


Private Sub Server_NewConnection (NewSocket As WiFiSocket)
	
	Astream.Initialize(NewSocket.Stream, "astream_NewData", "astream_Error")
	Astream.Write("<html lang=""en"" class="" "">")
	Astream.Write(  "<head>")
	Astream.Write("    <meta charset='utf-8'><meta name=""viewport"" content=""width=device-width,initial-scale=1,user-scalable=no""/>")
	Astream.Write("    <style>div,fieldset,input,select{padding:5px;font-size:1em;}fieldset{background:#4f4f4f;}p{margin:0.5em 0;}input{width:100%;box-sizing:border-box;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;background:#dddddd;color:#000000;}input[type=checkbox],input[type=radio]{width:1em;margin-right:6px;vertical-align:-1px;}input[type=range]{width:99%;}select{width:100%;background:#dddddd;color:#000000;}textarea{resize:none;width:98%;height:318px;padding:5px;overflow:auto;background:#1f1f1f;color:#65c115;}body{text-align:center;font-family:verdana,sans-serif;background:#252525;}td{padding:0px;}button{border:0;border-radius:0.3rem;background:#1fa3ec;color:#faffff;line-height:2.4rem;font-size:1.2rem;width:100%;-webkit-transition-duration:0.4s;transition-duration:0.4s;cursor:pointer;}button:hover{background:#0e70a4;}.bred{background:#d43535;}.bred:hover{background:#931f1f;}.bgrn{background:#47c266;}.bgrn:hover{background:#5aaf6f;}a{color:#1fa3ec;text-decoration:none;}.p{float:left;text-align:left;}.q{float:right;text-align:right;}.r{border-radius:0.3em;padding:2px;margin:6px 2px;}</style>")
	Astream.Write("  </head>")
	Astream.Write("  <body>")
	Astream.Write("    <div style='text-align:left;display:inline-block;color:#eaeaea;min-width:340px;'>")
	Astream.Write("    <div style='text-align:center;color:#eaeaea;'>")
	
	Dim numberofnetwork As Byte = WiFi.Scan
	For i = 0 To numberofnetwork - 1
		Astream.Write(" <div style='text-align:left;color:#0000FF;'>")
		Astream.Write("Rede: ").Write(Main.wifi.ScannedSSID(i)).Write("")
		Astream.Write("</div>")
	Next
	
	'	Astream.Write("ESP8266 IP address: ").Write(Main.WiFi.LocalIp)
 
	Astream.Write(" <h3>ESP8266 ESP-12F Modulo</h3>")
	Astream.Write(" </div>")
	Astream.Write(" <fieldset>")
	Astream.Write(" <form action='save' method='get'>")
    Astream.Write(" <div><label For='_nwk'>SSID:</label><br><input name='_nwk' id='_nwk' value='").write(bc.StringFromBytes(GStore1.slot0)).write("'></div>")
	Astream.Write(" <div><label For='_key'>SSID Key:</label><br><input name='_key' id='_key' value='").write(bc.StringFromBytes(GStore1.slot1)).write("'></div>")
	Astream.Write(" <div><label For='_mth'>MQTT Urlm:</label><br><input name='_mth' id='_mth' value='").write(bc.StringFromBytes(GStore1.slot2)).write("'></div>")
	Astream.Write(" <div><label For='_mtp'>MQTT Porta:</label><br><input name='_mtp' id='_mtp' value='").write(bc.StringFromBytes(GStore1.slot3)).write("'></div>")
	Astream.Write(" <div><label For='_mtc'>MQTT ClientID:</label><br><input name='_mtc' id='_mtc' value='").write(bc.StringFromBytes(GStore1.slot4)).write("'></div>")
	Astream.Write(" <div><label For='_mtu'>MQTT Nome:</label><br><input name='_mtu' id='_mtu' value='").write(bc.StringFromBytes(GStore1.slot5)).write("'></div>")
	Astream.Write(" <div><label For='_mtk'>MQTT Senha:</label><br><input name='_mtk' id='_mtk' value='").write(bc.StringFromBytes(GStore1.slot6)).write("'></div>")
	'Astream.Write(" <div><label For='_rf6'>Key6 (Rcode, Ecode, protocol, nb bits, delay)</label><br><input name='_rf6' id='_rf6' value='").write(bc.StringFromBytes(GStore1.slot7)).write("'></div>")
	Astream.Write("	<div><br><button name='_save'>Salvar</button></div>")
	Astream.Write("	</form>")
	Astream.Write(" <form action='_abort' method='get'>")
	Astream.Write(" <div><button onclick=""location.href='/';"" name='_clear'>Apagar</button></div>")
	Astream.Write(" </fieldset>")
	Astream.Write(" </body>")
	Astream.Write(" </html>")	
   ' Astream.Write("CESAR").Write(bc.StringFromBytes(GStore1.slot7))
End Sub

Private Sub Astream_NewData (Buffer() As Byte)
	''Log("Astream NewData startB=",Buffer,"=endB")
	Log("Astream NewData startB=",Buffer)
	If bc.IndexOf(Buffer, "save?_nwk=") <> -1 Then	
		Dim init(8) As Object
 		Dim Pt1,Pt2 As Int
		Dim nb As Int = 0
		Dim nkay() As String = Array As String("&_key=","&_mth=","&_mtp=","&_mtc=","&_mtu=","&_mtk=","&_save=")
		Pt1 = bc.IndexOf(Buffer, "save?_nwk=")+10
		For Each n As String In nkay
			Pt2 = bc.IndexOf(Buffer, n)
			Dim temp1() As Byte =bc.substring2(Buffer,Pt1,Pt2)
			temp1 = ReplaceString(temp1,"+".getbytes,"%20".getbytes)  'recovery of Space
			temp1 = convertunicode(temp1)
			bc.ObjectSet(temp1,init(nb))
			Log("Valor Nb= ",init(nb))
			Pt1 = Pt2+6		
			nb = nb+1
		Next
		CloseConnection(0)
		For Each o As Object In init
			Log("Html= ",o)
		Next
		Log("Htmldata:",sr.ConvertArrayToBytes(init))
	    Main.SaveNetworkDetails(sr.ConvertArrayToBytes(init))
		CloseConnection(0)
    Else
		If bc.IndexOf(Buffer, "/_abort?_abort=") <> -1 Then
			Log("====> abort input")
			CloseConnection(0)
		Else
			If bc.IndexOf(Buffer, "/_abort?_clear=") <> -1 Then
			Log("====> clear eeprow")
			Main.ClearStoredDataLength
			End If
			CloseConnection(9)
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


