B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private btReceive As B4XView
	Private btSend As B4XView
	Private lbData As B4XView
	Private lbFromId As B4XView
	Private lbId As B4XView
	Private lbToId As B4XView
	Private txData As B4XView
	Private txFromId As B4XView
	Private txId As B4XView
	Private lbType As B4XView
	Private txType As B4XView
	Private txToId As B4XView
	Private btDelete As B4XView
	Private btSetFlag As B4XView
	Private clvResponse As CustomListView
	
	Private PHPLink As String="https://xxxyourwebsitexxx.net/FS/FSLink.PHP/?"
	
	Private s, x, DumData As String
	Private i, k, l1, l2 As Int
	Private SepChr As String=Chr(154)
	Private bRR As Boolean
	Private DtStart, DtEnd As Double
		
	
End Sub

Public Sub Initialize
	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(Me,"Test PHP")
	
	' build dummy data record
	' In production, each field would be read from a table
	DumData="Rec-10" & SepChr & "Fld1aa" & SepChr & "Fld2bbb" & SepChr & "Fld3ccccc" & SepChr
	DumData=DumData & "Fld4Test ' ddddd" & SepChr & "Fld5Test & eeeee" & SepChr
	DumData=DumData & "Fld6fffffffffff" & SepChr & "Fld7ggg"
	txData.Text=DumData
	' give the table number   ' this allows you to un-parse the string into a data record for this table
	txType.Text=5
	
	' set up id and idto
	txId.Text="AbCdEfxxx"         ' this would be the 'family' id
	txToId.text="RsT"             ' this is the specific user you are sending to
	txFromId.Text="AbD"           ' this is you

End Sub

Private Sub ExecuteHttp
	' sub to execute http 
	Dim j As HttpJob
	clvResponse.Clear
	j.Initialize("", Me)
	j.Download(s)
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		DtEnd=DateTime.now
		x=j.GetString
		j.Release
	Else
		ToastMessageShow("Unable to access the Internet at this time",False)
		j.release
		Return	
	End If	

	If bRR Then
		' unpurge the rec
		x=UnPurgeChar(x)

		' get initial response
		l1=x.IndexOf ("Rec1")
		If l1>-1 Then
			' records found-write initial portion of record to 1st clv
			clvResponse.AddTextItem(x.SubString2(0,l1),False)
		Else
			' must be no recs
			clvResponse.AddTextItem(x,False)
			Return		
		End If
	
		' receive record-analyze it and write clv
		k=0
		For i=1 To 1000						' handle up to 1000 sub records
			l2=x.IndexOf2("Rec1",l1+5)
			If l2>-1 Then
				' found next start record-write out the one we just had
				k=k+1
				clvResponse.AddTextItem(k & " " & x.SubString2(l1,l2),False)
				' reset start
				l1=l2
			Else
				' end of file- 
				k=k+1
				l2=x.IndexOf2("Close1",l1)
				If l2>-1 Then
					' write final record
					clvResponse.AddTextItem(k & " " & x.SubString2(l1,l2),False)
					' write close1
					clvResponse.AddTextItem(x.SubString2(l2,x.Length),False)
				Else
					clvResponse.AddTextItem(k & " " & x.SubString2(l1,x.Length),False)
				End If
				
				' write summary and insert it as the 2nd rec
				s=k & " Records parsed" & CRLF
				s=s & x.Length & " Total length of string" & CRLF
				DtEnd=DtEnd-DtStart
				DateTime.DateFormat="sss.SSS"
				s=s & "Response time in seconds: " & DateTime.Date(DtEnd)
				clvResponse.insertatTextItem (1,s,False)
				Exit
			End If
		Next
		
	Else
		' not brr write entire x out as is
		' note it is still purged so you can see what the rec looked like in the send
		clvResponse.AddTextItem(x,False)
			
	End If
End Sub

Private Sub btSend_Click
	s=PHPLink
	s=s & "Cmd=IR"
	s=s & "&Id=" & PurgeChar(txId.Text)
	s=s & "&IdF=" & PurgeChar(txFromId.Text)
	s=s & "&IdT=" & PurgeChar(txToId.Text)
	s=s & "&Ty=" & PurgeChar(txType.text)
	s=s & "&Dt=" & PurgeChar(txData.text)
'	Log(s)
	' increment data for my convenience
	x=txData.Text.Trim
	i=x.IndexOf ("-")
	If i>-1 Then
		k=x.SubString2(i+1,i+3)+1
		txData.Text="Rec-" & k & x.SubString2(i+3,x.Length)
	End If
	bRR=False
	ExecuteHttp
End Sub

Private Sub btReceive_Click
	s=PHPLink
	s=s & "Cmd=RR"
	s=s & "&Id=" & PurgeChar(txId.Text)
	s=s & "&IdF=" & PurgeChar(txFromId.Text)
	s=s & "&IdT=" & PurgeChar(txToId.Text)
'	Log(s)
	bRR=True
	DtStart=DateTime.Now
	ExecuteHttp
	
End Sub

Private Sub btSetFlag_Click
	s=PHPLink
	s=s & "Cmd=SF"
	s=s & "&Id=" & PurgeChar(txId.Text)
	s=s & "&IdT=" & PurgeChar(txToId.Text)
'	Log(s)
	bRR=False
	ExecuteHttp
End Sub

Private Sub btDelete_Click
	s=PHPLink
	s=s & "Cmd=DR"
	s=s & "&Id=" & PurgeChar(txId.Text)
	s=s & "&IdT=" & PurgeChar(txToId.Text)
'	Log(s)
	bRR=False
	ExecuteHttp
End Sub

Private Sub btBuild_Click
	s=PHPLink
	s=s & "Cmd=BT" 
'	Log(s)
	bRR=False
	ExecuteHttp
End Sub

Public Sub PurgeChar (S1 As String) As String
	' sub to replace single and double quotes from text for writing to sql
	' mod to chr 149, 150 1/30/20 cwm
	S1=S1.replace ("'",Chr(149))			' single quote
	S1=S1.Replace (Chr(34), Chr(150))	' double quote
	S1=S1.Replace ("&", Chr(151))		' added 6/8/22 For sync  cwm
	S1=S1.Replace (Chr(10), Chr(152))	' added 6/8/22 For sync  cwm
	S1=S1.Replace (Chr(13),Chr(155))	' added 6/8/22 For sync  cwm
	S1=S1.Replace ("#", Chr(156))		' added 1/5/23 For sync  cwm # truncated the data
	S1=S1.Replace ("\", Chr(157))		' added 11/24/23 For sync  cwm '\' was dropped out of sync record
	S1=S1.Replace (Chr(9), Chr(158))	' added 11/24/23 For sync  cwm chr(9) was dropped out of sync record
	S1=S1.Replace ("+", Chr(159))	    ' added 11/24/23 For sync  cwm '+' was changed to a blank
	S1=S1.Replace ("/", Chr(160))	    ' added 11/24/23 For sync  cwm 
	S1=S1.Replace ("|", Chr(148))	    ' added 11/25/23 For sync  cwm php doc warned of this char
	S1=S1.Replace ("<", Chr(147))	    ' added 11/25/23 For sync  cwm php doc warned of this char-inserted garbage
	S1=S1.Replace (">", Chr(146))	    ' added 11/25/23 For sync  cwm php doc warned of this char-inserted garbage
	S1=S1.Replace ("^", Chr(145))	    ' added 11/25/23 For sync  cwm php doc warned of this char-dropped char behind it in some cases
	S1=S1.Replace ("%", Chr(144))	    ' added 11/25/23 For sync  cwm % key has special meaning in html ex %20 is a space
	
	Return S1
End Sub

Public Sub UnPurgeChar (S1 As String) As String
	' sub to rebuild single and double quotes  added 1/30/20 cwm
	S1=S1.replace (Chr(149), "'"	)		' single quote
	S1=S1.Replace (Chr(150),Chr(34))		' double quote
	S1=S1.Replace (Chr(151),"&")			' &
	S1=S1.Replace (Chr(152),Chr(10))	' added 6/8/22 For sync  cwm
	S1=S1.Replace (Chr(155),Chr(13))	' added 6/8/22 For sync  cwm
	S1=S1.Replace (Chr(156),"#")		' added 1/5/23 For sync  cwm
	S1=S1.Replace (Chr(157), "\")		' added 11/24/23 For sync  cwm '\' was dropped out of sync record
	S1=S1.Replace (Chr(158), Chr(9))	' added 11/24/23 For sync  cwm chr(9) was dropped out of sync record
	S1=S1.Replace (Chr(159), "+")    	' added 11/24/23 For sync  cwm '+' was converted to a blank by the php	s1=s1.Replace (Chr(158), Chr(9))	' added 11/24/23 For sync  cwm chr(9) was dropped out of sync record
	S1=S1.Replace (Chr(160), "/")	    ' added 11/24/23 For sync  cwm chr(9) was dropped out of sync record
	S1=S1.Replace (Chr(148),"|")	    ' added 11/25/23 For sync  cwm php doc warned of this char
	S1=S1.Replace (Chr(147),"<")	    ' added 11/25/23 For sync  cwm php doc warned of this char
	S1=S1.Replace (Chr(146),">")	    ' added 11/25/23 For sync  cwm php doc warned of this char
	S1=S1.Replace (Chr(145),"^")	    ' added 11/25/23 For sync  cwm php doc warned of this char
	S1=S1.Replace (Chr(144), "%")	    ' added 11/25/23 For sync  cwm % key has special meaning in html ex %20 is a space

	Return S1
End Sub