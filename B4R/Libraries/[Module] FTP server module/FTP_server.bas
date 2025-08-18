B4R=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=1.00
@EndOfDesignText@

'version 1.00
private Sub Process_Globals
	Private astream As AsyncStreams
	Private astream2 As AsyncStreams
	Private astream3 As AsyncStreams
	Private const FTPPort As UInt = 21
	Private const PASVPort As UInt = 50009

	Private lfs As LittleFS
	Private lfs2 As LittleFS
	Private bc As ByteConverter
	Private wifi As ESP8266WiFi
	Private FTPserver As WiFiServerSocket
	Private PASVserver As WiFiServerSocket
	Private ACTIclient As WiFiSocket
	Private ACTIip() As Byte = Array As Byte(192, 168, 0, 6)
	Private ACTIport As UInt =5009
	Private ACTIconnected As Boolean = False
	Private ACTImode As Boolean = False
	Private TransfertMode = 0 As Byte '0=no transfert 1=RETR 2=STOR 3=NLST 4=LIST 5=MLSD
	Private PASVconnected As Boolean = False
	Private activity As Timer
	Public  trace As Boolean = False
	Private RNFR_OK As Boolean = False
	Private FTPtimeOUT As ULong = 300 * 1000 
	Private LOGtimeOUT As ULong = 20 * 1000
	Private CommandTimeOut As ULong = 5 * 1000
	Private TransfertTimeOut As ULong = 2 * 1000
	Private LOGOK As Boolean = False
	Private millisConnectTimeOUT As ULong
	Private millisCommandStart As ULong
	Private millisTransfertStart As ULong

'	Globalstore.Slot0 = temporary Lpath 
'	GlobalStore.Slot1 = Lpath 
'	GlobalStore.Slot2 = FTPuser
'	GlobalStore.Slot3 = FTPpass
End Sub

Public Sub FTPStart(FTPuser As String,FTPpass As String)
	GlobalStore.put(2,FTPuser):GlobalStore.put(3,FTPpass)
	l_log("FTPStart")
	activity.Initialize("ActivityCheck",100)
	activity.Enabled = True
	If Not(lfs.Initialize()) Then l_log("FS initialization error")
	If Not(lfs2.Initialize()) Then l_log("FS2 initialization error")
	FTPserver.Initialize(FTPPort, "FTP_NewConnection")
	FTPserver.Listen
	PASVserver.Initialize(PASVPort, "PASV_NewConnection")
	PASVserver.Listen
	If trace Then 
		Log("fs_Total size: ", NumberFormat(lfs.TotalSize / 1024, 0, 0), " KB")
		Log("fs_Used size: ", NumberFormat(lfs.UsedSize / 1024, 0, 0), " KB")
	End If	
End Sub

Private Sub FTP_NewConnection (NewSocket As WiFiSocket)
	PASVconnected = False:ACTIconnected = False
	l_log("Simple FTP - new connection")
	millisConnectTimeOUT = Millis+LOGtimeOUT
	millisCommandStart = 0
	LOGOK = False
	astream.Initialize(NewSocket.Stream, "FTP_NewData", "FTP_astream_Error")
	astream.WaitForMoreDataDelay = 50
	astream.Write("220--- Welcome to FTPserver for ESP8266/ESP32"):astream.Write(CRLF)
	astream.Write("220--- built with B4R ---".getbytes):astream.Write(CRLF)
	astream.Write("220 -- Version FTP-2021-05-05".getbytes):astream.Write(CRLF)
End Sub

Private Sub FTP_NewData (Buffer() As Byte)
	Dim command() As Byte = bc.Trim(bc.SubString2(Buffer,0,4))
	Dim parameter() As Byte = bc.Trim(bc.SubString(Buffer,4))
	TransfertMode = 0
	If trace Then 
		Log("command: ",command)
   		Log("parameter: ",parameter)
	End If	
	If Not(LOGOK) Then
	  millisConnectTimeOUT = Millis+LOGtimeOUT
	  Select bc.StringFromBytes(command)
		Case "OPTS"			'OPTS - UTF8 support
			astream.Write("502 OPTS: UTF8 not understood"):astream.Write(CRLF)
			astream.Write("USER"):astream.Write(CRLF)			
		Case "USER"
				If parameter = GlobalStore.Slot2 Then
				astream.Write("331 OK. Password required"):astream.Write(CRLF)
			Else
				astream.Write("530 user not found"):astream.Write(CRLF)
				FTPdisconnect
			End If							
		Case "PASS"
				If parameter = GlobalStore.Slot3  Then
				astream.Write("230 OK."):astream.Write(CRLF)
				timeOUT_UPD
				LOGOK = True
				GlobalStore.Put(1,"/")
			Else
				astream.Write("530 wrong password"):astream.Write(CRLF)
				FTPdisconnect
			End If
	  End Select	
	Else	
	    timeOUT_UPD                    
		Dim Lpath() As Byte = JoinBytes(Array(GlobalStore.Slot1,"/".getbytes,parameter))
		Select bc.StringFromBytes(command)
		
			Case "CDUP"			'CDUP - Change to Parent Directory
				Dim new() As Byte = bc.SubString2(GlobalStore.Slot1,0,bc.LastIndexOf(GlobalStore.Slot1,"/"))
				If new ="" Then new ="/"
				GlobalStore.Put(1, new)
				astream.Write("250 Ok. Current directory is "):astream.write(new):astream.Write(CRLF)
				
			Case "CWD"			'CWD - Change Working Directory
				Dim new() As Byte
				If parameter = "." Or parameter = "" Or parameter = "\" Then
'					astream.write( "257 Current directory is  / "):astream.Write(CRLF)
					new= "/".getbytes
				else if bc.IndexOf(parameter,"/") < 0 Then	
					If GlobalStore.Slot1 = "/" Then
						new=JoinBytes(Array(GlobalStore.slot1,parameter))
					Else	
						new=JoinBytes(Array(GlobalStore.slot1,"/".getbytes,parameter))
					End If
				Else
					new = ReplaceStr(parameter,"\","/")
				End If
				If lfs.Exists(bc.StringFromBytes(new)) Then GlobalStore.Put(1,new) 'checck if file/directory exists on server
				astream.Write("257 Current directory is  "):astream.write(GlobalStore.slot1):astream.Write(CRLF)
				
			Case "PWD"			'PWD - give curret Directory to client
				astream.Write("257 "):astream.Write(Lpath):astream.write(" is your current directory"):astream.Write(CRLF)
					
			Case "QUIT"
				FTPdisconnect
		
			Case "MODE"			'MODE - Transfer Mode
				If parameter = "S" Then
					astream.Write("200 S Ok"):astream.Write(CRLF)
				Else
					astream.Write("504 Only S(tream) is suported"):astream.Write(CRLF)
				End If
			
			Case "SYST"			'SIZE - Size of the file
				astream.Write("215 UNIX Type: L8"):astream.Write(CRLF)
			
			Case "FEAT"			'FEAT - New Features
				astream.Write("211-Extensions suported:"):astream.Write(CRLF)
				astream.Write(" MLSD"):astream.Write(CRLF)
				astream.Write("211 End."):astream.Write(CRLF)
			
			Case "TYPE"			'TYPE - Data Type
				If parameter = "A" Then
					astream.Write("200 TYPE is now ASII"):astream.Write(CRLF)
				Else if parameter = "I" Then
					astream.Write("200 TYPE is now 8-bit binary"):astream.Write(CRLF)
				Else 
					astream.Write("504 Unknow TYPE"):astream.Write(CRLF)
				End If		
				
			Case "PORT"			'new address + port of client to connect for data transfert	=> active mode accepted		
				parseIP(bc.StringFromBytes(parameter),",")
				astream.Write("200 PORT command successful"):astream.Write(CRLF)
				ACTImode=True					
				
			Case "PASV" 		'Passive mode reception of IP address + port for data transfert
				Dim tmp1 =PASVPort / 256 As Byte : Dim tmp2 =  PASVPort Mod 256 As Byte
				Dim tmp4 As String = JoinStrings(Array As String(",",tmp1,",",tmp2,")"))
				astream.Write("227 Entering Passive Mode ("):astream.Write(ReplaceStr(wifi.LocalIp,".",",")):astream.Write(tmp4):astream.Write(CRLF)	
					

			Case "MLSD"			'MLSD - Listing for Machine Processing (see RFC 3659) like Filezilla
				TransfertMode = 5	
				millisCommandStart = Millis
				If ACTImode Then CallSubPlus("ACTI_NewConnection",1,0)
				CallSubPlus("FTP_MLSD",5,0)
			
			Case "STRU"			'STRU - File Structure
				If parameter = "F" Then
					astream.write( "200 F Ok"):astream.Write(CRLF)
				Else
					astream.write( "504 Only F(ile) is suported"):astream.Write(CRLF)
				End If
		
			Case "TYPE"			'TYPE - Data Type
				If parameter = "A" Then 
					astream.write( "200 TYPE is now ASII"):astream.Write(CRLF)
				else if parameter = "I" Then
					astream.write( "200 TYPE is now 8-bit binary"):astream.Write(CRLF)
				Else
					astream.write( "504 Unknow TYPE"):astream.Write(CRLF)
				End If	
			
			Case "ABOR"			'ABOR - Abort
				If TransfertMode > 0  Then
					lfs.Close
					TransfertMode = 0
				End If	
				If PASVconnected Then PASVserver.Socket.close
				If ACTIconnected Then ACTIclient.Close
				astream.write( "426 Transfer aborted"  ):astream.Write(CRLF)
				l_log( "Transfer aborted!")
				PASVconnected =False : ACTIconnected = False
			
			Case "DELE"			'DELE - Delete a File
				If  parameter= "" Then 
					astream.write( "501 No file name"):astream.Write(CRLF)
				Else
					If lfs.Exists(bc.StringFromBytes(Lpath)) Then				
						If lfs.Remove(bc.StringFromBytes(Lpath)) Then
							l_log("file removed")
							astream.write( "250 Deleted "):astream.write(Lpath):astream.Write(CRLF)
						Else
							astream.write( "450 Can't delete "):astream.Write(CRLF)
						End If
					Else	
						astream.write( "550 File "):astream.write(Lpath):astream.write(" not found"):astream.Write(CRLF)
					End If		
				End If
					
			Case "LIST"			'LIST - List all files in a directory name + date + size
				TransfertMode = 4
				millisCommandStart = Millis
				If ACTImode Then CallSubPlus("ACTI_NewConnection",1,0)
				CallSubPlus("FTP_LIST",5,0)
		
			Case "NLST"			'NLST - Name List only
				TransfertMode = 3
				millisCommandStart = Millis
				If ACTImode Then CallSubPlus("ACTI_NewConnection",1,0)
				CallSubPlus("FTP_NLST",5,0)
			
			Case "NOOP"			'NOOP - 
				astream.write( "200 Zzz..."):astream.Write(CRLF)
		
			Case "RETR"			'RETR - Retrieve a file 
				If  parameter= "" Then
					astream.write( "501 No file name"):astream.Write(CRLF)	
				Else
					If Not(lfs.Exists(bc.StringFromBytes(Lpath))) Then
						astream.write( "550 File "):astream.write(Lpath):astream.write(" not found"):astream.Write(CRLF)
					Else
						If Not(lfs.OpenRead(bc.StringFromBytes(Lpath))) Then
							astream.write( "450 Can't open "):astream.write(parameter):astream.Write(CRLF)
						Else
							TransfertMode = 1
							millisCommandStart = Millis
							If ACTImode Then CallSubPlus("ACTI_NewConnection",1,0)
							CallSubPlus("FTP_RETR",5,0)
						End If
					End If
				End If	
					
			Case "REST"
				astream.Write("502 REST not supported "):astream.Write(CRLF)
			
			Case "STOR"			'STOR - Store a file in server
				If  parameter= "" Then
					astream.write( "501 No file name"):astream.Write(CRLF)
				else if parameter.Length > 31 Then
					astream.write( "501 Wrong file name"):astream.Write(CRLF)
				Else
					If lfs.Exists(bc.StringFromBytes(Lpath)) Then
						astream.write( "550 File "):astream.write(Lpath):astream.write(" already found"):astream.Write(CRLF)
					Else
						If Not(lfs.OpenReadWrite(bc.StringFromBytes(Lpath))) Then
							astream.write( "451 Can't open/create "):astream.write(Lpath):astream.Write(CRLF)
						Else
							TransfertMode = 2		'file reception
							l_log("run STOR")
							If ACTImode Then CallSubPlus("ACTI_NewConnection",1,0)				
							millisCommandStart = Millis
							CallSubPlus("FTP_STOR",5,0)
							'nothing more to do
						End If
					End If
				End If	
									
			Case "MKD","XMKD"		'MKD - Make Directory
				If  parameter= "" Then
					astream.write( "501 No DIR name"):astream.Write(CRLF)
				Else
					If Not(lfs.Exists(bc.StringFromBytes(Lpath))) Then
						If lfs.MKDir(bc.StringFromBytes(Lpath)) Then
							l_log("DIR created")
							astream.write( "257 Created DIR "):astream.write(Lpath):astream.Write(CRLF)
						Else
							astream.write( "450 Can't Create "):astream.Write(CRLF)
						End If
					Else
						astream.write( "550 DIR "):astream.write(Lpath):astream.write(" not found"):astream.Write(CRLF)
					End If
				End If

			Case "RMD","XRMD"		'RMD - Remove a Directory
				If  parameter= "" Then
					astream.write( "501 No DIR name"):astream.Write(CRLF)
				Else
					If lfs.Exists(bc.StringFromBytes(Lpath)) Then
						If lfs.RMDir(bc.StringFromBytes(Lpath)) Then
							l_log("DIR removed")
							astream.write( "250 Deleted "):astream.write(Lpath):astream.Write(CRLF)
						Else
							astream.write( "450 Can't delete "):astream.Write(CRLF)
						End If
					Else
						astream.write( "550 DIR "):astream.write(parameter):astream.write(" not found"):astream.Write(CRLF)
					End If
				End If
				
			Case "RNFR"		'RNFR - check if file to rename exists
				If parameter = "" Then
					astream.write( "501 No file name"):astream.Write(CRLF)
				Else
					If Not(lfs.Exists(bc.StringFromBytes(Lpath))) Then
						astream.write( "550 File "):astream.Write(Lpath):astream.Write(" not found"):astream.Write(CRLF)
					Else
						astream.write( "350 RNFR accepted - file exists, ready for destination"):astream.write(CRLF)
						RNFR_OK = True
						GlobalStore.Put(0,Lpath)
					End If	
				End If

			Case "RNTO"           'RNTO - Rename file
				If RNFR_OK = False Then
					astream.Write( "503 Need RNFR before RNTO"):astream.Write(CRLF)
				else If parameter = "" Then
					astream.write( "501 No file name"):astream.Write(CRLF)
				Else
					Dim tmn() As Byte = GlobalStore.Slot0
					If lfs.Exists(bc.StringFromBytes(Lpath)) Then
						astream.write( "553 File "):astream.Write(parameter):astream.Write(" already exists"):astream.Write(CRLF)
					Else
						astream.write( "Renaming "):astream.Write(tmn):astream.write( " to "):astream.Write(parameter):astream.write(CRLF)
						If lfs.Rename(bc.StringFromBytes(tmn),bc.StringFromBytes(Lpath)) Then
							astream.write( "250 File successfully renamed or moved"):astream.write(CRLF)
						Else
							astream.write( "451 Rename/move failure")
						End If
						RNFR_OK = False
					End If
				End If
 
			Case "FEAT"			'FEAT - New Features
				astream.write( "211-Extensions suported:"):astream.Write(CRLF)
				astream.write( " MLSD"):astream.Write(CRLF)
				astream.write( "211 End."):astream.Write(CRLF)
			
			Case "MDTM"			'MDTM - File Modification Time (see RFC 3659)
				astream.write("550 Unable to retrieve time"):astream.Write(CRLF)
			
			Case "SIZE"			'SIZE - Size of the file
				If  parameter= "" Then
					astream.write( "501 No file name"):astream.Write(CRLF)
				Else
					If Not(lfs.Exists(bc.StringFromBytes(Lpath))) Then
						astream.write( "550 File "):astream.write(parameter):astream.write(" not found"):astream.Write(CRLF)
					Else
						If lfs.OpenRead(bc.StringFromBytes(Lpath)) Then
							Dim size() As Byte = NumberFormat(lfs.CurrentFile.Size,1,0)
							astream.write( "213 "):astream.write(size):astream.Write(CRLF)
							lfs.close
						Else
							astream.write( "450 Can't open "):astream.Write(CRLF)
						End If
					End If
				End If
				
			Case "SITE"			'SITE - System command
				astream.write("500 Unknow SITE command "):astream.write(parameter):astream.write(CRLF)
		
			Case Else
				astream.Write("500 Unknow command"):astream.Write(CRLF)			
		End Select
'just for example of file append / can be removed
		If trace Then
			If lfs2.OpenAppend("/log/logfile.txt") Then
				Dim tnn() As Byte = JoinStrings(Array As String("command: ",bc.StringFromBytes(command)," + parameter: ",bc.StringFromBytes(parameter),CRLF) )
				lfs2.Stream.WriteBytes(tnn,0,tnn.Length)
				lfs2.close
			Else
				l_log("error to open logfile.txt")
			End If	
		End If
	End If
'end example	
	If trace Then Log("stack: ",StackBufferUsage)
End Sub

private Sub ACTI_NewConnection(tag As Byte)
	l_log("ACTI - new CLIENT connection")
	PASVconnected = False
	If ACTIclient.ConnectIP(ACTIip, ACTIport) Then
		l_log("ACTI client connected")
		astream3.Initialize(ACTIclient.Stream, "ACTI_NewData", "ACTI_astream_Error")
		astream3.WaitForMoreDataDelay = 50
		ACTIconnected = True
		millisTransfertStart = Millis
	Else
		If tag < 5 Then
			tag = tag +1
			CallSubPlus("ACTI_newConnection", 10, tag)
		Else
			astream.Write("501 Can't create ACTIVE connexion"):astream.Write(CRLF)
			l_log("error connexion ACTI client")
			ACTIconnected = False
		End If
	End If
End Sub

private Sub ACTI_NewData (Buffer() As Byte)
	If TransfertMode =2 Then
		millisTransfertStart = Millis
		If lfs.TotalSize - lfs.UsedSize > Buffer.Length Then
		    lfs.Stream.WriteBytes(Buffer, 0, Buffer.Length)
			millisTransfertStart = Millis
		Else
			l_log("fs overflow")
			ACTI_Astream_error
		End If		
	End If
End Sub

private Sub PASV_NewConnection(NewSocket As WiFiSocket)
	l_log("PASV - new connection to server")
	ACTIconnected = False
	astream2.Initialize(NewSocket.Stream,"PASV_NewData","PASV_astream_Error")
	astream2.WaitForMoreDataDelay = 50
	PASVconnected = True
End Sub

private Sub PASV_NewData (Buffer() As Byte)
	If TransfertMode =2 Then
		millisTransfertStart = Millis
		If lfs.TotalSize - lfs.UsedSize > Buffer.Length Then
			lfs.Stream.WriteBytes(Buffer, 0, Buffer.Length)
			millisTransfertStart = Millis
		Else
			l_log("fs overflow")
			PASV_Astream_Error
		End If
	End If
End Sub	

private Sub FTP_STOR(tag As Byte) 		'FTPaction 2
	l_log("run STOR")
	If PASVconnected = False And ACTIconnected = False And tag<10 Then
		tag = tag + 1
		CallSubPlus("FTP_STOR",5,tag)
	Else If tag >= 10 Then
		astream.Write("425 No data connection"):astream.Write(CRLF)
		millisTransfertStart = 1
	Else
		millisCommandStart = 0:	millisTransfertStart = Millis
		astream.Write( "150 Port Connected "):astream.Write(CRLF)
	End If
End Sub

private Sub FTP_RETR(tag As Byte)	'FTPaction 1
	l_log("run RETR")
	If PASVconnected = False And ACTIconnected = False And tag<10 Then
		tag = tag + 1
		CallSubPlus("FTP_RETR",5,tag)
	Else If tag >= 10 Then
		astream.Write("425 No data connection"):astream.Write(CRLF)
		millisTransfertStart = 1
	Else
		millisCommandStart = 0:	millisTransfertStart = Millis
		Dim size() As Byte = NumberFormat(lfs.CurrentFile.size,1,0)
		astream.Write( "150 "):astream.Write(size):astream.Write(" bytes To download"):astream.Write(CRLF)
		Dim success As Boolean = True
		Dim counter As ULong = 0
		Dim b(1024) As  Byte
		Do While counter < lfs.CurrentFile.Size
			Dim read As Int = lfs.Stream.ReadBytes(b, 0, Min(b.Length, lfs.CurrentFile.Size - counter))
			If read = 0 Then
				success = False
				l_log("error read")
				Exit
			End If
			counter = counter + read
			If PASVconnected Then
				astream2.Write2(b, 0, read)
			Else
				astream3.Write2(b, 0, read)
			End If
			millisTransfertStart = Millis
		Loop
		lfs.Close
		l_log("0 byte => lfs.closure")
		TransfertMode = 0
		If PASVconnected Then  PASVserver.Socket.Close
		If ACTIconnected Then ACTIclient.Close
		ACTImode = False
		Dim count() As Byte =NumberFormat(counter,1,0)
		If success = True Then
			l_log("transfert OK")
			astream.write( "226 File successfully transferred"):astream.write(CRLF)
			astream.write("226 "):astream.write(count):astream.write("(bytesTransfered"):astream.write(CRLF)			
		Else
			l_log("erreur transfert")
			astream.write( "426 Transfer aborted  "):astream.write(count):astream.write("bytes transfered"):astream.write(CRLF)
		End If
		millisTransfertStart = 0
	End If	
End Sub			

private Sub FTP_NLST(tag As Byte)	'FTPaction 3
	l_log("run NLST")
	If PASVconnected = False And ACTIconnected = False And tag<10 Then
		tag = tag + 1
		CallSubPlus("FTP_NLST",5,tag)
	Else If tag >= 10 Then
		astream.Write("425 No data connection"):astream.Write(CRLF)
		millisTransfertStart = 1
	Else
		millisCommandStart = 0:	millisTransfertStart = Millis
		astream.Write( "150 Port Connected "):astream.Write(CRLF)
		Dim nm = 0 As Byte
		For Each f As File In lfs.ListFiles(bc.StringFromBytes(GlobalStore.Slot1)) '"/")
			FTP_NLST_SEND(f)
			nm = nm +1
			millisTransfertStart = Millis
		Next
		Dim nms As String = nm
		astream.Write( "226 "):astream.Write(nms):astream.Write(" matches total"):astream.Write(CRLF)	
		millisTransfertStart = 0
		If PASVconnected Then PASVserver.Socket.close
		If ACTIconnected Then ACTIclient.Close
		ACTImode = False
	End If	
End Sub

private Sub FTP_NLST_SEND(f As File)
	
	If PASVconnected Then
		astream2.Write("  "):astream2.Write(f.name):astream2.Write(CRLF)
	Else
		astream3.Write("  "):astream3.Write(f.name):astream3.Write(CRLF)
	End If
	If trace Then Log("name: ",f.name)
End Sub

private Sub FTP_LIST(tag As Byte)	'FTPaction 4
	l_log("run LIST")
	If PASVconnected = False And ACTIconnected = False And tag<10 Then
		tag = tag + 1
		CallSubPlus("FTP_NLST",5,tag)
	Else If tag >= 10 Then
		astream.Write("425 No data connection"):astream.Write(CRLF)
		millisTransfertStart = 1
	Else
		millisCommandStart = 0:	millisTransfertStart = Millis
		astream.Write( "150 Port Connected "):astream.Write(CRLF)
		Dim nm = 0 As Byte	
		For Each f As File In lfs.ListFiles(bc.StringFromBytes(GlobalStore.Slot1)) '"/")
			FTP_LIST_SEND(f)
			nm = nm +1
			millisTransfertStart = Millis
		Next
		Dim nms As String = nm
		astream.Write( "226 "):astream.Write(nms):astream.Write(" matches total"):astream.Write(CRLF)
		millisTransfertStart = 0
		If PASVconnected Then PASVserver.Socket.close
		If ACTIconnected Then ACTIclient.Close
		ACTImode = False
	End If	
End Sub

private Sub FTP_LIST_SEND(f As File)
	Dim fsize() As Byte: Dim fname() As Byte
	fsize =JoinBytes(Array(NumberFormat(f.size,1,0).getbytes,"             ".getbytes))
	fname = f.name
	If PASVconnected Then
		If f.isdirectory Then
			astream2.write("  "):astream2.Write("            "):astream2.Write("                     "):astream2.Write(fname):astream2.Write(CRLF)
		Else
			astream2.write("  "):astream2.Write(bc.substring2(fsize,0,12)):astream2.Write("01/01/2000 16:06:56  "):astream2.Write(fname):astream2.Write(CRLF)
		End If	
	Else
		If f.isdirectory Then
			astream3.write("  "):astream3.Write("            "):astream3.Write("                     "):astream3.Write(fname):astream3.Write(CRLF)
		Else
			astream3.write("  "):astream3.Write(bc.substring2(fsize,0,12)):astream3.Write("01/01/2000 16:06:56  "):astream3.Write(fname):astream3.Write(CRLF)
		End If
	End If	
	If trace Then Log(fname,"       ",fsize)
End Sub

private Sub FTP_MLSD(tag As Byte)	'FTPaction 5
	l_log("run MLSD")	
	If PASVconnected = False And ACTIconnected= False And tag<10 Then
		tag = tag + 1
		CallSubPlus("FTP_MLSD",5,tag)
	Else If tag >= 10 Then
		astream.Write("425 No data connection"):astream.Write(CRLF)
		millisTransfertStart = 1
	Else
		millisCommandStart = 0:	millisTransfertStart = Millis 
		astream.Write( "150 Port Connected "):astream.Write(CRLF)
	 	Dim nm = 0 As Byte
'		Log("MLSD ",bc.StringFromBytes(GlobalStore.Slot1)," - ","/")
		For Each f As File In lfs.ListFiles(bc.StringFromBytes(GlobalStore.Slot1))
			FTP_MLSD_send(f)
			nm = nm +1
			millisTransfertStart = Millis
		Next
		astream.Write("226 -options: -a -l"):astream.Write(CRLF)
		Dim nms As String = nm
		astream.Write( "226 "):astream.Write(nms):astream.Write(" matches total"):astream.Write(CRLF)
		millisTransfertStart = 0
		If PASVconnected Then PASVserver.Socket.close
		If ACTIconnected Then ACTIclient.Close
		ACTImode = False
	End If	
End Sub

private Sub FTP_MLSD_send(f As File)
 Dim size() As Byte = NumberFormat(f.size,1,0)
	If PASVconnected Then
		If f.isdirectory Then
			astream2.Write("Type=dir;modify=20000101160656; "):	astream2.Write(f.name):astream2.Write(CRLF)
		Else
			astream2.Write("Type=file;Size="):astream2.Write(size):astream2.Write(";modify=20000101160656; ")
			astream2.Write(f.name):astream2.Write(CRLF)				
		End If

	Else
		If f.isdirectory Then
			astream3.Write("Type=dir;modify=20000101160656; "):	astream3.Write(f.name):astream3.Write(CRLF)
		Else	
			astream3.Write("Type=file;Size="):astream3.Write(size):astream3.Write(";modify=20000101160656; ")
			astream3.Write(f.name):astream3.Write(CRLF)
		
		End If
	End If
	If f.isdirectory Then
		If trace Then Log("Type=dir;modify=20000101160656; ",f.name,CRLF)
	Else
		If trace Then Log("Type=file;Size=",size,"; modify=20000101160656; ",f.name,CRLF)
	End If
End Sub

private Sub FTPdisconnect
	astream.Write("221 Goodbye"):astream.Write(CRLF)
	FTPserver.Socket.Close
	LOGOK=False
	millisCommandStart = 0
	millisConnectTimeOUT = 0
	FTPserver.Listen
End Sub

private Sub timeOUT_UPD
	millisConnectTimeOUT = Millis+ FTPtimeOUT
End Sub

private Sub activityCheck
	If FTPserver.Socket.Connected Then
		Dim milli = Millis As ULong
		If (millisConnectTimeOUT>0) And (milli > millisConnectTimeOUT) Then	'check activity time out
			l_log("inactivity FTP timeOUT")'
			millisConnectTimeOUT = 0
			FTPdisconnect
		else if (millisCommandStart >0) And (milli > millisCommandStart+CommandTimeOut) Then
		    l_log("Command timeOUT")
			FTPdisconnect
		else if ACTIconnected And (millisTransfertStart >0) And ( milli > (millisTransfertStart + TransfertTimeOut)) Then
			l_log("timeOUT during transmission ACTIVE mode")
			PASV_Astream_Error
		else If PASVconnected And (millisTransfertStart >0) And (milli > (millisTransfertStart + TransfertTimeOut)) Then  
			l_log("timeOUT during transmission PASSIVE mode")
			PASV_Astream_Error	
		End If
	End If
	
	
End Sub

private Sub FTP_Astream_Error
	l_log("FTP Server Closed")
	millisCommandStart = 0:	millisTransfertStart = 0
	FTPserver.Socket.close
	LOGOK=False
	FTPserver.Listen
	
End Sub

private Sub PASV_Astream_Error
	l_log("PASV Server Closed")
	millisCommandStart = 0:	millisTransfertStart = 0
	Select TransfertMode
	Case 1 		'RETR
		l_log("error RETR")
	Case 2 		 'STOR
		If trace Then Log("Stored file size: ", lfs.CurrentFile.Size)
		astream.write( "226 File successfully transferred"):astream.Write(CRLF)
	End Select
	TransfertMode = 0
	lfs.close	
	PASVconnected = False

	PASVserver.Socket.close
	PASVserver.Listen
End Sub

private Sub ACTI_Astream_error
	l_log("ACTI Client Closed")
	millisCommandStart = 0:	millisTransfertStart = 0
	Select TransfertMode
		Case 1 		'RETR
			l_log("error RETR")
		Case 2 		 'STOR
			If trace Then Log("Stored file size: ", lfs.CurrentFile.Size)
			astream.write( "226 File successfully transferred"):astream.Write(CRLF)
	End Select
	TransfertMode = 0
	lfs.close
	ACTIclient.close	
	ACTIconnected = False
	ACTImode = False
End Sub

private Sub ReplaceStr(Original() As Byte, SearchFor() As Byte, ReplaceWith() As Byte) As Byte()
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

Private Sub parseIP(IPstring As String,delimit As String)
	Dim i As UInt = 0
	For Each b As Byte In ACTIip
		ACTIip(i) = 0
		i=i+1
	Next
	i=0
	For Each s() As Byte In bc.Split(IPstring, delimit)
		If i<4 Then
			ACTIip(i) = bc.StringFromBytes(s) 'bytes cannot be converted to numbers directly
		Else if i=4 Then
			ACTIport = 	(bc.StringFromBytes(s)) * 256
		Else
			ACTIport = ACTIport + bc.StringFromBytes(s)
		End If
		i = i + 1
	Next
End Sub

private Sub l_log(txt As String)
	If trace Then Log(txt)
End Sub