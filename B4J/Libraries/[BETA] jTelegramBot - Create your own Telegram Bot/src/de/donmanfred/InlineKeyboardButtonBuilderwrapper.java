package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.Document;
import io.fouad.jtb.core.beans.InlineKeyboardButton;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder.ButtonSet;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder.ButtonSetWithNoOptional;
import io.fouad.jtb.core.builders.KeyboardButtonBuilder;
import io.fouad.jtb.core.builders.KeyboardButtonBuilder.Row;

@ShortName("InlineKeyboardButtonBuilder")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class InlineKeyboardButtonBuilderwrapper extends AbsObjectWrapper<io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder> {
	void InlineKeyboardButtonBuilderwrapper(InlineKeyboardButtonBuilder msg){
		this.setObject(msg);
	}
	public InlineKeyboardButtonBuilderwrapper Initialize(){
		this.setObject(new InlineKeyboardButtonBuilder());
		return this;
	}
	public inlRowwrapper newRow(){
		getObject();
		inlRowwrapper row = new inlRowwrapper(getObject().newRow());
		return row;
	}

	public class inlRowwrapper extends AbsObjectWrapper<InlineKeyboardButtonBuilder.Row> {
		inlRowwrapper(InlineKeyboardButtonBuilder.Row msg){
			this.setObject(msg);
		}
		public inlButtonSetwrapper newButton(String text){
			inlButtonSetwrapper bset = new inlButtonSetwrapper(getObject().newButton(text));
			return bset;
		}
		public InlineKeyboardButton[][] build(){
			return getObject().build();
		}
	}
	public class inlButtonSetwrapper extends AbsObjectWrapper<InlineKeyboardButtonBuilder.ButtonSet> {
		inlButtonSetwrapper(InlineKeyboardButtonBuilder.ButtonSet msg){
			this.setObject(msg);
		}
		public InlineKeyboardButton[][] build(){
			return getObject().build();
		}

		public inlButtonSetwrapper newButton(String text){
			inlButtonSetwrapper bset = new inlButtonSetwrapper(getObject().newButton(text));
			return bset;
		}
		public inlRowwrapper newRow(){
			inlRowwrapper row = new inlRowwrapper(getObject().newRow());
			return row;
		}
		public ButtonSetWithNoOptionalwrapper withCallbackData(String callbackData){
			ButtonSetWithNoOptionalwrapper cb = new ButtonSetWithNoOptionalwrapper(getObject().withCallbackData(callbackData));
			return cb;
		}
		public ButtonSetWithNoOptionalwrapper withSwitchInlineQuery(String switchInlineQuery){
			ButtonSetWithNoOptionalwrapper cb = new ButtonSetWithNoOptionalwrapper(getObject().withSwitchInlineQuery(switchInlineQuery));
			return cb;
		}
		public ButtonSetWithNoOptionalwrapper withUrl(String url){
			ButtonSetWithNoOptionalwrapper cb = new ButtonSetWithNoOptionalwrapper(getObject().withUrl(url));
			return cb;
		}
	}

	public class ButtonSetWithNoOptionalwrapper extends AbsObjectWrapper<ButtonSetWithNoOptional> {
		ButtonSetWithNoOptionalwrapper(ButtonSetWithNoOptional msg){
			this.setObject(msg);
		}
		public inlButtonSetwrapper newButton(String text){
			inlButtonSetwrapper btn = new inlButtonSetwrapper(getObject().newButton(text));
			return btn;
		}
		public inlRowwrapper newRow(){
			inlRowwrapper btn = new inlRowwrapper(getObject().newRow());
			return btn;
		}
		public InlineKeyboardButton[][] build(){
			return getObject().build();
		}
	}

}
