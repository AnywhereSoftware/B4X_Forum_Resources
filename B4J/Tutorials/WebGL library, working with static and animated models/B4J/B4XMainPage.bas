B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

'Ctrl + click to export as zip: ide://run?File=%B4X%\Zipper.jar&Args=Project.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI
			
	Private Button1 As Button	
	Private gl As WebGL
	Private Port As Int = 8888
	
	Private GeneralServedFileSize As Long
	Private CodeServedFileSize As Long
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	B4XPages.SetTitle(B4XPages.MainPage, "WebGL Library Demo")
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Button1.Enabled = False
	
	' Set here the path where THREEJS distribution was unzipped.
	' More concurrent projects can run at same time, just use different port for each if you need this.
	gl.Initialize(Me, "WebGL", "FullDemoScene", "GMT+1", File.DirData("B4XWebGL"), Port)
	
	' We import here threejs library and used classes, so they are common to all 3 demo scenes. Anyway with GetEngine commands you have to import libraries before Update command.
	' If you use GetEngine3, you can use these or just put imports inside the full JavaScript code. If this is a case, the imports should be regular JavaScript imports.
	gl.Import("* as THREE from 'three'")
	gl.Import("{ OrbitControls } from 'three/addons/controls/OrbitControls.js'")
	
	Dim html As String = $"<!DOCTYPE html>
<html lang="en">
	<head>
		<title>three.js webgl - cloth simulation</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<style>
			body {
				font-family: Monospace;
				background-color: #000;
				color: #000;
				margin: 0px;
				padding: 0px;
				overflow: hidden;
			}
			#info {
				position: absolute;
				padding: 10px;
				width: 100%;
				text-align: center;
			}
			a {
				text-decoration: underline;
				cursor: pointer;
			}
		</style>
	</head>
	
	<body>
	
		<center>
			<div id="info">Cloth Simulation on B4X Logo<br/>
	         <a onclick="startAnimation();">Animate</a> |
				<a onclick="toggleWind();">Wind</a> |
				<a onclick="toggleBall();">Ball</a> |
				<a onclick="togglePins();">Pins</a><br/>
				(Models from <a href="https://www.mixamo.com/" target="_blank" rel="noopener">mixamo.com</a> - <a href="https://www.florasynth.com/" target="_blank" rel="noopener">florasynth.com</a> - <a href="https://www.sketchfab.com/" target="_blank" rel="noopener">sketchfab.com</a>)		   
			</div>
		</center>
			
		<script type="importmap">
			{
				"imports": {
					"three": "../build/three.module.min.js",
					"three/addons/": "./jsm/"
				}
			}
		</script>
						
		<script type="module">
			[IMPORT]
         [CODE]
		</script>
	</body>
</html>"$

	Wait For (gl.GetEngine) Complete (Success As Boolean)	
	If Success Then
'		gl.SetLocalServer
		gl.StartEngine2(html)
	Else
		LogColor("Unable to initialize WebGL Library", xui.Color_Red)
	End If
End Sub

'Sub Separator() As String
'	Return GetSystemProperty("file.separator","")
'End Sub

'///////////// WebGL Library Events ////////////

' Called if error occours
Sub WebGL_Error(Error As String)
	LogColor(Error, xui.Color_Red)
End Sub

' Called when there are library server logs
Sub WebGL_ServerLog(Text As String)
	If Text.Contains(".html") Or Text.ToLowerCase.Contains("mainpage") Then
		GeneralServedFileSize = 0 : CodeServedFileSize = 0
		If Text.Contains("[200]") Then  ' File found
			LogColor(Text, xui.Color_Magenta)
		Else If Text.Contains("[304]") Then  ' Cached
			LogColor(Text, 0xFFFF7F00)
		Else If Text.Contains("[404]") Then  ' File not found
			LogColor(Text, xui.Color_Red)
		End If
	Else
		If Text.Contains("[200]") Then  ' File found
			LogColor(Text, xui.Color_Blue)
		Else If Text.Contains("[304]") Then  ' Cached
			LogColor(Text, 0xFFFF7F00)
		Else If Text.Contains("[404]") Then  ' File not found
			LogColor(Text, xui.Color_Red)
		End If
	End If
	
	Dim s As Int = Text.IndexOf("(") + 1
	Dim e As Int = Text.IndexOf(")") - 6
	Dim size As Long = Text.SubString2(s, e)
	If Text.Contains(".html") Or Text.Contains(".js") Or Text.Contains(".css") Then
		CodeServedFileSize = CodeServedFileSize + size
	Else
		GeneralServedFileSize = GeneralServedFileSize + size
	End If
	
	Log("[" & DateTime.Now & "] - File size: " & size & " Bytes. Total served for this project: " & _
	GeneralServedFileSize & " Bytes = " & NumberFormat2((GeneralServedFileSize/1024.0/1024.0), 0, 2, 2, False) & " MB for general files and " & _
	CodeServedFileSize & " Bytes = " & NumberFormat2((CodeServedFileSize/1024.0/1024.0), 0, 2, 2, False) & " MB for code (html, js, css)")
End Sub

' Called when the library is fully initialized and user is ready to code
Sub WebGL_ReadyToCode(Url As String)
	Log(" ") : LogColor("WebGL ReadyToCode. Your WebGL code start here. URL: " & Url, 0xFF9A4EC0)
					
	gl.Alert("'Welcome to B4X WebGL Library.\n\nThis library is aimed by THREEJS project.\nCurrently tested on THREEJS r164.\nhttps://threejs.org/'")
	gl.Console("'Welcome to B4X WebGL Library.\n\nThis library is aimed by THREEJS project.\nCurrently tested on THREEJS r164.\nhttps://threejs.org/'")
	gl.Console("'THREEJS REVISION: ' + THREE.REVISION")
	gl.Console($"'Point to ${gl.ServerProjectPath} to see library examples\n'"$)
	gl.Console($"'Point to ${gl.ServerMainPage} to see library main page\n'"$)
				
	' We copy texture files (and/or any other file to use in our projects) to the library resources.
	' When a file is copied, we can use it on all projects, not only in the current project. It will be copied inside threejs distribution.
	'
	' Resources are placed inside DirData folder in a consistent folder strucrure. Use ProjectPath to refer the main project folder,
	' this folder contains subfolders for resources, eg. the folders /textures, /models and others. See threejs distribution /example
	' folder as reference. Resources are permanent, you can remove these in various ways, by code using File.Delete or manually.
	'
	' IMPORTANT NOTE: You can copy files by code or you can just put files manually inside the appropriate folder structure.
	'                 You can even add subfolders as you like, but please do not modify the main folder 
	'                 structure if you want mantain compatibility with projects you find on the web.
	'                 To refer your ProjectPath you can just do Log(gl.ProjectPath) and the log will show you where
	'                 project path is placed on your machine. On machine with Windows 11 it is placed on:
	'                 C:\Users\UserName\AppData\Roaming\B4XWebGL\three\examples\

	Dim files As List
	files.Initialize
	files.AddAll(Array As String("models/gltf/Eve/eve$@walk.glb", _
		                          "models/gltf/Plant/plant3.gltf", _
		                          "models/gltf/facial__body_animated_party_m_0001_-_actorcore.glb", _
										  "models/gltf/facial__body_animated_party_f_0002_-_actorcore.glb", _
										  "models/gltf/buster_drone.glb", _
										  "models/fbx/Northern Soul Floor Combo.fbx", _											  
										  "models/gltf/porsche_911/scene.gltf", _
										  "models/gltf/porsche_911/scene.bin", _		
										  "textures/cube/skybox/px.jpg", _
										  "textures/cube/skybox/nx.jpg", _
										  "textures/cube/skybox/py.jpg", _
										  "textures/cube/skybox/ny.jpg", _
										  "textures/cube/skybox/pz.jpg", _
										  "textures/cube/skybox/nz.jpg", _	
										  "textures/patterns/B4XLogo.png", _
										  "textures/patterns/B4J.jpg", _
										  "textures/terrain/grasslight-big.jpg", _
										  "textures/terrain/grasslight-big-nm.jpg", _
										  "jsm/physics/Cloth.js"))
	
	' These new useful commands help to copy multiple resources from a zip files placed 
	' in Assets to the appropriate folders inside the WebGL library project folder.									  
	Wait For (gl.CopyResourcesFromZipFile(files, "resources.zip", 8192)) Complete (Success As Boolean)
	If Success Then
		LogColor("GENERIC RESOURCES DONE", xui.Color_Blue)
	Else
		LogColor("SOMETHING WENT WRONG WHILE GET GENERIC RESOURCES", xui.Color_Red)
	End If
	
	Wait For (gl.CopyResourcesFromZipFileToSingleFolder("models/gltf/porsche_911/textures", "textures.zip", 8192)) Complete (Success As Boolean)
	If Success Then
		LogColor("CAR TEXTURES DONE", xui.Color_Blue)
	Else
		LogColor("SOMETHING WENT WRONG WHILE GET CAR TEXTURES", xui.Color_Red)
	End If
	
	' JUST UNCOMMENT ONE
	DemoScene1
'	DemoScene2
End Sub

' Called just one time when the scene is updated
Private Sub WebGL_Updated(Url As String)
	Log(" ") : LogColor("Server static folder: " & gl.MainFolder, xui.Color_Magenta)
	Log(" ") : Log("To access the scene:")
	LogColor(Url, xui.Color_Magenta)
	Log("To access the library main page:")
	LogColor(gl.ServerMainPage, xui.Color_Magenta) : Log(" ")
	
'	' To avoid log truncation we can print it line by line
'	Dim lines() As String = Regex.Split(CRLF, gl.HtmlStringDebug)
'	For Each line As String In lines
'		LogColor(line, xui.Color_Blue)
'	Next
	
'	LogColor(gl.HtmlString, xui.Color_Blue) : Log(" ")  ' Show the final html string
'	LogColor(gl.HtmlStringDebug, xui.Color_Blue) : Log(" ")  ' Show the final html string in debug mode with line numbers. With this we can track JavaScript console errors.
End Sub

'/////////////////////////////// S C E N E S ////////////////////////////

Sub DemoScene1
		
	gl.Import("Stats from 'three/addons/libs/stats.module.js'")
	gl.Import("{ GUI } from 'three/addons/libs/lil-gui.module.min.js'")

	gl.Import("{ DRACOLoader } from 'three/addons/loaders/DRACOLoader.js'")
	gl.Import("{ GLTFLoader } from 'three/addons/loaders/GLTFLoader.js'")
	gl.Import("{ FBXLoader } from 'three/addons/loaders/FBXLoader.js'")
	
	gl.Import("{ windStrength, windForce, cloth, simulate, pins, ballPosition, ballSize } from 'three/addons/physics/Cloth.js'")
'	gl.Import("{ ParametricGeometry } from 'three/addons/geometries/ParametricGeometry.js'")
	
	gl.Import ("{ MeshoptDecoder } from 'three/addons/libs/meshopt_decoder.module.js'")
	
	Dim js As String = $"/////// PINS ///////

let pinsFormation = [];
let pinned = [6];

pinsFormation.push(pinned);

pinned = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
pinsFormation.push(pinned);

pinned = [0];
pinsFormation.push(pinned);

pinned = []; // cut the rope ;)
pinsFormation.push(pinned);

pinned = [0, cloth.w]; // classic 2 pins
pinsFormation.push(pinned);

pinned = pinsFormation[1];  // Init with all pins attached 

let pinnedCnt = 1;

///////////////////////////////

const clothWidth = 250;
const clothHeight = 250;
const clothSegmentsX = 10;
const clothSegmentsY = 10;

let container, stats, camera, scene, renderer, controls, gui, light, lightHelper, envMap;
let clothGeometry, clothMesh, sphere;	  

let wind = true;
let userWindForce = { force: 40} 
	
let gltfLoader, dracoLoader, fbxLoader;	
	
let gltfMixer, gltfAction, gltfModel;
let gltfMixer2, gltfAction2, gltfModel2;
let gltfMixer3, gltfAction3, gltfModel3;
let gltfMixer4, gltfAction4, gltfModel4;
let fbxMixer, fbxAction, fbxModel;

const clock = new THREE.Clock();
	
let autoAnimate = false;  // true;	
	
let t = 0;

let count = 0;

//////////////////////////////

function makeShadowGUI(light, name, onChangeFn) {
   const folder = gui.addFolder(name);
   folder.add(light.shadow.camera, "left", -4000, -1, 0.1).onChange(onChangeFn)
   folder.add(light.shadow.camera, "right", 1, 4000, 0.1).onChange(onChangeFn)
   folder.add(light.shadow.camera, "top", 1, 4000, 0.1).onChange(onChangeFn)
   folder.add(light.shadow.camera, "bottom", -4000, -1, 0.1).onChange(onChangeFn)
   folder.add(light.shadow.camera, "near", 0.1, 100).onChange(onChangeFn)
   folder.add(light.shadow.camera, "far", 1000, 6000).onChange(onChangeFn)
	folder.add(light.shadow, 'radius', 0.0, 10.0, 0.001).name('Radius').onChange(onChangeFn)
   folder.add(light.shadow, "bias", -0.01, 0.0, 0.0001).onChange(onChangeFn)
   folder.add(light.shadow, "normalBias", -1, 1, 0.0001).onChange(onChangeFn)
	folder.close();
}

const onChangeShadow = () => {
	light.target.updateMatrixWorld();
	light.shadow.camera.updateProjectionMatrix(); 
	lightHelper.update();
	render();
};

/////////////////////////////

init();
animate();

function init() {
	container = document.createElement('div');
	document.body.appendChild(container);

	stats = new Stats();
	container.appendChild(stats.dom);

	gui = new GUI();  // Our GUI interface

	const path = 'textures/cube/skybox/';
	const format = '.jpg';
	envMap = new THREE.CubeTextureLoader().load([
	  path + 'px' + format, path + 'nx' + format,
	  path + 'py' + format, path + 'ny' + format,
	  path + 'pz' + format, path + 'nz' + format,
	]);
	envMap.mapping = THREE.EquirectangunarReflectionMapping;
	//envMap.encoding = THREE.sRGBEncoding;

	scene = new THREE.Scene();
	//scene.background = new THREE.Color(0xcce0ff);
	scene.background = envMap;
	scene.environment = envMap;

	scene.fog = new THREE.Fog(0xcce0ff, 5000, 12000);

	camera = new THREE.PerspectiveCamera(35, window.innerWidth / window.innerHeight, 5, 10000);
	//camera.position.set(800, -140, 1900);
	camera.position.set(-500, -180, 1800);

   scene.add(new THREE.AmbientLight(0xffffff, 1));

	light = new THREE.DirectionalLight(0xffffff, 5);
	light.position.set(-400, 600, 550).multiplyScalar(1.3);
	light.castShadow = true;

	const d = 1000;
	light.shadow.camera.left = -d;
	light.shadow.camera.right = d;
	light.shadow.camera.top = d;
	light.shadow.camera.bottom = -d;

	light.shadow.mapSize.width = 2048;
	light.shadow.mapSize.height = 2048;
	light.shadow.camera.near = 0.5;
	light.shadow.camera.far = 3000;
	light.shadow.bias = -0.0022;  // Important, remove strip lines
	//light.shadow.normalBias = 1;

	scene.add(light);

	lightHelper = new THREE.CameraHelper(light.shadow.camera);
	scene.add(lightHelper);

	renderer = new THREE.WebGLRenderer({ antialias: true });
	renderer.setPixelRatio(window.devicePixelRatio);
	renderer.setSize(window.innerWidth, window.innerHeight);
	renderer.outputEncoding = THREE.sRGBEncoding;
	renderer.shadowMap.enabled = true; 
	
   //renderer.shadowMap.type = THREE.BasicShadowMap;      // Gives unfiltered shadow maps - fastest, but lowest quality.
	renderer.shadowMap.type = THREE.PCFShadowMap;      // Filters shadow maps using the Percentage-Closer Filtering (PCF) algorithm (default).
	//renderer.shadowMap.type = THREE.PCFSoftShadowMap;  // Filters shadow maps using the Percentage-Closer Filtering (PCF) algorithm with better soft shadows especially when using low-resolution shadow maps.
   //renderer.shadowMap.type = THREE.VSMShadowMap;      // Filters shadow maps using the Variance Shadow Map (VSM) algorithm. When using VSMShadowMap all shadow receivers will also cast shadows. 
	                                                      // Really better shadows but consume lot more resources reducing the framerate. May just need to tune shadows in light settings.	  
   const folder = gui.addFolder('ToneMapping');
	folder.close();
	folder.add(renderer, 'toneMapping', {
	    No: THREE.NoToneMapping,
	    Linear: THREE.LinearToneMapping,	 
	    Reinhard: THREE.ReinhardToneMapping,
	    Cineon: THREE.CineonToneMapping,	 
	    ACESFilmic: THREE.ACESFilmicToneMapping,
		 AgX: THREE.AgXToneMapping,
		 Neutral: THREE.NeutralToneMapping,
		 Custom: THREE.CustomToneMapping
	})
	folder.add(renderer, 'toneMappingExposure').min(0).max(3).step(0.01);

	//renderer.setAnimationLoop( animate );
	container.appendChild(renderer.domElement);

	controls = new OrbitControls(camera, renderer.domElement);
	controls.rotateSpeed = 0.5;    // By default 1.0
	controls.zoomSpeed = 1.0;      // By default 1.0
	controls.panSpeed = 1.5;       // By default 1.0
	controls.maxPolarAngle = Math.PI * 0.5;  // Limit the range
	controls.minDistance = 80;
	controls.maxDistance = 6000;
	controls.enableDamping = true;
	controls.dampingFactor = 0.04;
	controls.target = new THREE.Vector3(0, -200, 0);

	if (autoAnimate) {
		controls.autoRotate = true;
		controls.autoRotateSpeed = -0.5;  //0.5;
	}

   gui.add(controls, 'autoRotate');
	gui.add(controls, 'autoRotateSpeed', -5, 0, 0.1);
	
	window.addEventListener('resize', onWindowResize, false);
	onWindowResize();
	
	const loader = new THREE.TextureLoader();
   const clothTexture = loader.load('textures/patterns/B4XLogo.png');
	// = loader.load('textures/patterns/B4J.jpg');	
	clothTexture.colorSpace = THREE.SRGBColorSpace;
	//clothTexture.anisotropy = 16;
	clothTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();

	const clothMaterial = new THREE.MeshLambertMaterial({
		map: clothTexture,
		side: THREE.DoubleSide,
		alphaTest: 0.5
	});

	clothGeometry = new THREE.PlaneGeometry(clothWidth, clothHeight, clothSegmentsX, clothSegmentsY);
	clothMesh = new THREE.Mesh(clothGeometry, clothMaterial);
	clothMesh.position.set(0, 0, 0);
	clothMesh.frustumCulled = false;
	clothMesh.castShadow = true;
	clothMesh.receiveShadow = true;
	scene.add(clothMesh);

	clothMesh.customDepthMaterial = new THREE.MeshDepthMaterial({
		depthPacking: THREE.RGBADepthPacking,
		map: clothTexture,
		alphaTest: 0.5,
		opacity: 0.55,
	});

	const ballGeo = new THREE.SphereGeometry(ballSize, 32, 16);
	const ballMat = new THREE.MeshPhongMaterial({ color: 0xff0000 });

	sphere = new THREE.Mesh(ballGeo, ballMat);
	sphere.castShadow = true;
	sphere.receiveShadow = true;
	sphere.visible = false;
	scene.add(sphere);

	const groundTexture = loader.load('textures/terrain/grasslight-big.jpg'); 
	groundTexture.wrapS = groundTexture.wrapT = THREE.RepeatWrapping;
	groundTexture.repeat.set(10, 10);
	groundTexture.colorSpace = THREE.SRGBColorSpace;
	//groundTexture.anisotropy = 16;
	groundTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();	 
	
/*	
	const groundBump = loader.load('textures/terrain/grasslight-big-nm.jpg');
	groundBump.wrapS = groundBump.wrapT = THREE.RepeatWrapping;
	groundBump.repeat.set(20, 20);
*/

	//const groundMaterial = new THREE.MeshPhongMaterial({ map: groundTexture, bumpMap: groundBump });
	const groundMaterial = new THREE.MeshPhongMaterial({ map: groundTexture});
	//const groundMaterial = new THREE.MeshLambertMaterial({ map: groundTexture });

	groundMaterial.dithering = true;
	groundMaterial.shininess = 0;
   // groundMaterial.lightMap = groundTexture;
   // groundMaterial.specularMap = groundTexture;
   // groundMaterial.envMap = envMap; // Only for reflective
	
	const groundMesh = new THREE.Mesh( new THREE.CircleGeometry( 3000, 32 ), groundMaterial ); 
	groundMesh.position.y = -250;
	groundMesh.rotation.x = -Math.PI / 2;
	groundMesh.receiveShadow = true;
	scene.add(groundMesh);

	const polePositions = [
		{ x: -127.5, y: -62 },
		{ x: 127.5, y: -62 },
		{ x: 0, y: -255 + 5 + (750 / 2) },
		{ x: 127.5, y: -255 + 6 },
		{ x: -127.5, y: -255 + 6 }
   ];

	const poleMat = new THREE.MeshLambertMaterial({color: 0x989898});
	for (let i = 0; i < polePositions.length; i++) {
		let poleGeo;
		switch(i) {
			case 0:
			case 1:
				poleGeo = new THREE.BoxGeometry(5, 375, 5);
				break;
			case 2:
				poleGeo = new THREE.BoxGeometry(255 + 5, 5, 5);
				break;
			case 3:
			case 4:
				poleGeo = new THREE.BoxGeometry(10, 2, 10);
				break;
        }
		const poleMesh = new THREE.Mesh(poleGeo, poleMat);
		poleMesh.position.set(polePositions[i].x, polePositions[i].y, 0);
		poleMesh.receiveShadow = true;
		poleMesh.castShadow = true;
		scene.add(poleMesh);
   }
	 
	gltfLoader = new GLTFLoader();
	gltfLoader.setMeshoptDecoder( MeshoptDecoder ); // To optimize mesh
	
	dracoLoader = new DRACOLoader();
	dracoLoader.setDecoderPath( '/examples/jsm/libs/draco/' );
	gltfLoader.setDRACOLoader(dracoLoader);
	
	fbxLoader = new FBXLoader();

	loadModel1(envMap);  // Woman
	loadModel35(envMap);  // Man
	loadModel36(envMap);  // Drone	
	loadModel38(envMap);  // Woman 2
	loadModel4(envMap);  // Dancing boy

   loadModel2(envMap);  // Plant	    IF YOU HAVE LOW FRAMERATE, TRY TO COMMENT THIS
   loadModel37(envMap);  // Car	    IF YOU HAVE LOW FRAMERATE, TRY TO COMMENT THIS

	makeShadowGUI(light, 'Shadows', onChangeShadow);
	     
	gui.add(userWindForce, 'force', 0.0, 300.0).name('Wind Strength');
	gui.close();
}

window.startAnimation = function startAnimation() {
	 if (gltfAction) gltfAction.play();	
	 if (gltfAction2) gltfAction2.play();
	 if (gltfAction3) gltfAction3.play();
	 if (gltfAction4) gltfAction4.play();
    if (fbxAction) fbxAction.play();
    console.log("Animation started");
};

window.toggleWind = function toggleWind() {
    wind = !wind;
    console.log("Wind: " + window.wind);
};

window.toggleBall = function toggleBall() {
    sphere.visible = !sphere.visible;
    console.log("Sphere visible: " + sphere.visible);
};

/* random
window.togglePins = function togglePins() {
    pinned = pinsFormation[~~(Math.random() * pinsFormation.length)];
    console.log("Pinned: " + JSON.stringify(pinned));
}
*/

window.togglePins = function togglePins() { 
	 pinnedCnt++;
	 pinned = pinsFormation[pinnedCnt % pinsFormation.length];
	 console.log("Pinned: " + JSON.stringify(pinned));
}

function onWindowResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
}

function animate() {
	 const delta = clock.getDelta();
	 const time = Date.now();
   
    if (wind) {	  
        //const windStrength = Math.cos(time / 7000) * 20 + 40;
		  const windStrength = Math.cos(time / 7000) * userWindForce.force;
        windForce.set(Math.sin(time / 2000), Math.cos(time / 3000), Math.sin(time / 1000));
        windForce.normalize();
        windForce.multiplyScalar(windStrength);
    }

    if (controls.autoRotate) camera.position.y -= controls.autoRotateSpeed * 0.05;

    if (gltfMixer) gltfMixer.update(delta);
	 if (gltfMixer2) gltfMixer2.update(delta);
	 if (gltfMixer3) gltfMixer3.update(delta);
	 if (gltfMixer4) gltfMixer4.update(delta);
    if (fbxMixer) fbxMixer.update(delta);

    if (gltfModel) {
        t += 0.01;
        gltfModel.rotation.y += 0.01;
        gltfModel.position.x += 4 * Math.sin(t);
        gltfModel.position.z += 4 * Math.cos(t);
    }

    simulate(time, wind, clothGeometry, sphere, pinned);
    
    controls.update();
    stats.update();	 	 
    render();
	 
	 requestAnimationFrame(animate); // Request next frame on animation loop
}

function render() {
    const positionAttribute = clothGeometry.attributes.position;
    const particles = cloth.particles;
    for (let i = 0; i < particles.length; i++) {
        const particle = particles[i];
        positionAttribute.setXYZ(i, particle.position.x, particle.position.y, particle.position.z);
    }
	 
    positionAttribute.needsUpdate = true;

	 clothGeometry.computeVertexNormals();
				
    sphere.position.copy(ballPosition); // Copy ball position
    renderer.render(scene, camera);
}

function loadModel1(envMap) {
    gltfLoader.load('models/gltf/Eve/eve$@walk.glb', 
	   function (gltf) { // onLoad callback
        gltfModel = gltf.scene;
        gltfModel.traverse(function (node) {
            if (node.isMesh) {
                //node.material.envMap = envMap;
					 //node.material.envMapIntensity = 0;
					 //node.material.metalness = 0;
					 node.frustumCulled = false;
                node.receiveShadow = true;
                node.castShadow = true;
            }
        });

        gltfModel.scale.set(255, 255, 255);
        gltfModel.position.set(-250, -253, 150);

        const animations = gltf.animations;
        if (animations && animations.length) {
            gltfMixer = new THREE.AnimationMixer(gltfModel);
            gltfMixer.timeScale = 1.0;
								
			   const folder = gui.addFolder('Woman Animation');
            folder.add(gltfMixer, 'timeScale', 0.0, 2.0).name('Scale');
				
            for (let i = 0; i < animations.length; i++) {
                const animation = animations[i];
                gltfAction = gltfMixer.clipAction(animation);
            }
        }
		  
        scene.add(gltfModel);
		  console.log('Load of models/gltf/Eve/eve$@walk.glb COMPLETED');
      },		
		function ( xhr ) { // onProgress callback
			//console.log('Loading models/gltf/Eve/eve$@walk.glb: ' + (xhr.loaded / xhr.total * 100) + '% loaded');
		},		
		function ( err ) { // onError callback
			console.log( 'An error happened loading models/gltf/Eve/eve$@walk.glb => ' + err);
		}
	 );
}

function loadModel2(envMap) {
    gltfLoader.load('models/gltf/Plant/plant3.gltf',
	 	function (gltf) {
        const model = gltf.scene;
        model.traverse(function (node) {
            if (node.isMesh) {
					node.material.alphaTest = 0.5;  // Foliage already is transparent, but here we get alpha test for it's shadows
					node.material.transparent = true;
					node.material.side= THREE.DoubleSide;		  				 						 
					node.receiveShadow = true;
					node.castShadow = true;
            }
        });

        model.scale.set(16, 16, 16);
        model.position.set(-900, -253, -50);
        scene.add(model);
		  console.log('Load of models/gltf/Plant/plant3.gltf COMPLETED');
      },
	 	function ( xhr ) { // onProgress callback
			//console.log('Loading models/gltf/Plant/Plant3.gltf: ' + (xhr.loaded / xhr.total * 100) + '% loaded');
		},		
		function ( err ) { // onError callback
			console.log( 'An error happened loading models/gltf/Plant/Plant3.gltf => ' + err);
		}
	 );
}

function loadModel3(envMap) {	
	 gltfLoader.load('models/gltf/lone-monk_cycles_and_exposure-node_demo.glb', 
	 	function (gltf) {
        const model = gltf.scene;
        model.traverse(function (node) {
            if (node.isMesh) {
					node.material.envMap = envMap;
					node.material.side= THREE.DoubleSide;		  	 
					node.receiveShadow = true;
					node.castShadow = true;
            }
        });

        model.scale.set(190, 190, 190);
        model.position.set(-3800, -190, 3170);  // -249.5
        scene.add(model);
		  console.log('Load of models/gltf/lone-monk_cycles_and_exposure-node_demo.glb COMPLETED');
      },
	 	function ( xhr ) { // onProgress callback
			console.log('Loading models/gltf/lone-monk_cycles_and_exposure-node_demo.glb: ' + (xhr.loaded / xhr.total * 100) + '% loaded');
		},		
		function ( err ) { // onError callback
			console.log( 'An error happened loading models/gltf/lone-monk_cycles_and_exposure-node_demo.glb => ' + err);
		}
	 );
}

function loadModel35(envMap) {	
	 gltfLoader.load('models/gltf/facial__body_animated_party_m_0001_-_actorcore.glb', 
	 	function (gltf) {
        gltfModel2 = gltf.scene;
        gltfModel2.traverse(function (node) {
            if (node.isMesh) {
                node.material.envMap = envMap;
				    node.material.side= THREE.DoubleSide;		  
					 node.frustumCulled = false;			 
                node.receiveShadow = true;
                node.castShadow = true;
            }
        });

        gltfModel2.scale.set(106, 106, 106);
        gltfModel2.position.set(780, -250, -450);
		  gltfModel2.rotateY(Math.PI/100);
		  
		  const animations = gltf.animations;
        if (animations && animations.length) {
            gltfMixer2 = new THREE.AnimationMixer(gltfModel2);
            gltfMixer2.timeScale = 0.9;
								
			   const folder = gui.addFolder('Man Animation');
            folder.add(gltfMixer2, 'timeScale', 0.0, 2.0).name('Scale');
				
            for (let i = 0; i < animations.length; i++) {
                const animation = animations[i];
					 console.log('ANIMATION: ' + animation.name);
					 console.log('DURATION: ' + animation.duration + " Seconds");
                gltfAction2 = gltfMixer2.clipAction(animation);
            }
        }
		  
        scene.add(gltfModel2);
		  console.log('Load of models/gltf/facial__body_animated_party_m_0001_-_actorcore.glb COMPLETED');
      },
	 	function ( xhr ) { // onProgress callback
			//console.log('Loading models/gltf/facial__body_animated_party_m_0001_-_actorcore.glb: ' + (xhr.loaded / xhr.total * 100) + '% loaded');
		},		
		function ( err ) { // onError callback
			console.log( 'An error happened loading models/gltf/facial__body_animated_party_m_0001_-_actorcore.glb => ' + err);
		}
	 );
}

function loadModel36(envMap) {	
	 gltfLoader.load('models/gltf/buster_drone.glb', 
	 	function (gltf) {
        gltfModel3 = gltf.scene;
        gltfModel3.traverse(function (node) {
            if (node.isMesh) {			
					node.material.envMap = envMap;
					node.material.side = THREE.DoubleSide;		  	 							
					node.frustumCulled = false;
					node.receiveShadow = true;
					node.castShadow = true;
            }
        });

        gltfModel3.scale.set(200, 200, 200);
        gltfModel3.position.set(300, 10, 850);
		  gltfModel3.rotateY(Math.PI/10);
		  
		  const animations = gltf.animations;
        if (animations && animations.length) {
            gltfMixer3 = new THREE.AnimationMixer(gltfModel3);
            gltfMixer3.timeScale = 0.8;
								
			   const folder = gui.addFolder('Drone Animation');
            folder.add(gltfMixer3, 'timeScale', 0.0, 2.0).name('Scale');
				
            for (let i = 0; i < animations.length; i++) {
                const animation = animations[i];
					 console.log('DRONE ANIMATION: ' + animation.name);
					 console.log('DRONE ANIMATION DURATION: ' + animation.duration + " Seconds");
                gltfAction3 = gltfMixer3.clipAction(animation);
            }
        }
		  
        scene.add(gltfModel3);
		  console.log('Load of models/gltf/buster_drone.glb COMPLETED');
      },
	 	function ( xhr ) { // onProgress callback
			//console.log('Loading models/gltf/buster_drone.glb: ' + (xhr.loaded / xhr.total * 100) + '% loaded');
		},		
		function ( err ) { // onError callback
			console.log( 'An error happened loading models/gltf/buster_drone.glb => ' + err);
		}
	 );
}

function loadModel37(envMap) {	
//	 gltfLoader.load('models/gltf/lamborghini_huracan_twin_turbo_lost.glb', 
	 gltfLoader.load('models/gltf/porsche_911/scene.gltf',
	 	 (gltf) => {
        const model = gltf.scene;
		  model.traverse(function (node) {
            if (node.isMesh) {
				    //console.log(">>>> NODE IS MESH: " + node.name);
					 node.frustumCulled = false;			 
                node.receiveShadow = true;
                node.castShadow = true;
            }
							
				if(node.material) {
					/*
					if(node.material.transparent == false) {  // Change random material
					   var color = new THREE.Color( 0xffffff );
                  color.setHex( Math.random() * 0xffffff );
						
						const nmap = node.material.map;
						
						node.material.dispose();  // Aggiunto dopo per liberare memoria. Da controllare ...
						node.material = new THREE.MeshPhongMaterial({
							map: nmap,
							color: color,
							shininess: 2000
						});
	           } 
				  */
				  
				  /*
				  if(node.material.transparent) {
						//node.material.alphaMap = envMap;
					   node.material.lightMap = envMap;
						
					   node.material.envMap = envMap;			
					   node.material.envMapIntensity = 2.0;
						// node.material.opacity = 0.5;
					}
					*/
					
					//node.material.side= THREE.DoubleSide;			
					//console.log(node.name + " -> roughness: " + node.material.roughness);
								
					if (node.material.roughness) {
						if (node.material.roughness > 0) {
							node.material.roughness = node.material.roughness / 2;
						} 
					}		
					if (node.material.metalness) {
					   if (node.material.metalness > 0) {
							node.material.metalness = node.material.metalness / 5;
						}
					}	
					if (node.material.reflectivity) {
						//node.material.reflectivity = 1.0;
						node.material.reflectivity = 2.0;
					}				
				}				
        });
		  
		  //model.envMap = envMap;			
		  //model.envMapIntensity = 1.0;
		 
        model.scale.set(200, 200, 200);
		  model.position.set(300, -273, -850);
		  model.rotateY(-Math.PI/10);
		  
        scene.add(model);
		  console.log('Load of models/gltf/porsche_911/scene.gltf COMPLETED');
      },
	 	function ( xhr ) { // onProgress callback
			//console.log('Loading models/gltf/porsche_911/scene.gltf: ' + (xhr.loaded / xhr.total * 100) + '% loaded');
		},		
		function ( err ) { // onError callback
			console.log( 'An error happened loading models/gltf/porsche_911/scene.gltf => ' + err);
		}
	 );
}

function loadModel38(envMap) {	
	 gltfLoader.load('models/gltf/facial__body_animated_party_f_0002_-_actorcore.glb', 
	 	function (gltf) {
        gltfModel4 = gltf.scene;
        gltfModel4.traverse(function (node) {
            if (node.isMesh) {
                node.material.envMap = envMap;
				    node.material.side= THREE.DoubleSide;		  
					 node.frustumCulled = false;			 
                node.receiveShadow = true;
                node.castShadow = true;
            }
        });

        gltfModel4.scale.set(106, 106, 106);
        gltfModel4.position.set(570, -250, -700);
		  
		  const animations = gltf.animations;
        if (animations && animations.length) {
            gltfMixer4 = new THREE.AnimationMixer(gltfModel4);
            gltfMixer4.timeScale = 0.9;
								
			   const folder = gui.addFolder('Woman 2 Animation');
            folder.add(gltfMixer4, 'timeScale', 0.0, 2.0).name('Scale');
				
            for (let i = 0; i < animations.length; i++) {
                const animation = animations[i];
					 console.log('ANIMATION: ' + animation.name);
					 console.log('DURATION: ' + animation.duration + " Seconds");
                gltfAction4 = gltfMixer4.clipAction(animation);
            }
        }
		  
        scene.add(gltfModel4);
		  console.log('Load of models/gltf/facial__body_animated_party_m_0001_-_actorcore.glb COMPLETED');
      },
	 	function ( xhr ) { // onProgress callback
			//console.log('Loading models/gltf/facial__body_animated_party_m_0001_-_actorcore.glb: ' + (xhr.loaded / xhr.total * 100) + '% loaded');
		},		
		function ( err ) { // onError callback
			console.log( 'An error happened loading models/gltf/facial__body_animated_party_m_0001_-_actorcore.glb => ' + err);
		}
	 );
}

function loadModel4(envMap) {
		fbxLoader.load('models/fbx/Northern Soul Floor Combo.fbx',
		 function (fbxModel) {
	        fbxModel.traverse(function (node) {
	            if (node.isMesh) {
	                //node.material.envMap = envMap;
						 node.frustumCulled = false;
	                node.receiveShadow = true;
	                node.castShadow = true;
	            }
	        });

	        fbxModel.scale.set(2, 2, 2);
           fbxModel.position.set(0, -250, 220);

	        fbxMixer = new THREE.AnimationMixer(fbxModel);
	        fbxMixer.timeScale = 1.0;
	        fbxAction = fbxMixer.clipAction(fbxModel.animations[0]);
		     fbxAction.setLoop(THREE.LoopPingPong, Infinity);
			  
			  const folder = gui.addFolder('Dancing Boy Animation');
           folder.add(fbxMixer, 'timeScale', 0.0, 2.0).name('Scale');
			  
	        scene.add(fbxModel);
			  console.log('Load of models/fbx/Northern Soul Floor Combo.fbx COMPLETED');
	    },
	    function ( xhr ) { // onProgress callback
			//console.log('Loading models/fbx/Northern Soul Floor Combo.fbx: ' + (xhr.loaded / xhr.total * 100) + '% loaded');
		 },		
		 function ( err ) { // onError callback
			console.log( 'An error happened loading models/fbx/Northern Soul Floor Combo.fbx => ' + err);		
		 }
	 );
}"$

	gl.Inject(js)
	gl.Update
End Sub

Sub DemoScene2
		
	gl.Import("Stats from 'three/addons/libs/stats.module.js'")
	gl.Import("{ GUI } from 'three/addons/libs/lil-gui.module.min.js'")
	gl.Import("{ windStrength, windForce, cloth, simulate, pins, ballPosition, ballSize } from 'three/addons/physics/Cloth.js'")
	
	Dim js As String = $"/* testing cloth simulation */

/////// PINS ///////

let pinsFormation = [];
let pinned = [6];

pinsFormation.push(pinned);

pinned = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
pinsFormation.push(pinned);

pinned = [0];
pinsFormation.push(pinned);

pinned = []; // cut the rope ;)
pinsFormation.push(pinned);

pinned = [0, cloth.w]; // classic 2 pins
pinsFormation.push(pinned);

pinned = pinsFormation[1];  // Init with all pins attached 

let pinnedCnt = 1;

///////////////////////////////

const clothWidth = 250;
const clothHeight = 250;
const clothSegmentsX = 10;
const clothSegmentsY = 10;

let container, stats, camera, scene, renderer, controls, gui;
let clothGeometry, clothMesh, sphere;	  

let wind = true;
let userWindForce = { force: 20}

const clock = new THREE.Clock();

//var windForce = new THREE.Vector3(0, 0, 0);
//var ballSize = 60; // Example size	
	
let t = 0;
let count = 0;

init();
animate();

function init() {
    container = document.createElement('div');
    document.body.appendChild(container);

	stats = new Stats();
	container.appendChild(stats.dom);

	gui = new GUI();  // Our GUI interface
	
    const path = 'textures/cube/skybox/';
    const format = '.jpg';
    const envMap = new THREE.CubeTextureLoader().load([
        path + 'px' + format, path + 'nx' + format,
        path + 'py' + format, path + 'ny' + format,
        path + 'pz' + format, path + 'nz' + format,
    ]);
    envMap.mapping = THREE.EquirectangunarReflectionMapping;
    envMap.encoding = THREE.sRGBEncoding;

    scene = new THREE.Scene();
    //scene.background = new THREE.Color(0xcce0ff);
	 scene.background = envMap;
	 scene.environment = envMap;
	 
    scene.fog = new THREE.Fog(0xcce0ff, 7000, 12000);
    
    camera = new THREE.PerspectiveCamera(30, window.innerWidth / window.innerHeight, 5, 14000);
    camera.position.set(1100, -150, 800);
    //camera.lookAt(0, 0, 0);

    //scene.add(new THREE.AmbientLight(0x666666));
    scene.add(new THREE.AmbientLight(0xffffff, 0.75));
	 
    //const light = new THREE.DirectionalLight(0xdfebff, 1.0);
	 const light = new THREE.DirectionalLight(0xffffff, 5.0);
    light.position.set(-400, 600, 550).multiplyScalar(1.3);
    light.castShadow = true;

    const d = 2000;
    light.shadow.camera.left = -d;
    light.shadow.camera.right = d;
    light.shadow.camera.top = d;
    light.shadow.camera.bottom = -d;

    light.shadow.mapSize.width = 2048;
    light.shadow.mapSize.height = 2048;
    light.shadow.camera.near = 0.5;
    light.shadow.camera.far = 3000;
    light.shadow.bias = -0.0022;  // Remove strip lines in shadows
    
	 scene.add(light);
    scene.add(new THREE.CameraHelper(light.shadow.camera));

    renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.setSize(window.innerWidth, window.innerHeight); 
	 
	 //renderer.toneMapping = THREE.NeutralToneMapping;
	 //renderer.toneMappingExposure = 1.0;  //0.75
	 //gui.add(renderer, 'toneMappingExposure').min(0).max(3).step(0.01);
	 
	 renderer.outputEncoding = THREE.sRGBEncoding;
    renderer.shadowMap.enabled = true;
	 
    //renderer.shadowMap.type = THREE.BasicShadowMap;      // Gives unfiltered shadow maps - fastest, but lowest quality.
	 //renderer.shadowMap.type = THREE.PCFShadowMap;        // Filters shadow maps using the Percentage-Closer Filtering (PCF) algorithm (default).
	 renderer.shadowMap.type = THREE.PCFSoftShadowMap;  // Filters shadow maps using the Percentage-Closer Filtering (PCF) algorithm with better soft shadows especially when using low-resolution shadow maps.
    //renderer.shadowMap.type = THREE.VSMShadowMap;      // Filters shadow maps using the Variance Shadow Map (VSM) algorithm. When using VSMShadowMap all shadow receivers will also cast shadows. 
	                                                      // Really better shadows but consume lot more resources reducing the framerate. May just need to tune shadows in light settings.
																			  
    container.appendChild(renderer.domElement);

    controls = new OrbitControls(camera, renderer.domElement);
    controls.maxPolarAngle = Math.PI * 0.5;
    controls.minDistance = 250;
    controls.maxDistance = 6000;
    controls.enableDamping = true;
    controls.dampingFactor = 0.02;
    controls.autoRotate = true;
    controls.autoRotateSpeed = 0.5;
    controls.target = new THREE.Vector3(0, -160, 0);

    window.addEventListener('resize', onWindowResize, false);

    const loader = new THREE.TextureLoader();
    //const clothTexture = loader.load('textures/patterns/B4XLogo.png');
	 const clothTexture = loader.load('textures/patterns/B4J.jpg');
    clothTexture.colorSpace = THREE.SRGBColorSpace;
	 //clothTexture.anisotropy = 16;
    clothTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();

    const clothMaterial = new THREE.MeshLambertMaterial({
        map: clothTexture,
        side: THREE.DoubleSide,
        alphaTest: 0.5
    });

    clothGeometry = new THREE.PlaneGeometry(clothWidth, clothHeight, clothSegmentsX, clothSegmentsY);
    clothMesh = new THREE.Mesh(clothGeometry, clothMaterial);
    clothMesh.position.set(0, 0, 0);
	 clothMesh.frustumCulled = false;
    clothMesh.castShadow = true;
    clothMesh.receiveShadow = true;
    scene.add(clothMesh);
	 
    clothMesh.customDepthMaterial = new THREE.MeshDepthMaterial({
        depthPacking: THREE.RGBADepthPacking,
        map: clothTexture,
        alphaTest: 0.5,
		  opacity: 0.55,
    });

    const ballGeo = new THREE.SphereGeometry(ballSize, 32, 16);
    const ballMat = new THREE.MeshPhongMaterial({ color: 0xff0000 });  // Red

    sphere = new THREE.Mesh(ballGeo, ballMat);
    sphere.castShadow = true;
    sphere.receiveShadow = true;
    scene.add(sphere);

    sphere.visible = false;

    const groundTexture = loader.load('textures/terrain/grasslight-big.jpg');
    groundTexture.wrapS = groundTexture.wrapT = THREE.RepeatWrapping;
    groundTexture.repeat.set(25, 25);
	 groundTexture.colorSpace = THREE.SRGBColorSpace;
    //groundTexture.anisotropy = 16;
	 groundTexture.anisotropy = renderer.capabilities.getMaxAnisotropy();
	 
/*	 
    const groundBump = loader.load('textures/terrain/grasslight-big-nm.jpg');
    groundBump.wrapS = groundBump.wrapT = THREE.RepeatWrapping;
    groundBump.repeat.set(25, 25);
*/

    const groundMaterial = new THREE.MeshPhongMaterial({  map: groundTexture });
    //const groundMaterial = new THREE.MeshPhongMaterial({  map: groundTexture,  bumpMap: groundBump });

    groundMaterial.dithering = true;
	 groundMaterial.shininess = 0;	
    // groundMaterial.lightMap = groundTexture;
    // groundMaterial.specularMap = groundTexture;
    // groundMaterial.envMap = envMap;

    //const mesh = new THREE.Mesh(new THREE.PlaneGeometry(16000, 16000), groundMaterial);
    const mesh = new THREE.Mesh( new THREE.CircleGeometry( 6000, 32 ), groundMaterial );
    mesh.position.y = -250;
    mesh.rotation.x = -Math.PI / 2;
    mesh.receiveShadow = true;
    scene.add(mesh);

    const polePositions = [
        { x: -127.5, y: -62 },
        { x: 127.5, y: -62 },
        { x: 0, y: -255 + 5 + (750 / 2) },
        { x: 127.5, y: -255 + 6 },
        { x: -127.5, y: -255 + 6 }
    ];

    const poleMat = new THREE.MeshLambertMaterial({color: 0x989898});
    for (let i = 0; i < polePositions.length; i++) {
        let poleGeo;
        switch(i) {
            case 0:
            case 1:
                poleGeo = new THREE.BoxGeometry(5, 375, 5);
                break;
            case 2:
                poleGeo = new THREE.BoxGeometry(255 + 5, 5, 5);
                break;
            case 3:
            case 4:
                poleGeo = new THREE.BoxGeometry(10, 2, 10);
                break;
        }
        const poleMesh = new THREE.Mesh(poleGeo, poleMat);
        poleMesh.position.set(polePositions[i].x, polePositions[i].y, 0);
        poleMesh.receiveShadow = true;
        poleMesh.castShadow = true;
        scene.add(poleMesh);
    }
	 
	 gui.add(userWindForce, 'force', 0.0, 300.0).name('Wind Strength');
}

window.startAnimation = function startAnimation() {
    console.log("Animation started. Just a fake.");
};

window.toggleWind = function toggleWind() {
    wind = !wind;
    console.log("Wind: " + wind);
};

window.toggleBall = function toggleBall() {
    sphere.visible = !sphere.visible;
    console.log("Sphere visible: " + sphere.visible);
};

/* random
window.togglePins = function togglePins() {
    pinned = pinsFormation[~~(Math.random() * pinsFormation.length)];
    console.log("Pinned: " + JSON.stringify(pinned));
}
*/

window.togglePins = function togglePins() { 
	 pinnedCnt++;
	 pinned = pinsFormation[pinnedCnt % pinsFormation.length];
	 console.log("Pinned: " + JSON.stringify(pinned));
}

function onWindowResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
}

function animate() {
    const delta = clock.getDelta();
    requestAnimationFrame(animate);

    camera.position.y += 0.01;

    const time = Date.now();
	 
	 /*
    if (wind) {
        const windStrength = Math.cos(time / 7000) * 20 + 50;
        windForce.set(Math.sin(time / 2000), Math.cos(time / 3000), Math.sin(time / 1000));
        windForce.normalize();
        windForce.multiplyScalar(windStrength); 
    }
	 */
	 
	 if (wind) {	  
        //const windStrength = Math.cos(time / 7000) * 20 + 40;
		  const windStrength = Math.cos(time / 7000) * userWindForce.force;
        windForce.set(Math.sin(time / 2000), Math.cos(time / 3000), Math.sin(time / 1000));
        windForce.normalize();
        windForce.multiplyScalar(windStrength);
    }

    simulate(time, wind, clothGeometry, sphere, pinned);

    controls.update();
    stats.update();
    render();
}

function render() {
    const positionAttribute = clothGeometry.attributes.position;
    const particles = cloth.particles;
    for (let i = 0; i < particles.length; i++) {
        const particle = particles[i];
        positionAttribute.setXYZ(i, particle.position.x, particle.position.y, particle.position.z);
    }
	  
    positionAttribute.needsUpdate = true;

    // Calculate normals before rendering
    clothGeometry.computeVertexNormals();

    sphere.position.copy(ballPosition);
    renderer.render(scene, camera);
}"$

	gl.Inject(js)
	gl.Update
End Sub
