B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private Root As B4XView 'ignore
	Private xui As XUI 'ignore
	Private TxtImporto As B4XView
	Private EditText1 As B4XView
	Private EditText2 As B4XView
	Private ButStprenotazione As B4XView
    Public  LabDevice As B4XView
	Private escpo As ESCPOSThermalPrinter
	
	Private TxtNumero As B4XView
End Sub

'You can add more parameters here.
Public Sub Initialize As Object
	Return Me
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	'load the layout to Root
	Root.LoadLayout("Escpos")
	
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub ButStampa_Click
	Dim bim ,BmQd As Bitmap
	Dim sb       As StringBuilder
	Dim Iva As Int
	Iva = (TxtImporto.Text*22)/100
	sb.Initialize
	bim = xui.LoadBitmap(File.DirAssets, "2.jpeg")
	BmQd = xui.LoadBitmap(File.DirAssets, "Qcode.png")
	
	Dim gradient As Boolean
	
	If escpo.connectiontusb = True Then
		Dim txtheimg,txtQcode As String
		txtheimg =escpo.Imgstrinbtmap(bim,False)
		txtQcode = escpo.mQrcode(BmQd,False)
		escpo.connectiontusb
		sb.Append("[C]").Append(txtheimg).Append(CRLF)
'		sb.Append("[L]").Append(CRLF)
		sb.Append("[C]<u><font size='big'>Scontrino N ").Append(TxtNumero.Text).Append("</font></u>").Append(CRLF)
		sb.Append("[L]").Append(CRLF)'		
		sb.Append("[C]================================").Append(CRLF)
		sb.Append("[R]<b>Euro</b>").Append(CRLF)
		sb.Append("[L]").Append(CRLF)
		sb.Append("[L]<b>Trattamento di Bellezza</b>[R]").Append(TxtImporto.Text).Append(CRLF).Append(CRLF)
		sb.Append("[L]<b>Di Cui IVA</b>[C]22% [R]").Append(Iva).Append(CRLF)
		sb.Append("[C]================================").Append(CRLF)
		
		sb.Append("[C]================================").Append(CRLF)
		sb.Append("[C]").Append(txtQcode)
		sb.Append("[C]").Append("<barcode Type='ean13' height='10'>").Append("831254784551").Append("</barcode>").Append(CRLF)
		sb.Append("[C]").Append("<qrcode size='20'>").Append("https://dantsu.com/").Append("</qrcode>") 
'		Log(sb.ToString)
		escpo.connectiontusb
		escpo.doPrintBluetoot(sb.ToString)
	End If
End Sub

Private Sub ButStprenotazione_Click
	
End Sub