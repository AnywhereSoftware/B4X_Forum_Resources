B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.8
@EndOfDesignText@
'Static code module
'this module is only used to test API Calls. You can delete it when you make your own bot.

Sub Process_Globals
	Private fx As JFX
	Private pane_API_call_buttons As Pane
	Private btn_Reset As Button
	Dim txt_Output As TextArea
	Dim cmb_Bot, cmb_Scoin, cmb_Coinpair As ComboBox
	Dim lbl_Exchange, lbl_Open_Orders As Label
	Private xui As XUI
	Dim API_Call_Map As Map
	
	'------------------------------------------------------------------------------- BTC Limit Buy & Sell Buttons
	Dim btc_buy_price As Double = 10000				'in USD
	Dim btc_buy_volume As Double = .002
	Dim btc_buy_total As Double = btc_buy_price * btc_buy_volume
	
	Dim btc_edit_buy_price As Double = 5000				'in USD
	Dim btc_edit_buy_volume As Double = .002
	Dim btc_edit_buy_total As Double = btc_edit_buy_price * btc_edit_buy_volume
	
	Dim btc_sell_price As Double = 84000			'in USD
	Dim btc_sell_volume As Double = .0002
	Dim btc_sell_total As Double = btc_sell_price * btc_sell_volume
End Sub

Sub Start
	Main.MainForm.RootPane.LoadLayout("test")
	cmb_Scoin.Items.Add("Get Markets")
	cmb_Coinpair.Items.Add("Get Markets")
	Create_List_of_API_Calls
End Sub

Private Sub Create_List_of_API_Calls
	API_Call_Map.Initialize
	API_Call_Map.Put("Test_PHP", "See if _Bot_Template can" & CRLF & "communicate with API_call.php")
	API_Call_Map.Put("Test_CCXT", "gets ccxt version")
	API_Call_Map.Put("exchanges", "Public Call" & CRLF & "get a list of ccxt supported exchanges")	' & CRLF & "$exchanges=\ccxt\Exchange::$exchanges;")
	API_Call_Map.Put("exchange_info", "Public Call")	' & CRLF & "$exchanges=\ccxt\Exchange::$exchanges;")
	API_Call_Map.Put("fetch_markets", "Public Call" & CRLF & "returns All Coinpairs")
	API_Call_Map.Put("fetch_ticker", "Public Call" & CRLF & "Single Coinpair")
	API_Call_Map.Put("fetch_tickers", "Public Call," &  CRLF & "Doesn't work with all Exchanges" & CRLF & "All Coinpairs")
	API_Call_Map.Put("fetch_l2_order_book", "Public Call" & CRLF & "Single Coinpair")
	API_Call_Map.Put("fetch_ohlcv", "Public Call" & CRLF & "timeframe = 1d" & CRLF & "Single Coinpair")
	API_Call_Map.Put("fetch_trades", "Public Call" & CRLF & "Single Coinpair")
	API_Call_Map.Put("fetch_balance", "Private Call" & CRLF & "All Coinpairs")
	API_Call_Map.Put("fetch_open_orders", "Private Call" & CRLF & "Single Coinpair")
	API_Call_Map.Put("fetch_all_open_orders", "Private Call" & CRLF & "Doesn't work with all Exchanges" & CRLF & "All Coinpairs")
	API_Call_Map.Put("fetch_my_trades", "Private Call" & CRLF & "Single Coinpair")
	API_Call_Map.Put("fetch_all_my_trades", "Private Call"  & CRLF & "Doesn't work with all Exchanges" & CRLF &  "All Coinpairs")
	API_Call_Map.Put("create_limit_buy_order", "Private Call" & CRLF & "preset to Buy " & btc_buy_volume & " BTC @ $" & btc_buy_price & " = $" & btc_buy_total)
	API_Call_Map.Put("create_limit_sell_order", "Private Call" & CRLF & "preset to Sell " & btc_sell_volume & " BTC @ $" & btc_sell_price & " = $" & btc_sell_total)
	API_Call_Map.Put("edit_limit_order", "Private Call" & CRLF & "preset to Edit last Buy to " & btc_edit_buy_volume & " BTC @ $" & btc_edit_buy_price & " = $" & btc_edit_buy_total)
	API_Call_Map.Put("cancel_order", "Private Call" & CRLF & "preset to Cancel last Sell Limit Order")
'	API_Call_Map.Put("Cancel_All_Orders", "Private Call" & CRLF & "Cancels all open Orders for One coinpair" & CRLF & "Singlel Coinpair")
	API_Call_Map.Put("cancel_all_orders", "Private Call" & CRLF & "Cancels all open Orders" & CRLF & "All Coinpairs")
	API_Call_Map.Put("create_market_buy_order", "Private Call" & CRLF & "will execute a trade")
	API_Call_Map.Put("create_market_sell_order", "Private Call" & CRLF & "will execute a trade")
	Create_Grid_of_Buttons
End Sub

Private Sub Create_Grid_of_Buttons
	Dim num_of_columns As Int = 4
	Dim num_of_rows As Int = 6
	pane_API_call_buttons.RemoveAllNodes
	Dim gap As Int = 2
	Dim border As Int = 10
	Dim width As Int = pane_API_call_buttons.PrefWidth - (border*2) - (num_of_columns-1)
	Dim height As Int = pane_API_call_buttons.PrefHeight - (border*2) - (num_of_rows-1)
	Dim btn_width As Int = (width) / num_of_columns
	Dim btn_height As Int = (height) / num_of_rows
	Dim btn_count As Int
	For y = 0 To num_of_rows -1
		For x = 0 To num_of_columns -1
			If btn_count < API_Call_Map.Size Then
				Dim Btn As Button
				Btn.Initialize("btn")
				Dim key, value As String
				key = API_Call_Map.GetKeyAt(btn_count)
				value = API_Call_Map.GetValueAt(btn_count)
				Btn.Text = key & CRLF & value
				Btn.WrapText = True
				Btn.Tag = key
				Dim xpos As Int = x * (btn_width + gap) + border
				Dim ypos As Int = y * (btn_height + gap) + border
				'make private calls purple-ish
				If value.Contains("Private") Then
					CSSUtils.SetStyleProperty(Btn, "-fx-background-color", "linear-gradient(#7F3FBF, #592E84)")
					Btn.TextColor = fx.Colors.White
				End If
				'only enable certain buttons
				Btn.Enabled = False
				If key.Contains("Test") Or key.Contains("exchanges") Then Btn.Enabled = True			'first 3 buttons
				If Main.Selected_Bot.IsInitialized And Main.Selected_Bot.name.Length > 0 Then									'if a bot has been selected
					If value.Contains("Single Coinpair") = False Then Btn.Enabled = True
				End If
				If Main.Selected_Coinpair.Length > 0 Then	Btn.Enabled = True
				'If key.Contains("Create") Or key.Contains("Edit") Then		'disable trade buttons, enable at your own risk
				'	Btn.Enabled = True
				'End If
				If key.Contains("create_market") Then Btn.Enabled = False			'Careful, Market Orders will Instanty Buy/Sell
				pane_API_call_buttons.AddNode(Btn, xpos, ypos, btn_width, btn_height)
				btn_count = btn_count + 1
			End If
		Next
	Next
End Sub

Sub btn_Click										'default calls for the example buttons
	Dim btn As Button = Sender
	Select btn.Tag
		Case "Test_PHP" : ccxt.Test_PHP
		Case "Test_CCXT" : ccxt.Test_CCXT
		Case "exchanges" : 	ccxt.Exchanges
		Case "exchange_info" : ccxt.Exchange_Info
		Case "fetch_markets" : ccxt.Markets
		Case "fetch_ticker" : 	ccxt.Ticker(Main.Selected_Coinpair)
		Case "fetch_tickers" : ccxt.All_Tickers
		Case "fetch_l2_order_book" : ccxt.OrderBook(Main.Selected_Coinpair, 50)
		Case "fetch_ohlcv" : ccxt.OHLCV(Main.Selected_Coinpair, "1d")
		Case "fetch_trades" : ccxt.Public_Trade_History(Main.Selected_Coinpair, 50)
		Case "fetch_balance" : ccxt.My_Balances
		Case "fetch_open_orders" : ccxt.My_Open_Orders(Main.Selected_Coinpair)
		Case "fetch_all_open_orders" : ccxt.All_My_Open_Orders
		Case "fetch_my_trades" : ccxt.My_Trade_History(Main.Selected_Coinpair, 0, 50)
		Case "fetch_all_my_trades" : ccxt.All_My_Trade_History(0, 200)
		Case "create_limit_buy_order" : ccxt.Create_Limit_Buy_Order("BTC/USD",  btc_buy_price, btc_buy_volume)		'place buy limit using preset values
		Case "create_limit_sell_order" : ccxt.Create_Limit_Sell_Order("BTC/USD", btc_sell_price, btc_sell_volume)			'kraken minimun .0001 BTC, place sell limit using preset values
		Case "edit_limit_order" 
			Dim last_buy_order As Order
			For i = 0 To Calc.All_My_Orders_List.Size-1																'edit last Buy Limit Order
				Dim this_order As Order = Calc.All_My_Orders_List.Get(i)
				If this_order.side = "buy" Then last_buy_order = this_order
			Next
			ccxt.Edit_Limit_Order(last_buy_order.id, last_buy_order.Coinpair, last_buy_order.side, btc_edit_buy_price, btc_edit_buy_volume)		'change buy limit order using preset values
			'	Log("---Need to have an open limit Buy order and click on 'Get_All_My_Open_Orders' to gather the data.---")
			
		Case "cancel_order"					'cancel last Sell Limit Order
			Dim last_sell_order As Order
			For i = 0 To Calc.All_My_Orders_List.Size-1
				Dim this_order As Order = Calc.All_My_Orders_List.Get(i)
				If this_order.side = "sell" Then last_sell_order = this_order
			Next
			ccxt.Cancel_Order(last_sell_order.Coinpair, last_sell_order.id)
'		Case "Cancel_All_Orders"
'			ccxt.Cancel_All_Orders(Main.Selected_Coinpair)
		Case "cancel_all_orders" : ccxt.cancel_all_orders
		Case "create_market_buy_order"
		Case "create_market_sell_order"
			
	End Select
End Sub

Sub cmb_Bot_SelectedIndexChanged(Index As Int, Value As Object)
	Log("Sub: cmb_Exchange_SelectedIndexChanged(" & Value & ")")
	Try
		Reset_Stuff
	
		Dim this_bot As Trading_Bot
		For i = 0 To Main.Bot_List.Size-1				'look for the right bot
			this_bot = Main.Bot_List.Get(i)
			If this_bot.name = Value Then		'found it
				'fill the Selected_Bot object
				Main.Selected_Bot.Initialize
				Main.Selected_Bot = this_bot
				lbl_Exchange.Text = Main.Selected_Bot.exchange
			End If
		Next
		Create_Grid_of_Buttons
	
	Catch
		Log(LastException)
	End Try
End Sub

Sub cmb_Scoin_SelectedIndexChanged(Index As Int, Value As Object)
	Log("Sub: cmb_Coinpair_SelectedIndexChanged(" & Value & ")")
	Try
		
		Select Value
			Case "Get Markets"
				ccxt.Markets
			Case Else
				Main.Selected_Scoin = Value
				
				'Add coinpairs to combo box
				cmb_Coinpair.Items.Clear
				Dim coinpair As String
				Dim scoin As String
				ccxt.Coinpair_List.Sort(True)
				For i = 0 To ccxt.Coinpair_List.Size-1
					coinpair = ccxt.Coinpair_List.Get(i)
					scoin = Calc.Get_Scoin(coinpair)
					If scoin = Main.Selected_Scoin Then cmb_Coinpair.Items.Add(coinpair)
				Next
				
		End Select
	
	Catch
		Log(LastException)
	End Try
End Sub
'
Sub cmb_Coinpair_SelectedIndexChanged(Index As Int, Value As Object)
	Log("Sub: cmb_Coinpair_SelectedIndexChanged(" & Value & ")")
	Try
		
		Select Value
			Case "Get Markets"
				ccxt.Markets
			Case Else
				Main.Selected_Coinpair = Value
		End Select
		Create_Grid_of_Buttons
		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub btn_Reset_Click
	cmb_Bot.SelectedIndex = -1 : Main.Selected_Bot.name = ""
	Reset_Stuff
End Sub

Private Sub Reset_Stuff
	cmb_Scoin.SelectedIndex = -1 : Main.Selected_Scoin = ""
	cmb_Coinpair.SelectedIndex = -1 : Main.Selected_Coinpair = ""
	lbl_Exchange.Text = ""
	txt_Output.Text = ""
	Calc.All_My_Orders_List.Initialize
	Calc.All_My_Trades_List.Initialize
	lbl_Open_Orders.Text = Calc.All_My_Orders_List.Size & " open orders"
	Create_Grid_of_Buttons
End Sub

Sub Update_Orders
	lbl_Open_Orders.Text = Calc.All_My_Orders_List.Size & " open orders"
End Sub