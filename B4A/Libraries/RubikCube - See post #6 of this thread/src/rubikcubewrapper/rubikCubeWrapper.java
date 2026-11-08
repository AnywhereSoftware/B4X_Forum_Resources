package rubikcubewrapper;

import com.catalinjurjiu.animcubeandroid.AnimCube;

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
//import android.view.MotionEvent;

//import android.graphics.Color;
//import android.graphics.Typeface;

import android.view.View;
import android.widget.TextView;
import android.widget.ImageView;
//import android.view.Gravity; 

//import android.util.Log;
//import android.view.ViewTreeObserver;

//import android.media.AudioFormat;
//import android.media.AudioRecord;
//import android.media.MediaRecorder;

import java.util.ArrayList;
import java.util.List;
//import java.util.Timer;
//import java.util.TimerTask;

//import android.os.Build;
import android.os.Bundle;
import android.widget.FrameLayout;



import android.os.Handler;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.view.MotionEvent;
import android.view.View.OnTouchListener;


import android.widget.Toast;
import android.view.Gravity;




@ActivityObject
@Events(values={"animation_finished", "cube_model(model As String)"})
//@Author("Github: Sayyam Mehmood, Wrapped by: Johan Schoeman")
@Version(1.00f)
@ShortName("RubikCube")
//@DependsOn(values={"android-support-v4"})
public class rubikCubeWrapper extends ViewWrapper<AnimCube> implements DesignerCustomView, AnimCube.OnCubeModelUpdatedListener, AnimCube.OnCubeAnimationFinishedListener {


	private BA ba;
	private String eventName;
    private AnimCube cv;
	

	
//	int[] sampleImages = {BA.applicationContext.getResources().getIdentifier("image_1", "drawable", BA.packageName), 
//						BA.applicationContext.getResources().getIdentifier("image_2", "drawable", BA.packageName), 
//						BA.applicationContext.getResources().getIdentifier("image_3", "drawable", BA.packageName), 
//						BA.applicationContext.getResources().getIdentifier("image_4", "drawable", BA.packageName), 
//						BA.applicationContext.getResources().getIdentifier("image_5", "drawable", BA.packageName)};	
	

	public void Initialize(BA ba, String EventName) {
		_initialize(ba, null, EventName);
	}

	@Hide
	public void _initialize(BA ba, Object activityClass, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		cv = new AnimCube(ba.context);
        this.setObject(cv);
		
		cv.setOnCubeModelUpdatedListener(this);
        cv.setOnAnimationFinishedListener(this);

 	}
	
	@Hide
    @Override
    public void onCubeModelUpdate(int[][] newCubeModel) {
        BA.Log("Cube model updated!");
        printCubeModel(newCubeModel);
    }	
	
	@Hide
    @Override
    public void onAnimationFinished() {
		if (ba.subExists(eventName + "_animation_finished")) {
          ba.raiseEvent2(ba, false, eventName + "_animation_finished", true, new Object[]{});
        }		
    }	
	
	
    void printCubeModel(int[][] cube) {
        StringBuilder stringBuilder = new StringBuilder("");
        for (int i = 0; i < cube.length; i++) {
            stringBuilder.append("\n");
            stringBuilder.append(i);
            stringBuilder.append(":\n");
            for (int j = 0; j < cube[i].length; j++) {
                stringBuilder.append(" ");
                stringBuilder.append(cube[i][j]);
                if ((j + 1) % 3 == 0) {
                    stringBuilder.append("\n");
                } else {
                    stringBuilder.append(", ");
                }
            }
        }
        //BA.Log("Cube model: " + "\n" + stringBuilder.toString());
		if (ba.subExists(eventName + "_cube_model")) {
			ba.raiseEvent2(ba, false, eventName + "_cube_model", true, new Object[]{stringBuilder.toString()});
        }		
		
    }			
	
	
	public void setMoveSequence(String moveSequence) {
	
		cv.setMoveSequence(moveSequence);
		cv.invalidate();
	}
	
	
    /**
     * 
     * Animates all the moves in the currently set move sequence one move at a time. When a move has completed, the next one is automatically started.
     * 
     * The animation stops when the last move in the move sequence is reached and animated.
     */
    public void AnimateMoveSequence() {
        cv.animateMoveSequence();
		cv.invalidate();
    }	
	
    /**
     * 
     * Animates all the moves in the currently set move sequence one move at a time, in reverse (i.e. from end to start with opposite twisting direction). When a move has
     * completed, the next one is automatically started.
     * 
     * The animation stops when the first move in the move sequence is reached and animated.
     */
    public void AnimateMoveSequenceReversed() {
        cv.animateMoveSequenceReversed();
		cv.invalidate();
    }	
	
	
	
    /**
     * 
     * Animates only the next move from the move sequence. When it has completed, the next one is not automatically started.
     *
     */
    public void animateMove() {
        cv.animateMove();
		cv.invalidate();
    }

    /**
     * 
     * Animates in reverse (i.e. with opposite twisting direction) only the previous move from the move sequence. When it has completed, the next one is not automatically started.
     * 
     */
    public void animateMoveReversed() {
        cv.animateMoveReversed();
		cv.invalidate();
    }

    /**
     * Instantly applies the whole move sequence on the cube, without animation.
     */
    public void applyMoveSequence() {
        cv.applyMoveSequence();
		cv.invalidate();
    }

    /**
     * Instantly applies the whole move sequence in reverse, on the cube, without animation.
     */
    public void applyMoveSequenceReversed() {
        cv.applyMoveSequenceReversed();
		cv.invalidate();
    }

    /**
     * Instantly applies the next move on the cube, without animation.
     */
    public void applyMove() {
        cv.applyMove();
		cv.invalidate();
    }

    /**
     * Instantly applies the previous move on reverse, on the cube, without animation.
     */
    public void applyMoveReversed() {
        cv.applyMoveReversed();
		cv.invalidate();
    }

    /**
     * Stops an in-progress animation. No-op if an animation is not in progress.
     */
    public void stopAnimation() {
        cv.stopAnimation();
		cv.invalidate();
    }
	
	
    /**
     * set the backface distance from the cube
     */	
	public void setBackFaceDistance(int bfd) {             //added by johan to set back face distance from the cube
		cv.setBackFaceDistance(bfd);
		cv.invalidate();
	}		

    /**
     * 
     * Sets the cube in the specified state. This method expects a String with exactly 54 characters (i.e. 9 facelets on each cube face * 6 cube faces). If the string
     * is of different length, nothing will happen.
	 *
     * The string needs to be a sequence of integers specified in CubeColors. Each integer specifies the color of one cube facelet. Additionally, the
     * order in which faces are specified is not relevant, since AnimCube doesn't care about the cube model that much. The specified model doesn't even have to be a
     * valid Rubik's cube.
	 *
     * For example:
     *    "000000000111111111222222222333333333444444444555555555"
     * Represents a solved cube.
	 *
     * Note: after this is set, resetToInitialState() will reset the cube to the state set here, not to the cube state previous to calling setCubeModel(String)
     *
     *
     * colorValues a String of integers in the format described above.
     */
    public void setCubeModel(String colorValues) {
		cv.setCubeModel(colorValues);
		cv.invalidate();
    }	
	
	
    /**
     * 
     * Resets the cube to its initial state. This includes:
     * 
     * stopping any running animation
     * resetting the facelets colors to their initial state
     * resetting the move counter to the start of the currently defined move sequence.
     *
     * see setMoveSequence(String)
     * see setCubeModel(String)
     */	
	public void ResetToInitialState() {
		cv.resetToInitialState();
		cv.invalidate();
		
	}	
	
    /**
     * Enables or disables individual face rotation through user touch event. If this is disabled, touch interactions will always turn the whole cube, not individual faces.
     *
     * isEditable = true if the user should be able to edit the cube
     */
    public void setEditable(boolean isEditable) {
        cv.setEditable(isEditable);
    }	
	
	

    /**
     * 
     * Sets the rotation speed of a single rotation. This parameter allows to customize the speed of quarter turn separately from face turns.
     * 
     *
     * The value should consist only of decimal digits.
     * 
     *
     * The higher value the slower is the animation. The default value is 10, which corresponds to approximately 1 second for face turn and approximately 2/3
     * seconds for quarter turn if not specified differently.
     * 
     *
     * The face turn speed can be adjusted separately by setDoubleRotationSpeed(int).
     * 
     *
     * If this is called while the cube is animating a move, its effects will only be applied starting with the next move.
     * 
     *
     * singleRotationSpeed => the desired rotation speed.
     */
    public void setSingleRotationSpeed(int singleRotationSpeed) {
        cv.setSingleRotationSpeed(singleRotationSpeed);
        cv.invalidate();    
	}

    /**
     * 
     * Sets the rotation speed of a double rotation. This parameter allows to customize the speed of face turns separately from quarter turns.
     *
     * 
     * The value should consist only of decimal digits.
     * 
     * The higher value the slower is the animation. The default value is 10, which corresponds to approximately 1 second
     * for the face turn.
     *
     * The default is set to the 150% of the value of speed.
     * 
     * 
     * The quarter turn speed can be adjusted by setSingleRotationSpeed(int).
     * 
     * 
     * If this is called while the cube is animating a move, its effects will only be applied starting with the next move.
     * 
     *
     * doubleRotationSpeed => the desired rotation speed.
     */
    public void setDoubleRotationSpeed(int doubleRotationSpeed) {
        cv.setDoubleRotationSpeed(doubleRotationSpeed);
		cv.invalidate();
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
	
	
	

/*     private void addListener1() {
        cv.setImageListener(imageListener);
		
        cv.setImageClickListener(new ImageClickListener() {
            @Override
            public void onClick(int position) {
                //Toast.makeText(ba.applicationContext, "Clicked item: "+ position, Toast.LENGTH_SHORT).show();
            }
        });		
//        cv.setViewListener(mViewListener);		
	}	 */
	
 
	
/*     ViewListener viewListener = new ViewListener() {
        @Override
        public View setViewForPosition(int position) {

            View customView = getLayoutInflater().inflate(R.layout.view_custom, null);

            TextView labelTextView = (TextView) customView.findViewById(R.id.labelTextView);
            ImageView fruitImageView = (ImageView) customView.findViewById(R.id.fruitImageView);

            fruitImageView.setImageResource(sampleImages[position]);
            labelTextView.setText(sampleTitles[position]);

            carouselView.setIndicatorGravity(Gravity.CENTER_HORIZONTAL|Gravity.TOP);

            return customView;
        }
    };	 */
	
/*     private List<Object> bImage;
    public void setImageBitmaps(List<Object> bImage) {
        this.bImage = bImage;
		cv.setPageCount(bImage.size());
        //if (ba.subExists(eventName + "_picture_changed")) {
        //  ba.raiseEvent2(ba, false, eventName + "_picture_changed", true, new Object[]{0});
        //}		
    }	 */
	
/* 	ImageListener imageListener = new ImageListener() {
        @Override
        public void setImageForPosition(int position, ImageView imageView) {
            //if (ba.subExists(eventName + "_current_position")) {
            //  ba.raiseEvent2(ba, false, eventName + "_current_position", true, new Object[] {position});
            //}
			imageView.setImageBitmap((Bitmap) bImage.get(position));	
        }
    }; */


	

/*     public void setIndicatorMarginVertical(int indicatorMarginVertical) {
        cv.setIndicatorMarginVertical(indicatorMarginVertical);
		cv.invalidate();
    }


    public void setIndicatorMarginHorizontal(int indicatorMarginHorizontal) {
        cv.setIndicatorMarginHorizontal(indicatorMarginHorizontal);
		cv.invalidate();
    } */



/*     public void setBackground(Drawable background) {
        super.setBackground(background);
    }

    public Drawable getIndicatorBackground() {
        return mIndicator.getBackground();
    } */


	

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


	

	
	
	
	
	
	
/*     public void setImageListener(ImageListener mImageListener) {
        this.mImageListener = mImageListener;
    }

    public void setViewListener(ViewListener mViewListener) {
        this.mViewListener = mViewListener;
    } */

//    public int getPageCount() {
//        return mPageCount;
//    }

/*     public void setPageCount(int mPageCount) {
        cv.setPageCount(mPageCount);
        cv.invalidate();
    } */

//    public void addOnPageChangeListener(ViewPager.OnPageChangeListener listener) {
//        containerViewPager.addOnPageChangeListener(listener);
//    }

/*     public void setCurrentItem(int item) {
        cv.setCurrentItem(item);
		cv.invalidate();
    } */

//    public int getPosition() {
//        return mPosition;
//    }

//    public void setPosition(int position) {
//        cv.setPosition(position);
//		cv.invalidate();
//    }


//    public int getOrientation() {
//        return mIndicator.getOrientation();
//    }

//    public int getFillColor() {
//        return mIndicator.getFillColor();
//    }

//    public int getStrokeColor() {
//        return mIndicator.getStrokeColor();
//    }

/*     public void setSnap(boolean snap) {
        cv.setSnap(snap);
		cv.invalidate();
    }

    public void setRadius(float radius) {
        cv.setRadius(radius);
		cv.invalidate();
    } */

//    public float getStrokeWidth() {
//        return mIndicator.getStrokeWidth();
//    }

//    public void setBackground(Drawable background) {
//        super.setBackground(background);
//    }


/*     public void setFillColor(int fillColor) {
        cv.setFillColor(fillColor);
		cv.invalidate();
    }


    public void setOrientation(int orientation) {
        cv.setOrientation(orientation);
		cv.invalidate();
    } */

//    public boolean isSnap() {
//        return cv.isSnap();
//    }

/*     public void setStrokeColor(int strokeColor) {
        cv.setStrokeColor(strokeColor);
		cv.invalidate();
    }


    public void setPageColor(int pageColor) {
        cv.setPageColor(pageColor);
		cv.invalidate();
    }

    public void setStrokeWidth(float strokeWidth) {
        cv.setStrokeWidth(strokeWidth);
		cv.invalidate();
    } */

    /**
     * Starts auto scrolling if
     */
/*     public void playCarousel() {
        cv.playCarousel();
		cv.invalidate();
    } */

    /**
     * Stops auto scrolling.
     */
/*     public void pauseCarousel() {
        cv.pauseCarousel();
		cv.invalidate();
    } */


    /**
     * Set interval for one slide in milliseconds.
     *
     * @param slideInterval milliseconds
     */
/*     public void setSlideInterval(int slideInterval) {
        cv.setSlideInterval(slideInterval);
		cv.invalidate();
    }
 */
    /**
     * Set interval for one slide in milliseconds.
     *
     * @param slideInterval milliseconds
     */
//   public void reSetSlideInterval(int slideInterval) {
//       cv.reSetSlideInterval(slideInterval);
//		cv.invalidate();
//    }

//    public boolean isAutoPlay() {
//        return cv.isAutoPlay();
//    }

/*     public void setAutoPlay(boolean autoPlay) {
        cv.setAutoPlay(autoPlay);
    } */

//    public boolean isDisableAutoPlayOnUserInteraction() {
//        return cv.isDisableAutoPlayOnUserInteraction();
//    }

/*     public void setDisableAutoPlayOnUserInteraction(boolean disableAutoPlayOnUserInteraction) {
        cv.setDisableAutoPlayOnUserInteraction(disableAutoPlayOnUserInteraction);
		cv.invalidate();
    } */

//    public void setData() {
//        cv.setData();
//		cv.invalidate();
//    }	
	
	


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
