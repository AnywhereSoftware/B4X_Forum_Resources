B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
'RabbitMQ Sample
'
'Original Sample code By  MAGMA, Georgios Kantzas.
'Link: https://www.b4x.com/android/forum/threads/b4j-rabbitmq-client-ssl-username-password.166110/
'
'Library And Advance Code Sample By Frost Codes ( Oluwaseyi Aderinkomi )
'
'
'License:
'This project Is licensed under the Apache License 2.0 And depends on the RabbitMQ Java Client,
'which is triple-licensed under MPL 2.0, GPLv2, and Apache License 2.0.
'
'
'Code:    https://github.com/frostcodes/FrostRabbitMQ-For-B4J
'Links: 
'         https://github.com/frostcodes
'         https://www.b4x.com/android/forum/members/frostcodes.107647/
'
'
'Support my work 👇👇
'  LINK 1: https://flutterwave.com/donate/xua1z1xmabji
'  LINK 2: https://paystack.com/pay/rbhzwdgozj

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
	Private fx As JFX
	
	Private Button1 As Button
	Private FrostRabbitMQ1 As FrostRabbitMQ
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.
Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	FrostRabbitMQ1.Initialize(Me, "FrostRabbitMQ1")
	
	#Region Uncomment to test!
	'FrostRabbitMQ1.SetRequestedHeartbeat(30) 'Call and change before connecting to RabbitMq
	'FrostRabbitMQ1.DisableAutomaticRecovery 'Call before connecting to RabbitMq
	#End Region

	Dim IsRabbitMqConnected As Boolean = FrostRabbitMQ1.ConnectToRabbitMQ("127.0.0.1", FrostRabbitMQ1.PORT_NORMAL, "localroot", "1234", "/")

	If IsRabbitMqConnected Then
		Log("RMQ connected. Connection and Channel are ready")
		Log("In this example, the code is continued in the 'ChannelReady' event")
		
		'NOTE:
		' You can either:
		'   1) Use the callback events (ConnectionReady / ChannelReady) to continue your code, OR
		'   2) Continue execution here as both the connection and channel are ready here.
		'
		' Guidelines:
		' - Use "ConnectionReady" for connection-level setup only (e.g., logging in, opening channels).
		' - Use "ChannelReady" for channel-specific setup (e.g., declaring queues/exchanges, starting consumers, publishing messages, etc).
		' - Only start consuming or sending messages *after* "ChannelReady" has been called.
	End If
End Sub

Private Sub Button1_Click
	SendSampleMessages
End Sub

Private Sub Button2_Click
	If FrostRabbitMQ1.IsConnectionOpened Then
		Log("✅ Connection is open")
	Else
		Log("❌ Connection is closed")
	End If
End Sub

Private Sub Button3_Click
	If FrostRabbitMQ1.IsChannelOpened Then
		Log("✅ Channel is open")
	Else
		Log("❌ Channel is closed")
	End If
End Sub

Public Sub SendMessageToQueue(QueueName As String, Message As String)
	Try
		FrostRabbitMQ1.SendMessageToQueue(QueueName, Message) 'send message
		Log("⬆️ Message Sent: " & Message)
	Catch
		'TODO: You should handle the error!
		Log("❌ Error Sending Message: " & LastException)
	End Try
End Sub

Public Sub SendMessageToExchange(ExchangeName As String,Message As String)
	Try
		FrostRabbitMQ1.SendMessageToExchange(ExchangeName, Message) 'send message
		Log("⬆️ Message Sent to exchange: " & Message)
	Catch
		'TODO: You should handle the error!
		Log("❌ Error Sending Message to exchange: " & LastException)
	End Try
End Sub

Private Sub SendSampleMessages
	Dim k As Int = Rnd(10000, 99999)
	
	'Send to queue directly
	SendMessageToQueue("test_queue", "Test - 1   ::::  " & k) 'send random messages...
	SendMessageToQueue("test_queue", "Test - 2   ::::  " & k) 'send random messages...
	SendMessageToQueue("test_queue", "Test - 3   ::::  " & k) 'send random messages...
End Sub


#Region FrostRabbitMQ Events
Public Sub FrostRabbitMQ1_ConnectionReady
	'YOU SHOULD NOT CONSUME MESSAGES HERE OR
	'DO ANYTHING THAT REQUIRES THE CHANNEL TO BE READY
	
	Log("📡 RabbitMQ connection opened")
End Sub

Public Sub FrostRabbitMQ1_ConnectionFailed(ex As Exception)
	Log("❌ Error RabbitMq connection error: " & ex.Message)
End Sub

Public Sub FrostRabbitMQ1_ChannelReady
	'Do setup: declare queues, start consuming, etc.
	Log("✔ RabbitMQ channel is ready")
	
	#Region Simple Sample
	'Create a new queue if it does not exist already with same params
	FrostRabbitMQ1.QueueDeclare("test_queue", True, False, False, Null)
	SendMessageToQueue("test_queue", "Hello test_queue") 'send sample message
	
	'Create a new queue with Advanced params if it does not exist already with same params
	'Read RabbitMQ docs for more information: https://www.rabbitmq.com/docs/queues
	Dim args As Map
	args.Initialize
	args.Put("x-message-ttl", 60000) ' Messages expire after 60 seconds

	FrostRabbitMQ1.QueueDeclare("expiring_queue", True, False, False, args)
	SendMessageToQueue("expiring_queue", "Hello expiring_queue. This message would be deleted automatically in the Queue after 60 secs if not consumed") 'send sample message
	
	'Create exchange if it does not exist
	FrostRabbitMQ1.ExchangeDeclare("emails.tasks", FrostRabbitMQ1.EXCHANGE_TYPE_FANOUT, True, False, Null)
	#End Region
	
	
	#Region ADVANCE SAMPLE: Create Headers exchange type with extra ARGS
	Dim ExchangeArgs As Map
	ExchangeArgs.Initialize
	ExchangeArgs.Put("x-match", "all") 'Matching rule: "all" (all header values must match) or "any" (any header matches)
	ExchangeArgs.Put("some-header", "value") 'A custom header that must match for routing
	
	FrostRabbitMQ1.ExchangeDeclare("upload.tasks", FrostRabbitMQ1.EXCHANGE_TYPE_HEADERS, True, False, ExchangeArgs)
	#End Region
	
	
	#Region Bind a quque to an exchange and send message sample
	'Bind the new queue to an exchange so it can receive the message we sent from the exchange
	FrostRabbitMQ1.QueueBind("test_queue", "emails.tasks", "")

	'Send message via an exchange if you want
	SendMessageToExchange("emails.tasks", "Test From Exchange (emails.tasks) - " & Rnd(10000,99999)) 'send message
	#End Region
	
	
	#Region Simple Sample: Send message using BasicPublish
	'Send message to queue
	Dim messageToQueue As String = "Hello from BasicPublish to queue"
	Dim messageToQueueAsBytes() As Byte = messageToQueue.GetBytes("UTF8")
	
	FrostRabbitMQ1.BasicPublish("", "test_queue", Null, messageToQueueAsBytes)
	
	'Send message to exchange
	Dim messageToExchange As String = "Hello from BasicPublish to Exchange (emails.tasks)"
	Dim messageToExchangeAsBytes() As Byte = messageToExchange.GetBytes("UTF8")
	
	FrostRabbitMQ1.BasicPublish("emails.tasks", "", Null, messageToExchangeAsBytes)
	#End Region
	
	
	#Region Advanced Sample: BasicPublish2 with BasicProperties and headers sample
	' Prepare properties
	Dim headers As Map
	headers.Initialize
	headers.Put("app", "B4XProducer")
	headers.Put("type", "test")

	Dim props As JavaObject = FrostRabbitMQ1.CreateBasicProperties(FrostRabbitMQ1.DELIVERY_MODE_PERSISTENT, FrostRabbitMQ1.CONTENT_TYPE_TEXT_PLAIN, headers)
	'OR you can define like this:
'	Dim props As JavaObject = FrostRabbitMQ1.CreateBasicProperties(2, "text/plain", headers)

	' Message body
	Dim msg() As Byte = "Hello from B4X with headers and BasicProperties".GetBytes("UTF8")

	' Publish to exchange
	FrostRabbitMQ1.BasicPublish2("emails.tasks", "", True, props, msg)
	#End Region
	
	
	#Region Queue Unbind Sample
	'Unbind the queue so it wont receive newer messages from the exchange
	FrostRabbitMQ1.QueueUnbind("test_queue", "emails.tasks", "")
	
	'Send a message the the queue wont receive. If you want to receive it, create another queue and bind it to the Exchange (emails.tasks)
	SendMessageToExchange("emails.tasks", "Any NEW messages from the Exchange (emails.tasks) wont be received by the queue: test_queue") 'send message
	#End Region	
	
	
	#Region Consume new messages from queue
	FrostRabbitMQ1.SetPrefechCount(4)
	Private MessageReceiverStarted As Boolean = FrostRabbitMQ1.ReceiveSecureMessages("test_queue", False) 'Manuel ack
	'Private MessageReceiverStarted As Boolean = FrostRabbitMQ1.ReceiveSecureMessages("test_queue", True) 'Auto ack enabled
		
	If Not(MessageReceiverStarted) Then
		Log("❌ Error Message Receiver Failed To Start: " & LastException)
		Return
	End If
		
	SendSampleMessages
	#End Region
	
	#Region Extra Samples - Uncomment to test
'	LogColor("GetConsumerTag:   " & FrostRabbitMQ1.GetConsumerTag, xui.Color_Cyan)
'	Sleep(5000)
'	
'	FrostRabbitMQ1.BasicCancel(FrostRabbitMQ1.GetConsumerTag)
'	Sleep(5000)
'	
'	FrostRabbitMQ1.CloseChannel
'	FrostRabbitMQ1.CloseConnection
	#End Region
End Sub

Public Sub FrostRabbitMQ1_ChannelShutdownCompleted(Reason As String)
	Log("⚠️ Channel closed")
	Log("Shutdown reason: " & Reason)
End Sub
 
Public Sub FrostRabbitMQ1_ConnectionShutdownCompleted(Reason As String)
	Log("⚠️ Connection closed")
	Log("Shutdown reason: " & Reason)
End Sub
 
Sub FrostRabbitMQ1_HandleRecoveryStarted(r As JavaObject)
	Log("⏳ Auto connection recovery started... You don't have to do anything " & r)
End Sub

Sub FrostRabbitMQ1_HandleTopologyRecoveryStarted(r As JavaObject)
	Log("⏳ TopologyRecoveryStarted: " & r)
	'You don't have to do anything
End Sub

Sub FrostRabbitMQ1_HandleRecovery(r As JavaObject)
	Log("🔁 Recovered: " & r)
	'You don't have to do anything
End Sub

Private Sub FrostRabbitMQ1_MessageReceived(Message As String, MessageInfo As Map)
	Dim Envelope As Map = FrostRabbitMQ1.ExtractEnvelopeData(MessageInfo.Get("Envelope"))
	Dim Properties As Map = FrostRabbitMQ1.ExtractBasicProperties(MessageInfo.Get("BasicProperties"))
	
	Dim DeliveryTag As Long = Envelope.Get("DeliveryTag")
	Dim	ConsumerTag As String = MessageInfo.Get("ConsumerTag")
	
	Log("📩 Message Received: " & Message)
	Log(Envelope)
	Log(Properties)
	
	Log($"ConsumerTag: ${ConsumerTag} and DeliveryTag: ${DeliveryTag}"$)
	
	Try
'		 ✅ Do your processing here
		'TODO: do some work here with message like save to DB, Logs or anything
		
'		Dim i As Int ="crash" 'Using this would stimulate a crash and would NACK the message instead in Manuel ACK mode
		FrostRabbitMQ1.Ack(DeliveryTag) 'TODO: Remove if you are using Auto Ack mode!
	Catch
'		❌ If failed:
		FrostRabbitMQ1.Nack(DeliveryTag) 'TODO: Remove if you are using Auto Ack mode!
'		Log("❌ Message failed:" & LastException)
	End Try
	
	Log("===================")
End Sub

Private Sub FrostRabbitMQ1_ConsumerClosed(ConsumerTag As String)
	Log($"WARNING: the queue consumer with tag: ${ConsumerTag} connection has been cancelled/closed!"$)
	ExitApplication 'Handle how you want or close the program
End Sub

'Called if your client(using "BasicCancel") is the one that requested that the consumer be cancelled
Private Sub FrostRabbitMQ1_ClientCancelledConsumer(ConsumerTag As String)
	Log("👌 Client cancelled consumer: " & ConsumerTag)
End Sub
#End Region
