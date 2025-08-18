package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.InlineKeyboardButton;
import io.fouad.jtb.core.beans.KeyboardButton;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder.ButtonSet;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder.ButtonSetWithNoOptional;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder.Row;

@ShortName("InlineButtonSet")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class InlineButtonSetwrapper extends AbsObjectWrapper<ButtonSet> {
	private BA ba;
	private void ButtonSetwrapper(ButtonSet row){
		this.setObject(row);
	}

	public ButtonSet newButton(String text){
		return getObject().newButton(text);
	}
	public ButtonSetWithNoOptional requestContact(String callbackData)	{
		return getObject().withCallbackData(callbackData);
	}
	
	public ButtonSetWithNoOptional withUrl(String url){
		return getObject().withUrl(url);
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
	public InlineKeyboardButton[][] build()	{
		return getObject().build();
	}

}
