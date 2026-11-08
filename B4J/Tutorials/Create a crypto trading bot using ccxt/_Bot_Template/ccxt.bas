B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@
'Static code module

'Programming order of operation: _Bot_Template.b4j --> API_call.php --> ccxt --> Exchange API --> ccxt --> API_call.php --> _Bot_Template.b4j

'Uses ccxt: works with multiple exchanges, gets regular updates, uses uniform coinpairs and methods

'This requires ccxt installed and running on a PHP server (ie XAMPP)

'I store the api keys in the PHP code.  When setting up api keys at the exchanges I don't allow withdrawals.
'I'm not planning on storing more funds on an exchange than I can afford to lose.

'Set up ccxt: dl from github, put in htdocs folder, rename 'ccxt-master' folder to 'ccxt'.
'Install composer to your main php directory, https://getcomposer.org/download/
'open cmd window, cd to the ccxt directory type 'composer install' or maybe 'composer update'
'compser finds the 'composer.json' file and should install the required methods
'--> I also had to use this fix with Windows 10 https://stackoverflow.com/questions/39724594/composer-is-not-recognized-as-an-internal-or-external-command-in-windows-serve/51811708#51811708
'--> I had to install xampp with php 8.1.12 to get it to work

'To update, the ccxt folder--> clone it from github, extract and replace older 'ccxt' in C:\xampp\htdocs. You may have to update dependicies with composer.

'Only edit API_Calls.php, not any ccxt php files.
'All API calls use the functions in Exchange.php, there are plenty more there that may be of interest...
'If your exchange doesn't do the thing you want it to, you may have to manually look up its API and add those functions to the params array of the api call.

'note:  When using ccxt you’re talking to the exchanges directly. ccxt is not a server, nor a service, it’s a software library. All data that you are getting with ccxt is received directly from the exchanges first-hand.

Sub Process_Globals
	'Private Module As String = "ccxt"
	Private fx As JFX
	Private PHP_Port As Int = 8080																							'Update this with your port
	Private PHP_URL As String = "http://localhost:" & PHP_Port & "/API_call.php"				'Uses 'API_call.php' to talk to ccxt and output in JSON format
	Private JSON As JSONParser
	Dim Buy_Orderbook_Map As Map
	Dim Sell_Orderbook_Map As Map
	Dim Coinpair_List As List																										'a list of all coin pairs your exchange supports
	Dim Pcoin_List As List																											'a list of all primary coins (base) to trade
	Dim Scoin_List As List																											'a list of all secondary coins (quote) to trade against
	Dim OHLCV_TimeFrame_List As List																					'List of Time Frame Strings for OHLCV ie(6h, 1d, 1h, 5m, 15m, 1m)
	Dim Canceled_Order_ID As String																						'B4j saves the canceled order ID when Sub Edit_Limit_Order is called
	Dim Exchange_Info_Map As Map																						'map of selected exchange properties
End Sub


Sub Test_PHP
	Dim input As String = "bot=NA&command=Test_PHP"
	API_Call("Test_PHP", input)
End Sub

Sub Test_CCXT
	Dim input As String = "bot=NA&command=Test_CCXT"
	API_Call("Test_CCXT", input)
End Sub

Sub exchanges
	Dim input As String = "command=exchanges"
	API_Call("exchanges", input)
End Sub

'shows which methods are available for this exchange
Sub exchange_info
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&command=exchange_info"
	API_Call("Get_Exchange_Info", input)
End Sub

Sub fetch_markets
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&command=fetch_markets"
	API_Call("Get_Markets", input)
End Sub

'Get Ticker for a single coinpair
Sub fetch_ticker(coinpair As String)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&command=fetch_ticker"
	API_Call("Get_Ticker", input)
End Sub

Sub fetch_tickers
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&command=fetch_tickers"
	API_Call("Get_All_Tickers", input)
End Sub

'limit = 0 for maximum
Sub fetch_l2_order_book(coinpair As String, limit As Int)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&limit=" & limit & "&command=fetch_l2_order_book"
	API_Call("Get_OrderBook", input)
End Sub

'get timeframe options from Exchange_Info (s m h d w M y) default = 1m.
Sub fetch_ohlcv(coinpair As String, timeframe As String)	'optional ccxt variables ($since, $limit)
	'I think this is the best way to collect data for trading logic
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&timeframe=" & timeframe &  "&command=fetch_ohlcv"
	API_Call("Get_OHLCV", input)
End Sub

'Get public trade history for a certain coin.
Sub fetch_trades(coinpair As String, limit As Int)		'optional ccxt variable($since)
	'Can be faster than OHLCV
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&limit=" & limit & "&command=fetch_trades"
	API_Call("Get_Public_Trade_History", input)
End Sub

Sub fetch_balance
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&command=fetch_balance"
	API_Call("Get_My_Balances", input)
End Sub

'Single Coinpair
Sub fetch_open_orders(coinpair As String)	'optional ccxt variables ($since, $limit)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&command=fetch_open_orders"
	API_Call("Get_My_Open_Orders", input)
End Sub

'All my open orders for any coinpair
Sub fetch_all_open_orders		'optional ccxt variables ($since, $limit)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&command=fetch_all_open_orders"
	API_Call("Get_All_My_Open_Orders", input)
End Sub

'Some exchanges require a coinpair
Sub fetch_my_trades(coinpair As String, since As Long, limit As Int)
'	Dim limit As Int = 50		'optional
'	Dim since As Long = 0 '(DateTime.Now - DateTime.TicksPerDay * 180)			'not for all exchanges
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&limit=" & limit & "&since=" & since & "&command=fetch_my_trades"
	API_Call("Get_My_Trade_History", input)
End Sub

'All coins
Sub fetch_all_my_trades(since As Long, limit As Int)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&limit=" & limit & "&since=" & since & "&command=fetch_all_my_trades"
	API_Call("Get_All_My_Trade_History", input)
End Sub

'-----Be careful here, see the ccxt docs 'Orders' section https://docs.ccxt.com/en/latest/manual.html#editing-orders
'by default these are good til canceled
Sub create_limit_buy_order(coinpair As String, price As Double, volume As Double)
	Dim p As String = NumberFormat2(price, 1,8,8,False)			'keep numbers in a format the exchanges can understand
	Dim v As String = NumberFormat2(volume, 1,8,8,False)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&amount=" & v & "&price=" & p & "&command=create_limit_buy_order"
	API_Call("Create_Limit_Buy_Order", input)
End Sub

'by default these are good til canceled
Sub create_limit_sell_order(coinpair As String, price As Double, volume As Double)
	Dim p As String = NumberFormat2(price, 1,8,8,False)
	Dim v As String = NumberFormat2(volume, 1,8,8,False)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&amount=" & v & "&price=" & p & "&command=create_limit_sell_order"
	API_Call("Create_Limit_Sell_Order", input)
End Sub

'if not supported by exchange, ccxt will cancel and re-issue an order
Sub edit_limit_order(id As String, coinpair As String, side As String, price As Double, volume As Double)
	Canceled_Order_ID = id
	Dim p As String = NumberFormat2(price, 1,8,8,False)
	Dim v As String = NumberFormat2(volume, 1,8,8,False)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&id=" & id & "&symbol=" & coinpair & "&side=" & side & "&amount=" & v & "&price=" & p & "&command=edit_limit_order"
	API_Call("Edit_Limit_Order", input)
End Sub

Sub cancel_order(coinpair As String, id As String)
	Canceled_Order_ID = id
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&id=" & id & "&symbol=" & coinpair & "&command=cancel_order"
	API_Call("Cancel_Order", input)
End Sub

'Doesn't Work
Sub cancel_orders(coinpair As String)			'ccxt looking for id's
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&coinpair=" & coinpair & "&command=cancel_orders"
	API_Call("Cancel_All_Orders", input)
End Sub

'Doesn't work with all Exchanges
Sub cancel_all_orders
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&command=cancel_all_orders"
	API_Call("Cancel_All_Orders", input)
End Sub

'WARNING this method can be risky due to high volatility, use it at your own risk and only use it when you know really well what you’re doing!
Sub create_market_buy_order(coinpair As String, volume As Double)
	'create_market_buy_order
	Dim v As String = NumberFormat2(volume, 1,8,8,False)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&amount=" & v & "&command=create_market_buy_order"
	API_Call("Create_Market_Buy_Order", input)
End Sub

'WARNING this method can be risky due to high volatility, use it at your own risk and only use it when you know really well what you’re doing!
Sub create_market_sell_order(coinpair As String, volume As Double)
	Dim v As String = NumberFormat2(volume, 1,8,8,False)
	Dim input As String = "bot=" & Main.Selected_Bot.name & "&symbol=" & coinpair & "&amount=" & v & "&command=create_market_sell_order"
	API_Call("Place_Market_Sell_Order", input)
End Sub

Private Sub API_Call(Call As String, input As String)
	Log("-------------------- API Call '" & Call & "' --------------------")
	Log("Wait For(Start_Job(" & Call & ", " & PHP_URL & ", " & input & ")) Complete (Result As String)")
	Wait For(Start_Job(Call, PHP_URL, input)) Complete (Result As String)
	
	'***** test_ui *****
	test_ui.txt_Output.Text = Result
End Sub


Private Sub Start_Job(Call As String, URL As String, Input As String) As ResumableSub
'	Log("ccxt.Start_Job(" & URL & "?" & Input & ")")
'	Log(URL)
	Dim Job As HttpJob
	Job.Initialize("", Me)
	Dim Result As String = "Null"
	
	Try
		Job.Download(URL & "?" & Input)
		Wait For (Job) JobDone(Job As HttpJob)
		
		Log("B4J Job Success = " & Job.Success)
		
		If Job.Success Then
			
			Result = Job.GetString
			Log(Result)
			If Result <> "Null" Then
				Dim JResult As String = Filter_JSON_String(Result)
				
				Select Call
					Case "Test_PHP"
						
					Case "Test_CCXT"
						
					Case "Get_Exchanges"
						Get_Exchanges_completed(JResult)
					Case "Get_Exchange_Info"
						Get_Exchange_Info_completed(JResult)
					Case "Get_Markets"
						Get_Markets_completed(JResult)
					Case "Get_Ticker"
						Get_Ticker_completed(JResult)
					Case "Get_All_Tickers"
						Get_All_Tickers_completed(JResult)
					Case "Get_OrderBook"
						Get_Orderbook_completed(JResult)
					Case "Get_OHLCV"
						Get_OHLCV_completed(JResult)
					Case "Get_Public_Trade_History"
						
					Case "Get_My_Balances"
						Get_My_Balances_completed(JResult)
					Case "Get_My_Open_Orders"
						Get_All_My_Open_Orders_Completed(JResult)
					Case "Get_All_My_Open_Orders"
						Get_All_My_Open_Orders_Completed(JResult)
					Case "Get_My_Trade_History"
						Get_My_Trade_History_Completed(JResult)
					Case "Get_All_My_Trade_History"
						Get_All_My_Trade_History_Completed(JResult)
					Case "Create_Limit_Buy_Order"
						Order_Completed(JResult)
					Case "Create_Limit_Sell_Order"
						Order_Completed(JResult)
					Case "Edit_Limit_Order"
						Remove_My_Order(Canceled_Order_ID)					'Remove the Canceled Order from All_My_Orders_List
						Order_Completed(JResult)
						'Edit_Limit_Order_Completed(JResult)
					Case "Place_Market_Buy_Order"
						
					Case "Place_Market_Sell_Order"
						
					Case "Cancel_Order"
						Cancel_Order_Completed(JResult)
					Case "Cancel_All_Orders"
						Cancel_All_Orders_Completed(JResult)
					Case Else
						Log("Sub:Start_Job, Case """ & Call & """ DOES NOT EXIST!!!")
					End Select
			Else
				LogError("result = " & Result)
			End If
			
		Else
			LogError("Job Failed!!!")
			Result = Job.ErrorMessage
			'Log("Fail! See logs for details...")
		End If
		
	Catch
		Log(LastException)
	End Try
	
	Job.Release
	Return Result
End Sub

Private Sub Get_Exchanges_completed(result As String)
Log("Get_Exchanges_completed")

Try
	If Is_JSON(result) = True Then
		JSON.Initialize(result)
		Dim L As List
		L = JSON.NextArray
		For i = 0 To L.Size-1
			'Dim exch As String = L.Get(i)
			'Log(exch)
			'....  Your code here
			
		Next
	End If
	
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Get_Exchange_Info_completed(result As String)
	Log("Get_Exchange_Info_completed")
	'Example of some methods...
	'createDepositAddress': false,
	'createOrder': true,
	'fetchBalance': true,
	'fetchCanceledOrders': false,
	'fetchMyTrades': false,								'- though not a part of the orders’ API, it is closely related, since it provides the history of *my settled trades.
	'fetchClosedOrder': false,							'- fetches *my single closed order by order id
	'fetchClosedOrders': false,						'- fetches a list of *my closed (or canceled) orders.
	'fetchOpenOrder': false,							'- fetches *my single open order by order id
	'fetchOpenOrders': false,							'- fetches a list of *my open orders.
	'fetchOrder': false,										'- fetches *my single order (open or closed) by order id.
	'fetchOrders': false,									'- fetches a list of all *my orders (either open or closed/canceled).
	'fetchCurrencies': false,								'-fetches all available currencies an exchange and returns an associative dictionary of currencies (objects with properties such as code, name, etc.).
	'fetchDepositAddress': false,
	'fetchMarkets': true,
	'fetchOHLCV': false,
	'fetchOrderBook': true,
	'fetchStatus': 'emulated',							'-returns information regarding the exchange status from either the info hardcoded in the exchange instance or the API, if available.
	'fetchTicker': true,										'-fetches latest ticker data by trading symbol.
	'fetchTickers': false,
	'fetchBidsAsks': false,
	'fetchTrades': true,										'- fetches recent *public trades for a particular trading symbol
	
	OHLCV_TimeFrame_List.Initialize
	
	Try
		If Is_JSON(result) = True Then
			JSON.Initialize(result)
			Dim m1, m2 As Map
			m1 = JSON.NextObject
			Log("id: " & m1.Get("id"))
			Log("countries: " & m1.Get("countries"))
			m2 = m1.Get("has")
			Log("Get_Markets: " & m2.Get("fetchMarkets"))
			Log("Get_Ticker: " & m2.Get("fetchTicker"))
			Log("Get_All_Tickers: " & m2.Get("fetchTickers"))
			Log("Get_OrderBook" & m2.Get("fetchOrderBook"))
			Log("Get_OHLCV: " & m2.Get("fetchOHLCV"))
			Log("Get_Public_Trade_History: " & m2.Get("fetchTrades"))
			Log("Get_My_Balances: " & m2.Get("fetchBalance"))
			Log("Get_All_My_Open_Orders: " & m2.Get("fetchOpenOrders"))
			Log("Cancel_Order: " & m2.Get("cancelOrder"))
			m2 = m1.Get("timeframes")															'for OHLCV
			For i = 0 To m2.Size-1
				Dim tf As String = m2.GetKeyAt(i)
				OHLCV_TimeFrame_List.Add(tf)
			Next
			Log("Supported OHLCV Time Frames: " & OHLCV_TimeFrame_List)
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Get_Markets_completed(result As String)
Log("Get_Markets_completed")
'	[{"id":"1INCHUSD","symbol":"1INCH/USD","base":"1INCH","quote":"USD","settle":null,"baseId":"1INCH","quoteId":"ZUSD","settleId":null,"darkpool":false,
'	"altname":"1INCHUSD","type":"spot","spot":true,"margin":false,"swap":false,"future":false,"option":false,"active":true,"contract":false,"linear":null,"inverse":null,
'	"taker":0.0026,"maker":0.0016,"contractSize":null,"expiry":null,"expiryDatetime":null,"strike":null,"optionType":null,"precision":{"amount":8,"price":3},
'	"limits":{"leverage":{"min":1,"max":1},"amount":{"min":5,"max":null},"price":{"min":0.001,"max":null},"cost":{"min":null,"max":null}},
'	"info":{"altname":"1INCHUSD","wsname":"1INCH/USD","aclass_base":"currency","base":"1INCH","aclass_quote":"currency","quote":"ZUSD","lot":"unit",
'	"cost_decimals":"5","pair_decimals":"3","lot_decimals":"8","lot_multiplier":"1","leverage_buy":[],"leverage_sell":[],
'	"fees":[[0,0.26],[50000,0.24],[100000,0.22],[250000,0.2],[500000,0.18],[1000000,0.16],[2500000,0.14],[5000000,0.12],[10000000,0.1]],
'	"fees_maker":[[0,0.16],[50000,0.14],[100000,0.12],[250000,0.1],[500000,0.08],[1000000,0.06],[2500000,0.04],[5000000,0.02],[10000000,0]],
'	"fee_volume_currency":"ZUSD","margin_call":"80","margin_stop":"40","ordermin":"5","costmin":"0.5","tick_size":"0.001"}}]
	
Try
	'Log(result)
	If Is_JSON(result) Then
		JSON.Initialize(result)
		Dim coinpair, pcoin, scoin As String
		Dim L1 As List
		Dim m1 As Map
		L1 = JSON.NextArray
		Log(L1)
		
		Pcoin_List.Initialize
		Scoin_List.Initialize
		Coinpair_List.Initialize
		test_ui.cmb_Coinpair.Items.Clear
		
		For i = 0 To L1.Size-1
			m1 = L1.Get(i)
			Log(m1)
			pcoin = m1.Get("base")
			Pcoin_List.Add(pcoin)
			coinpair = m1.Get("symbol")
			Coinpair_List.Add(coinpair)
			scoin = m1.Get("quote")
			If Scoin_List.IndexOf(scoin) = -1 Then Scoin_List.Add(scoin)
		Next
		
		'***** test_ui ***** Fill secondary coin combo box
		test_ui.cmb_Scoin.Items.Clear
		Scoin_List.Sort(True)
		For Each coin In Scoin_List
			test_ui.cmb_Scoin.Items.Add(coin)
		Next
	End If
	
Catch
	Log(LastException)
End Try
End Sub

Private Sub Get_Ticker_completed(result As String)
	Log("Get_Ticker_completed")
	'symbol':        string symbol of the market ('BTC/USD', 'ETH/BTC', ...)
	'info':        { the original non-modified unparsed reply from exchange API },
	'timestamp':     int (64-bit Unix Timestamp in milliseconds since Epoch 1 Jan 1970)
	'datetime':      ISO8601 datetime string with milliseconds
	'high':          float, // highest price
	'low':           float, // lowest price
	'bid':           float, // current best bid (buy) price
	'bidVolume':     float, // current best bid (buy) amount (may be missing or undefined)
	'ask':           float, // current best ask (sell) price
	'askVolume':     float, // current best ask (sell) amount (may be missing or undefined)
	'vwap':          float, // volume weighed average price
	'open':          float, // opening price
	'close':         float, // price of last trade (closing price for current period)
	'last':          float, // same as `close`, duplicated for convenience
	'previousClose': float, // closing price for the previous period
	'change':        float, // absolute change, `last - open`
	'percentage':    float, // relative change, `(change/open) * 100`
	'average':       float, // average price, `(last + open) / 2`
	'baseVolume':    float, // volume of base currency traded for last 24 hours
	'quoteVolume':   float, // volume of quote currency traded for last 24 hours
	
	Try
		If Is_JSON(result) = True Then
			JSON.Initialize(result)
			Dim m1 As Map
			m1 = JSON.NextObject
			Dim coinpair As String = m1.Get("symbol")
			Log("-----" & coinpair & "-----")
			Log("TS: " & m1.Get("timestamp"))
			Log(	Calc.My_Date_Time( m1.Get("timestamp")))
			'm2 = m1.Get("info")
			Log("price: " & m1.Get("close"))		'same as "last"
			Log("24hr volume: " & m1.Get("quoteVolume") & " " & Calc.Get_Scoin(coinpair))
			Log("24hr change: " & m1.Get("change") & "%")
			
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Get_All_Tickers_completed(result As String)
Log("Get_Tickers_completed")
	'same options as Get_Ticker_completed ^^^
	Try
		If Is_JSON(result) = True Then
			JSON.Initialize(result)
			Dim m1, m2 As Map
			m1 = JSON.NextObject
			
			For i = 0 To m1.Size-1
				Dim coinpair As String = m1.GetKeyAt(i)
				'If coinpair.EndsWith(Main.Selected_Scoin) Then				'only log quote coins
					m2 = m1.GetValueAt(i)
					Log("----------" & coinpair & "----------")
					Log(	Calc.My_Date_Time( m2.Get("timestamp")))
					Log("Last Price: " & m2.Get("last"))
				'End If
			Next
			
		End If
	
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Get_Orderbook_completed(result As String)
Log("Get_Orderbook_completed")
Try
	'Log(result)
	If Is_JSON(result) Then
		JSON.Initialize(result)
		Dim coinpair As String
		Dim price, volume As Double
		Dim L1, L2 As List
		Dim m1 As Map
		m1 = JSON.NextObject
		coinpair = m1.Get("symbol")
		If coinpair = Main.Selected_Coinpair Then
			Buy_Orderbook_Map.Initialize
			L1 = m1.Get("bids")
			For i = 0 To L1.Size - 1
				L2 = L1.Get(i)
				price = L2.Get(0)
				volume = L2.Get(1)
				Buy_Orderbook_Map.Put(price, volume)
			Next
				
			Sell_Orderbook_Map.Initialize
			L1 = m1.Get("asks")
			For i = 0 To L1.Size - 1
				L2 = L1.Get(i)
				price = L2.Get(0)
				volume = L2.Get(1)
				Sell_Orderbook_Map.Put(price, volume)
			Next
		End If
	End If
	
Catch
		Log(LastException)
	End Try
End Sub

Private Sub Get_OHLCV_completed(result As String)
Log("Get_OHLCV_completed")
Try
	If Is_JSON(result) = True Then
		JSON.Initialize(result)
		Dim L1, L2 As List
		L1 = JSON.NextArray
		
		For i = 0 To L1.Size-1
			L2 = L1.Get(i)
			Log("TS: " & L2.Get(0) & " open: " & L2.Get(1) & " high: " & L2.Get(2) & " low: " & L2.Get(3) & " close: " & L2.Get(4) & " volume: " & L2.Get(5))
		Next
		
	End If

Catch
	Log(LastException)
End Try
End Sub

Private Sub Get_My_Balances_completed(result As String)
Log("Get_My_Balances_completed")
'getting Map "info" may have extra data but is exchange specific
	Try
		If Is_JSON(result) = True Then
			JSON.Initialize(result)
			Dim m1, m2 As Map
			'Dim pcoin As String
			m1 = JSON.NextObject
			'Log(m1)
			
'			m2 = m1.Get("total")
'			For Each Key As String In m2.Keys
'				Log(Key & ", " & Key.Length)
'			Next
			Log("----- Balance Held -----")
			m2 = m1.Get("used")
			For Each Key As String In m2.Keys
				Dim val As Object = m2.Get(Key)
				If val <> Null And val > 0 Then Log(Key & ": " & val)
			Next
			
			Log("----- Balance Available -----")
			m2 = m1.Get("free")
			For Each Key As String In m2.Keys
				Dim val As Object = m2.Get(Key)
				If val <> Null And val > 0 Then Log(Key & ": " & val)
			Next
			
			Log("----- Balance Total -----")
			m2 = m1.Get("total")
			For Each Key As String In m2.Keys
				Dim val As Object = m2.Get(Key)
				If val <> Null And val > 0 Then Log(Key & ": " & val)
			Next
			
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Get_All_My_Open_Orders_Completed(result As String)
Log("Get_All_My_Open_Orders_Completed")

Try
	Calc.All_My_Orders_List.Initialize									'reset All_My_Orders_List
	If Is_JSON(result) = True Then
		JSON.Initialize(result)
		Dim L As List
		Dim m As Map
		L = JSON.NextArray
		For i = 0 To L.Size-1
			Dim my_order As Order : 	my_order.Initialize
			m = L.Get(i)
			Add_My_Order(m.Get("timestamp"), m.Get("symbol"), m.Get("side"), m.Get("id"), m.Get("price"), m.Get("amount"), m.Get("filled"), m.Get("remaining"), m.Get("type"), m.Get("status"))
		Next
	End If
	
Catch
	Log(LastException)
End Try
End Sub

Private Sub Get_My_Trade_History_Completed(result As String)
Log("Get_My_Trade_History_Completed")
'Most exchanges only let you get trade history for one coinpair at a time
'you can narrow your trade history calls by only looking at coins with a current balance...

End Sub

Private Sub Get_All_My_Trade_History_Completed(result As String)
Log("Get_All_My_Trade_History_Completed")
Try
	Calc.All_My_Trades_List.Initialize									'reset All_My_Trades_List
	
	If Is_JSON(result) = True Then
		JSON.Initialize(result)
		Dim m1, m2 As Map
		Dim L1 As List
		L1 = JSON.NextArray
		'Log(L1)
			
		For i = 0 To L1.Size-1
			m1 = L1.Get(i)
			m2 = m1.Get("fee")
			Add_My_Trade(m1.Get("timestamp"), m1.Get("symbol"), m1.Get("side"), m1.Get("id"), m1.Get("order"), m1.Get("price"), m1.Get("amount"), m1.Get("type"), m2.Get("cost"), m2.Get("currency"))
		Next
	End If

Catch
	Log(LastException)
End Try
End Sub

Private Sub Order_Completed(result As String)
Log("Order_Completed")

Try
	If Is_JSON(result) = True Then
		JSON.Initialize(result)
		Dim m As Map
		m = JSON.NextObject
		Dim ts As Long = m.GetDefault("timestamp", DateTime.Now)
		Dim coinpair As String = m.GetDefault("symbol", "none")
		Dim side As String = m.GetDefault("side", "none")
		Dim id As String = m.GetDefault("id", "none")
		Dim amount As Double = m.GetDefault("amount", 0)
		Dim filled As Double = m.GetDefault("filled", 0)
		Dim remaining As Double = m.GetDefault("remaining", 0)
		Dim order_type As String = m.GetDefault("type", "none")
		Dim status As String = m.GetDefault("status", "none")
		
		If side = "sell" Then
			Dim price As Double = m.GetDefault("price", 0)
		Else 'buy
			Dim price As Double = m.GetDefault("price", 1000000)			'1,000,000 error price for safety (bot won't resell for cheap thinking it aquired free coins)
		End If
		
		If result.Contains("error") = False Then Add_My_Order(ts, coinpair, side, id, price, amount, filled, remaining, order_type, status)
	End If
	
Catch
		Log(LastException)
	End Try

End Sub

Private Sub Cancel_Order_Completed(result As String)
'It seems you get a varied response here, depending on the exchange. Coinbase returns the canceled order id, Kraken just returns a cancel count.
'b4j will have to remember the canceled order id and remove it after confirming that the cancel worked.
'it will fail if:
' --> your canceled order already filled.
' --> your order was already canceled.

	Log("Cancel_Order_Completed")
	Try
		Log(result)
		If Main.Selected_Bot.exchange.Contains("coinbase") Then
			Dim id As String = result.SubString2(3, result.Length-4)			'remove extra characters from ccxt, this may not always work...
			Log(id)
			Remove_My_Order(id)
		Else If Main.Selected_Bot.exchange.Contains("kraken") Then
			JSON.Initialize(result)
			Dim m As Map = JSON.NextObject
			Dim error_list As List = m.Get("error")
			Dim result_map As Map = m.Get("result")
			Dim k_count As Int
			Log(error_list)
			Log(result_map)
			k_count = result_map.GetDefault("count", 0)
			If k_count = 1 Then
				Remove_My_Order(Canceled_Order_ID)
			Else
				Log(result_map)
			End If
		'Else If Main.Selected_Bot.exchange.Contains("your_exchange") Then
			
		End If
	Catch
		Log(LastException)
	End Try
End Sub

Private Sub Cancel_All_Orders_Completed(result As String)
	Log("Cancel_All_Orders_Completed")
	Try
		Log(result)
		
		If Is_JSON(result) = True Then
			JSON.Initialize(result)
			If Main.Selected_Bot.exchange = "kraken" Then
				Dim m1, m2 As Map
				m1 = JSON.NextObject
				m2 = m1.Get("result")
				Dim count As Int = m2.GetDefault("count", 0)
				If count >= Calc.All_My_Orders_List.Size Then
					Calc.All_My_Orders_List.Clear
					test_ui.Update_Orders
				End If
			Else																					'this may create an error depending on the exchange
				Dim L1 As List
				L1 = JSON.NextArray
				For i = 0 To L1.Size-1
					Dim id As String = L1.Get(i)
					Remove_My_Order(id)
				Next
			End If
		If Calc.All_My_Orders_List.Size > 0 Then LogError("All_My_Orders_List.Size = " & Calc.All_My_Orders_List.Size & ", but should be 0")
		End If
		
	Catch
		Log(LastException)
	End Try
End Sub

'Sub Get_Order_Index(id As String) As Int				'useful when canceling/removing an order
'	Dim this_id As String
'	Dim found_it_index As Int = -1
'		
'	For i = 0 To Calc.All_My_Orders_List.Size-1
'		Dim my_order As Order = Calc.All_My_Orders_List.Get(i)
'		this_id = my_order.id
'		If id.Contains(this_id) Then
'			found_it_index = i
'		End If
'	Next
'	Return found_it_index
'End Sub

Sub Add_My_Trade(TS As Long, Coinpair As String, Side As String, trade_id As String, order_id As String, price As Double, volume As Double, trade_type As String, fee As Double, fee_currency As String)
	'may want to add code to ignore/replace duplicate trade id's
	Dim total As Double = price * volume
	Dim this As AMT
	this.TS = TS												'1502962946216
	this.Coinpair = Coinpair								'ETH/BTC
	this.Side = Side											'buy
	this.trade_id = trade_id								'12345-67890:09876/54321	// string trade id
	this.order_id = order_id								'12345-67890:09876/54321	// order id for the trade
	this.Price = price										'0.06917684
	this.Volume = volume								'1.5
	this.total = total											'0.10376526
	this.trade_type = trade_type						'limit
	this.Fee = fee												'0.0015
	this.Fee_Currency = fee_currency			'ETH											// usually base(pcoin) currency for buys, quote(scoin) currency for sells
	Calc.All_My_Trades_List.Add(this)
End Sub

'Add a single order to AMO_List
Sub Add_My_Order(TS As Long, Coinpair As String, Side As String, id As String, Price As Double, Volume As Double, Filled As Double, Remaining As Double, Order_Type As String, Status As String)
If id <> "none" Then	
	Dim total As Double = Price * Volume
	Dim this As Order : this.Initialize
	'Ignore adding order if it already exists, may want to change code to Replace order if it already exists...
	Dim already_exists As Boolean = False
	For i = 0 To Calc.All_My_Orders_List.Size-1
		Dim compare_order As Order = Calc.All_My_Orders_List.Get(i)
		If compare_order.id = id Then already_exists = True
	Next
	If already_exists = True Then
		Log("Order '" & id & "' already exists")
	Else		'add the order	
		this.TS = TS : this.Coinpair = Coinpair : this.side = Side : this.id = id : this.Price = Price : this.Volume = Volume : this.Total = total
		this.filled = Filled : this.remaining = Remaining		'in base currency
		this.Order_Type = Order_Type									'limit
		this.Status = Status													'open
		Calc.All_My_Orders_List.Add(this)
		
		'***** test_ui *****
		test_ui.Update_Orders
		Log("Added my " & this.side & " " & this.Order_Type & " Order for " & this.Coinpair & " @ " & this.Price)
		
	End If
End If
End Sub

'Remove a single Map from AMO List
Sub Remove_My_Order(id As String)
	Dim index As Int = -1
	
	Log("started with " & Calc.All_My_Orders_List.Size & " orders")
	
	For i = 0 To Calc.All_My_Orders_List.Size-1
		Dim this As Order = Calc.All_My_Orders_List.Get(i)
		If this.id = id Then
			Log("Removed my " & this.side & " " & this.Order_Type & " Order for " & this.Coinpair & " @ " & this.Price)
			index = i
		End If
	Next
	If index > -1 Then Calc.All_My_Orders_List.RemoveAt(index)
	
	Log("ended with " & Calc.All_My_Orders_List.Size & " orders")
	
	test_ui.Update_Orders
End Sub


Sub Is_JSON(json_string As String) As Boolean
	Dim It_Is_JSON As Boolean = False
	If json_string.StartsWith("[{") Or json_string.StartsWith("[") Or json_string.StartsWith("{") Then
		It_Is_JSON = True
	End If
	Return It_Is_JSON
End Sub

Sub Filter_JSON_String(str As String) As String
	'Trim the characters before JSON string
	Dim json_string As String = "Null"
'	Log(str)
'	Log(str.Length)
	
	Dim cha As String
	Dim cha_count As Int
	
	Do Until cha = "[" Or cha = "{" Or cha_count = str.Length -1 
		cha = str.CharAt(cha_count)
		cha_count = cha_count + 1
	Loop
'	Log("first character ( " & cha & " ) at " & cha_count)
	
	json_string = str.SubString(cha_count - 1)
	'Log(json_string.Length)
	
	If json_string.Length > 2 Then
		Return json_string
	Else			'not a json string, return the original string
		Return str
	End If
End Sub

'return_json_number 0 for first json string, 1 for second, etc...
Sub Count_JSON_String(result As String, return_json_number As Int) As String
	'----- Get the start of the first JSON portion
	Dim starting_string As String = "[5] => "
	Dim json_string As String = result
	
	For i = 0 To return_json_number
		Dim starting_index As Int = json_string.IndexOf(starting_string) + starting_string.Length
		json_string = json_string.SubString(starting_index)
	Next
	
	'----- count the brackets, add the open brackets, subtract the closing brackets. when all three counts are 0, the json section is done
'	Dim square_curly_count As Int
	Dim curly_count As Int
	Dim square_count As Int
	Dim character_count As Int
	Do While curly_count > 0 Or square_count > 0 Or character_count = 0
		Dim ch As String = json_string.CharAt(character_count)
		If ch = "[" Then square_count = square_count + 1
		If ch = "]" Then square_count = square_count - 1
		If ch = "{" Then curly_count = curly_count + 1
		If ch = "}" Then curly_count = curly_count - 1
		character_count = character_count + 1
	Loop
	
	json_string = json_string.SubString2(0, character_count)
	LogError(json_string.Length & "   " & json_string)
	
	Return json_string
End Sub


#Region ---------- Redundant, my preferred designations

Sub Markets
	fetch_markets
End Sub

'Get Ticker for a single coinpair
Sub Ticker(coinpair As String)
	fetch_ticker(coinpair)
End Sub

Sub All_Tickers
	fetch_tickers
End Sub

'limit = 0 for maximum
Sub OrderBook(coinpair As String, limit As Int)
	fetch_l2_order_book(coinpair, limit)
End Sub

'get timeframe options from Exchange_Info (s m h d w M y) default = 1m.
Sub OHLCV(coinpair As String, timeframe As String)	'optional ccxt variables ($since, $limit)
	fetch_ohlcv(coinpair, timeframe)
End Sub

'Get public trade history for a certain coin.
Sub Public_Trade_History(coinpair As String, limit As Int)		'optional ccxt variable($since)
	fetch_trades(coinpair, limit)
End Sub

Sub My_Balances
	fetch_balance
End Sub

Sub My_Open_Orders(coinpair As String)	'optional ccxt variables ($since, $limit)
	fetch_open_orders(coinpair)
End Sub

'All my open orders for any coinpair
Sub All_My_Open_Orders		'optional ccxt variables ($since, $limit)
	fetch_all_open_orders
End Sub

'Some exchanges require a coinpair
Sub My_Trade_History(coinpair As String, since As Long, limit As Int)
	fetch_my_trades(coinpair, since, limit)
End Sub

'All coins
Sub All_My_Trade_History(since As Long, limit As Int)
	fetch_all_my_trades(since, limit)
End Sub

'WARNING this method can be risky due to high volatility, use it at your own risk and only use it when you know really well what you’re doing!
Sub Place_Market_Buy_Order(coinpair As String, volume As Double)
	create_market_buy_order(coinpair, volume)
End Sub

'WARNING this method can be risky due to high volatility, use it at your own risk and only use it when you know really well what you’re doing!
Sub Place_Market_Sell_Order(coinpair As String, volume As Double)
	create_market_sell_order(coinpair, volume)
End Sub




#End Region

