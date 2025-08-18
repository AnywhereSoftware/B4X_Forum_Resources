package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.ReplyKeyboardHide;

@ShortName("ReplyKeyboardHide")
public class ReplyKeyboardHidewrapper extends AbsObjectWrapper<ReplyKeyboardHide> {
	public void initialize(){
		this.setObject(new ReplyKeyboardHide());
}
	public ReplyKeyboardHide hideKeyboard(){
		return getObject();
	}
}
