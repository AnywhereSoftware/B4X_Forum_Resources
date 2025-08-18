package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.InlineKeyboardButton;
import io.fouad.jtb.core.beans.KeyboardButton;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder.ButtonSet;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder.Row;

@ShortName("InlineRow")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class InlineRowwrapper extends AbsObjectWrapper<Row> {
	private BA ba;
	private void Rowwrapper(Row row){
		this.setObject(row);
	}

	public InlineKeyboardButton[][] build(){
		return getObject().build();
	}
	public ButtonSet newButton(String text){
		return getObject().newButton(text);
	}

}
