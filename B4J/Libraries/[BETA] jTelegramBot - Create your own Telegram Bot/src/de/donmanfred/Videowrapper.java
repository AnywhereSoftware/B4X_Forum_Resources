package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.Video;
import io.fouad.jtb.core.beans.Voice;

@ShortName("Video")
public class Videowrapper extends AbsObjectWrapper<Video> {
	private BA ba;
	private String eventName;
	
	private void Videowrapper(Video msg){
		this.setObject(msg);
	}
	
	public int getHeight(){
		return getObject().getHeight();
	}
	public int getWidth(){
		return getObject().getWidth();
	}

	public String getFileId(){
		return getObject().getFileId();
	}
	public int getDuration(){
		return getObject().getDuration();
	}
	public String getMimeType(){
		return getObject().getMimeType();
	}
	public Integer getFileSize(){
		return getObject().getFileSize();
	}
}
