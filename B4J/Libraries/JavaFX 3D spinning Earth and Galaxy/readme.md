### JavaFX 3D spinning Earth and Galaxy by Johan Schoeman
### 12/16/2022
[B4X Forum - B4J - Libraries](https://www.b4x.com/android/forum/threads/144843/)

Change it to your liking - download it from here:  
  
[MEDIA=googledrive]1Ms1TxAljysbLW8JW6O8o\_mOJnzE8VsmD[/MEDIA]  

```B4X
#Region Project Attributes  
    #MainFormWidth: 600  
    #MainFormHeight: 600  
#End Region  
  
#AdditionalJar: j3dcore  
#AdditionalJar: j3dutils  
#AdditionalJar: vecmath  
  
  
Sub Process_Globals  
    Private fx As JFX  
    Private MainForm As Form  
    Private xui As XUI  
    Private Pane1 As Pane  
   
    Dim erth As earth  
    Dim bb As JavaObject  
   
    Dim t As Timer  
   
   
   
    Private ImageView1 As ImageView  
End Sub  
  
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    MainForm.Show  
       
    t.Initialize("t", 10)  
    erth.Initialize  
  
    bb = erth.makethecube  
   
    Pane1.AddNode(bb, MainForm.Width * 0.06, MainForm.Height * 0.1, MainForm.Width * 0.8, MainForm.Height * 0.8)  
    Pane1.Visible = True  
   
    t.Enabled = True  
   
End Sub  
  
  
Sub t_tick  
   
    erth.Rotationspeed = -0.2  
   
End Sub
```

  
  

```B4X
Sub Class_Globals  
    Private fx As JFX  
   
    Dim nativeMe As JavaObject  
    Dim ips1, ips2, ips3, ips4 As InputStream  
   
End Sub  
  
'Initializes the object. You can add parameters to this method if needed.  
Public Sub Initialize  
   
  
    nativeMe = Me  
    ips1 = File.OpenInput(File.DirAssets, "earth-d.jpg")  
    ips2 = File.OpenInput(File.DirAssets, "earth-l.jpg")  
    ips3 = File.OpenInput(File.DirAssets, "earth-s.jpg")  
    ips4 = File.OpenInput(File.DirAssets, "earth-n.jpg")  
   
   
  
End Sub  
  
public Sub makethecube As JavaObject  
   
    Return nativeMe.RunMethod("start1",  Array(ips1, ips2, ips3, ips4))  
   
End Sub  
  
  
public Sub setRotationspeed (spd As Float)  
   
    nativeMe.RunMethod("rotateEarth", Array(spd))  
   
   
End Sub  
  
  
  
#if Java  
  
import javafx.animation.AnimationTimer;  
import javafx.application.Application;  
import javafx.beans.property.DoubleProperty;  
import javafx.beans.property.SimpleDoubleProperty;  
import javafx.scene.Camera;  
import javafx.scene.Group;  
import javafx.scene.Node;  
import javafx.scene.PerspectiveCamera;  
import javafx.scene.Scene;  
import javafx.scene.image.Image;  
import javafx.scene.input.ScrollEvent;  
import javafx.scene.paint.Color;  
import javafx.scene.paint.PhongMaterial;  
import javafx.scene.shape.Sphere;  
import javafx.scene.transform.Rotate;  
import javafx.stage.Stage;  
import java.io.InputStream;  
  
  
  
  private static final float WIDTH = 300;  
  private static final float HEIGHT = 300;  
  
  private double anchorX, anchorY;  
  private double anchorAngleX = 0;  
  private double anchorAngleY = 0;  
  private final DoubleProperty angleX = new SimpleDoubleProperty(0);  
  private final DoubleProperty angleY = new SimpleDoubleProperty(0);  
  
  private final Sphere sphere = new Sphere(150);  
  
   
  public Group start1(InputStream ips1, InputStream ips2, InputStream ips3, InputStream ips4) {  
    Camera camera = new PerspectiveCamera(true);  
    camera.setNearClip(1);  
    camera.setFarClip(10000);  
    camera.translateZProperty().set(-900);  
  
    Group world = new Group();  
    world.getChildren().add(prepareEarth(ips1, ips2, ips3, ips4));  
  
    Scene scene = new Scene(world, WIDTH, HEIGHT, true);  
    scene.setFill(Color.SILVER);  
    scene.setCamera(camera);  
  
//    initMouseControl(world, scene, primaryStage);  
  
//    prepareAnimation();  
   
    return world;  
  }  
  
  
    public void rotateEarth(float rotspeed) {  
   
        sphere.rotateProperty().set(sphere.getRotate() + rotspeed);  
   
    }  
  
/*  
  private void prepareAnimation() {  
    AnimationTimer timer = new AnimationTimer() {  
      @Override  
      public void handle(long now) {  
        sphere.rotateProperty().set(sphere.getRotate() + 0.2);  
      }  
    };  
    timer.start();  
  }  */  
  
  private Node prepareEarth(InputStream ips1, InputStream ips2, InputStream ips3, InputStream ips4) {  
    PhongMaterial earthMaterial = new PhongMaterial();  
    earthMaterial.setDiffuseMap(new Image(ips1));  
    earthMaterial.setSelfIlluminationMap(new Image(ips2));  
    earthMaterial.setSpecularMap(new Image(ips3));  
    earthMaterial.setBumpMap(new Image(ips4));  
  
    sphere.setRotationAxis(Rotate.Y_AXIS);  
    sphere.setMaterial(earthMaterial);  
    return sphere;  
  }  
  
  private void initMouseControl(Group group, Scene scene, Stage stage) {  
    Rotate xRotate;  
    Rotate yRotate;  
    group.getTransforms().addAll(  
        xRotate = new Rotate(0, Rotate.X_AXIS),  
        yRotate = new Rotate(0, Rotate.Y_AXIS)  
    );  
    xRotate.angleProperty().bind(angleX);  
    yRotate.angleProperty().bind(angleY);  
  
    scene.setOnMousePressed(event -> {  
      anchorX = event.getSceneX();  
      anchorY = event.getSceneY();  
      anchorAngleX = angleX.get();  
      anchorAngleY = angleY.get();  
    });  
  
    scene.setOnMouseDragged(event -> {  
      angleX.set(anchorAngleX - (anchorY - event.getSceneY()));  
      angleY.set(anchorAngleY + anchorX - event.getSceneX());  
    });  
  
    stage.addEventHandler(ScrollEvent.SCROLL, event -> {  
      double delta = event.getDeltaY();  
      group.translateZProperty().set(group.getTranslateZ() + delta);  
    });  
  }  
  
#End If
```

  
  
  
  
![](https://www.b4x.com/android/forum/attachments/137026)