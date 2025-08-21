package androidrotationsensorwrapper;

import com.kviation.sample.orientation.AttitudeIndicator;
import com.kviation.sample.orientation.Orientation;

import android.content.Context;
//import android.graphics.Bitmap;
//import android.graphics.drawable.Drawable;
//import android.util.DisplayMetrics;
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
//import android.view.MotionEvent;

//import android.graphics.Color;
//import android.graphics.Typeface;

//import android.view.View;
//import android.widget.TextView;
//import android.widget.ImageView;
//import android.view.Gravity; 

//import android.util.Log;
//import android.view.ViewTreeObserver;

//import android.media.AudioFormat;
//import android.media.AudioRecord;
//import android.media.MediaRecorder;

//import java.util.ArrayList;
//import java.util.List;
import java.util.Calendar;
//import java.util.Timer;
//import java.util.TimerTask;

//import android.os.Build;
//import android.os.Bundle;


//import android.os.Handler;
//import android.view.View.OnClickListener;
//import android.widget.Button;
//import android.view.MotionEvent;
//import android.view.View.OnTouchListener;


//import android.os.Build;
//import android.support.annotation.RequiresApi;
//import android.util.AttributeSet;



@ActivityObject
@Events(values={"orientation_changed(pitch As Float, roll As Float)"})
@Author("Github: Keith Platfoot, Wrapped by: Johan Schoeman")
@Version(1.00f)
@ShortName("AttitudeIndicator")
@DependsOn(values={"com.android.support:support-compat", "com.android.support:support-v4", "com.android.support:appcompat-v7", "com.android.support:support-annotations"})
public class androidrotationsensorWrapper extends ViewWrapper<AttitudeIndicator> implements DesignerCustomView, Orientation.Listener {


	private BA ba;
	private String eventName;
    private AttitudeIndicator cv;
	private Orientation mOrientation;
	
	

	public void Initialize(BA ba, String EventName) {
		_initialize(ba, null, EventName);
	}

	@Hide
	public void _initialize(BA ba, Object activityClass, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		cv = new AttitudeIndicator(ba.context, null);
		mOrientation = new Orientation(ba.activity);
        this.setObject(cv);

//        addListener1();
//		addListener3();
		//addListener2();
		//cv.setOnTouchListener(this);
        //cv.setOnClickListener(pauseOnClickListener);

 	}
	
  @Override
  public void onOrientationChanged(float pitch, float roll) {
    cv.setAttitude(pitch, roll);
	if (ba.subExists(eventName + "_orientation_changed")) {
		ba.raiseEventFromDifferentThread(getObject(), null, 0, eventName + "_orientation_changed", true, new Object[] {pitch, roll});	
	}
  }	
	
  public void startListening() {
    mOrientation.startListening(this);
  }
  
   public void stopListening() {
    mOrientation.stopListening();
  } 
  
  private int earthColor = 0x865B4B;
  public void setEarthColor (int earthColor) {
	  this.earthColor = earthColor;
	  cv.setEarthColor(earthColor);
	  cv.invalidate();
  }
  

  private int pitchLadderColor = 0xFFFFFF;
  public void setPitchLadderColor (int pitchLadderColor) {
	  this.pitchLadderColor = pitchLadderColor;
	  cv.setPitchLadderColor(pitchLadderColor);
	  cv.invalidate();
  }  
  
  private int bottomPitchLadderColor = 0xFFFFFF;
  public void setBottomPitchLadderColor (int bottomPitchLadderColor) {
	  this.bottomPitchLadderColor = bottomPitchLadderColor;
	  cv.setBottomPitchLadderColor(bottomPitchLadderColor);
	  cv.invalidate();
  }   
  
  private int minPlainColor = 0xE8D4BB;
  public void setMinPlaneColor (int minPlainColor) {
	  this.minPlainColor = minPlainColor;
	  cv.setMinPlaneColor(minPlainColor);
	  cv.invalidate();
  }    
  
  private int skyColor = 0x36B4DD;
  public void setSkyColor (int skyColor) {
	  this.skyColor = skyColor;
	  cv.setSkyColor(skyColor);
	  cv.invalidate();
  }      

		
		

/*     View.OnClickListener pauseOnClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            BA.Log("HIER");
        }
    };	
 */	
 
 
/*  yourRelativeLayout.setOnTouchListener(new View.OnTouchListener() {  
    @Override
    public boolean onTouch(View arg0, MotionEvent arg1) {
        //gesture detector to detect swipe.
        gestureDetector.onTouchEvent(arg1);
        return true;//always return true to consume event
    }
});
 */	
 
 
/*  	private void addListener2() {
		cv.setOnTouchListener(new View.OnTouchListener() {
			@Override
			public boolean onTouch(View v, MotionEvent event) {
				BA.Log("GOT HERE");
				if(event.getAction() == MotionEvent.ACTION_UP){

					BA.Log("up");
					return true;
				}
				return true;
			}
		});
	}
 */ 	
	
/*     @Override
    public boolean onTouch(View v, MotionEvent event) {

        //int action = event.getAction();
        switch (event.getAction()){
        case MotionEvent.ACTION_DOWN:
            BA.Log("DOWN");
        break;

        case MotionEvent.ACTION_MOVE:
            BA.Log("MOVE");
        break;

        case MotionEvent.ACTION_UP:
            BA.Log("UP");


        break;
        }
        return true;
    }
 */	
	
	
	
	
		
/*     private void addListener2() {
		//BA.Log("addListener2");
		cv.setOnClickListener(new View.OnClickListener() {

			volatile int i = 0;

			@Override
			public void onClick(View v) {
                BA.Log("in onClick");
				i++;
				Handler handler = new Handler();

				Runnable r = new Runnable() {
					@Override
					public void run() {
						if (i == 1) {
              if (ba.subExists(eventName + "_single_click")) {
                ba.raiseEvent2(ba, false, eventName + "_single_click", true, new Object[0]);
              }
						}
					}
				};

				if (i == 1) {
					handler.postDelayed(r, 150);
				} else if (i == 2) {
					handler.removeCallbacks(r);
					i = 0;
              if (ba.subExists(eventName + "_double_click")) {
                //ba.raiseEvent2(ba, false, eventName + "_double_click", true, new Object[0]);
				ba.raiseEventFromDifferentThread(getObject(), null, 0, eventName + "_double_click", true, new Object[0]);
              }
				}
			}
		}
		);		
    }
	 */
	 
	 
	
/* 	ImageListener imageListener = new ImageListener() {
        @Override
        public void setImageForPosition(int position, ImageView imageView) {
            //if (ba.subExists(eventName + "_current_position")) {
            //  ba.raiseEvent2(ba, false, eventName + "_current_position", true, new Object[] {position});
            //}
			imageView.setImageBitmap((Bitmap) bImage.get(position));	
        }
    };
 */	
	
	
    // To set custom views
//    ViewListener viewListener = new ViewListener() {
//        @Override
//        public void setViewForPosition(int position) {

//			if (ba.subExists(eventName + "_current_position")) {
//			  ba.raiseEvent2(ba, false, eventName + "_current_position", true, new Object[] {position});
//			}
//        }
//    };	
	  
	 


//     private void addListener() {
//        cv.setOnProgressTrackListener(new OnProgressTrackListener() {
//            @Override
//            public void onProgressFinish() {
//              if (ba.subExists(eventName + "_progress_completed")) {
//                ba.raiseEvent2(ba, false, eventName + "_progress_completed", true, new Object[0]);
//              }
//            }
//            @Override
//            public void onProgressUpdate(int progress) {
//              if (ba.subExists(eventName + "_progress_changed")) {
//                ba.raiseEvent2(ba, false, eventName + "_progress_changed", true, new Object[]{progress});
//              }
//            }
//        });
//    }



//          public void addListener2() {
//            ViewTreeObserver observer = cv.getViewTreeObserver();
//            observer.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
//                @Override
//                public void onGlobalLayout() {
//                    cv.setBaseY(cv.getHeight());
//                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
//                        cv.getViewTreeObserver().removeOnGlobalLayoutListener(this);
//                    } else {
//                        cv.getViewTreeObserver().removeGlobalOnLayoutListener(this);
//                    }
//                }
//            });
//          }




/*     @Hide
    public void addListener3(){

        cv.setCallback(new CarouselView.Callback() {
            @Override
            public void picture_changed() {

              if (ba.subExists(eventName + "_picture_changed")) {
                ba.raiseEvent2(ba, false, eventName + "_picture_changed", true, new Object[]{cv.getCurrentPosition()});
              }
            }

            @Override
            public void scroll_stopped() {

              if (ba.subExists(eventName + "_scroll_stopped")) {
                ba.raiseEvent2(ba, false, eventName + "_scroll_stopped", true, new Object[0]);
              }
            }
			
            @Override
            public void picture_touched() {

              if (ba.subExists(eventName + "_picture_touched")) {
                ba.raiseEvent2(ba, false, eventName + "_picture_touched", true, new Object[]{cv.getCurrentPosition()});
              }
            }	

            @Override
            public void picture_long_touched() {

              if (ba.subExists(eventName + "_picture_long_touched")) {
                ba.raiseEvent2(ba, false, eventName + "_picture_long_touched", true, new Object[]{cv.getCurrentPosition()});
              }
            }				
			
			
        });
    }
 */
	
  
	

    
//    public void addImage(String draw) {
//		 int DrawableID = BA.applicationContext.getResources().getIdentifier(draw, "drawable", BA.packageName);
//               cv.setForeground(DrawableID);
//		 Drawable drawable = BA.applicationContext.getResources().getDrawable(DrawableID);
//                 cv.setForeground(drawable); 
//    }


	
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
	
	

	
	


/*     Callback callback;
    public interface  Callback{
        void picture_changed();
		void scroll_stopped();
		void picture_touched();
		void picture_long_touched();
    }

    private void invokePictureChanged() {
        if(callback!=null){
            callback.picture_changed();
        }
    }
	
    private void invokeUserScrollStopped() {
        if(callback!=null){
            callback.scroll_stopped();
        }
    }	
	
    private void invokePictureTouched() {
        if(callback!=null){
            callback.picture_touched();
        }
    }	

    private void invokePictureLongTouched() {
        if(callback!=null){
            callback.picture_long_touched();
        }
    }			


    public void setCallback(Callback callback){
        this.callback = callback;
    }	
	
 */	
	

   
}
