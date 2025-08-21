
package smm.mpsspackage;

import android.content.Intent;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Rect;
import android.graphics.Point;
import android.graphics.PixelFormat;
import android.media.Image;
import android.graphics.Canvas;
import android.graphics.Color;
import android.net.Uri;
import android.os.Environment;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.view.ViewGroup;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.Events;
import anywheresoftware.b4a.BA.Hide;
import anywheresoftware.b4a.BA.Pixel;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import anywheresoftware.b4a.AbsObjectWrapper;

import anywheresoftware.b4a.BA.Author;
import anywheresoftware.b4a.BA.DependsOn;
import anywheresoftware.b4a.BA.ActivityObject;


import android.media.projection.MediaProjectionManager;
import android.media.projection.MediaProjection;
import android.hardware.display.VirtualDisplay;
import android.media.projection.MediaProjection.Callback;
import android.media.MediaRecorder;
import android.util.DisplayMetrics;
import java.io.IOException;
import android.view.WindowManager;
import android.hardware.display.DisplayManager;
import anywheresoftware.b4a.IOnActivityResult;
import android.view.Display;
import android.media.ImageReader;
import android.os.Handler;
import java.nio.ByteBuffer;
import  java.util.concurrent.Callable;
import  android.content.res.Resources;
@Version(2.0000000000000013f)
@ShortName("MediaProjectionScreenShot")
@Author("SMM")




public class mpss   {
	private BA ba;	
    private MediaProjectionManager mProjectionManager;
    
    private MediaProjection mProjection;

	private String eventName;
	private IOnActivityResult ion;
	public void Initialize(BA ba , String EventName ) {
		_initialize(ba,  EventName);
		
	}

	@Hide
	public void _initialize(final BA ba,String EventName) {
		this.ba = ba;
		this.eventName = EventName.toLowerCase(BA.cul);

		 mProjectionManager = (MediaProjectionManager) ba.applicationContext.getSystemService(Context.MEDIA_PROJECTION_SERVICE);
		
				
					
		}
	@ActivityObject
	public void AskforPermission(final BA b){
		
		ion = new IOnActivityResult() {
			
			@Override
			public void ResultArrived(int arg0, Intent data) {
				 
			if (arg0==-1){
				 mProjection = mProjectionManager.getMediaProjection(-1, data);
				
				 if (b.subExists(eventName + "_permissiongranted")) {
					 b.raiseEvent2(b, false, eventName + "_permissiongranted", true, new Object[0]);
					 
			
			}
				
			}		 
		
			
			}
		};
		
		b.startActivityForResult(ion, mProjectionManager.createScreenCaptureIntent());	
		
	}
	 Handler handler = new Handler();
	  DisplayMetrics metrics;
	   ImageReader mImageReader;
	   public void stop(){
		   mProjection.stop();
	   }
	public void init(int width , int height , int density){
		
		WindowManager wm = (WindowManager) ba.context.getSystemService(Context.WINDOW_SERVICE);
	Display display = wm.getDefaultDisplay();
	metrics = new DisplayMetrics();
	display.getRealMetrics(metrics);
	
	
	
	
	
	
	
	
	
	
	Point size = new Point();
	display.getRealSize(size);
	int mWidth=0;
	 int mHeight=0;
	 int mDensity=0;
	if (width>0){
		mWidth=width;
	}
	else{
		 mWidth = size.x;
	}
	
	
	if (height>0){
		mHeight=height;
	}
	else{
		 mHeight = size.y;
	}	
	 
	  
	if (density>0){
		mDensity=density;
	}
	else{
		 mDensity = metrics.densityDpi;
	} 
	

	 mImageReader = ImageReader.newInstance(mWidth, mHeight, PixelFormat.RGBA_8888, 2);

	

	int flags = DisplayManager.VIRTUAL_DISPLAY_FLAG_OWN_CONTENT_ONLY  | DisplayManager.VIRTUAL_DISPLAY_FLAG_PUBLIC ;
	mProjection.createVirtualDisplay("screen-mirror", mWidth, mHeight, mDensity, flags, mImageReader.getSurface(), null, handler);
	}
	public void TakeScreenshot(){
		ba.runAsync(ba, this, "",  null, new Callable<Object[]>() {
       @Override
       public Void[] call() throws Exception {
       
        pTakeScreenshot( );
		return null;
	    }
     });
	}
	Bitmap realSizeBitmap =null;
	private int getNavBarHeight(){
		Resources resources = ba.context.getResources();
		int resourceId = resources.getIdentifier("navigation_bar_height", "dimen", "android");
		if (resourceId > 0) {
			return resources.getDimensionPixelSize(resourceId);
		}
	return 0;
	}
	private void pTakeScreenshot(){
		
		mImageReader.setOnImageAvailableListener(new ImageReader.OnImageAvailableListener() {
            @Override
            public void onImageAvailable(ImageReader reader) {
               reader.setOnImageAvailableListener(null, handler);

                Image image = reader.acquireLatestImage();

                final Image.Plane[] planes = image.getPlanes();
                final ByteBuffer buffer = planes[0].getBuffer();
				
                int pixelStride = planes[0].getPixelStride();
                int rowStride = planes[0].getRowStride();
                int rowPadding = rowStride - pixelStride * metrics.widthPixels;
                
                Bitmap bmp = Bitmap.createBitmap(metrics.widthPixels + (int) ((float) rowPadding / (float) pixelStride), metrics.heightPixels, Bitmap.Config.ARGB_8888);
                 bmp.copyPixelsFromBuffer(buffer);
				Rect rect = image.getCropRect();

				if (ba.subExists(eventName + "_imageready")) {
					ba.raiseEvent2(ba, false, eventName + "_imageready", true, new Object[]{Bitmap.createBitmap(bmp, 0, 0, image.getWidth(), image.getHeight())});
				}
				image.close();
                reader.close();
				bmp.recycle();
				
				
            }
        }, handler);
		
	}
	
	
	
}

