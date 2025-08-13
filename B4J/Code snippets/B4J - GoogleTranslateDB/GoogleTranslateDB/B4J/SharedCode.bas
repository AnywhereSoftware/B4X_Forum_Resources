B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	
	Dim AppName As String = "B4JGoogleTranslateDB"

	Type MyType(Result As Boolean,FileName As String)
	Type MyEdIn(wrd As String, src As String, dst As String)
	Dim SafeDelete As MyType
	Dim SafeGoogle As MyEdIn
	
	Dim Safencryption As AESEncryption
	
    #Region ©.RuntimeGoogle Translation
	Dim CheckInternet As B4XCheckInternet
	Dim sGoogle As String
	#End Region
	
    #Region ©.RuntimePermissions 
	Private xui As XUI
	Private sdd As String
	#End Region
End Sub

Public Sub ClearSystemClipboard As ResumableSub
	Private myClipBoard As JavaObject
	myClipBoard.InitializeStatic("javafx.scene.input.Clipboard")
	myClipBoard.RunMethodJO("getSystemClipboard",Null).RunMethod("clear",Null)
	Return True
End Sub

Public Sub Delete(fPath As String,fName As String) As ResumableSub
	Try
		If File.Exists(fPath, fName) Then
			Private raf As RandomAccessFile
			Dim sr As SecureRandom

			raf.Initialize(fPath,fName, False)
			Dim aesKey(64) As Byte '64 bytes = 4x128 bits
			Dim total As Long
			Do While (raf.CurrentPosition < raf.Size)
				Sleep(5)
				total = raf.Size

				sr.SetRandomSeed(total)
				sr.GetRandomBytes(aesKey)
				raf.WriteObject(aesKey, False, raf.CurrentPosition)
			Loop
			raf.Flush
			raf.Close
			File.Delete(fPath,fName)
		End If
		SafeDelete.Result = True
		Sleep(0)
	Catch
		SafeDelete.Result = False
		Return False
	End Try
	Return True
End Sub

Public Sub SafeResult As Boolean
	Return SafeDelete.Result
End Sub

Public Sub SafeFileName As Boolean
	Return SafeDelete.FileName
End Sub

Public Sub GenerateRandom(numChars As Int, numbers As Boolean, lowercase As Boolean, uppercase As Boolean, symbols As Boolean) As String

	Dim charList As List
	charList.Initialize

	If numbers   Then charList.AddAll(Main.numbersArray)
	If lowercase Then charList.AddAll(Main.lowercaseArray)
	If uppercase Then charList.AddAll(Main.uppercaseArray)
	If symbols   Then charList.AddAll(Main.symbolsArray)

	Dim newPassword As StringBuilder
	newPassword.Initialize

	For i = 1 To numChars
		newPassword.Append(charList.Get(Rnd(0, charList.Size)))
	Next

	Return newPassword

End Sub

Public Sub YourMailValid(New As String) As Boolean
	Dim VMail As Boolean = Regex.IsMatch("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", New)
	Dim Valid As Boolean = New.Length > 0 And VMail
	Return Valid ' Valid Email Address.
End Sub

Public Sub MeasureTextWidth(t As String, f As B4XFont) As Float
	Dim cvs As B4XCanvas
	Dim p As B4XView = xui.CreatePanel("")
	p.SetLayoutAnimated(0, 0, 0, 2dip, 2dip)
	cvs.Initialize(p)
	Dim Width As Float = cvs.MeasureText(t, f).Width
	Return Width
End Sub

Public Sub DateFormat(Date As String, Time As String)
	DateTime.DateFormat = Date
	DateTime.TimeFormat = Time
End Sub

Public Sub ConvertTextencoding(text As String, fromEncoding As String, toEncoding As String) As String
	Dim b() As Byte = text.getbytes(fromEncoding) 'Encoding: "UTF-8", "iso-8859-1", ...
	Return BytesToString( b, 0, b.Length, toEncoding)
End Sub

#Region Encrypt/Decrypt 
Private Sub GenerateIV As String
	Private IV As String
	Try
		sdd = xui.DefaultFolder
		If Not(File.Exists(sdd, Main.GenerateIVf)) Then
			Safencryption.InitializationVector = Main.iv_passdAES
			Safencryption.SecretKey = Main.pc_passdAES
			IV = Safencryption.AESEncrypt(Main.ss_passdAES)
			File.WriteString(sdd, Main.GenerateIVf, IV)
		Else
			IV = File.ReadString(sdd, Main.GenerateIVf)
		End If
		Return IV
	Catch
		Return ""
	End Try
End Sub

Public Sub EncryptTextFile(text As String) As String
	If GenerateIV.Length > 0 Then
		Safencryption.InitializationVector = Main.ss_passdAES
		Safencryption.SecretKey = Main.pc_passdAES
		Return Safencryption.AESEncrypt(text)
	Else
		'"wrong encryption method"
		Return ""
	End If
End Sub

Public Sub DecryptTextFile(text As String) As String
	Try
		Main.ss_passdAES = DecryptText(GenerateIV)
		Safencryption.InitializationVector = Main.ss_passdAES
		Safencryption.SecretKey = Main.pc_passdAES
		Return Safencryption.AESDecrypt(text)
	Catch
		'"wrong decryption method"
		Return ""
	End Try
End Sub

Public Sub EncryptText(text As String) As String
	If GenerateIV.Length > 0 Then
		Safencryption.InitializationVector = Main.iv_passdAES
		Safencryption.SecretKey = Main.pc_passdAES
		Return Safencryption.AESEncrypt(text)
	Else
		'"wrong encryption method"
		Return ""
	End If
End Sub

Public Sub DecryptText(text As String) As String
	Try
		Safencryption.InitializationVector = Main.iv_passdAES
		Safencryption.SecretKey = Main.pc_passdAES
		Return Safencryption.AESDecrypt(text)
	Catch
		'"wrong decryption method"
		Return ""
	End Try
End Sub

Public Sub StartGenerateIV As String
	Dim PWC As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+=-`<>?/.,';:"&Chr(34)&"\]|1234567890"
	Dim IV As String
	For i = 0 To 15
		IV = IV & PWC.CharAt(Rnd(0,PWC.Length))
	Next
	Return IV
End Sub
#End Region

Public Sub TestInternet()As ResumableSub
	Dim result As Boolean
	Dim Job As HttpJob
	Job.Initialize("Job", Me)
	Job.Download("https://google.com")
	Wait For(Job) JobDone(Job As HttpJob)
	If Job.Success Then
		result = True
	Else
		result = False
	End If
	Job.Release
	Return result
End Sub

Public Sub DBTableExists(DB As SQL, TableName As String) As Boolean
	Dim Result As Boolean = False
	Dim Cur As ResultSet

	Try
'or		Cur = DB.ExecQuery2("SELECT name FROM sqlite_master WHERE type=? AND upper(name) = ?", Array As String("table", TableName.ToUpperCase))
		Cur = DB.ExecQuery2("SELECT name FROM sqlite_master WHERE type='table' AND name = ? COLLATE NOCASE", Array (TableName))
		Result = (Cur.IsInitialized And Cur.NextRow = True)
	Catch
		Return False
	End Try
 
	Return Result
End Sub

#Region Google Translation 
'edIn - Input text for translation.
'src - source code
'dst - destination code
'Return = The result of the translation.
Public Sub goGoogleTranslation (DB As SQL, wrd As String, src As String, dst As String) As ResumableSub
	Dim job As HttpJob
	
	SafeGoogle.wrd = wrd
	SafeGoogle.src = src
	SafeGoogle.dst = dst

	Dim transtr As String = wrd
	Dim jobname As String = "xlate"
	Dim jobtag As String = "french"

	job.Initialize(jobname, Me)
	job.Tag = jobtag

	' Use Google Free google API translate
	Dim srclang As String = src
	Dim dstlang As String = dst
	
	Dim poststr As String = "https://Translate.googleapis.com/translate_a/single?client=gtx&sl=" & _
    srclang & "&tl=" & dstlang & "&dt=t&q=" & transtr

    #Region ©.Google Translation JobDone
	Try
		job.Download(poststr)
		sGoogle = ""

		Wait For (job) JobDone(job As HttpJob)

		If (job.Success = True) Then
			Dim trans As String = job.GetString

			'========Modified code to take only the first "Double quote Value"
			Dim count=0, i=0 As Int
			Do While i<2
				If trans.SubString2(count, count+1)=$"""$ Then i=i+1
				count=count+1
			Loop
			trans=trans.SubString2(0, count)
			'========Modified code Over to take only the first "Double quote Value"

			Dim rlst As List = MyParser(trans)

			For Each sa() As String In rlst
				If (sa.Length > 0) Then
					If (sGoogle <> "") Then sGoogle = sGoogle & CRLF
					sGoogle = sGoogle & sa(0)
				End If
			Next

			Dim sArr() As String

			sArr = Array As String (B4XPages.MainPage.sRow.ToLowerCase, B4XPages.MainPage.ComboBox2.Value, sGoogle)
			DB.ExecNonQuery2("INSERT INTO data VALUES (?, ?, ?)", sArr)

			sArr = Array As String (sGoogle.ToLowerCase, B4XPages.MainPage.ComboBox1.Value, B4XPages.MainPage.sRow)
			DB.ExecNonQuery2("INSERT INTO data VALUES (?, ?, ?)", sArr)
		Else
			sGoogle = ""
			job.Release
			Return False
		End If

		sGoogle = ""

		job.Release
		Return True
	Catch
		sGoogle = ""
		If job.IsInitialized Then job.Release
		Return False
	End Try
	#End Region
End Sub

Sub MyParser(js As String) As List ' returns list of string arrays
	Dim rlst As List
	Dim sa1(), str As String
	Dim p As Int

	rlst.Initialize

	sa1 = Regex.Split("]", js)

	For Each s1 As String In sa1
		p = s1.LastIndexOf("[")
		If (p < 0) Then Continue

		str = s1.SubString2(p + 1, s1.Length)
		str = str.Replace(QUOTE, "")

		Dim sa2() As String = Regex.Split(",", str)
		rlst.Add(sa2)
	Next

	Return(rlst)
End Sub
#End Region