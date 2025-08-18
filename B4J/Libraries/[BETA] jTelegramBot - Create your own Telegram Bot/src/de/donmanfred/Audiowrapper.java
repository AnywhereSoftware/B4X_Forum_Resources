package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Audio;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.Video;
import io.fouad.jtb.core.beans.Voice;

@ShortName("Audio")
public class Audiowrapper extends AbsObjectWrapper<Audio> {
	private BA ba;
	private String eventName;
	
	private void Audiowrapper(Audio msg){
		this.setObject(msg);
	}
	
	public String getPerformer(){
		return getObject().getPerformer();
	}
	public String getTitle(){
		return getObject().getTitle();
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
