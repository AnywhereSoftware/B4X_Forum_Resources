B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
#IgnoreWarnings:12
Sub Class_Globals
	Private BANano As BANano		'ignore
	Private sea As BANanoObject
	Public mCallBack As Object
	Public epriv As String
	Public epub As String
	Public priv As String
	Public pub As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(Module As Object)
	mCallBack = Module
	'get sea
	sea = BANano.Window.GetField("SEA")
	pub = ""
	epub = ""
	priv = ""
	epriv = ""
End Sub

'get a pair
Sub Pair As Map
	Dim p As Map = BANano.Await(sea.RunMethod("pair", Null))
	epriv = p.Get("epriv")
	priv = p.Get("priv")
	pub = p.Get("pub")
	epub = p.Get("pub")
	Return p
End Sub

'encrypt (content, pair)
Sub Encrypt(target As Object, p As Object) As Object
	Dim e As Object = BANano.Await(sea.RunMethod("encrypt", Array(target, p)))
	Return e
End Sub

'sign (encryption, pair)
Sub Sign(e As Object, p As Object) As Object
	Dim s As Object = BANano.Await(sea.RunMethod("sign", Array(e, p)))
	Return s
End Sub

'verify (data, pub)
Sub Verify(d As Object, p As Object) As Object
	Dim s As Object = BANano.Await(sea.RunMethod("verify", Array(d, p)))
	Return s
End Sub

'decrypt (msg, pub)
Sub Decrypt(m As Object, p As Object) As Object
	Dim s As Object = BANano.Await(sea.RunMethod("decrypt", Array(m, p)))
	Return s
End Sub

'work (msg, pub)
Sub Work(d As Object, p As Object) As Object
	Dim s As Object = BANano.Await(sea.RunMethod("work", Array(d, p)))
	Return s
End Sub

'Secret (msg, pub)
Sub Secret(d As Object, p As Object) As Object
	Dim s As Object = BANano.Await(sea.RunMethod("secret", Array(d, p)))
	Return s
End Sub

'Certify (msg, pub)
Sub Certify(d As Object, c As Object, p As Object) As Object
	Dim s As Object = BANano.Await(sea.RunMethod("certify", Array(d, c, p)))
	Return s
End Sub