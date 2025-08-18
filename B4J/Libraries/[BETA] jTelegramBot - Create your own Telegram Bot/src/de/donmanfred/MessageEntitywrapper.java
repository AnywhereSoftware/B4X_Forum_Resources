package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Document;
import io.fouad.jtb.core.beans.MessageEntity;
import io.fouad.jtb.core.beans.PhotoSize;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.Video;
import io.fouad.jtb.core.beans.Voice;
import io.fouad.jtb.core.enums.MessageEntityType;

@ShortName("MessageEntity")
public class MessageEntitywrapper extends AbsObjectWrapper<MessageEntity> {
	private BA ba;
	private String eventName;
	
	public MessageEntityType getType(){
		return getObject().getType();
	}
	public int getOffset(){
		return getObject().getOffset();
	}
	public int getLength(){
		return getObject().getLength();
	}
	public String getUrl(){
		return getObject().getUrl();
	}
	public String getPhonenumber(){
		return getObject().getPhonenumber();
	}
	public User getUser(){
		return getObject().getUser();
	}
}
