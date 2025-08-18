package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Document;
import io.fouad.jtb.core.beans.PhotoSize;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.Video;
import io.fouad.jtb.core.beans.Voice;

@ShortName("PhotoSize")
public class PhotoSizewrapper extends AbsObjectWrapper<PhotoSize> {
	private BA ba;
	private String eventName;
	
	private void PhotoSizewrapper(PhotoSize msg){
		this.setObject(msg);
	}
	
	
	public String getFileUniqueID(){
		return getObject().getFileUniqueID();
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
