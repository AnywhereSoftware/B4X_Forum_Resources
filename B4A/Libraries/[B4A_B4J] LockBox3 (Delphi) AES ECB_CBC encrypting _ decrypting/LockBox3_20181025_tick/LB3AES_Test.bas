B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=6.51
@EndOfDesignText@
Sub Process_Globals
	
End Sub

Public Sub Test
	Dim lb3_ecb As LB3AES
	lb3_ecb.Initialize(256, "156xukn", "ECB")
	Log("The output should be: Decrypt this text test")
	Log(lb3_ecb.DecryptString("SjGSQBY0xu2JG6sWDL3w+T+/rmY20Z93+vSWUGDRklU="))
	Log(lb3_ecb.EncryptString("Decrypt this text test"))

	Dim lb3_cbc As LB3AES
	lb3_cbc.Initialize(256, "123", "CBC")
	Log("The output should be: 0123456789123456")
	Log(lb3_cbc.DecryptString("eNPG2rdR/PPSPp1D6FQP7x95mIafW4Ql"))
	Log("The output should be: 0123456789012345")
	Log(lb3_cbc.DecryptString("9cvoc5smn/OlFeOjpTifyKZsukaShl7s"))
	Log("The output should be: 012345678901234")
	Log(lb3_cbc.DecryptString("RJSBnX2HSdfBVOmB4aDVuAx67v/KKtE="))
	Log("The output should be: 0123456789")
	Log(lb3_cbc.DecryptString("LwcJW9Y1HyS4D22NP2ExBOmQ"))
	Log("The output should be: 12345")
	Log(lb3_cbc.DecryptString(lb3_cbc.EncryptString("12345")))
	Log("The output should be: 5")
	Log(lb3_cbc.DecryptString(lb3_cbc.EncryptString("5")))
	Log("The output should be: Hello my darling how are you today")
	Log(lb3_cbc.DecryptString(lb3_cbc.EncryptString("Hello my darling how are you today")))
	Log("Output should return an empty string (which does not even produce a log line)")
	Log(lb3_cbc.DecryptString(lb3_cbc.EncryptString("")))
	Log("Output should return an empty string (which does not even produce a log line)")
	Log(lb3_cbc.EncryptString(""))
End Sub