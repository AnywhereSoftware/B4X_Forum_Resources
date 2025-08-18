package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.KeyboardButton;
import io.fouad.jtb.core.beans.ReplyKeyboardMarkup;

@ShortName("ReplyKeyboardMarkup")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class ReplyKeyboardMarkupwrapper extends AbsObjectWrapper<ReplyKeyboardMarkup> {
	private BA ba;
//	private void ReplyKeyboardMarkupwrapper(ReplyKeyboardMarkup row){
//		this.setObject(row);
//	}
	private KeyboardButton[][] internkeyboard;
	
	public void initkeyboard(int rows, int columns) {
		internkeyboard = new KeyboardButton[rows][columns];
	}
	public void SetButton(int row, int column, String ButtonText) {
		KeyboardButton button = new KeyboardButton();
		button.setText(ButtonText);
		button.setRequestContact(false);
		button.setRequestLocation(false);
		internkeyboard[row][column] = button;
		BA.Log(internkeyboard[row][column].toString());
	}
	public KeyboardButton[][] GetKeyboard() {
		return internkeyboard;
	}

	
	public void initialize(KeyboardButton[][] keyboard, Boolean resizeKeyboard, Boolean oneTimeKeyboard,
	                           Boolean selective){
		this.setObject(new ReplyKeyboardMarkup( keyboard, resizeKeyboard, oneTimeKeyboard,selective));
	}
	
	public KeyboardButton[][] getKeyboard(){
		return getObject().getKeyboard();
	}
	public void setKeyboard(KeyboardButton[][] keyboard){
		getObject().setKeyboard(keyboard);
	}
	
	public Boolean getResizeKeyboard(){
		return getObject().getResizeKeyboard();
	}
	public void setResizeKeyboard(Boolean resizeKeyboard){
		getObject().setResizeKeyboard(resizeKeyboard);
	}
	
	public Boolean getOneTimeKeyboard(){
		return getObject().getOneTimeKeyboard();
	}
	public void setOneTimeKeyboard(Boolean oneTimeKeyboard){
		getObject().setOneTimeKeyboard(oneTimeKeyboard);
	}
	
	public Boolean getSelective(){
		return getObject().getSelective();
	}
	public void setSelective(Boolean selective){
		getObject().setSelective(selective);
	}

}
