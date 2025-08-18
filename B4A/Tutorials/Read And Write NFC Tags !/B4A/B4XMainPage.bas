B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=11.5
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private NFCRE As NFCRead
	Private NFCWR As NFCWrite
	Private Label1 As Label
	Private READB As Button
	Private WRITEB As Button
End Sub

'You can add more parameters here.
Public Sub Initialize
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("1")
	NFCRE.Initialize
	B4XPages.AddPage("NFC RE", NFCRE)
	NFCWR.Initialize
	B4XPages.AddPage("NFC WR", NFCWR)
End Sub



Private Sub WRITEB_Click
	B4XPages.ShowPage("NFC WR")
End Sub

Private Sub READB_Click
	B4XPages.ShowPage("NFC RE")
End Sub