B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=8.5
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano 'ignore
	Private mHost As String = "0.peerjs.com"
	Private mPort As Int = 443
	Private mPingInterval As Int = 5000
	Private mPath As String = "/"
	Private mSecure As Boolean = True
	Private mDebug As Int = 0
	Private mIceServers As List
	Private mSdpSemantics As String = "unified-plan"	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	'mIceServers.Initialize	
End Sub

' Server host. Defaults to 0.peerjs.com. Also accepts '/' to signify relative hostname.
public Sub getHost() As String
	Return mHost
End Sub

public Sub setHost(sHost As String)
	mHost = sHost
End Sub

' Server port. Defaults to 443.
public Sub getPort() As Int
	Return mPort
End Sub

public Sub setPort(iPort As Int	)
	mPort = iPort
End Sub

' Ping interval in ms. Defaults to 5000.
public Sub getPingInterval() As Int
	Return mPingInterval
End Sub

public Sub setPingInterval(iPingInterval As Int	)
	mPingInterval = iPingInterval
End Sub

' The path where your self-hosted PeerServer is running. Defaults to '/'.
public Sub getPath() As String
	Return mPath
End Sub

public Sub setPath(sPath As String)
	mPath = sPath
End Sub

' true if you're using SSL.
' Note that the default cloud-hosted server and assets may not support SSL.
public Sub getSecure() As Boolean
	Return mSecure
End Sub

public Sub setSecure(bSecure As Boolean)
	mSecure = bSecure
End Sub

' Prints log messages depending on the debug level passed in. Defaults to DEBUG_NO_LOGS
public Sub getDebug() As Int
	Return mDebug
End Sub

public Sub setDebug(iDebug As Int)
	mDebug = iDebug
End Sub

public Sub getIceServers() As List
	Return mIceServers
End Sub

' default 'unified-plan'
public Sub getSdpSemantics() As String
	Return mSdpSemantics
End Sub

public Sub setSdpSemantics(sSdpSemantics As String)
	mSdpSemantics = sSdpSemantics
End Sub

' e.g. "stun:stun.l.google.com:19302", ""
'      "turn:homeo@turn.bistri.com:80", "homeo"
'
' default: "stun:stun.l.google.com:19302"
public Sub AddIceServer(server As String, Credentials As String)
	If Credentials Then
		mIceServers.Add(CreateMap("url": server, "credentials": Credentials))
	Else
		mIceServers.Add(CreateMap("url": server))
	End If		
End Sub
