package flm.b4j.mqttbroker;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Properties;

import org.apache.log4j.AppenderSkeleton;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.spi.LoggingEvent;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.DependsOn;
import anywheresoftware.b4a.BA.Events;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import io.moquette.interception.InterceptHandler;
import io.moquette.interception.messages.InterceptConnectMessage;
import io.moquette.interception.messages.InterceptDisconnectMessage;
import io.moquette.interception.messages.InterceptPublishMessage;
import io.moquette.interception.messages.InterceptSubscribeMessage;
import io.moquette.interception.messages.InterceptUnsubscribeMessage;
import io.moquette.proto.messages.AbstractMessage;
import io.moquette.proto.messages.AbstractMessage.QOSType;
import io.moquette.proto.messages.PublishMessage;
import io.moquette.server.Server;
import io.moquette.server.config.IConfig;
import io.moquette.server.config.MemoryConfig;

@Version(1.0f)
@ShortName("MQTTBrokerExtended")
@DependsOn(values = { "Moquette8" })
@Events(values = {
		"Connect(ClientID As String, UserName As String, Password() As Byte, ProtocolName As String, ProtocolVersion As Byte, QOS As String, KeepAlive As Int, IsCleanSession As Boolean, IsDupFlag As Boolean, IsUserFlag As Boolean, IsPasswordFlag As Boolean, IsWillFlag As Boolean)",
		"Disconnect(ClientID As String)",
		"LastWill(ClientID As String, QOS As Byte, TopicName As String, Payload() As Byte, IsRetain As Boolean)",
		"Publish(ClientID As String, QOS As String, TopicName As String, Payload() As Byte, IsDup As Boolean, IsRetain As Boolean)",
		"Suscribe(ClientID As String, RequestedQOS As String, TopicFilter As String)",
		"Unsuscribe(ClientID As String, TopicFilter As String)"
})
public class MQTTBrokerExtended
{
	Server server;
	Properties properties;
	ArrayList<InterceptHandler> handlers;

	/** QOS 0 : It guarantees a best effort delivery. A message won't be acknowledged by the receiver or stored and redelivered by the sender. */
	public final static String AT_MOST_ONCE = QOSType.MOST_ONE.toString();
	/** QOS 1 : It is guaranteed that a message will be delivered at least once to the receiver. But the message can also be delivered more than once. */
	public final static String AT_LEAST_ONCE = QOSType.LEAST_ONE.toString();
	/** QOS 2 : It guarantees that each message is received only once by the counterpart. It is the safest and also the slowest quality of service level. */
	public final static String EXACTLY_ONCE = QOSType.EXACTLY_ONCE.toString();

	public void Initialize(final BA ba, int Port, String EventPrefix)
	{
		server = new Server();

		properties = new Properties();
		properties.setProperty("port", Integer.toString(Port));

		handlers = new ArrayList<>();
		final String evtPrefix = EventPrefix.toLowerCase(BA.cul) + "_";
		final String ConnectEvent = evtPrefix + "connect";
		final String DisconnectEvent = evtPrefix + "disconnect";
		final String LastWillEvent = evtPrefix + "lastwill";
		final String PublishEvent = evtPrefix + "publish";
		final String SuscribeEvent = evtPrefix + "suscribe";
		final String UnsuscribeEvent = evtPrefix + "unsuscribe";
		InterceptHandler IH = new InterceptHandler()
		{
			@Override
			public void onConnect(InterceptConnectMessage msg) {
				ba.raiseEvent(this, ConnectEvent, new Object[] {msg.getClientID(), msg.getUsername(), msg.getPassword(),
						msg.getProtocolName(), msg.getProtocolVersion(), msg.getQos().toString(), msg.getKeepAlive(), msg.isCleanSession(),
						msg.isDupFlag(), msg.isUserFlag(), msg.isPasswordFlag(), msg.isWillFlag()});
				if (msg.isWillFlag())
					ba.raiseEvent(this, LastWillEvent, new Object[] {msg.getClientID(), msg.getWillQos(), msg.getWillTopic(), msg.getWillMessage(), msg.isWillRetain()});
			}

			@Override
			public void onDisconnect(InterceptDisconnectMessage msg) {
				ba.raiseEvent(this, DisconnectEvent, new Object[] {msg.getClientID()});
			}

			@Override
			public void onPublish(InterceptPublishMessage msg) {
				ba.raiseEvent(this, PublishEvent, new Object[] {msg.getClientID(), msg.getQos().toString(), msg.getTopicName(), msg.getPayload().array(),
						msg.isDupFlag(), msg.isRetainFlag()});
			}

			@Override
			public void onSubscribe(InterceptSubscribeMessage msg) {
				ba.raiseEvent(this, SuscribeEvent, new Object[] {msg.getClientID(), msg.getRequestedQos().toString(), msg.getTopicFilter()});
			}

			@Override
			public void onUnsubscribe(InterceptUnsubscribeMessage msg) {
				ba.raiseEvent(this, UnsuscribeEvent, new Object[] {msg.getClientID(), msg.getTopicFilter()});
			}
		};
		handlers.add(IH);

		final AppenderSkeleton appender = new AppenderSkeleton() {
			public boolean requiresLayout() {
				return false;
			}

			public void close() {
			}

			protected void append(LoggingEvent lev) {
				BA.Log(getLayout().format(lev));
			}
		};
		appender.setLayout(new PatternLayout("%m%n"));
		appender.activateOptions();
		Logger.getRootLogger().addAppender(appender);
		Logger.getRootLogger().setLevel(Level.INFO);
	}

	public void setDebugLog(boolean b)
	{
		Logger.getRootLogger().setLevel(b ? Level.INFO : Level.WARN);
	}

	public void Start() throws IOException
	{
		final IConfig config = new MemoryConfig(properties);
		server.startServer(config, handlers);
	}

	public void Stop()
	{
		server.stopServer();
	}

	public void InternalPublish(String TopicName, byte[] Payload, String QOS, boolean RetainFlag)
	{
		PublishMessage msg = new PublishMessage();
		msg.setTopicName(TopicName);
		msg.setPayload(ByteBuffer.wrap(Payload));
		msg.setQos(QOSType.valueOf(QOS));
		msg.setRetainFlag(RetainFlag);
		msg.setMessageType(AbstractMessage.PUBLISH);
		server.internalPublish(msg);
	}
}
