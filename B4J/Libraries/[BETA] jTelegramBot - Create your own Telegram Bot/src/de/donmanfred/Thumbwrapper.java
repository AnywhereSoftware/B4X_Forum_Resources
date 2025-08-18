package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Document;
import io.fouad.jtb.core.beans.PhotoSize;
import io.fouad.jtb.core.beans.Thumb;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.Video;
import io.fouad.jtb.core.beans.Voice;

@ShortName("Thumb")
public class Thumbwrapper extends AbsObjectWrapper<Thumb> {
	private BA ba;
	private String eventName;
	
	private void PhotoSizewrapper(Thumb msg){
		this.setObject(msg);
	}
	

	public String getFilePath(){
		return getObject().getFilePath();
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
	public Integer getFileSize(){
		return getObject().getFileSize();
	}
}
