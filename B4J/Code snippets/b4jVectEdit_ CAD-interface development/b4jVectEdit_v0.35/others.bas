B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Type LeftTop (left As Double, top As Double)
	Type WidthHeight (width As Double, height As Double)
	Private rotate As JavaObject
	Private point3D As JavaObject
End Sub

Sub SavePicture (dir As String, fn As String, bmp As B4XBitmap)
	Dim outs As OutputStream
	outs = File.OpenOutput(dir, fn, False)
	bmp.WriteToStream(outs, 80, "PNG")
	outs.Close
End Sub

Sub Rotate_View(v As B4XView, degrees As Double)
	' 1.0,0.0,0.0, = x axis, 0.0,1.0,0.0 = y axis and 0.0,0.0,1.0 = z axis
	point3D = point3D.InitializeNewInstance("javafx.geometry.Point3D",Array(0.0,0.0,1.0))
	' rotate 45degrees on axis defined above (y axis)
	rotate.InitializeNewInstance("javafx.scene.transform.Rotate",Array(degrees,point3D))
	' transform the node/control
	asJO(v).RunMethodJO("getTransforms",Null).RunMethod("add",Array(rotate))
End Sub
Sub asJO(o As JavaObject)As JavaObject
	Return o
End Sub

