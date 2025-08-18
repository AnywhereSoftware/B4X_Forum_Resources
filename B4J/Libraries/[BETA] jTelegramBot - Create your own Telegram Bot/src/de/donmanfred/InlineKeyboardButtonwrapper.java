package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.InlineKeyboardButton;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder;
import io.fouad.jtb.core.builders.KeyboardButtonBuilder;
import io.fouad.jtb.core.builders.KeyboardButtonBuilder.Row;

@ShortName("InlineKeyboardButton")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class InlineKeyboardButtonwrapper extends AbsObjectWrapper<InlineKeyboardButton> {
	private BA ba;
	public InlineKeyboardButton initialize(String text, String url, String callbackData, String switchInlineQuery){
		setObject(new InlineKeyboardButton(text, url, callbackData, switchInlineQuery));
		return getObject();
	}

}
