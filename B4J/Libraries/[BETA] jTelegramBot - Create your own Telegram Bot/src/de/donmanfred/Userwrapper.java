package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.User;

@ShortName("User")
public class Userwrapper extends AbsObjectWrapper<User> {
	private BA ba;
	private String eventName;
	
	private void Userwrapper(User msg){
		this.setObject(msg);
	}
	
	public void Initialize(BA ba, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		this.setObject(new User());
	}
	public int getId(){
		return getObject().getId();
	}
	public String getFirstName(){
		return getObject().getFirstName();
	}
	public String getLastName(){
		return getObject().getLastName();
	}
	public String getUsername(){
		return getObject().getUsername();
	}
//	public String getLanguageCode(){
//		return getObject().getLanguageCode();
//	}
//	public boolean getisBot(){
//		return getObject().getisBot();
//	}

}
