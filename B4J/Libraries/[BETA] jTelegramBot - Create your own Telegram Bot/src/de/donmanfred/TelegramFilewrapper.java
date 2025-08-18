package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.TelegramFile;

@ShortName("TelegramFile")
public class TelegramFilewrapper extends AbsObjectWrapper<TelegramFile> {
	private void TelegramFilewrapper(TelegramFile msg){
		this.setObject(msg);
	}
	
	public int getFileSize(){
		return getObject().getFileSize();
	}
	public String getFilePath(){
		return getObject().getFilePath();
	}

	public String getFileId(){
		return getObject().getFileId();
	}
}
