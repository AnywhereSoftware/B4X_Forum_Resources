B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
'FrostRabbitMQ
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

#Region Events

#Event: ConnectionReady
#Event: ConnectionFailed (ex As Exception)
#Event: ChannelReady

#Event: ChannelShutdownCompleted (Reason As String)
#Event: ConnectionShutdownCompleted (Reason As String)
#Event: HandleRecoveryStarted (r As JavaObject)

#Event: HandleTopologyRecoveryStarted (r As JavaObject)
#Event: HandleRecovery (r As JavaObject)
#Event: MessageReceived (Message As String, MessageInfo As Map)

#Event: ConsumerClosed (ConsumerTag As String)
#Event: ClientCancelledConsumer (ConsumerTag As String)

#End Region


#Region RaisesSynchronousEvents

#RaisesSynchronousEvents: Channel_Event
#RaisesSynchronousEvents: Connection_Event
#RaisesSynchronousEvents: Recovery_Event

#End Region

Private Sub Class_Globals
	#Region Constants
	'Ports
	Public const PORT_SSL As Int = 5671
	Public const PORT_NORMAL As Int = 5672
	
	'Virtual Host
	Public const VIRTUAL_HOST_DEFAULT As String = "/"
	
	' Exchange types: This is defined in the "Initialize" sub.
	Public EXCHANGE_TYPE_DIRECT As Object
	Public EXCHANGE_TYPE_FANOUT As Object
	Public EXCHANGE_TYPE_TOPIC As Object
	Public EXCHANGE_TYPE_HEADERS As Object
	
	'Delivery Mode
	Public const DELIVERY_MODE_NON_PERSISTENT As Int = 1
	Public const DELIVERY_MODE_PERSISTENT As Int = 2
	
	'Content Types Sample
	Public const CONTENT_TYPE_TEXT_PLAIN As String = "text/plain"
	Public const CONTENT_TYPE_APPLICATION_JSON As String = "application/json"
	#End Region
	
	Private mEventName As String
	Private mCallBack As Object
	
	Private Channel As JavaObject
	Private Connection As JavaObject
	Private ConnectionFactory As JavaObject
	Private BuiltinExchangeType As JavaObject
	
	Private CurrentConsumerTag As String
	Private HeatbeatTimeInSeconds As Int = -1 'We use -1 to denote the default and if left as is, we dont change the original heartbeat when setting up the connection
	Private AutomaticRecoveryEnabled As Boolean = True 'Connection is auto recovered unless changed.
End Sub

Public Sub Initialize(Callback As Object, EventName As String)
	mCallBack = Callback
	mEventName = EventName

	'Create static object
	BuiltinExchangeType.InitializeStatic("com.rabbitmq.client.BuiltinExchangeType")
	
	'Initialize ENUM constants
	EXCHANGE_TYPE_DIRECT = GetExchangeTypeEnumValue("DIRECT")
	EXCHANGE_TYPE_FANOUT = GetExchangeTypeEnumValue("FANOUT")
	EXCHANGE_TYPE_TOPIC = GetExchangeTypeEnumValue("TOPIC")
	EXCHANGE_TYPE_HEADERS = GetExchangeTypeEnumValue("HEADERS")
End Sub

'Get the Enum value of an Exchange Type
Private Sub GetExchangeTypeEnumValue(ExchangeType As String) As Object
	Return BuiltinExchangeType.RunMethod("valueOf", Array(ExchangeType.ToUpperCase))
End Sub

'Connect to your RabbitMQ server
Public Sub ConnectToRabbitMQ(Host As String, Port As Int, UserName As String, Password As String, VirtualHost As String) As Boolean
	Try
		#Region General connection configurations
		
		'Initialize Connection Factory
		Dim ConnectionFactory As JavaObject
		ConnectionFactory.InitializeNewInstance("com.rabbitmq.client.ConnectionFactory", Null)
		
		'Set RabbitMQ Server Details
		ConnectionFactory.RunMethod("setHost", Array(Host))
		ConnectionFactory.RunMethod("setPort", Array(Port))
		ConnectionFactory.RunMethod("setUsername", Array(UserName))
		ConnectionFactory.RunMethod("setPassword", Array(Password))
		ConnectionFactory.RunMethod("setVirtualHost", Array(VirtualHost))
		
		'Set connection heartbeat time if a custom one was supplied
		If HeatbeatTimeInSeconds <> -1 Then
			ConnectionFactory.RunMethod("setRequestedHeartbeat", Array(HeatbeatTimeInSeconds))
		End If
		
		'Check if Automatic connection recovery was disabled. Recovery is enabled by default.
		If Not(AutomaticRecoveryEnabled) Then
			ConnectionFactory.RunMethod("setAutomaticRecoveryEnabled", Array(False))
		End If
		#End Region

 
		#Region SSL Support
		'If using SSL connection
		If Port = PORT_SSL Then
			'Use Java's Default SSL Context
			Dim SSLContext As JavaObject
			SSLContext.InitializeStatic("javax.net.ssl.SSLContext")
			SSLContext = SSLContext.RunMethod("getInstance", Array("TLSv1.2"))

			'Use Default Java TrustStore (No Manual File Loading)
			Dim TrustManagerFactory As JavaObject
			TrustManagerFactory.InitializeStatic("javax.net.ssl.TrustManagerFactory")
			Dim TrustManagerAlgorithm As String = TrustManagerFactory.RunMethod("getDefaultAlgorithm", Null)
			TrustManagerFactory = TrustManagerFactory.RunMethod("getInstance", Array(TrustManagerAlgorithm))
			TrustManagerFactory.RunMethod("init", Array(Null)) ' Load default system CA certificates

			'Initialize SSL Context with TrustManager
			SSLContext.RunMethod("init", Array(Null, TrustManagerFactory.RunMethod("getTrustManagers", Null), Null))

			'Apply SSL to RabbitMQ Connection
			ConnectionFactory.RunMethod("useSslProtocol", Array(SSLContext))
		End If
		#End Region
		
		
		#Region Create Connection
		Dim Connection As JavaObject = ConnectionFactory.RunMethod("newConnection", Null)
		
		' Add shutdown listener To Connection - This is called when the connection is broken or was closed/shutdown
		Dim ConnectionShutdownListener As Object = Connection.CreateEventFromUI("com.rabbitmq.client.ShutdownListener", "connection", Null)
		Connection.RunMethod("addShutdownListener", Array As Object(ConnectionShutdownListener))
		
		' Detect Reconnecting if "AutomaticRecoveryEnabled" is TRUE
		' If you want To Log Or act when a reconnect happens:
		If AutomaticRecoveryEnabled Then
			Dim ConnectionRecoveryListener As Object = Connection.CreateEventFromUI("com.rabbitmq.client.RecoveryListener", "recovery", Null)
			Connection.RunMethod("addRecoveryListener", Array(ConnectionRecoveryListener))
		End If
		
		CallSubDelayed(mCallBack, mEventName & "_ConnectionReady")
		#End Region
		
		
		#Region Create Channel
		Dim Channel As JavaObject = Connection.RunMethod("createChannel", Null)
		
		' Add shutdown listener To Channel - This is called when the channel is broken or was closed/shutdown
		Dim ChannelShutdownListener As Object = Channel.CreateEventFromUI("com.rabbitmq.client.ShutdownListener", "channel", Null)
		Channel.RunMethod("addShutdownListener", Array As Object(ChannelShutdownListener))

		CallSubDelayed(mCallBack, mEventName & "_ChannelReady")
		#End Region
		 
		Return True
	Catch
		CallSubDelayed2(mCallBack, mEventName & "_ConnectionFailed", LastException)
		Return False
	End Try
End Sub

'Dynamic listener of Connection Shutdown Event
Private Sub Connection_Event(MethodName As String, Args() As Object) As Object
	If MethodName = "shutdownCompleted" Then
		Dim cause As Exception = Args(0)
		CallSubDelayed2(mCallBack, mEventName & "_ConnectionShutdownCompleted", cause.Message)
	End If
	
	Return Null
End Sub

'Dynamic listener of Channel Shutdown Event
Private Sub Channel_Event(MethodName As String, Args() As Object) As Object
	If MethodName = "shutdownCompleted" Then
		Dim cause As Exception = Args(0)
		CallSubDelayed2(mCallBack, mEventName & "_ChannelShutdownCompleted", cause.Message)
	End If

	Return Null
End Sub

'Dynamic listener of Connection Recovery Events
Private Sub Recovery_Event(MethodName As String, Args() As Object) As Object
	Dim argJo As JavaObject = Args(0)
	CallSubDelayed2(mCallBack, mEventName & "_" & MethodName, argJo)
	Return Null
End Sub

#Region RabbitMQ basicPublish Overloads
'Publish message with default flags
'
' ExchangeName    - The name of the target exchange.
' RoutingKey  - The routing key for message routing.
' Props       - BasicProperties object (can be Null if not needed).
' Body        - Message payload as a byte array.
Public Sub BasicPublish(ExchangeName As String, RoutingKey As String, Props As Object, Body() As Byte)
	Channel.RunMethod("basicPublish", Array(ExchangeName, RoutingKey, Props, Body))
End Sub

'Publish with mandatory flag
'
' ExchangeName    - The name of the target exchange.
' RoutingKey  - The routing key for message routing.
' Props       - BasicProperties object (can be Null if not needed).
' Body        - Message payload as a byte array.
' Mandatory  - If True, unroutable messages will be returned to the publisher.
Public Sub BasicPublish2(ExchangeName As String, RoutingKey As String, Mandatory As Boolean, Props As Object, body() As Byte)
	Channel.RunMethod("basicPublish", Array(ExchangeName, RoutingKey, Mandatory, Props, body))
End Sub

' Helper to Create BasicProperties
'
' This returns a JavaObject of com.rabbitmq.client.AMQP.BasicProperties
' You can customize headers, content type and delivery mode.
'
' DeliveryMode - 1 = Non-persistent, 2 = Persistent
' ContentType  - e.g., "text/plain" or "application/json". It can be an empty string also.
' Headers      - Optional Map of custom headers (can be Null if not needed).
Public Sub CreateBasicProperties(DeliveryMode As Int, ContentType As String, Headers As Map) As JavaObject
	Dim propsBuilder As JavaObject
	propsBuilder.InitializeNewInstance("com.rabbitmq.client.AMQP$BasicProperties$Builder", Null)
    
	If DeliveryMode > 0 Then propsBuilder.RunMethod("deliveryMode", Array(DeliveryMode))
	If ContentType <> "" Then propsBuilder.RunMethod("contentType", Array(ContentType))
	If Headers <> Null Then propsBuilder.RunMethod("headers", Array(Headers))
    
	Return propsBuilder.RunMethod("build", Null)
End Sub

#End Region

'This function reads the envelope's delivery tag, redelivery flag, exchange name,
'and routing key from an AMQP Envelope object.
'
'Parameters:
'  EnvelopeObj (Object) - The AMQP Envelope object.
'
'Returns:
'  Map - A map containing:
'<code>
'      "DeliveryTag"  (Long)   : Unique tag identifying the delivery.
'      "IsRedeliver"  (Boolean): True if the message is being redelivered; False otherwise.
'      "Exchange"     (String) : Name of the exchange that the message was published to.
'      "RoutingKey"   (String) : Routing key used to route the message.
'</code>
Public Sub ExtractEnvelopeData(EnvelopeObj As Object) As Map
	Dim m As Map
	m.Initialize
    
	Dim Envelope As JavaObject = EnvelopeObj
	m.Put("DeliveryTag", Envelope.RunMethod("getDeliveryTag", Null))
	m.Put("IsRedeliver", Envelope.RunMethod("isRedeliver", Null))
	m.Put("Exchange", Envelope.RunMethod("getExchange", Null))
	m.Put("RoutingKey", Envelope.RunMethod("getRoutingKey", Null))
    
	Return m
End Sub

'This function extracts AMQP basic properties such as content type, encoding,
'headers, delivery mode, priority, identifiers, and other metadata from a BasicProperties object.
'
'<b>Parameters:</b>
'  PropsObj (Object) - The AMQP BasicProperties object.
'
'Returns a Map containing:
'<code>
'      "ContentType"     (String) : MIME type of the message content.
'      "ContentEncoding" (String) : Content encoding (e.g., "UTF-8").
'      "Headers"         (Map)    : Custom headers associated with the message.
'      "DeliveryMode"    (Integer): Delivery mode (1 = non-persistent, 2 = persistent).
'      "Priority"        (Integer): Message priority (0-9).
'      "CorrelationId"   (String) : Correlation identifier for request/reply patterns.
'      "ReplyTo"         (String) : Address to reply to.
'      "Expiration"      (String) : Expiration time in milliseconds or as a timestamp string.
'      "MessageId"       (String) : Unique identifier for the message.
'      "Timestamp"       (Date)   : Timestamp associated with the message.
'      "Type"            (String) : Message type or classification.
'      "UserId"          (String) : User ID of the publishing connection.
'      "AppId"           (String) : Application ID of the publishing application.
'</code>
Public Sub ExtractBasicProperties(PropsObj As Object) As Map
	Dim m As Map
	m.Initialize
    
	Dim props As JavaObject = PropsObj
	m.Put("ContentType", props.RunMethod("getContentType", Null))
	m.Put("ContentEncoding", props.RunMethod("getContentEncoding", Null))
	m.Put("Headers", props.RunMethod("getHeaders", Null))
	m.Put("DeliveryMode", props.RunMethod("getDeliveryMode", Null))
	m.Put("Priority", props.RunMethod("getPriority", Null))
	m.Put("CorrelationId", props.RunMethod("getCorrelationId", Null))
	m.Put("ReplyTo", props.RunMethod("getReplyTo", Null))
	m.Put("Expiration", props.RunMethod("getExpiration", Null))
	m.Put("MessageId", props.RunMethod("getMessageId", Null))
	m.Put("Timestamp", props.RunMethod("getTimestamp", Null))
	m.Put("Type", props.RunMethod("getType", Null))
	m.Put("UserId", props.RunMethod("getUserId", Null))
	m.Put("AppId", props.RunMethod("getAppId", Null))
    
	Return m
End Sub

'Helper function for "BasicPublish" to send a message to a queue
Public Sub SendMessageToQueue(QueueName As String, Message As String)
	Dim MessageBytes() As Byte = Message.GetBytes("UTF8")
	Channel.RunMethod("basicPublish", Array("", QueueName, Null, MessageBytes))
End Sub

'Helper function for "BasicPublish" to send a message to an exchange
Public Sub SendMessageToExchange(ExchangeName As String, Message As String)
	Dim MessageBytes() As Byte = Message.GetBytes("UTF8")
	Channel.RunMethod("basicPublish", Array(ExchangeName, "", Null, MessageBytes))
End Sub

' Set prefetch count
' <b>NOTE:</b> You must call this before you start to consume messages
Public Sub SetPrefechCount(PrefetchCount As Int)
	Channel.RunMethod("basicQos", Array(PrefetchCount))
End Sub

' <b>NOTE:</b> To modify the default interval, you must call this before the "ConnectToRabbitMQ" function/sub.
Public Sub SetRequestedHeartbeat(seconds As Int)
	HeatbeatTimeInSeconds = seconds
End Sub

' Disable automatic connection recovery, recovery is enabled by default.
' This would also disable all the "AutomaticRecovery" events.
' <b>NOTE:</b> you must call this before the "ConnectToRabbitMQ" function/sub.
Public Sub DisableAutomaticRecovery
	AutomaticRecoveryEnabled = False
End Sub

'This function starts a consumer for consuming messages from a specified queue.
'It establishes a message listener that processes incoming messages either in
'auto-acknowledge or manual-acknowledge mode.
'
'<b>Parameters:</b>
'  QueueName       - The name of the queue to consume messages from.
'  ShouldAutoAck   - True to automatically acknowledge messages upon receipt;
'  False to enable manual acknowledgment.
'
'Returns True if the consumer started successfully and False if there was an error initializing
'the connection, channel, or starting the consumer.
Public Sub ReceiveSecureMessages(QueueName As String, ShouldAutoAck As Boolean) As Boolean
	Try
		'Ensure connection is active
		If Connection.IsInitialized = False Or Channel.IsInitialized = False Then
			Log("❌ Error: RabbitMQ Connection or channel not initialized")
			Return False
		End If

		'Create A Consumer And Start Consuming Messages
		Dim Consumer As JavaObject = CreateRabbitMQConsumer(Channel)
		CurrentConsumerTag = Channel.RunMethod("basicConsume", Array(QueueName, ShouldAutoAck, Consumer))

		If ShouldAutoAck Then
			Log("📩 Message Consumer Started (Auto Ack)")
		Else
			Log("📩 Message Consumer Started (Manual Ack)")
		End If
		
		Return True
	Catch
		Log("❌ Error Receiving Messages: " & LastException)
		Return False
	End Try
End Sub


'Creates a new RabbitMQ consumer bound to the specified channel.
'
'<b>Parameters:</b>
'  CurrentChannel - The AMQP channel for the consumer.
'
'Returns a JavaObject of the created RabbitMQ consumer object ready to be used for message consumption.
Public Sub CreateRabbitMQConsumer(CurrentChannel As JavaObject) As JavaObject
	Dim jo As JavaObject = Me
	Return jo.RunMethod("CreateConsumer", Array(CurrentChannel, mEventName))
End Sub

'Acknowledge message received and proccessed
Public Sub Ack(DeliveryTag As Long)
	Channel.RunMethod("basicAck", Array(DeliveryTag, False))
End Sub

'Negatively acknowledge the message and requeue it
Public Sub Nack(DeliveryTag As Long)
	Channel.RunMethod("basicNack", Array(DeliveryTag, False, True)) 'requeue = True
End Sub

'Close the channel
Public Sub CloseChannel
	Channel.RunMethod("close", Null)
End Sub

'Close the RabbitMQ connection
Public Sub CloseConnection
	Connection.RunMethod("close", Null)
End Sub

'Cancels an active RabbitMQ consumer identified by its consumer tag.
'
'After cancellation, RabbitMQ stops delivering messages to that consumer
'that was previously registered with "basicConsume", but the channel
'remains open and the queue is not deleted. Only the consumer subscription 
'associated with that consumer tag is affected.
'
'<b>Parameters:</b>
'  ConsumerTag - The identifier of the consumer to cancel.
Public Sub BasicCancel(ConsumerTag As String)
	Channel.RunMethod("basicCancel", Array(ConsumerTag))
End Sub

'Returns the consumer tag of the currently active RabbitMQ consumer.
Public Sub GetConsumerTag As String
	Return CurrentConsumerTag
End Sub

'Declares a queue with the specified properties.
'
'<b>Parameters:</b>
'  QueueName - The name of the queue to declare.
'  Durable - True to make the queue survive broker restarts; False for a transient queue.
'  Exclusive - True to restrict queue access to the current connection only.
'  AutoDelete - True to automatically delete the queue when no longer in use.
'  Arguments (<b>Map/Null</b>) - Additional optional parameters in a MAP object (e.g., x-message-ttl).
'  <b>Can be Null</b> if not needed.
'
'For more details, see: <a href="https://www.rabbitmq.com/docs/queues">RabbitMQ Queues Docs</a>
Public Sub QueueDeclare(QueueName As String, Durable As Boolean, Exclusive As Boolean, AutoDelete As Boolean, Arguments As Object)
	Channel.RunMethod("queueDeclare", Array(QueueName, Durable, Exclusive, AutoDelete, Arguments))
End Sub

'Binds a queue to an exchange.
'
'<b>Parameters:</b>
'  QueueName - The name of the queue to bind.
'  ExchangeName - The name of the exchange to bind to.
'  RoutingKey - <b>Can be an empty string</b>. The routing key used to match messages for delivery to the queue.
Public Sub QueueBind(QueueName As String, ExchangeName As String, RoutingKey As String)
	Channel.RunMethod("queueBind", Array(QueueName, ExchangeName, RoutingKey))
End Sub

'Unbinds a queue from an exchange, removing the routing key association(if any).
'
'<b>Parameters:</b>
'  QueueName - The name of the queue to unbind.
'  ExchangeName - The name of the exchange to unbind from.
'  RoutingKey - The routing key used for the original binding. <b>May be an empty string ("") if applicable.</b>
Public Sub QueueUnbind(QueueName As String, ExchangeName As String, RoutingKey As String)
	Channel.RunMethod("queueUnbind", Array(QueueName, ExchangeName, RoutingKey))
End Sub

'Deletes a queue.
'It ignores whether queue is empty/used and permanently removes the queue and any messages it contains.
'If the queue has active consumers, their subscriptions will be canceled automatically.
Public Sub QueueDelete(QueueName As String)
	Channel.RunMethod("queueDelete", Array(QueueName))
End Sub

'Conditionally deletes a queue (based on if unused and empty)
'It Permanently removes the queue and any messages it contains.
'If the queue has active consumers, their subscriptions will be canceled automatically.
'
'<b>Parameters:</b>
'  QueueName - The name of the queue to delete.
'  IfUnused - True to delete only if the queue has no active consumers.
'  IfEmpty - True to delete only if the queue contains no messages.
'
'<b>Note:</b> Throws an IOException if any specified condition fails.
Public Sub QueueDelete2(QueueName As String, IfUnused As Boolean, IfEmpty As Boolean)
	Channel.RunMethod("queueDelete", Array(QueueName, IfUnused, IfEmpty))
End Sub

'Removes all messages from a queue without deleting the queue itself.
'Purging does not affect the queue's consumers or its configuration,
'it just empties the queue messages.
Public Sub QueuePurge(QueueName As String)
	Channel.RunMethod("queuePurge", Array(QueueName))
End Sub

'Declares an exchange with the specified properties.
'
'<b>Parameters:</b>
'  ExchangeName - The name of the exchange to declare.
'  ExchangeType - The type of exchange (e.g., "EXCHANGE_TYPE_DIRECT", "EXCHANGE_TYPE_FANOUT", etc).
'  Durable - True to make the exchange survive broker restarts; False for a transient exchange.
'  AutoDelete - True to automatically delete the exchange when no longer in use.
'  Arguments (<b>Map/Null</b>) - Additional optional parameters for the exchange. <b>Can be Null if not needed.</b>
'
'For more details, see: <a href="https://www.rabbitmq.com/docs/exchanges">RabbitMQ Exchange Docs</a>
Public Sub ExchangeDeclare(ExchangeName As String, ExchangeType As Object, Durable As Boolean, AutoDelete As Boolean, Arguments As Object)
	Channel.RunMethod("exchangeDeclare", Array(ExchangeName, ExchangeType, Durable, AutoDelete, Arguments))
End Sub

'Deletes an exchange.
Public Sub ExchangeDelete(ExchangeName As String)
	Channel.RunMethod("exchangeDelete", Array(ExchangeName))
End Sub

'Deletes an exchange based on a condition.
'If IfUnused Is False and the exchange still has queues bound to it,
'RabbitMQ will delete the exchange and automatically remove its bindings.
'
'<b>Parameters:</b>
'  ExchangeName - The name of the exchange to delete.
'  IfUnused - True to delete only if the exchange has no active bindings to queues.
'
'<b>Notes:</b> Throws an IOException if the IfUnused condition is True but the exchange is still in use.
Public Sub ExchangeDelete2(ExchangeName As String, IfUnused As Boolean)
	Channel.RunMethod("exchangeDelete", Array(ExchangeName, IfUnused))
End Sub

'Is the connection open
Public Sub IsConnectionOpened As Boolean
	If Connection = Null Or Connection.IsInitialized = False Then
		Return False
	End If
	
	Return Connection.RunMethod("isOpen", Null)
End Sub

'Is the Channel Open
Public Sub IsChannelOpened As Boolean
	If Channel = Null Or Channel.IsInitialized = False Then
		Return False
	End If
	
	Return Channel.RunMethod("isOpen", Null)
End Sub

#Region Java To B4X Event Fowarder
'Called when a new message was received
Private Sub On_Message_Received(ConsumerTag As String, Envelope As Object, BasicProperties As Object, Message As String)
	CallSubDelayed3(mCallBack, mEventName & "_messagereceived", Message, CreateMap("ConsumerTag": ConsumerTag, "Envelope": Envelope, "BasicProperties": BasicProperties))
End Sub

'Called when the queue consumer connection was cancelled/closed.
Private Sub On_Consumer_Closed(ConsumerTag As String)
	CallSubDelayed2(mCallBack, mEventName & "_consumerclosed", ConsumerTag)
End Sub

'Called if your client(using "BasicCancel") is the one that requested that the consumer be cancelled
Private Sub On_Client_Cancelled_Consumer(ConsumerTag As String)
	CallSubDelayed2(mCallBack, mEventName & "_clientcancelledconsumer", ConsumerTag)
End Sub

#End Region


#If JAVA
import com.rabbitmq.client.*;
import java.io.IOException;

public DefaultConsumer CreateConsumer(Channel channel, String EventName) {
    return new DefaultConsumer(channel) {
        @Override
        public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties, byte[] body) throws IOException {
            String message = new String(body, "UTF-8");
			
			ba.raiseEventFromUI(this, "on_message_received", new Object[] {
				consumerTag,
    			envelope,
				properties,
    			message
			});
        }

        @Override
        public void handleCancel(String consumerTag) throws IOException {
			ba.raiseEventFromUI(this, "on_consumer_closed", new Object[] { consumerTag });  
        }
		
		@Override
		public void handleCancelOk(String consumerTag) {
			ba.raiseEventFromUI(this, "on_client_cancelled_consumer", new Object[] { consumerTag });
		}

    };
}
#End If


#Region TODO
'Add removeRecoveryListener
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/Recoverable.html

' Add more methods from:  https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/Channel.html


'TODO: add like basicReject

'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/Channel.html

'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/AMQP.Basic.Qos.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/AMQP.Basic.Return.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/AMQP.Exchange.Bind.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/AMQP.Exchange.Unbind.html

'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/CancelCallback.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/AMQP.Connection.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/AMQP.Confirm.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/AMQP.Channel.html

'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/AMQP.Tx.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/BlockedListener.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/ConfirmCallback.html

'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/Connection.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/ConnectionFactory.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/ConnectionFactoryConfigurator.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/Consumer.html

'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/ConsumerShutdownSignalCallback.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/DefaultConsumer.html
'https://rabbitmq.github.io/rabbitmq-java-client/api/current/com/rabbitmq/client/DeliverCallback.html

#End Region
