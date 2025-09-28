B4J=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=10.3
@EndOfDesignText@
' Product:		EndsMeet
' Version:		1.40
' License:		MIT License
' GitHub:		https://github.com/pyhoon/EndsMeet
' Donation:	PayPal (https://paypal.me/aeric80/)
' Developer:	Poon Yip Hoon (Aeric) (https://www.b4x.com/android/forum/members/aeric.74499/)
Sub Class_Globals
	Public ctx 						As Map
	Public srvr 					As Server
	Public api 						As ApiSettings
	Public ssl 						As SslSettings
	Public cors 					As CorsSettings
	Public email 					As EmailSettings
	Public staticfiles 				As StaticFilesSettings
	Public routes					As List
	Private mPort 					As Int
	Private mMessage 				As String
	Private mVersion				As String
	Private mRootUrl 				As String
	Private mRootPath 				As String
	Private mServerUrl 				As String
	Private mConfigFile				As String
	Private mRedirect 				As Boolean
	Private mLogEnabled 			As Boolean
	Private mRemoveUnusedConfig		As Boolean
	Private Const COLOR_RED 		As Int = -65536
	Private Const COLOR_BLUE 		As Int = -16776961
	Type ApiSettings (Name As String, Versioning As Boolean, PayloadType As String, ContentType As String, EnableHelp As Boolean, VerboseMode As Boolean, OrderedKeys As Boolean)
	Type SslSettings (Enabled As Boolean, Port As Int, KeystoreDir As String, KeystoreFile As String, KeystorePassword As String)
	Type EmailSettings (SmtpUserName As String, SmtpPassword As String, SmtpServer As String, SmtpUseSsl As String, SmtpPort As Int)
	Type CorsSettings (Enabled As Boolean, Path As List, Settings As Map)
	Type StaticFilesSettings (Folder As String, Browsable As Boolean)
	Type Route (Method As String, Path As String, Class As String)
End Sub

Public Sub Initialize
	ctx.Initialize
	api.Initialize
	ssl.Initialize
	cors.Initialize
	email.Initialize
	routes.Initialize
	staticfiles.Initialize
	srvr.Initialize("")
	mPort = 8080
	mVersion = "1.40"
	mConfigFile = "config.ini"
	mRemoveUnusedConfig = True
	mRootUrl = "http://127.0.0.1"
	staticfiles.Folder = File.Combine(File.DirApp, "www")
	api.Name = "api"
	api.VerboseMode = True
	api.OrderedKeys = True
	api.PayloadType = "application/json"
	api.ContentType = "application/json"
End Sub

' Add path and class which allows GET method 
Public Sub Get (Path As String, Class As String)
	If RouteAdded(Path, Class) = False Then
		srvr.AddHandler(Path, Class, False)
	End If
	routes.Add(CreateRoute("GET", Path, Class))
End Sub

' Add path and class which allows POST method 
Public Sub Post (Path As String, Class As String)
	If RouteAdded(Path, Class) = False Then
		srvr.AddHandler(Path, Class, False)
	End If
	routes.Add(CreateRoute("POST", Path, Class))
End Sub

' Add path and class which allows PUT method 
Public Sub Put (Path As String, Class As String)
	If RouteAdded(Path, Class) = False Then
		srvr.AddHandler(Path, Class, False)
	End If
	routes.Add(CreateRoute("PUT", Path, Class))
End Sub

' Add path and class which allows DELETE method 
Public Sub Delete (Path As String, Class As String)
	If RouteAdded(Path, Class) = False Then
		srvr.AddHandler(Path, Class, False)
	End If
	routes.Add(CreateRoute("DELETE", Path, Class))
End Sub

' Checks route is added
Private Sub RouteAdded (Path As String, Class As String) As Boolean
	For Each rt As Route In routes
		If rt.Path.EqualsIgnoreCase(Path) And rt.Class.EqualsIgnoreCase(Class) Then
			Return True
		End If
	Next
	Return False
End Sub

' Check http method allowed for the given path and class name
Public Sub MethodAvailable (Method As String, Path As String, Class As String) As Boolean
	For Each rt As Route In routes
		If rt.Method.EqualsIgnoreCase(Method) And _
			rt.Path.EqualsIgnoreCase(Path) And _
			rt.Class.EqualsIgnoreCase(Class) Then
			Return True
		End If
	Next
	Return False
End Sub

' Check http method allowed for the given path and class object (e.g by passing Me as Class)
Public Sub MethodAvailable2 (Method As String, Path As String, Class As Object) As Boolean
	Dim jo As JavaObject
	jo.InitializeStatic("anywheresoftware.b4a.BA")
	Dim PackageName As String = jo.GetField("packageName")
	Dim Handler As String = GetType(Class).Replace(PackageName & ".", "")
	For Each rt As Route In routes
		If rt.Method.EqualsIgnoreCase(Method) And _
			rt.Path.EqualsIgnoreCase(Path) And _
			rt.Class.EqualsIgnoreCase(Handler) Then
			Return True
		End If
	Next
	Return False
End Sub

' Load from config file
' e.g PORT, SSL_PORT, ROOT_URL, ROOT_PATH,
' API_VERBOSE_MODE, API_ORDERED_KEYS
Public Sub LoadConfig
	If File.Exists(File.DirApp, mConfigFile) = False Then
		File.Copy(File.DirAssets, "config.example", File.DirApp, mConfigFile)
	End If
	ctx = File.ReadMap(File.DirApp, mConfigFile)
	If ctx.ContainsKey("PORT") Then mPort = ctx.Get("PORT")
	If ctx.ContainsKey("SSL_PORT") Then ssl.Port = ctx.Get("SSL_PORT")
	If ctx.ContainsKey("SSL_KEYSTORE_DIR") Then ssl.KeystoreDir = ctx.Get("SSL_KEYSTORE_DIR")
	If ctx.ContainsKey("SSL_KEYSTORE_FILE") Then ssl.KeystoreFile = ctx.Get("SSL_KEYSTORE_FILE")
	If ctx.ContainsKey("SSL_KEYSTORE_PASSWORD") Then ssl.KeystorePassword = ctx.Get("SSL_KEYSTORE_PASSWORD")
	If ctx.ContainsKey("ROOT_URL") Then mRootUrl = ctx.Get("ROOT_URL")
	If ctx.ContainsKey("ROOT_PATH") Then mRootPath = ctx.Get("ROOT_PATH")
	If ctx.ContainsKey("API_NAME") Then api.Name = ctx.Get("API_NAME")
	If ctx.ContainsKey("API_VERSIONING") Then api.Versioning = ctx.Get("API_VERSIONING").As(String).EqualsIgnoreCase("True")
	If ctx.ContainsKey("API_VERBOSE_MODE") Then api.VerboseMode = ctx.Get("API_VERBOSE_MODE").As(String).EqualsIgnoreCase("True")
	If ctx.ContainsKey("API_ORDERED_KEYS") Then api.OrderedKeys = ctx.Get("API_ORDERED_KEYS").As(String).EqualsIgnoreCase("True")
End Sub

' Starts the server
Public Sub Start
	mServerUrl = mRootUrl
	' Update useful keys
	ctx.Put("ROOT_URL", mRootUrl)
	ctx.Put("ROOT_PATH", mRootPath)
	' Remove unused keys
	If mRemoveUnusedConfig Then
		ctx.Remove("PORT")
		ctx.Remove("SSL_PORT")
		ctx.Remove("SSL_KEYSTORE_DIR")
		ctx.Remove("SSL_KEYSTORE_FILE")
		ctx.Remove("SSL_KEYSTORE_PASSWORD")
		ctx.Remove("API_NAME")
		ctx.Remove("API_VERSIONING")
		ctx.Remove("API_VERBOSE_MODE")
		ctx.Remove("API_ORDERED_KEYS")
	End If
	If mPort <> 0 Then
		srvr.Port = mPort
	Else
		mPort = srvr.Port
		If mLogEnabled Then	LogColor($"Server Port is not set (default to ${mPort})"$, COLOR_RED)
	End If
	If ssl.Port = 0 Then
		ssl.Enabled = False
		If mPort <> 80 Then
			mServerUrl = mRootUrl & ":" & mPort
		End If
		ctx.Put("SERVER_URL", mServerUrl)
		If mLogEnabled Then	LogColor("SSL is disabled", COLOR_BLUE)
	Else
		If ssl.KeystoreFile = "" Then
			ssl.Enabled = False
			If mLogEnabled Then	LogColor("Ssl KeystoreFile is not set (SSL is disabled)", COLOR_RED)
		Else
			If ssl.KeystoreDir = "" Then
				ssl.KeystoreDir = File.DirApp
			End If
			If File.Exists(ssl.KeystoreDir, ssl.KeystoreFile) = False Then
				ssl.Enabled = False
				If mLogEnabled Then	LogColor("Ssl KeystoreFile is found (SSL is disabled)", COLOR_RED)
			Else
				Dim sc As SslConfiguration
				sc.Initialize
				sc.SetKeyStorePath(ssl.KeystoreDir, ssl.KeystoreFile)
				sc.KeyStorePassword = ssl.KeystorePassword
				srvr.SetSslConfiguration(sc, ssl.Port)
				If mRedirect Then
					' Add filter to redirect all traffic from http to https (optional)
					srvr.AddFilter("/*", "HttpsFilter", False)
					mRootUrl = mRootUrl.Replace("http:", "https:")
					ctx.Put("ROOT_URL", mRootUrl)
					If mPort = 443 Then
						mServerUrl = mRootUrl
					Else
						mServerUrl = mRootUrl & ":" & ssl.Port
					End If
				Else
					mServerUrl = mRootUrl & ":" & mPort
				End If
				ssl.Enabled = True
				If mLogEnabled Then	LogColor("SSL is enabled", COLOR_BLUE)
			End If
		End If
		ctx.Put("SERVER_URL", mServerUrl)
	End If
	If mRootPath <> "" Then
		If mRootPath.StartsWith("/") = False Then mRootPath = "/" & mRootPath
		If mRootPath.EndsWith("/") = True Then mRootPath = mRootPath.SubString2(0, mRootPath.Length)
		mServerUrl = mServerUrl & mRootPath
		ctx.Put("ROOT_PATH", mRootPath)
		ctx.Put("SERVER_URL", mServerUrl)
	End If
	If Initialized(cors.Path) And Initialized(cors.Settings) Then
		For Each path As String In cors.Path
			Me.As(JavaObject).RunMethod("addFilter", Array As Object(srvr.As(JavaObject).GetField("context"), path, cors.Settings))
		Next
		If mLogEnabled Then	LogColor("CORS is enabled", COLOR_BLUE)
	End If
	srvr.StaticFilesFolder = staticfiles.Folder
	srvr.SetStaticFilesOptions(CreateMap("dirAllowed": staticfiles.Browsable))
	srvr.Start
End Sub

Public Sub getMessage As String
	Return mMessage
End Sub

Public Sub setMessage (Message As String)
	mMessage = Message
End Sub

Public Sub getVersion As String
	Return mVersion
End Sub

Public Sub getPort As Int
	Return mPort
End Sub

Public Sub setPort (Port As Int)
	mPort = Port
End Sub

Public Sub getRootUrl As String
	Return mRootUrl
End Sub

Public Sub setRootUrl (RootUrl As String)
	mRootUrl = RootUrl
End Sub

Public Sub getRootPath As String
	Return mRootPath
End Sub

Public Sub setRootPath (RootPath As String)
	mRootPath = RootPath
End Sub

Public Sub getServerUrl As String
	Return mServerUrl
End Sub

Public Sub getLogEnabled As Boolean
	Return mLogEnabled
End Sub

Public Sub setLogEnabled (Enabled As Boolean)
	mLogEnabled = Enabled
End Sub

' Remove unused config keys in ctx
Public Sub getRemoveUnusedConfig As Boolean
	Return mRemoveUnusedConfig
End Sub

Public Sub setRemoveUnusedConfig (Enabled As Boolean)
	mRemoveUnusedConfig = Enabled
End Sub

' Set config file name
Public Sub getConfigFile As String
	Return mConfigFile
End Sub

Public Sub setConfigFile (FileName As String)
	mConfigFile = FileName
End Sub

Public Sub setRedirectToHttps (Enabled As Boolean)
	mRedirect = Enabled
End Sub

' Show startup message
Public Sub LogStartupMessage
	If mMessage = "" Then mMessage = $"EndsMeet server (version = ${mVersion}) is running on port ${mPort}${IIf(ssl.Port > 0 And mRedirect, $" (redirected to port ${ssl.Port})"$, "")}"$
	Log(mMessage)
End Sub

Public Sub CreateRoute (Method As String, Path As String, Class As String) As Route
	Dim t1 As Route
	t1.Initialize
	t1.Method = Method
	t1.Path = Path
	t1.Class = Class
	Return t1
End Sub

#If JAVA
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map.Entry;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.Filter;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.FilterHolder;
import anywheresoftware.b4a.objects.collections.Map.MyMap;

public void addFilter (ServletContextHandler context, String path, MyMap settings) throws Exception {
    FilterHolder fh = new FilterHolder((Class<? extends Filter>) Class.forName("org.eclipse.jetty.servlets.CrossOriginFilter"));
    if (settings != null) {
        HashMap<String,String> m = new HashMap<String, String>();
        copyMyMap(settings, m, true); //integerNumbersOnly!
        fh.setInitParameters(m);
    }
    context.addFilter(fh, path, EnumSet.of(DispatcherType.REQUEST));
}

private void copyMyMap (MyMap m, java.util.Map<String, String> o, boolean integerNumbersOnly) {
    for (Entry<Object, Object> e : m.entrySet()) {
        String value;
        if (integerNumbersOnly && e.getValue() instanceof Number) {
            value = String.valueOf(((Number)e.getValue()).longValue());
        } else {
            value = String.valueOf(e.getValue());
            o.put(String.valueOf(e.getKey()), value);
        }
    }
}
#End If