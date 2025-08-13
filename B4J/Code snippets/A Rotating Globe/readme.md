### A Rotating Globe by jkhazraji
### 10/07/2024
[B4X Forum - B4J - Code snippets](https://www.b4x.com/android/forum/threads/163471/)

Using the inline feature, the code displays a rotating globe with a diffuse map. It totally relies on the inline code without the   
need for external libraries or references.  
Code needs to be completed in some places by an attentive b4j programmer. I just left them blank for interaction:)  
see demo:   
[MEDIA=youtube]Gheksmhqm6U[/MEDIA]  

```B4X
Sub AppStart (Form1 As Form, Args() As String)  
    MainForm = Form1  
    MainForm.RootPane.LoadLayout("Layout1")  
    Dim jform As JavaObject = MainForm  
    Dim jStage As JavaObject  
   '  
   '……………………………………  
   Dim earthView As JavaObject=(Me).As(JavaObject).InitializeStatic("com.prosoft.jEarthView.main$EarthViewer")  
   '……………………………………  
    MainForm.Show  
End Sub  
  
#if Java  
import javafx.animation.*;  
import javafx.scene.*;  
import javafx.scene.image.Image;  
import javafx.scene.layout.StackPane;  
import javafx.scene.paint.*;  
import javafx.scene.shape.Sphere;  
import javafx.scene.transform.Rotate;  
//……………………….  
import javafx.util.Duration;  
  
public static class EarthViewer {  
  
  private static final double EARTH_RADIUS  = 320;  
  private static final double VIEWPORT_SIZE = 600;  
  private static final double ROTATE_SECS   = 80;  
  
  private static final double MAP_WIDTH  = 8192 / 2d;  
  private static final double MAP_HEIGHT = 4092 / 2d;  
  
  private static final String DIFFUSE_MAP ="https://planetpixelemporium.com/download/download.php?8081/earthmap10k.jpg";  
            
  private static final String NORMAL_MAP = "";  
  private static final String SPECULAR_MAP = "";  
  
  private static Group buildScene() {  
    Sphere earth = new Sphere(EARTH_RADIUS);  
    earth.setTranslateX(VIEWPORT_SIZE / 2d);  
    earth.setTranslateY(VIEWPORT_SIZE / 2d);  
  
    PhongMaterial earthMaterial = new PhongMaterial();  
    earthMaterial.setDiffuseMap(  
      new Image(  
        DIFFUSE_MAP,  
        MAP_WIDTH,  
        MAP_HEIGHT,  
        true,  
        true  
      )  
    );  
    earthMaterial.setBumpMap(  
      new Image(  
        NORMAL_MAP,  
        MAP_WIDTH,  
        MAP_HEIGHT,  
        true,  
        true  
      )  
    );  
    earthMaterial.setSpecularMap(  
      new Image(  
        SPECULAR_MAP,  
        MAP_WIDTH,  
        MAP_HEIGHT,  
        true,  
        true  
      )  
    );  
  
    earth.setMaterial(  
        earthMaterial  
    );  
  
    return new Group(earth);  
  }  
  
   
  public void earthview(Stage stage) {  
    Group group = buildScene();  
  
    Scene scene = new Scene(  
      new StackPane(group),  
      VIEWPORT_SIZE, VIEWPORT_SIZE,  
      true,  
      SceneAntialiasing.BALANCED  
    );  
  
    scene.setFill(Color.rgb(10, 10, 40));  
  
    scene.setCamera(new PerspectiveCamera());  
  
    stage.setScene(scene);  
   //……………………………..  
  
   //………………………………  
  
    rotateAroundYAxis(group).play();  
  }  
  
  private static RotateTransition rotateAroundYAxis(Node node) {  
    RotateTransition rotate = new RotateTransition(  
      Duration.seconds(ROTATE_SECS),  
      node  
    );  
    rotate.setAxis(Rotate.Y_AXIS);  
    rotate.setFromAngle(360);  
    rotate.setToAngle(0);  
    rotate.setInterpolator(Interpolator.LINEAR);  
    rotate.setCycleCount(RotateTransition.INDEFINITE);  
  
    return rotate;  
  }  
  
}  
  
#End If
```