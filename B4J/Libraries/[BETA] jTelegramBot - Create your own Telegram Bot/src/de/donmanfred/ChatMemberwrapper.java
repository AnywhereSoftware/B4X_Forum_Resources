package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Audio;
import io.fouad.jtb.core.beans.Chat;
import io.fouad.jtb.core.beans.ChatMember;
import io.fouad.jtb.core.beans.Contact;
import io.fouad.jtb.core.beans.Document;
import io.fouad.jtb.core.beans.Location;
import io.fouad.jtb.core.beans.Message;
import io.fouad.jtb.core.beans.MessageEntity;
import io.fouad.jtb.core.beans.PhotoSize;
import io.fouad.jtb.core.beans.Sticker;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.Venue;
import io.fouad.jtb.core.beans.Video;
import io.fouad.jtb.core.beans.Voice;
import io.fouad.jtb.core.enums.ChatMemberStatus;

@ShortName("User")
public class ChatMemberwrapper extends AbsObjectWrapper<ChatMember> {
	private BA ba;
	private String eventName;
	
	private void Userwrapper(ChatMember msg){
		this.setObject(msg);
	}
	
	public void Initialize(BA ba, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		this.setObject(new ChatMember());
	}
	public User getUser(){
		return getObject().getUser();
	}
	public ChatMemberStatus getStatus(){
		return getObject().getStatus();
	}

}
