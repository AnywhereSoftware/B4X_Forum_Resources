package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.KeyboardButton;
import io.fouad.jtb.core.builders.KeyboardButtonBuilder.ButtonSet;
import io.fouad.jtb.core.builders.KeyboardButtonBuilder.Row;

@ShortName("ButtonSet")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class ButtonSetwrapper extends AbsObjectWrapper<ButtonSet> {
	private BA ba;
	private void ButtonSetwrapper(ButtonSet row){
		this.setObject(row);
	}

	public ButtonSet newButton(String text){
		return getObject().newButton(text);
	}
	/**
	 * the user's phone number will be sent as a contact when the button
	 * is pressed. Available in private chats only.
	 * 
	 * If requestContact() is invoked, requestLocation() will be discarded.
	 */
	public ButtonSet requestContact()	{
		return getObject().requestContact();
	}
	
	/**
	 * the user's current location will be sent when the button is pressed.
	 * Available in private chats only.
	 * 
	 * If requestLocation() is invoked, requestContact() will be discarded.
	 */
	public ButtonSet requestLocation(){
		return getObject().requestLocation();
	}
	
	/**
	 * Starts a new row of the keyboard.
	 */
	public Row newRow(){
		return getObject().newRow();
	}
	
	/**
	 * Builds the keyboard.
	 *
	 * @return the keyboard
	 */
	public KeyboardButton[][] build()	{
		return getObject().build();
	}

}
