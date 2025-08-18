package com.nea.nehe.lesson09;

import android.app.Activity;
import android.os.Bundle;

/**
 * The initial Android Activity, setting and initiating
 * the OpenGL ES Renderer Class @see Lesson09.java
 * 
 * @author INsanityDesign
 */
public class Run extends Activity {

	/** Our own OpenGL View overridden */
	private Lesson09 lesson09;

	/**
	 * Initiate our @see Lesson09.java,
	 * which is GLSurfaceView and Renderer
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		//Initiate our Lesson with this Activity Context handed over
		lesson09 = new Lesson09(this);
		//Set the lesson as View to the Activity
		setContentView(lesson09);
	}

	/**
	 * Remember to resume our Lesson
	 */
	@Override
	protected void onResume() {
		super.onResume();
		lesson09.onResume();
	}

	/**
	 * Also pause our Lesson
	 */
	@Override
	protected void onPause() {
		super.onPause();
		lesson09.onPause();
	}

}