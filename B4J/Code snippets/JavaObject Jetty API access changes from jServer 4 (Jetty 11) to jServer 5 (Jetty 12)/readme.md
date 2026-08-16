### JavaObject Jetty API access changes from jServer 4 (Jetty 11) to jServer 5 (Jetty 12) by Chris2
### 08/14/2026
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/171805/)

I propose this thread to be a list of changes needed in JavaObject calls to Jetty APIs when moving from jServer 4 (Jetty 11) to jServer 5 (Jetty 12).  
  
Please add any that you find, posting both the original jServer 4 compatible version and the new jServer 5 compatible version. A brief note on what you're using it for might be useful too. Thanks.  
  
To start us off….  
jServer 4:

```B4X
JO.InitializeNewInstance("org.eclipse.jetty.client.dynamic.HttpClientTransportDynamic", Array(ClientConnector, Infos))
```

  
JServer 5:

```B4X
JO.InitializeNewInstance("org.eclipse.jetty.client.transport.HttpClientTransportDynamic", Array(ClientConnector, Infos))
```

  
This is used when forcing the client to accept all SSL certifcates (see [here](https://www.b4x.com/android/forum/threads/jwebsocketclient-v2-accept-all-certificates.157001/)).