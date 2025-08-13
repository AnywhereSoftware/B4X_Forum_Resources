B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
'Math and Utilites to support the Bot Logic

Sub Process_Globals
	Private fx As JFX
	Private My_GMT_Offset As Int = -8												'PST for me, set for your timezone, just for b4j logs...
	
	Type Order(Coinpair As String, side As String, id As String, TS As Long, Price As Double, Volume As Double, Total As Double, filled As Double, remaining As Double, Order_Type As String, Status As String)
	Dim All_My_Orders_List As List																								'a list of all my active limit orders
	Type AMT (trade_id As String, order_id As String, Coinpair As String, TS As Long, Side As String, Price As Double, Volume As Double, Total As Double, Fee As Double, Fee_Currency As String, trade_type As String)
	Dim All_My_Trades_List As List																						'a list of All My Trades
End Sub

'Get Primary (Base) Coin
Sub Get_Pcoin (coinpair As String) As String
	Dim pcoin As String
	Dim index As Int = coinpair.IndexOf("/")
	pcoin = coinpair.SubString2(0, index)
	Return pcoin
End Sub

'Get Secondary (Quote) Coin
Sub Get_Scoin (coinpair As String) As String
	Dim scoin As String
	Dim index As Int = coinpair.IndexOf("/") + 1
	scoin = coinpair.SubString(index)
	Return scoin
End Sub

'for human readable timestamps in logs
Sub My_Date_Time(TS As Long) As String
	DateTime.SetTimeZone(My_GMT_Offset)
	Dim dt As String = DateTime.Date(TS) & "   " & DateTime.Time(TS)
	DateTime.SetTimeZone(0)												'Back to UTC time standard for ccxt
	Return (dt)
End Sub