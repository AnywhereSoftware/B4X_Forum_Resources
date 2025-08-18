package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Audio;
import io.fouad.jtb.core.beans.CallbackQuery;
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

@ShortName("CallbackQuery")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class CallbackQuerywrapper extends AbsObjectWrapper<CallbackQuery> {
	private BA ba;
	private String eventName;
	
	private void CallbackQuerywrapper(CallbackQuery msg){
		this.setObject(msg);
	}
	
	public void Initialize(BA ba, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		this.setObject(new CallbackQuery());
	}
	public String getInline_message_id(){
		return getObject().getInline_message_id();
	}
	public String getData(){
		return getObject().getData();
	}	
	public String getId(){
		return getObject().getId();
	}
	public Message getMessage(){
		return getObject().getMessage();
	}
	public String getChatInstance(){
		return getObject().getChatInstance();
	}
	public User getFrom(){
		return getObject().getFrom();
	}

}
