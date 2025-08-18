package textureoffsetwrapper;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.util.DisplayMetrics;
import android.view.ViewGroup;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.Author;
import anywheresoftware.b4a.BA.Hide;
import anywheresoftware.b4a.BA.Pixel;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import anywheresoftware.b4a.BALayout;
import anywheresoftware.b4a.BA.DependsOn;
import anywheresoftware.b4a.keywords.Common.DesignerCustomView;
import anywheresoftware.b4a.objects.LabelWrapper;
import anywheresoftware.b4a.objects.PanelWrapper;
import anywheresoftware.b4a.objects.ViewWrapper;
import anywheresoftware.b4a.BA.ActivityObject;

import anywheresoftware.b4a.BA.Events;

import android.view.MotionEvent;

import android.view.View;



import android.opengl.GLES20;
import android.os.Bundle;
import android.util.Log;

import javax.microedition.khronos.egl.EGLConfig;

import java.util.List;

import min3d.Shared;
import min3d.interfaces.ISceneController;
import android.app.Activity;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.os.Handler;

import min3d.core.Scene;

import min3d.core.Renderer;

import min3d.Utils;
import min3d.core.Object3dContainer;
//import min3d.core.RendererActivity;
import min3d.objectPrimitives.Box;
import min3d.vos.Light;
import min3d.vos.TextureVo;
import android.graphics.Bitmap;

import min3d.objectPrimitives.Sphere;

import javax.microedition.khronos.opengles.GL10;



@ActivityObject
//@Events(values={"picture_changed(position As Int)", "scroll_stopped()", "picture_touched(position As Int)", "picture_long_touched(position As Int)"})
//@Author("Github: Saurabh kumar, Wrapped by: Johan Schoeman")
@Version(1.00f)
@ShortName("min3DTextureOffset")
//@DependsOn(values={"org.apache.commons.io"})
public class textureoffsetWrapper extends ViewWrapper<GLSurfaceView> implements DesignerCustomView, ISceneController {

	Object3dContainer _earth;
	TextureVo _cloudTexture;

	int _count = 0;


	private BA ba;
	private String eventName;
	private GLSurfaceView cv;
	
	public Scene scene;
	protected GLSurfaceView _glSurfaceView;
	
	protected Handler _initSceneHander;
	protected Handler _updateSceneHander;
	
    private boolean _renderContinuously;
	
	Object3dContainer _cube;
	TextureVo _jupiterTexture;
    

	final Runnable _initSceneRunnable = new Runnable() 
	{
        public void run() {
            onInitScene();
        }
    };
    
	final Runnable _updateSceneRunnable = new Runnable() 
    {
        public void run() {
            onUpdateScene();
        }
    };
    	
	
	

	public void Initialize(BA ba, String EventName) {
		_initialize(ba, null, EventName);
	}
	

	@Hide
	public void _initialize(BA ba, Object activityClass, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		cv = new GLSurfaceView(ba.context);
		cv.setEGLContextClientVersion(1);
		glSurfaceViewConfig();
	

		
        this.setObject(cv);

		_initSceneHander = new Handler();
		_updateSceneHander = new Handler();		

		Shared.context(ba.applicationContext);
		scene = new Scene(this);
		Renderer r = new Renderer(scene);
		Shared.renderer(r);		
		
		cv.setRenderer(r);
		cv.setRenderMode(GLSurfaceView.RENDERMODE_CONTINUOUSLY);			
		
		
//		addListener1();
 	}
	

	public void PAUSE() {
		cv.onPause();
	}
	

	public void RESUME() {
		cv.onResume();
	}
	
	    protected void glSurfaceViewConfig()
    {
	    // Example which makes glSurfaceView transparent (along with setting scene.backgroundColor to 0x0)
	    //cv.setEGLConfigChooser(8,8,8,8, 16, 0);
	    //cv.getHolder().setFormat(PixelFormat.TRANSLUCENT);

		// Example of enabling logging of GL operations 
		// _glSurfaceView.setDebugFlags(GLSurfaceView.DEBUG_CHECK_GL_ERROR | GLSurfaceView.DEBUG_LOG_GL_CALLS);
    }
	
	
	
	

	//programmatically add view
    @Hide
	public void AddToParent(ViewGroup Parent, @Pixel int left, @Pixel int top, @Pixel int width, @Pixel int height) {
		Parent.addView(cv, new BALayout.LayoutParams(left, top, width, height));
	}
	
	//this method cannot be hidden.
  
        
	public void DesignerCreateView(PanelWrapper base, LabelWrapper lw, anywheresoftware.b4a.objects.collections.Map props) {
		ViewGroup vg = (ViewGroup) base.getObject().getParent();
		AddToParent(vg, base.getLeft(), base.getTop(), base.getWidth(), base.getHeight());
		base.RemoveView();
		//set text properties
	}

	public void setLeft(int left)	{
		BALayout.LayoutParams lp = (BALayout.LayoutParams)cv.getLayoutParams();
		lp.left = left;
		cv.getParent().requestLayout();
	}

	public int getLeft()	{
		BALayout.LayoutParams lp = (BALayout.LayoutParams)cv.getLayoutParams();
		return lp.left;
	}
	public void setTop(int top)	{
		BALayout.LayoutParams lp = (BALayout.LayoutParams)cv.getLayoutParams();
		lp.top = top;
		cv.getParent().requestLayout();
	}
 
	public int getTop()	{
		BALayout.LayoutParams lp = (BALayout.LayoutParams)cv.getLayoutParams();
		return lp.top;
	}
	
	public void setWidth(int Width)	{
		BALayout.LayoutParams lp = (BALayout.LayoutParams)cv.getLayoutParams();
		lp.width = Width;
		cv.getParent().requestLayout();
	}

	public int getWidth()	{
		BALayout.LayoutParams lp = (BALayout.LayoutParams)cv.getLayoutParams();
		return lp.width;
	}
	
	public void setHeight(int height)	{
		BALayout.LayoutParams lp = (BALayout.LayoutParams)cv.getLayoutParams();
		lp.height = height;
		cv.getParent().requestLayout();
	}

	public int getHeight()	{
		BALayout.LayoutParams lp = (BALayout.LayoutParams)cv.getLayoutParams();
		return lp.height;
	}

	/**
    * Set the cube background color 
	* values should be between 0.0f and 1.0f
	* Note: sequence is RGBA
    */	

   	
	
	public void initScene() 
	{
		Light light = new Light();
		light.ambient.setAll((short)64, (short)64, (short)64, (short)255);
		light.position.setAll(3, 3, 3);
		scene.lights().add(light);

		_earth = new Sphere(1.2f, 15, 10);
		scene.addChild(_earth);

		Bitmap b = Utils.makeBitmapFromResourceId(BA.applicationContext, R.drawable.earth);
		Shared.textureManager().addTextureId(b, "jupiter", false);
		b.recycle();

		b = Utils.makeBitmapFromResourceId(BA.applicationContext, R.drawable.clouds_alpha2b);
		Shared.textureManager().addTextureId(b, "clouds", false);
		b.recycle();

		TextureVo t = new TextureVo("jupiter");
		_earth.textures().add(t);

		_cloudTexture = new TextureVo("clouds");
		_cloudTexture.textureEnvs.get(0).param = GL10.GL_DECAL; 
		_cloudTexture.repeatU = true; // .. this is the default, but just to be explicit

		_earth.textures().add(_cloudTexture);

		_count = 0;
	}
	
	@Override 
	public void updateScene() 
	{
		_earth.rotation().y += 1.0f;
		
		// Animate texture offset
		_cloudTexture.offsetU += 0.001f;		
		
		_count++;
	}
	
    /**
     * Called _after_ scene init (ie, after initScene).
     * Unlike initScene(), gets called from the UI thread.
     */
    public void onInitScene()
    {
    }
    
    /**
     * Called _after_ updateScene()
     * Unlike initScene(), gets called from the UI thread.
     */
    public void onUpdateScene()
    {
    }
    
    /**
     * Setting this to false stops the render loop, and initScene() and onInitScene() will no longer fire.
     * Setting this to true resumes it. 
     */
    public void renderContinuously(boolean $b)
    {
    	_renderContinuously = $b;
    	if (_renderContinuously)
    		cv.setRenderMode(cv.RENDERMODE_CONTINUOUSLY);
    	
    	else
    		cv.setRenderMode(cv.RENDERMODE_WHEN_DIRTY);
    }
    
	public Handler getInitSceneHandler()
	{
		return _initSceneHander;
	}
	
	public Handler getUpdateSceneHandler()
	{
		return _updateSceneHander;
	}

    public Runnable getInitSceneRunnable()
    {
    	return _initSceneRunnable;
    }
	
    public Runnable getUpdateSceneRunnable()
    {
    	return _updateSceneRunnable;
    }	
	
	
   
}
