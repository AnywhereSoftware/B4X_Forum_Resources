package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Animation;
import io.fouad.jtb.core.beans.Document;
import io.fouad.jtb.core.beans.PhotoSize;
import io.fouad.jtb.core.beans.Thumb;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.Video;
import io.fouad.jtb.core.beans.Voice;

@ShortName("Animation")
public class Animationwrapper extends AbsObjectWrapper<Animation> {
	private BA ba;
	private String eventName;
	
	private void PhotoSizewrapper(Animation msg){
		this.setObject(msg);
	}
	

	public String getFilename(){
		return getObject().getFilename();
	}
	public String getPerformer(){
		return getObject().getPerformer();
	}
	public String getTitle(){
		return getObject().getTitle();
	}
	public String getMimeType(){
		return getObject().getMimeType();
	}
	public String getFileId(){
		return getObject().getFileId();
	}
	public int getWidth(){
		return getObject().getWidth();
	}
	public int getHeight(){
		return getObject().getHeight();
	}
	public int getDuration(){
		return getObject().getDuration();
	}
	public Integer getFileSize(){
		return getObject().getFileSize();
	}
//	public Thumb getThumb(){
//		return getObject().getThumb();
//	}

}
