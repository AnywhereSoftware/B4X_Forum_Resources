package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Voice;

@ShortName("Voice")
public class Voicewrapper extends AbsObjectWrapper<Voice> {
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
