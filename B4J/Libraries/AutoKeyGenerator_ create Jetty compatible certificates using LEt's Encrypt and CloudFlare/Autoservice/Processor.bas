B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
Sub Class_Globals
	Type Arguments (isRenew As Boolean, configFileLocation As String, errorMessage As String)
	Private pLogger As Logger
	Private pConfig As config
	Private pArgs As Arguments
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (args() As String)
	pArgs = ParseArgs (args)
	
	If pArgs.errorMessage <> "" Then
		DisplayInfo
		Log (" ")
		Log ("Error: " & pArgs.errormessage)
		ExitApplication
	End If
		
	pConfig.Initialize(pArgs.configFileLocation)
	
	'If config file does not exist -> create template
	If Not (File.Exists (File.GetFileParent(pArgs.configFileLocation), File.GetName(pArgs.configFileLocation))) Then
		pConfig.CreateConfig	
		Log ("Config file template created. EXITING. Update the config file and restart.")
		ExitApplication
	End If
	
	'Config file was ok -> create logger
	pConfig.ParseFile
	pLogger.Initialize(pConfig.logfile)
End Sub



public Sub Process
	Dim stepsToExecute As String

	If pArgs.isRenew Then
		pLogger.Write ("STARTED: renew")
		stepsToExecute =  "FGHIJKL"
	Else
		pLogger.Write ("STARTED: create")
		stepsToExecute = "ABCDEFGHIJKL"
	End If
		
	If stepsToExecute.Contains ("A") Then 
		Wait For (A_CreateUserAccountKey) Complete (success As Boolean)
	End If

	If stepsToExecute.Contains ("B") Then 
		Wait for (B_CreatePrivateDomainKey) Complete (success As Boolean)
	End If

	If stepsToExecute.Contains ("C") Then C_CreateSSLConfig

	If stepsToExecute.Contains ("D") Then
		Wait for (D_CreateCSR) Complete (success As Boolean)
	End If

	If stepsToExecute.Contains ("E") Then
		Wait for (E_RegisterCAAccount) Complete (success As Boolean)
	End If

	If stepsToExecute.Contains ("F") Then F_Clean

	If stepsToExecute.Contains ("G") Then
		Wait for (G_DownloadChallenges) Complete (success As Boolean)
	End If

	If stepsToExecute.Contains ("H") Then
		Wait for (H_UploadChallenges) Complete (success As Boolean)
		pLogger.Write ("Sleeping for 20 seconds")
		Sleep(20000)
	End If
	

	If stepsToExecute.Contains ("I") Then
		Wait for (I_VerifyChallenges) Complete (success As Boolean)
	End If

	If stepsToExecute.Contains ("J") Then
		Wait for (J_DownloadCertificates) Complete (success As Boolean)
	End If
	
	If stepsToExecute.Contains ("K") Then
		Wait for (K_ConvertIntoP12) Complete (success As Boolean)
	End If

	If stepsToExecute.Contains ("L") Then
		Wait for (L_ConvertIntoJKS) Complete (success As Boolean)
	End If

	pLogger.Write ("ENDED")
	ExitApplication
End Sub


#region Steps

private Sub A_CreateUserAccountKey As ResumableSub
	LogStart ("CreateUserAccountKey (A)")
	ExecuteCommand(pConfig.OpenSSL, Array As String ("genrsa", "-out", pConfig.keyFile ("account.key"), "2048"), "")
	Wait for shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	LogEnd ("CreateUserAccountKey (A)", Success, "")
	Return Success
End Sub

private Sub B_CreatePrivateDomainKey As ResumableSub
	LogStart ("CreatePrivateDomainKey (B)")
	ExecuteCommand(pConfig.OpenSSL, Array As String ("genrsa", "-out", pConfig.keyFile (pConfig.domain & ".key"), "2048"), "")
	Wait for shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	LogEnd ("CreatePrivateDomainKey (B)", Success, "")
	Return Success
End Sub

private Sub C_CreateSSLConfig 
	Try
		LogStart ("CreateSSLConfig (C)")
		Dim cnf As String = File.ReadString(File.DirAssets, "openssl.cnf")

		Dim lcv As Int, sb As StringBuilder
		sb.Initialize
		
		Dim alternatives() As String = pConfig.alternatives
		For lcv = 0 To alternatives.Length - 1
			sb.Append ("DNS." & (lcv + 1) & " = " & alternatives(lcv) & Chr(13) & Chr(10))
		Next
		
		cnf = cnf.Replace("<alternatives>", sb.ToString)
		Dim fn As String = pConfig.keyFile("openssl.cnf")
		File.WriteString(File.GetFileParent(fn), File.GetName(fn), cnf)

		LogEnd ("CreateSSLConfig (C)", True, "")
	Catch
		LogEnd ("CreateSSLConfig (C)", False, LastException.Message)
	End Try
End Sub

private Sub D_CreateCSR As ResumableSub
	LogStart ("CreateCSR (D)")
	ExecuteCommand(pConfig.OpenSSL, Array As String ("req", "-config", pConfig.keyFile("openssl.cnf"), "-new", "-key", pConfig.keyfile (pConfig.domain & ".key"), _
			  "-sha256", "-nodes", "-subj", """/C=" & pConfig.certificate_c & "/ST=" & pConfig.certificate_st & "/L=" & pConfig.certificate_l & "/O=" & pConfig.certificate_O & _
			  "/OU=" & pConfig.certificate_ou & "/CN=" & pConfig.domain & "/emailAddress=" & pConfig.email & """", _
			  "-outform", "PEM", "-out", pConfig.keyFile(pConfig.domain & ".csr")), "")
	Wait for shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	LogEnd ("CreateCSR (D)", Success, "")
	Return Success
End Sub

private Sub E_RegisterCAAccount As ResumableSub
	LogStart ("RegisterCAAccount (E)")
	ExecuteCommand(pConfig.java, Array As String ("-jar" , pConfig.acme_client, "--command", "register", "-a", pConfig.keyFile("account.key"), "--with-agreement-update", "--email", pConfig.email), "")
	Wait for shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	LogEnd ("RegisterCAAccount (E)", Success, StdOut)
	Return Success
End Sub

private Sub F_Clean
	LogStart ("Clean (F)")
	Dim lcv As Int, files As List = File.ListFiles(pConfig.workdir)
	For lcv = 0 To files.Size - 1
		File.Delete(pConfig.workdir, files.Get(lcv))
	Next

	files = File.ListFiles(pConfig.digests)
	For lcv = 0 To files.Size - 1
		File.Delete(pConfig.digests, files.Get(lcv))
	Next
		
	LogEnd ("Clean (F)", True, "")
End Sub



private Sub G_DownloadChallenges As ResumableSub
	LogStart ("DownloadChallenges (G)")
	ExecuteCommand(pConfig.java, Array As String ("-jar", pConfig.acme_client, "--command", "order-certificate", "-a", pConfig.keyFile ("account.key"), "-w", pConfig.workdir, _
		"-c", pConfig.keyFile (pConfig.domain & ".csr"), "--challenge-type", "DNS01", "--dns-digests-dir", pConfig.digests), "")
	Wait for shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	LogEnd ("DownloadChallenges (G)", Success, StdOut)
	Return Success
End Sub

private Sub H_UploadChallenges As ResumableSub
	Dim isSuccess As Boolean = True
	
	LogStart ("UploadChallenges (H)")

	Dim lcv As Int, lcv2 As Int, mp As Map, files As List = File.ListFiles(pConfig.digests)
	mp.Initialize
	
	'Get challanges per zone
	For lcv = 0 To files.Size - 1
		Dim fn As String = files.Get(lcv)
		Dim domain As String = fn.SubString2(0, fn.IndexOf("_"))
		Dim lst As List
		If mp.ContainsKey (domain) Then
			lst = mp.Get(domain)
		Else
			lst.Initialize
			mp.Put(domain, lst)
		End If
		
		Dim challenge As String = File.ReadString(pConfig.digests, fn)
		challenge = challenge.Trim
		lst.Add(challenge)
	Next

	'Call the external API for each zone
	For lcv = 0 To mp.Size - 1
		Dim zonename As String = mp.GetKeyAt(lcv)
		Dim challenges As List = mp.GetValueAt(lcv)

		LogStart ("UploadChallenges for " & zonename)

		Dim sb As StringBuilder
		sb.Initialize
		For lcv2 = 0 To challenges.Size - 1
			If lcv2 > 0 Then sb.Append (",")
			sb.Append (challenges.Get(lcv2))
		Next
		
		Dim mp2 As Map
		mp2.Initialize
		mp2.Put ("email", pConfig.cf_email)
		mp2.Put ("apikey", pConfig.cf_key)
		mp2.Put ("zonename", zonename)
		mp2.Put ("challenges", sb.ToString)
		
		Dim fn As String = pConfig.keyfile (DateTime.Now)
		File.WriteMap(File.GetFileParent(fn), File.GetName(fn), mp2)

		Try
			ExecuteCommand(pConfig.java, Array As String ("-jar", pConfig.dns_client, fn), "")
			Wait for shl_ProcessCompleted (success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
			If Not (success) Then isSuccess = False
			LogEnd ("UploadChallenges for " & zonename, success, StdOut & "/" & StdErr)
		Catch
			Log(LastException)
		End Try
		
		File.Delete(File.GetFileParent(fn), File.GetName(fn))
	Next
	
	LogEnd ("UploadChallenges (H)", isSuccess, "")
	Return True
End Sub

private Sub cf_OnLog (URLAndStatus As String, response As String)
	pLogger.Write ("cloudflare: " & URLAndStatus)		
End Sub

private Sub I_VerifyChallenges As ResumableSub
	LogStart ("VerifyChallenges (I)")
	ExecuteCommand(pConfig.java, Array As String ("-jar", pConfig.acme_client, "--command", "verify-domains", "-a", pConfig.keyFile("account.key"), "-w", pConfig.workdir, _
		"-c", pConfig.keyFile(pConfig.domain & ".csr"), "--challenge-type", "DNS01"), "")
	Wait for shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	LogEnd ("VerifyChallenges (I)", Success, StdOut)
	Return Success
End Sub

private Sub J_DownloadCertificates As ResumableSub
	LogStart ("DownloadCertificates (J)")
	ExecuteCommand(pConfig.java, Array As String ("-jar", pConfig.acme_client, "--command", "generate-certificate", "-a", pConfig.keyFile("account.key"), "-w", pConfig.workdir, _
		"--csr", pConfig.keyFile(pConfig.domain & ".csr"), "--cert-dir", pConfig.keyfolder), "")
	Wait for shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	LogEnd ("DownloadCertificates (J)", Success, StdOut)
	Return Success
End Sub

private Sub K_ConvertIntoP12 As ResumableSub
	LogStart ("ConvertIntoP12 (K)")
	ExecuteCommand(pConfig.OpenSSL, Array As String ("pkcs12", "-export", "-inkey", pConfig.keyFile(pConfig.domain & ".key"), "-in", pConfig.keyFile("fullchain.pem"), _
	"-in", pConfig.keyFile("cert.pem"), "-name", pConfig.domain, "-out", pConfig.keyFile(pConfig.domain & ".p12"), "-passout", "pass:" & pConfig.password), "")
	Wait for shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	LogEnd ("ConvertIntoP12 (K)", Success, StdOut)
	Return Success
End Sub

private Sub L_ConvertIntoJKS As ResumableSub
	LogStart ("ConvertIntoJKS (L)")
	
	Dim inputdata As String = pConfig.password & Chr(13) & Chr(10) & "yes" & Chr(13) & Chr(10)

	ExecuteCommand(pConfig.keytool, Array As String ("-importkeystore", "-srckeystore", pConfig.keyFile(pConfig.domain & ".p12"), "-srcstoretype", "pkcs12", _
	"-destkeystore", pConfig.keyFile(pConfig.domain & ".jks"), "-storepass", pConfig.password), inputdata)
	Wait for shl_ProcessCompleted (Success As Boolean, ExitCode As Int, StdOut As String, StdErr As String)
	LogEnd ("ConvertIntoJKS (L)", Success, StdOut)

	Return Success
End Sub


#end region steps


Private Sub ExecuteCommand (command As String, args() As String, inputdata As String)
	Dim shl As Shell
	
	shl.Initialize("shl", command, args)
	
	If inputdata <> "" Then
		shl.InputStreamEnabled = True
		
		Dim lcv As Int, bytes(inputdata.Length) As Byte
		For lcv = 0 To inputdata.Length - 1
			bytes(lcv) = Asc(inputdata.CharAt(lcv))
		Next

		shl.WriteToInputStream(bytes)
	End If
	
	shl.Run (120000) 'Timeout of 2 minutes
End Sub


private Sub DisplayInfo
	Log ("Syntax: java -jar AutoKeyGenerator.jar -mode:<create/renew> -config:<full path to the config file>")
	Log (" ")
	Log ("When the config file does not yet exist, a template file will be created (and the application will exit).")
	Log ("In such a case: update the info in the template file and restart.")	
End Sub

'Parse the commandline arguments
private Sub ParseArgs (Args() As String) As Arguments
	Dim modeFound As Boolean = False
	Dim result As Arguments
	result.Initialize
	
	result.isRenew = True
	result.configFileLocation = ""
	result.errorMessage = ""
	
	Dim lcv As Int
	For lcv = 0 To Args.Length - 1
		If Args(lcv).ToLowerCase.StartsWith("-mode:") Then
			modeFound = True
			Dim val As String = Args(lcv).SubString(6).Trim.ToLowerCase
			If val = "create" Then
				result.isRenew = False
			else if val = "renew" Then
				result.isRenew = True				
			Else
				result.errorMessage = "Invalid value for '-mode:'. Allowed values: 'create' and 'renew'." & CRLF		
			End If
		else if Args(lcv).ToLowerCase.StartsWith("-config:") Then
			result.configFileLocation = Args(lcv).SubString(8).Trim
		End If
	Next

	If Not (modeFound) Then
		result.errorMessage = "Value for '-mode:' not provided." & CRLF
	End If

	If result.configFileLocation = "" Then 
		result.errorMessage = "Value for '-config:' not provided." & CRLF
	End If
		
	Return result
End Sub

Private Sub LogStart (stp As String)
	Dim logStr As String = "-> Start " & stp
	pLogger.Write(logStr)
End Sub

private Sub LogEnd (stp As String, success As Boolean, extramsg As String)
	Dim logStr As String = "<- End " & stp & " [success:" & success & "]"
	If extramsg <> "" Then logStr = logStr & " (" & extramsg & ")"
	pLogger.Write(logStr)
End Sub