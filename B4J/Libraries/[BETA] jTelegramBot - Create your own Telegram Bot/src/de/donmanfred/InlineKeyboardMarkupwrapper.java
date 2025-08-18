package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.InlineKeyboardButton;
import io.fouad.jtb.core.beans.InlineKeyboardMarkup;
import io.fouad.jtb.core.beans.KeyboardButton;
import io.fouad.jtb.core.beans.ReplyKeyboardMarkup;

@ShortName("InlineKeyboardMarkup")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class InlineKeyboardMarkupwrapper extends AbsObjectWrapper<InlineKeyboardMarkup> {
	private BA ba;
	private void ReplyKeyboardMarkupwrapper(InlineKeyboardMarkup row){
		this.setObject(row);
	}
	public void initialize(InlineKeyboardButton[][] inlineKeyboard){
		this.setObject(new InlineKeyboardMarkup(inlineKeyboard));
	}
	
	public InlineKeyboardButton[][] getInlineKeyboard(){
		return getObject().getInlineKeyboard();
	}
	public void setKeyboard(InlineKeyboardButton[][] keyboard){
		getObject().setInlineKeyboard(keyboard);
	}
	

}
