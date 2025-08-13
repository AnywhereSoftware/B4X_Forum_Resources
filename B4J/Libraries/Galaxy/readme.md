### Galaxy by Johan Schoeman
### 12/27/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/145082/)

Not to scale but all planets as well as the sun rotating on their respective axis's at the same rate (for now) - a 3D view of all of the planets and the sun (have included Pluto)  
  
Download it from here - too big a zip to upload:  
[MEDIA=googledrive]1HrWoJDeoGrjL54flmOY0KxxCnLvzQdsg[/MEDIA]  
  
  
![](https://www.b4x.com/android/forum/attachments/137367)  
  
Mostly done with JavaObject - sample code (images used from various places on the web):  
  

```B4X
#Region  Project Attributes  
    #MainFormWidth: 800  
    #MainFormHeight: 800  
#End Region  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Dim ips1, ips2, ips3, ips4 As InputStream  
    Dim rotspeed As Double = 0  
     
    Dim earth, sphereEarth As JavaObject  
    Dim sun, sphereSun As JavaObject  
    Dim mercury, sphereMercury As JavaObject  
    Dim venus, sphereVenus As JavaObject  
    Dim moon, sphereMoon As JavaObject  
    Dim mars, sphereMars As JavaObject  
    Dim jupiter, sphereJupiter As JavaObject  
    Dim saturn, sphereSaturn As JavaObject  
    Dim uranus, sphereUranus As JavaObject  
    Dim neptune, sphereNeptune As JavaObject  
    Dim pluto, spherePluto As JavaObject  
     
    Dim lft, tp, wdth, hght As Int  
     
    Dim t As Timer  
  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
     
    t.Initialize("t", 100)  
  
    MainForm.Initialize("frm", fx.PrimaryScreen.MaxX - fx.PrimaryScreen.MinX, fx.PrimaryScreen.MaxY - fx.PrimaryScreen.MinY)  
    MainForm.WindowWidth = fx.PrimaryScreen.MaxX - fx.PrimaryScreen.MinX           'set the screen to full width/height  
    MainForm.WindowLeft = fx.PrimaryScreen.MinX  
    MainForm.WindowHeight = fx.PrimaryScreen.MaxY - fx.PrimaryScreen.MinY  
    MainForm.WindowTop = fx.PrimaryScreen.MinY  
     
    MainForm.RootPane.LoadLayout("main")  
    MainForm.Show  
    Sleep(0)  
  
    addSun  
    Sleep(0)  
    addMercury  
    Sleep(0)  
    addVenus  
    Sleep(0)  
    addEarth  
    Sleep(0)  
    addMoon  
    Sleep(0)  
    addMars  
    Sleep(0)  
    addJupiter  
    Sleep(0)  
    addSaturn  
    Sleep(0)  
    addUranus  
    Sleep(0)  
    addNeptune  
    Sleep(0)  
    addPluto  
    Sleep(0)  
     
     
    t.Enabled = True  
  
End Sub  
  
Sub t_tick  
     
    rotspeed = -0.84  
    Dim pos As Double = sphereSun.RunMethod("getRotate", Null)  
    rotspeed = rotspeed + pos  
    sphereSun.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    sphereMercury.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    sphereVenus.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    sphereEarth.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    sphereMoon.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    sphereMars.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    sphereJupiter.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    sphereSaturn.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    sphereUranus.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    sphereNeptune.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    spherePluto.RunMethodJO("rotateProperty", Null).RunMethodJO("set", Array(rotspeed))  
    Sleep(0)  
     
End Sub  
  
Sub addSun  
     
    Dim diam As Double = 100.0dip  
     
    sphereSun.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    sun.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "sun.jfif")  
  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
     
  
    Dim sunMaterial As JavaObject  
    sunMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    sunMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereSun.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereSun.RunMethodJO("setMaterial", Array(sunMaterial))  
  
    sun.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereSun))  
     
    lft = 20dip  
    tp = MainForm.WindowHeight - (3 * diam)  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(sun, lft,tp, wdth, hght)  
  
End Sub  
  
Sub addMercury  
     
    Dim diam As Double = 25.0dip  
     
    sphereMercury.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    mercury.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "mercury5.jfif")  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
  
    Dim mercuryMaterial As JavaObject  
    mercuryMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    mercuryMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereMercury.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereMercury.RunMethodJO("setMaterial", Array(mercuryMaterial))  
  
    mercury.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereMercury))  
     
    lft = lft + 250dip  
    tp = tp - 5dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(mercury, lft, tp, wdth, hght)  
  
End Sub  
  
Sub addVenus  
     
    Dim diam As Double = 25.0dip  
     
    sphereVenus.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    venus.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "venus2.jfif")  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
  
    Dim venusMaterial As JavaObject  
    venusMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    venusMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereVenus.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereVenus.RunMethodJO("setMaterial", Array(venusMaterial))  
  
    venus.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereVenus))  
     
    lft = lft + 100dip  
    tp = tp - 15dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(venus, lft, tp, wdth, hght)  
  
End Sub  
  
Sub addEarth  
     
    Dim diam As Double = 50.0dip  
     
    sphereEarth.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    earth.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "earth-d.jpg")  
    ips2 = File.OpenInput(File.DirAssets, "earth-l.jpg")  
    ips3 = File.OpenInput(File.DirAssets, "earth-s.jpg")  
    ips4 = File.OpenInput(File.DirAssets, "earth-n.jpg")  
  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
    Dim image2 As JavaObject  
    image2.InitializeNewInstance("javafx.scene.image.Image", Array(ips2))  
    Dim image3 As JavaObject  
    image3.InitializeNewInstance("javafx.scene.image.Image", Array(ips3))  
    Dim image4 As JavaObject  
    image4.InitializeNewInstance("javafx.scene.image.Image", Array(ips4))  
     
  
    Dim earthMaterial As JavaObject  
    earthMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    earthMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
    earthMaterial.RunMethodJO("setSelfIlluminationMap", Array(image2))  
    earthMaterial.RunMethodJO("setSpecularMap", Array(image3))  
    earthMaterial.RunMethodJO("setBumpMap", Array(image4))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereEarth.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereEarth.RunMethodJO("setMaterial", Array(earthMaterial))  
  
    earth.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereEarth))  
     
    lft = lft + 100dip  
    tp = tp - 70dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(earth, lft, tp, wdth, hght)  
  
End Sub  
  
Sub addMoon  
     
    Dim diam As Double = 15.0dip  
     
    sphereMoon.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    moon.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "moon.jfif")  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
     
    Dim moonMaterial As JavaObject  
    moonMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    moonMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereMoon.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereMoon.RunMethodJO("setMaterial", Array(moonMaterial))  
  
    moon.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereMoon))  
     
    lft = lft + 0dip  
    tp = tp - 30dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(moon, lft, tp, wdth, hght)  
  
End Sub  
  
Sub addMars  
     
    Dim diam As Double = 35.0dip  
     
    sphereMars.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    mars.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "mars1.jfif")  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
     
    Dim marsMaterial As JavaObject  
    marsMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    marsMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereMars.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereMars.RunMethodJO("setMaterial", Array(marsMaterial))  
  
    mars.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereMars))  
     
    lft = lft + 150dip  
    tp = tp - 30dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(mars, lft, tp, wdth, hght)  
  
End Sub  
  
Sub addJupiter  
     
    Dim diam As Double = 50.0dip  
     
    sphereJupiter.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    jupiter.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "jupiter4.jfif")  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
     
    Dim jupiterMaterial As JavaObject  
    jupiterMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    jupiterMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereJupiter.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereJupiter.RunMethodJO("setMaterial", Array(jupiterMaterial))  
  
    jupiter.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereJupiter))  
     
    lft = lft + 120dip  
    tp = tp - 50dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(jupiter, lft, tp, wdth, hght)  
  
End Sub  
  
Sub addSaturn  
     
    Dim diam As Double = 60.0dip  
     
    sphereSaturn.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    saturn.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "saturn3.jfif")  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
     
    Dim saturnMaterial As JavaObject  
    saturnMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    saturnMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereSaturn.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereSaturn.RunMethodJO("setMaterial", Array(saturnMaterial))  
  
    saturn.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereSaturn))  
     
    lft = lft + 150dip  
    tp = tp - 60dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(saturn, lft, tp, wdth, hght)  
  
End Sub  
  
Sub addUranus  
     
    Dim diam As Double = 60.0dip  
     
    sphereUranus.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    uranus.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "uranus2.jfif")  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
     
    Dim uranusMaterial As JavaObject  
    uranusMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    uranusMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereUranus.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereUranus.RunMethodJO("setMaterial", Array(uranusMaterial))  
  
    uranus.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereUranus))  
     
    lft = lft + 150dip  
    tp = tp - 60dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(uranus, lft, tp, wdth, hght)  
  
End Sub  
  
Sub addNeptune  
     
    Dim diam As Double = 50.0dip  
     
    sphereNeptune.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    neptune.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "neptune2.jfif")  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
     
    Dim neptuneMaterial As JavaObject  
    neptuneMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    neptuneMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    sphereNeptune.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    sphereNeptune.RunMethodJO("setMaterial", Array(neptuneMaterial))  
  
    neptune.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(sphereNeptune))  
     
    lft = lft + 150dip  
    tp = tp - 60dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(neptune, lft, tp, wdth, hght)  
  
End Sub  
  
Sub addPluto  
     
    Dim diam As Double = 10.0dip  
     
    spherePluto.InitializeNewInstance("javafx.scene.shape.Sphere", Array(diam))  
    pluto.InitializeNewInstance("javafx.scene.Group", Null)  
  
    ips1 = File.OpenInput(File.DirAssets, "pluto.jfif")  
     
    Dim image1 As JavaObject  
    image1.InitializeNewInstance("javafx.scene.image.Image", Array(ips1))  
     
    Dim plutoMaterial As JavaObject  
    plutoMaterial.InitializeNewInstance("javafx.scene.paint.PhongMaterial", Null)  
  
    plutoMaterial.RunMethodJO("setDiffuseMap", Array(image1))  
     
    Dim rot As JavaObject  
    rot.InitializeStatic("javafx.scene.transform.Rotate")  
     
    spherePluto.RunMethodJO("setRotationAxis", Array(rot.GetField("Y_AXIS")))  
    spherePluto.RunMethodJO("setMaterial", Array(plutoMaterial))  
  
    pluto.RunMethodJO("getChildren", Null).RunMethodJO("add", Array(spherePluto))  
     
    lft = lft + 150dip  
    tp = tp - 60dip  
    wdth = diam  
    hght = diam  
     
    MainForm.RootPane.AddNode(pluto, lft, tp, wdth, hght)  
  
End Sub
```