package com.nea.nehe.lesson09;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;

import javax.microedition.khronos.opengles.GL10;

/**
 * This class is an object representation of 
 * a Star
 * 
 * @author INsanityDesign
 */
public class Star {
	
	public int r, g, b;				//Stars Color
	public float dist;				//Stars Distance From Center
	public float angle;				//Stars Current Angle
	
	/** The buffer holding the vertices */
	private FloatBuffer vertexBuffer;
	/** The buffer holding the texture coordinates */
	private FloatBuffer textureBuffer;

	/** The initial vertex definition */
	private float vertices[] = {
								-1.0f, -1.0f, 0.0f, 	//Bottom Left
								1.0f, -1.0f, 0.0f, 		//Bottom Right
								-1.0f, 1.0f, 0.0f,	 	//Top Left
								1.0f, 1.0f, 0.0f 		//Top Right
													};
	
	/** The initial texture coordinates (u, v) */	
	private float texture[] = {
								0.0f, 0.0f, 
								1.0f, 0.0f, 
								0.0f, 1.0f, 
								1.0f, 1.0f,
											};

	/**
	 * The Star constructor.
	 * 
	 * Initiate the buffers.
	 */
	public Star() {
		//
		ByteBuffer byteBuf = ByteBuffer.allocateDirect(vertices.length * 4);
		byteBuf.order(ByteOrder.nativeOrder());
		vertexBuffer = byteBuf.asFloatBuffer();
		vertexBuffer.put(vertices);
		vertexBuffer.position(0);

		//
		byteBuf = ByteBuffer.allocateDirect(texture.length * 4);
		byteBuf.order(ByteOrder.nativeOrder());
		textureBuffer = byteBuf.asFloatBuffer();
		textureBuffer.put(texture);
		textureBuffer.position(0);
	}

	/**
	 * The object own drawing function.
	 * Called from the renderer to redraw this instance
	 * with possible changes in values.
	 * 
	 * @param gl - The GL Context
	 */
	public void draw(GL10 gl) {
		//Enable the vertex, texture and normal state
		gl.glEnableClientState(GL10.GL_VERTEX_ARRAY);
		gl.glEnableClientState(GL10.GL_TEXTURE_COORD_ARRAY);
		
		//Point to our buffers
		gl.glVertexPointer(3, GL10.GL_FLOAT, 0, vertexBuffer);
		gl.glTexCoordPointer(2, GL10.GL_FLOAT, 0, textureBuffer);
		
		//Draw the vertices as triangle strip
		gl.glDrawArrays(GL10.GL_TRIANGLE_STRIP, 0, vertices.length / 3);
		
		//Disable the client state before leaving
		gl.glDisableClientState(GL10.GL_VERTEX_ARRAY);
		gl.glDisableClientState(GL10.GL_TEXTURE_COORD_ARRAY);
	}
}
