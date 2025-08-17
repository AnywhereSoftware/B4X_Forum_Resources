B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	
	Private fx As JFX
	Dim nativeMe As JavaObject
	
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
	nativeMe = Me

End Sub

public Sub makethecube () As JavaObject
	
	Return nativeMe.RunMethod("start1", Null)
	
End Sub

public Sub setA (value As Double)
	
	nativeMe.RunMethod("setA", Array(value))
	
End Sub

public Sub setB (value As Double)
	
	nativeMe.RunMethod("setB", Array(value))
	
End Sub

public Sub setC (value As Double)
	
	nativeMe.RunMethod("setC", Array(value))
	
End Sub

public Sub setM (value As Double)
	
	Dim myval As Int = value
	nativeMe.RunMethod("setM", Array(myval))
	
End Sub

public Sub setN (value As Double)
	
	Dim myval As Int = value
	nativeMe.RunMethod("setN", Array(myval))
	
End Sub



#if Java

import java.util.function.BiFunction;
import java.util.function.Function;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.geometry.Point2D;
import javafx.scene.Group;
import javafx.scene.PerspectiveCamera;
import javafx.scene.PointLight;
import javafx.scene.Scene;
import javafx.scene.SubScene;
import javafx.scene.SceneAntialiasing;
import javafx.scene.paint.Color;
import javafx.scene.shape.CullFace;
import javafx.scene.transform.Rotate;
import javafx.stage.Stage;
import javafx.util.Duration;
import org.fxyz3d.scene.paint.Patterns.CarbonPatterns;
import org.fxyz3d.shapes.primitives.SurfacePlotMesh;
import org.fxyz3d.utils.CameraTransformer;


    private double a = 2;
    private double b = 4;
    private double c = 2;
    private int m = 4;
    private int n = 2;

    private double time = 0;
	
	public void setA(double a) {
	    this.a = a;
	}
	
	public void setB(double b) {
	    this.b = b;
	}
	
	public void setC(double c) {
	    this.c = c;
	}
	
	public void setM(int m) {
	    this.m = m;
	}
	
	public void setN(int n) {
	    this.n = n;
	}			
	
	
    private BiFunction<Double, Double, Double> functionGenerator(double time) {
        final double k = Math.PI * Math.sqrt(Math.pow(n / a, 2) + Math.pow(m / b, 2));
        return (pX, pY) -> {
            return Math.sin(n * Math.PI * pX / a)
                    * Math.sin(m * Math.PI * pY / b)
                    * Math.cos(c * k * time);
        };
    }

    private Function<Point2D, Number> generateFunction(double time) {
        return (Point2D p) -> {
            return functionGenerator(time).apply(p.getX(), p.getY());
        };
    }	

	public SubScene start1() {
        Group sceneRoot = new Group();
        SubScene scene = new SubScene(sceneRoot, 800, 800, true, SceneAntialiasing.BALANCED);
        PerspectiveCamera camera = new PerspectiveCamera(true);
        //setup camera transform for rotational support
        CameraTransformer cameraTransform = new CameraTransformer();
        cameraTransform.setTranslate(0, 0, -10);
        cameraTransform.getChildren().add(camera);
        //add a Point Light for better viewing of the grid coordinate system
        PointLight light = new PointLight(Color.BLUE);
        cameraTransform.getChildren().add(light);
        light.setTranslateX(camera.getTranslateX());
        light.setTranslateY(camera.getTranslateY());
        light.setTranslateZ(camera.getTranslateZ());
        scene.setCamera(camera);

        Group group = new Group();
        group.getChildren().add(cameraTransform);

        SurfacePlotMesh surface = new SurfacePlotMesh(generateFunction(0), a, b, 100, 100, 1);
        surface.getTransforms().addAll(new Rotate(200, Rotate.X_AXIS),
                new Rotate(60, Rotate.Y_AXIS));
        surface.setCullFace(CullFace.NONE);
        surface.setTextureModePattern(CarbonPatterns.LIGHT_CARBON, 1.0d);

        KeyFrame keyFrame = new KeyFrame(Duration.millis(50), (ActionEvent event) -> {
            surface.setFunction2D(generateFunction(time));
            time += 0.005;
        });
        Timeline timeLine = new Timeline(keyFrame);
        timeLine.setCycleCount(Timeline.INDEFINITE);
        timeLine.play();
        group.getChildren().addAll(surface);

        sceneRoot.getChildren().addAll(group);

		return scene;
	}

#End If

