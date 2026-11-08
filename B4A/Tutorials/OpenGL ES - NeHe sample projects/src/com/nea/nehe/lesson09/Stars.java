package com.nea.nehe.lesson09;

import java.io.IOException;
import java.io.InputStream;
import java.util.Random;

import javax.microedition.khronos.opengles.GL10;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.opengl.GLUtils;

/**
 * This class contains, loads, initiates textures
 * and draws our stars
 * 
 * @author INsanityDesign
 */
public class Stars {
	
	private int num = 1;					//Basic number of stars	
	private Star[] stars;					//Hold all our star instances in this array
		
	private Random rand = new Random();		//Initiate Random for random values of stars
	
	private float zoom = -15.0f;			//Distance Away From Stars
	private float tilt = 90.0f;				//Tilt The View
	private float spin;						//Spin Stars
	
	/** Our texture pointer */
	private int[] textures = new int[1];
	
	/**
	 * Constructor for our stars holder
	 * with the number of maximum stars.
	 * Initiate all stars with random 
	 * numbers.
	 * 
	 * @param num - Number of stars
	 */
	public Stars(int num) {
		this.num = num;
		
		//Initiate the stars array
		stars = new Star[num];
		
		//Initiate our stars with random colors and increasing distance
		for(int loop = 0; loop < num; loop++) {
			stars[loop] = new Star();
			stars[loop].angle = 0.0f;
			stars[loop].dist = ((float) loop / num) * 5.0f;
			stars[loop].r = rand.nextInt(256);
			stars[loop].g = rand.nextInt(256);
			stars[loop].b = rand.nextInt(256);
		}
	}
	
	/**
	 * The Stars drawing function.
	 * 
	 * @param gl - The GL Context
	 * @param twinkle - Twinkle on or off
	 */
	public void draw(GL10 gl, boolean twinkle) {
		//Bind the star texture for all stars
		gl.glBindTexture(GL10.GL_TEXTURE_2D, textures[0]);
				
		//Iterate through all stars
		for(int loop = 0; loop < num; loop++) {
			//Recover the current star into an object
			Star star = stars[loop];
			
			gl.glLoadIdentity();							//Reset The Current Modelview Matrix

			gl.glTranslatef(0.0f, 0.0f, zoom); 				//Zoom Into The Screen (Using The Value In 'zoom')
			gl.glRotatef(tilt, 1.0f, 0.0f, 0.0f); 			//Tilt The View (Using The Value In 'tilt')
			gl.glRotatef(star.angle, 0.0f, 1.0f, 0.0f); 	//Rotate To The Current Stars Angle
			gl.glTranslatef(star.dist, 0.0f, 0.0f); 		//Move Forward On The X Plane
			gl.glRotatef(-star.angle, 0.0f, 1.0f, 0.0f); 	//Cancel The Current Stars Angle
			gl.glRotatef(-tilt, 1.0f, 0.0f, 0.0f); 			//Cancel The Screen Tilt
			
			//Twinkle, twinkle little star
			if(twinkle) {
				//Twinkle with an over drawn second star
				gl.glColor4f(	(float)stars[(num - loop) - 1].r/255, 
								(float)stars[(num - loop) - 1].g/255, 
								(float)stars[(num - loop) - 1].b/255, 
								1.0f);
				
				//Draw
				star.draw(gl);
			}

			//Continuously iterate and spin all stars
			gl.glRotatef(spin, 0.0f, 0.0f, 1.0f);
			//Set the random star color
			gl.glColor4f((float)star.r/255, (float)star.g/255, (float)star.b/255, 1.0f);
			
			//Draw
			star.draw(gl);

			//Increase and decrease the values
			spin += 0.01f;
			star.angle += (float) loop / num;
			star.dist -= 0.01f;
			
			//Distance zero...
			if(star.dist < 0.0f) {
				//Set back to a five distance
				star.dist += 5.0f;
				star.r = rand.nextInt(256);
				star.g = rand.nextInt(256);
				star.b = rand.nextInt(256);
			}
		}
	}
		
	/**
	 * Load the textures
	 * 
	 * @param gl - The GL Context
	 * @param context - The Activity context
	 */
	public void loadGLTexture(GL10 gl, Context context) {
		//Get the texture from the Android resource directory
		InputStream is = context.getResources().openRawResource(R.drawable.star);
		Bitmap bitmap = null;
		try {
			//BitmapFactory is an Android graphics utility for images
			bitmap = BitmapFactory.decodeStream(is);

		} finally {
			//Always clear and close
			try {
				is.close();
				is = null;
			} catch (IOException e) {
			}
		}

		//Generate there texture pointer
		gl.glGenTextures(1, textures, 0);

		//Create Linear Filtered Texture and bind it to texture
		gl.glBindTexture(GL10.GL_TEXTURE_2D, textures[0]);
		gl.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_MAG_FILTER, GL10.GL_LINEAR);
		gl.glTexParameterf(GL10.GL_TEXTURE_2D, GL10.GL_TEXTURE_MIN_FILTER, GL10.GL_LINEAR);
		GLUtils.texImage2D(GL10.GL_TEXTURE_2D, 0, bitmap, 0);
		
		//Clean up
		bitmap.recycle();
	}
}
