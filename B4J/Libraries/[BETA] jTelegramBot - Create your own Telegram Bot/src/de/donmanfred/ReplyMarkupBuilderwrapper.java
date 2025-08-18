package de.donmanfred;

import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.beans.InlineKeyboardButton;
import io.fouad.jtb.core.beans.KeyboardButton;
import io.fouad.jtb.core.beans.ReplyMarkup;
import io.fouad.jtb.core.builders.ReplyMarkupBuilder;
import io.fouad.jtb.core.builders.ReplyMarkupBuilder.MessageWithAttachingInlineKeyboard;
import io.fouad.jtb.core.builders.ReplyMarkupBuilder.MessageWithCustomKeyboard;

@ShortName("ReplyMarkupBuilder")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class ReplyMarkupBuilderwrapper  {
	private BA ba;

	public ReplyMarkup attachInlineKeyboard(InlineKeyboardButton[][] inlineKeyboard)	{
		return ReplyMarkupBuilder.attachInlineKeyboard(inlineKeyboard).toReplyMarkup();
	}
	public ReplyMarkup forceReply()	{
		return ReplyMarkupBuilder.forceReply().toReplyMarkup();
	}
	public ReplyMarkup hideCustomKeyboard()	{
		return ReplyMarkupBuilder.hideCustomKeyboard().toReplyMarkup();
	}
	public MessageWithCustomKeyboard sendCustomKeyboard(KeyboardButton[][] keyboard)	{
		return ReplyMarkupBuilder.sendCustomKeyboard(keyboard).resizeKeyboard();
	}
	public ReplyMarkup sendCustomKeyboard2(KeyboardButton[][] keyboard)	{
		return ReplyMarkupBuilder.sendCustomKeyboard(keyboard).asOneTimeKeyboard().toReplyMarkup();
	}
	public ReplyMarkup sendCustomKeyboard3(InlineKeyboardButton[][] inlineKeyboard)	{
		return ReplyMarkupBuilder.attachInlineKeyboard(inlineKeyboard).toReplyMarkup();
	}

}
