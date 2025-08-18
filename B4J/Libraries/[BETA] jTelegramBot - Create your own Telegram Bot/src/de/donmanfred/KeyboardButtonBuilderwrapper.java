package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import de.donmanfred.InlineKeyboardButtonBuilderwrapper.ButtonSetWithNoOptionalwrapper;
import io.fouad.jtb.core.beans.KeyboardButton;
import io.fouad.jtb.core.builders.KeyboardButtonBuilder;
import io.fouad.jtb.core.builders.KeyboardButtonBuilder.Row;

@ShortName("KeyboardButtonBuilder")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class KeyboardButtonBuilderwrapper extends AbsObjectWrapper<KeyboardButtonBuilder> {
	private BA ba;
	public KeyboardButtonBuilderwrapper Initialize(){
		this.setObject(new KeyboardButtonBuilder());
		return this;
	}
	public Rowwrapper newRow(){
		getObject();
		Rowwrapper row = new Rowwrapper(getObject().newRow());
		return row;
	}

	public class Rowwrapper extends AbsObjectWrapper<KeyboardButtonBuilder.Row> {
		Rowwrapper(KeyboardButtonBuilder.Row msg){
			this.setObject(msg);
		}
		public ButtonSetwrapper newButton(String text){
			ButtonSetwrapper bset = new ButtonSetwrapper(getObject().newButton(text));
			return bset;
		}
		public KeyboardButton[][] build(){
			return getObject().build();
		}
	}
	public class ButtonSetwrapper extends AbsObjectWrapper<KeyboardButtonBuilder.ButtonSet> {
		ButtonSetwrapper(KeyboardButtonBuilder.ButtonSet msg){
			this.setObject(msg);
		}
		public KeyboardButton[][] build(){
			return getObject().build();
		}
		public ButtonSetwrapper newButton(String text){
			ButtonSetwrapper bset = new ButtonSetwrapper(getObject().newButton(text));
			return bset;
		}

		public ButtonSetwrapper newContactButton(String text){
			ButtonSetwrapper bset = new ButtonSetwrapper(getObject().newButton(text).requestContact());
			return bset;
		}
		public ButtonSetwrapper newLocationButton(String text){
			ButtonSetwrapper bset = new ButtonSetwrapper(getObject().newButton(text).requestLocation());
			return bset;
		}
		public Rowwrapper newRow(){
			Rowwrapper row = new Rowwrapper(getObject().newRow());
			return row;
		}
		public ButtonSetwrapper requestContact(){
			ButtonSetwrapper row = new ButtonSetwrapper(getObject().requestContact());
			return row;
		}
		public ButtonSetwrapper requestLocation(){
			ButtonSetwrapper row = new ButtonSetwrapper(getObject().requestLocation());
			return row;
		}
	}

	public class KeyboardButtonwrapper extends AbsObjectWrapper<KeyboardButton> {
		KeyboardButtonwrapper(KeyboardButton msg){
			this.setObject(msg);
		}
		public Boolean getRequestContact(){
			return getObject().getRequestContact();
		}
		public void setRequestContact(Boolean requestContact){
			getObject().setRequestContact(requestContact);
		}
		public Boolean getRequestLocation(){
			return getObject().getRequestLocation();
		}
		public void setRequestLocation(Boolean requestLocation){
			getObject().setRequestLocation(requestLocation);
		}
		public void setText(String text){
			getObject().setText(text);
		}
		public String getText(){
			return getObject().getText();
		}
	}
}
