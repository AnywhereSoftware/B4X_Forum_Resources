package de.donmanfred;

import com.fasterxml.jackson.annotation.JsonProperty;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Document;
import io.fouad.jtb.core.beans.PhotoSize;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.Video;
import io.fouad.jtb.core.beans.Voice;

@ShortName("Document")
public class Documentwrapper extends AbsObjectWrapper<Document> {
	private BA ba;
	private String eventName;
	
	private void Documentwrapper(Document msg){
		this.setObject(msg);
	}

	public PhotoSize getThumb(){
		return getObject().getThumb();
	}
	public String getFileName(){
		return getObject().getFileName();
	}
	public String getFileUniqueID(){
		return getObject().getFileUniqueID();
	}
	public String getFileId(){
		return getObject().getFileId();
	}
	public String getMimeType(){
		return getObject().getMimeType();
	}
	public Integer getFileSize(){
		return getObject().getFileSize();
	}

}
