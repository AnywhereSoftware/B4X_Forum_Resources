package openglesphotocubewrapper;

import android.content.Context;
import android.graphics.Bitmap;
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
//import anywheresoftware.b4a.objects.TextViewWrapper;
import anywheresoftware.b4a.BA.ActivityObject;

import anywheresoftware.b4a.BA.Events;

import android.opengl.GLSurfaceView;

import com.test.MyGLRendererPhoto;


@ActivityObject
//@Events(values={"picture_changed(position As Int)", "scroll_stopped()", "picture_touched(position As Int)", "picture_long_touched(position As Int)"})
//@Author("Github: Saurabh kumar, Wrapped by: Johan Schoeman")
@Version(1.00f)
@ShortName("glSurfaceView")
//@DependsOn(values={"android-support-v4"})
public class openglesphotocubeWrapper extends ViewWrapper<GLSurfaceView> implements DesignerCustomView {


	private BA ba;
	private String eventName;
    private GLSurfaceView cv;
	private MyGLRendererPhoto mglrtc;
	
	

	public void Initialize(BA ba, String EventName) {
		_initialize(ba, null, EventName);
	}

	@Hide
	public void _initialize(BA ba, Object activityClass, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		cv = new GLSurfaceView(ba.context);
        this.setObject(cv);
		mglrtc = new MyGLRendererPhoto(ba.applicationContext);
		cv.setRenderer(mglrtc); // Use a custom renderer

 	}
	
	public void PAUSE() {
		cv.onPause();
	}
	
	public void RESUME() {
		cv.onResume();
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
   
}
