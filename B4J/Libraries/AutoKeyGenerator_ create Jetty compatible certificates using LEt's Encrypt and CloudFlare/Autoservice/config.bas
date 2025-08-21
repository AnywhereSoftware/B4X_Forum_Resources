B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.1
@EndOfDesignText@
Sub Class_Globals
	Private pFolder As String
	Private pFileName As String	
	Private pContents As Map
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize (aFileName As String)
	pFolder = File.GetFileParent(aFileName)
	pFileName = File.GetName(aFileName)
	pContents.Initialize
End Sub

'Create the config template file when it was not found; otherwise nothing is done
Public Sub CreateConfig
	If Not (File.Exists(pFolder, pFileName)) Then
		File.Copy(File.DirAssets, "config.txt", pFolder, pFileName)		
	End If
End Sub

public Sub ParseFile
	pContents = File.ReadMap(pFolder, pFileName)
End Sub

public Sub OpenSSL As String
	Return pContents.Get("openssl")
End Sub

public Sub acme_client As String
	Return pContents.Get("acme_client")
End Sub

public Sub dns_client As String
	Return pContents.Get("dns_client")
End Sub

public Sub java As String
	Return pContents.Get("java")
End Sub

public Sub keytool As String
	Return pContents.Get("keytool")
End Sub

public Sub keyfolder As String
	Return pContents.Get("keyfolder")
End Sub

public Sub logfile As String
	Return pContents.Get("logfile")
End Sub

public Sub domain As String
	Return pContents.Get("domain")
End Sub

public Sub alternatives As String()
	Dim foo As String = pContents.Get("alternatives")
	Return Regex.Split(",", foo)
End Sub

public Sub email As String
	Return pContents.Get("email")
End Sub

public Sub certificate_c As String
	Return pContents.Get("certificat_c")
End Sub

public Sub certificate_st As String
	Return pContents.Get("certificat_st")
End Sub

public Sub certificate_l As String
	Return pContents.Get("certificat_l")
End Sub

public Sub certificate_o As String
	Return pContents.Get("certificat_o")
End Sub

public Sub certificate_ou As String
	Return pContents.Get("certificat_ou")
End Sub

public Sub password As String
	Return pContents.Get("password")
End Sub

public Sub cf_email As String
	Return pContents.Get("cf_email")
End Sub

public Sub cf_key As String
	Return pContents.Get("cf_key")
End Sub

#region Calculated

public Sub keyFile (fileName As String) As String
	Return File.Combine(keyfolder, fileName)
End Sub

Public Sub workdir As String
	If Not (File.Exists(keyfolder, "workdir")) Then
		File.MakeDir(keyfolder, "workdir")
	End If
	Return File.Combine(keyfolder, "workdir")
End Sub

public Sub digests As String
	If Not (File.Exists(keyfolder, "digests")) Then
		File.MakeDir(keyfolder, "digests")
	End If
	Return File.Combine(keyfolder, "digests")
End Sub

#end region




