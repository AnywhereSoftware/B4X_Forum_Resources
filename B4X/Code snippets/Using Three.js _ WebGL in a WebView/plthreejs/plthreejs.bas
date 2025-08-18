B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.5
@EndOfDesignText@
Sub Class_Globals

	#If B4A
	Private mWebView As WebView
	#End If

	#If B4I
	Private mWebView As WKWebView
	#End If

	Public BackgroundColor As Int = 0xFF1E1E1E				' Background color for the html file
	Public Filename As String = "index.html"				' Filename of the html file
	Public RequestAnimationFrame As Boolean = False			' True: constant rendering at 60 fps, False: only rendering when the user interacts with the model
	
	Public MaterialType_MeshStandardMaterial As Int = 0		' Constants, not used yet
	
	#If B4A
	Private wx As WebViewExtras
	#End If
	
	Private xui As XUI
	
End Sub

'Initializes the plthreejs interface
Public Sub Initialize(WebView As WebView)
		
	mWebView = WebView
		
	' Setup the WebView for B4A
	#If B4A
		mWebView.JavaScriptEnabled = True
		mWebView.ZoomEnabled = False
	#End If
	
	' Setup the WebView for B4I
	#If B4I
		
	#End If
		
End Sub

' Prepares the basic HTML file
Public Sub PrepareHTML
		
	Dim BackgroundColorARGB() As Int = GetARGB(BackgroundColor)
	
	Dim sRenderType As String = "controls.addEventListener('change', render);"
	If RequestAnimationFrame = True Then sRenderType = "function animate() {requestAnimationFrame(animate);controls.update();renderer.render(scene, camera);} animate();"
	
	' Create a basic HTML page
	Dim sHTML As String = $"
	<!DOCTYPE html><head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>plthreejs</title>
	<style> body {margin:0;}
	</style></head>
	<body><style>body{
	background-color: rgb(${BackgroundColorARGB(1)},${BackgroundColorARGB(2)},${BackgroundColorARGB(3)});
    font-family:verdana;font-size:16px;}</style>"$
	
	' Add Three.js and OrbitControls.js
	sHTML = sHTML & "<script>" & File.ReadString(File.DirAssets, "three.min.js") & "</script>" & CRLF
	sHTML = sHTML & "<script>" & File.ReadString(File.DirAssets, "OrbitControls.js") & "</script>" & CRLF
	
	' Add the basic Three.js stuff
	sHTML = sHTML & $"
	<script>
	let camera, scene, renderer, controls;
	scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera( 25, window.innerWidth / window.innerHeight, 0.1, 1000000 );
	scene.add(camera);
	renderer = new THREE.WebGLRenderer({antialias:true, alpha:true});
	renderer.setSize( window.innerWidth, window.innerHeight );
	renderer.setClearColor(0x000000, 0);
	document.body.appendChild( renderer.domElement );
	controls = new THREE.OrbitControls(camera, renderer.domElement );
	${sRenderType}
	function render(){renderer.render(scene, camera);}
	</script></body></html>"$
	
	' Writes the file
	File.WriteString(xui.DefaultFolder, Filename, sHTML)
	
End Sub

' Create a Box
Public Sub CreateBoxGeometry(width As Float, height As Float, depth As Float, MaterialType As Int, Color As Int)
	RunJS($"const geometry = new THREE.BoxGeometry( ${width}, ${height}, ${depth});
	const material = new THREE.MeshStandardMaterial( {color: ${Color}} );
	const cube = new THREE.Mesh( geometry, material );
	scene.add( cube );"$)
End Sub

' Create a TorusKnot
Public Sub CreateTorusKnotGeometry(radius As Float, tube As Float, tubularSegments As Int, radialSegments As Int, p As Int, q As Int, MaterialType As Int, Color As Int)
	RunJS($"const geometry = new THREE.TorusKnotGeometry( ${radius}, ${tube}, ${tubularSegments}, ${radialSegments}, ${p}, ${q});
	const material = new THREE.MeshStandardMaterial( { color: ${Color} } );
	const torusKnot = new THREE.Mesh( geometry, material );
	scene.add( torusKnot );"$)
End Sub

' Sets the camera position
Public Sub SetCameraPosition(x As Float, y As Float, z As Float)
	RunJS($"camera.position.set(${x},${y},${z});controls.update();"$)
End Sub

' Adds a PointLight to the Scene or the Camera
Public Sub AddPointLight(x As Float, y As Float, z As Float, Color As Int, Intensity As Int, AddToCamera As Boolean)
	Dim sAddTo As String = "scene"
	If AddToCamera = True Then sAddTo = "camera"
	RunJS($"var pointLight = new THREE.PointLight(${Color}, ${Intensity});
	pointLight.position.x = ${x};
	pointLight.position.y = ${y};
	pointLight.position.z = ${z};
	${sAddTo}.add( pointLight );"$)
End Sub

' Renders the scene
Public Sub render
	RunJS("render();")
End Sub

' Runs then JavaScript code in the webview
Private Sub RunJS(js As String)
		
	#If B4A
		wx.executeJavascript(mWebView, js)
	#End If
	
	#If B4I
		mWebView.EvaluateJavaScript("", js)
		Wait For mWebView_JSComplete (Success As Boolean, Tag As Object, Result As String)
	#End If
	
End Sub

' Loads the HTML file, return false if the file does not exist
Public Sub LoadHTML As Boolean	
	If File.Exists(xui.DefaultFolder, Filename) = False Then Return False
	mWebView.LoadUrl(xui.FileUri(xui.DefaultFolder, Filename))
	Return True
End Sub

Private Sub GetARGB(Color As Int) As Int()
	Private res(4) As Int
	res(0) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff000000), 24)
	res(1) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff0000), 16)
	res(2) = Bit.UnsignedShiftRight(Bit.And(Color, 0xff00), 8)
	res(3) = Bit.And(Color, 0xff)
	Return res
End Sub

