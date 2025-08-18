package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Audio;
import io.fouad.jtb.core.beans.Chat;
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
import io.fouad.jtb.core.enums.ChatType;

@ShortName("Chat")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class Chatwrapper extends AbsObjectWrapper<Chat> {
	private BA ba;
	private String eventName;
	
	private void Chatwrapper(Chat msg){
		this.setObject(msg);
	}
	
	public void Initialize(BA ba, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		this.setObject(new Chat());
	}
	public Boolean getallMembersareAdministrators(){
		return getObject().getallMembersareAdministrators();
	}

	public long getId(){
		return getObject().getId();
	}
	public ChatType getType(){
		return getObject().getType();
	}
	public String getTitle(){
		return getObject().getTitle();
	}
	public String getUsername(){
		return getObject().getUsername();
	}
	public String getFirstName(){
		return getObject().getFirstName();
	}
	public String getLastName(){
		return getObject().getLastName();
	}

}
