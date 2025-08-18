package de.donmanfred;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.Author;
import anywheresoftware.b4a.BA.DependsOn;
import anywheresoftware.b4a.BA.Events;
import anywheresoftware.b4a.BA.Permissions;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.BA.Version;
import io.fouad.jtb.core.JTelegramBot;
import io.fouad.jtb.core.TelegramBotApi;
import io.fouad.jtb.core.TelegramBotConfig;
import io.fouad.jtb.core.UpdateHandler;
import io.fouad.jtb.core.beans.BooleanOrMessageResult;
import io.fouad.jtb.core.beans.CallbackQuery;
import io.fouad.jtb.core.beans.Chat;
import io.fouad.jtb.core.beans.ChatIdentifier;
import io.fouad.jtb.core.beans.ChatMember;
import io.fouad.jtb.core.beans.ChosenInlineResult;
import io.fouad.jtb.core.beans.InlineKeyboardButton;
import io.fouad.jtb.core.beans.InlineKeyboardMarkup;
import io.fouad.jtb.core.beans.InlineQuery;
import io.fouad.jtb.core.beans.InlineQueryResult;
import io.fouad.jtb.core.beans.MediaIdentifier;
import io.fouad.jtb.core.beans.Message;
import io.fouad.jtb.core.beans.ReplyMarkup;
import io.fouad.jtb.core.beans.TelegramFile;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.UserProfilePhotos;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder;
import io.fouad.jtb.core.builders.InlineKeyboardButtonBuilder.Row;
import io.fouad.jtb.core.enums.ChatAction;
import io.fouad.jtb.core.enums.ParseMode;
import io.fouad.jtb.core.exceptions.NegativeResponseException;

@Version(0.31f)
@ShortName("JTB")
@Author("DonManfred (Wrapper)")
//@ActivityObject

@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
@Events(values={
"onGetUpdatesFailure(error As String)",
"onCallbackQueryReceived(api As Object, id As Int, query As Object)",
"onChosenInlineResultReceived(api As Object, id As Int,	result As Object)",
"onInlineQueryReceived(api As Object, id As Int, query As Object)",
"onMessageReceived(api As Object, id As Int, msg As Object)",
"onEditedMessageReceived(api As Object, id As Int, msg As Object)"
})
@DependsOn(values={"commons-logging-1.2","jackson-core-2.9.8","jackson-databind-2.9.8","jackson-annotations-2.9.8"})

public class JTBwrapper  {
	private BA ba;
	private String eventName;
	private JTelegramBot jbot;
	/**
	 *  <link>...|http://www.b4x.com</link>
	 */
	public static void LIBRARY_DOC() {
	}

	public void Initialize(final BA ba, final String EventName,final String botName, final String apiToken) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		this.jbot = new JTelegramBot(botName, apiToken, new UpdateHandler(){

			@Override
			public void onMessageReceived(TelegramBotApi telegramBotApi, int id, Message message) {
				// TODO Auto-generated method stub
				//BA.Log("onMessageReceived");
				ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_onmessagereceived", true, new Object[] {telegramBotApi,id,message});
			}

			@Override
			public void onEditedMessageReceived(TelegramBotApi telegramBotApi, int id, Message message) {
				// TODO Auto-generated method stub
				//BA.Log("onEditedMessageReceived");
				ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_oneditedmessagereceived", true, new Object[] {telegramBotApi,id,message});
				
			}

			@Override
			public void onInlineQueryReceived(TelegramBotApi telegramBotApi, int id, InlineQuery inlineQuery) {
				// TODO Auto-generated method stub
				//BA.Log("onInlineQueryReceived");
				ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_oninlinequeryreceived", true, new Object[] {telegramBotApi,id,inlineQuery});

			}

			@Override
			public void onChosenInlineResultReceived(TelegramBotApi telegramBotApi, int id,	ChosenInlineResult chosenInlineResult) {
				// TODO Auto-generated method stub
				//BA.Log("onChosenInlineResultReceived");
				ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_onchoseninlineresultreceived", true, new Object[] {telegramBotApi,id,chosenInlineResult});

			}

			@Override
			public void onCallbackQueryReceived(TelegramBotApi telegramBotApi, int id, CallbackQuery callbackQuery) {
				// TODO Auto-generated method stub
				//BA.Log("onCallbackQueryReceived");
				ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_oncallbackqueryreceived", true, new Object[] {telegramBotApi,id,callbackQuery});
				
			}

			@Override
			public void onGetUpdatesFailure(Exception e) {
				// TODO Auto-generated method stub
				//BA.Log("onGetUpdatesFailure:"+e);
      	String ex = e.toString();
				ba.raiseEventFromDifferentThread(this, null, 0, eventName + "_ongetupdatesfailure", true, new Object[] {ex});
			}

		});
		
	}
	
	public InlineKeyboardButton[][] CreateDummyKeyboard()	{
		Row row1 = InlineKeyboardButtonBuilder.newRow();
		
		row1.newButton("BTN1").withCallbackData("BTN1")
		.newButton("BTN2").withCallbackData("BTN2")
		.newButton("BTN3").withCallbackData("BTN3")
		.newButton("BTN4").withCallbackData("BTN4")
		.newButton("BTN5").withCallbackData("BTN5")
		.newRow()
		.newButton("BTN6").withSwitchInlineQuery("BTN6IQ")
		.newButton("BTN7").withSwitchInlineQuery("BTN7IQ")
		.newButton("BTN8").withSwitchInlineQuery("BTN8IQ")
		.newButton("BTN9").withSwitchInlineQuery("BTN9IQ")
		.newButton("BTN10").withSwitchInlineQuery("BTN10IQ")
		.newRow()
		.newButton("Forum").withUrl("https://www.b4x.com/android/forum/")
		.newButton("DonManfreds Overview").withUrl("https://www.b4x.com/android/forum/threads/donmanfreds-overview.54618/")
		.newButton("Bot").withUrl("https://t.me/donmanfred_bot")
		.newButton("JTB").withUrl("https://www.b4x.com/android/forum/threads/beta-jtelegrambot-create-your-own-telegram-bot.103821/")
		.newRow();

		return row1.build();
	}

	public ParseMode parsemodeHTML()	{
		return ParseMode.HTML;
	}
	public ParseMode parsemodeMARKDOWN()	{
		return ParseMode.MARKDOWN;
	}
	public ParseMode parsemodePLAIN()	{
		return ParseMode.PLAIN;
	}

	public ChatAction ChatActionFIND_LOCATION()	{
		return ChatAction.FIND_LOCATION;
	}
	public ChatAction ChatActionRECORD_AUDIO()	{
		return ChatAction.RECORD_AUDIO;
	}
	public ChatAction ChatActionRECORD_VIDEO()	{
		return ChatAction.RECORD_VIDEO;
	}
	public ChatAction ChatActionTYPING()	{
		return ChatAction.TYPING;
	}
	public ChatAction ChatActionUPLOAD_AUDIO()	{
		return ChatAction.UPLOAD_AUDIO;
	}
	public ChatAction ChatActionUPLOAD_DOCUMENT()	{
		return ChatAction.UPLOAD_DOCUMENT;
	}
	public ChatAction ChatActionUPLOAD_PHOTO()	{
		return ChatAction.UPLOAD_PHOTO;
	}
	public ChatAction ChatActionUPLOAD_VIDEO()	{
		return ChatAction.UPLOAD_VIDEO;
	}

	public ChatIdentifier byId(long id)	{
		return ChatIdentifier.byId(id);
	}
	
	public ChatIdentifier byUsername(String username)	{
		return ChatIdentifier.byUsername(username);
	}

	/**
	 * Starts the bot in POLLING mode. This method returns immediately.
	 */
	public void startAsync(){
		this.jbot.startAsync();
	}
	
	/**
	 * Stops the bot at next timeout.
	 */
	public void stop(){
		this.jbot.stop();
	}

	
	public MediaIdentifier MediaByFile(String path, String filename) throws FileNotFoundException{
		File inputfile = new File(path,filename);
		return MediaIdentifier.byFile(inputfile);
	}
	public MediaIdentifier MediaById(String id) throws FileNotFoundException{
		return MediaIdentifier.byId(id);
	}
	
	/**
	 * Starts the bot in POLLING mode, with passing custom configurations. This method returns immediately.
	 *
	 * @param telegramBotConfig custom configurations related to the bot
	 */
	public void startAsync(final TelegramBotConfig telegramBotConfig) throws IllegalStateException {
		this.jbot.startAsync(telegramBotConfig);
	}

	/**
	 * @return token used to authenticate with bot API
	 */
	public String getApiToken(){
		return this.jbot.getApiToken();
	}

	/**
	 * A simple method for testing the bot's authentication token.
	 * 
	 * @return basic information about the bot in form of a <code>User</code> object
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public User getMe() throws IOException, NegativeResponseException{
		return this.jbot.getMe();
	}
	
	public Message sendAnimation(ChatIdentifier targetChatIdentifier, MediaIdentifier mediaIdentifier,
			Integer duration, Integer width, Integer height, 
			MediaIdentifier Thumb, Boolean silentMessage, Integer replyToMessageId,
			ReplyMarkup replyMarkup, String caption, ParseMode parseMode) throws IOException, NegativeResponseException {
		return this.jbot.sendAnimation(targetChatIdentifier, mediaIdentifier, duration, width, height, Thumb, silentMessage, replyToMessageId, replyMarkup, caption, parseMode);
	}
	
	/**
	 * Delete message.
	 * 
	 * param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * param replyToMessageId if the message is a reply, id of the original message
	 * param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 * 
	 * return the sent <code>Message</code>
	 * 
	 * throws IOException if an I/O exception occurs
	 * NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */

	public String DeleteMessage(ChatIdentifier targetChatIdentifier, Integer MessageId) throws IOException, NegativeResponseException{
		
		String result = this.jbot.DeleteMessage(targetChatIdentifier, MessageId);
		if (result != null) {
			return result;
		} else {
			return null;
		}
		//return this.jbot.DeleteMessage(targetChatIdentifier, MessageId);
	}

	/**
	 * Sends text messages.
	 * 
	 * param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * param text text of the message to be sent
	 * param parseMode send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width
	 *                  text or inline URLs in your bot's message
	 * param disableLinkPreviews disables link previews for links in this message
	 * param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * param replyToMessageId if the message is a reply, id of the original message
	 * param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 * 
	 * return the sent <code>Message</code>
	 * 
	 * throws IOException if an I/O exception occurs
	 * NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */

	public Message sendMessage(ChatIdentifier targetChatIdentifier, String text, String parseMode,
	                    Boolean disableLinkPreviews, Boolean silentMessage, Integer replyToMessageId,
	                    ReplyMarkup replyMarkup) throws IOException, NegativeResponseException{
		
		return this.jbot.sendMessage((ChatIdentifier)targetChatIdentifier, text, ParseMode.valueOf(parseMode), disableLinkPreviews, silentMessage, replyToMessageId,(ReplyMarkup) replyMarkup);
	}
	

	/**
	 * Forwards messages of any kind.
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param sourceChatIdentifier unique identifier for the chat or username of the channel where the original
	 *                             message was sent
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param messageId unique identifier for the message to be forwarded
	 * 
	 * @return the forwarded <code>Message</code>
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message forwardMessage(ChatIdentifier targetChatIdentifier, ChatIdentifier sourceChatIdentifier,
	                       Boolean silentMessage, Integer messageId) throws IOException, NegativeResponseException{
		return this.jbot.forwardMessage(targetChatIdentifier, sourceChatIdentifier, silentMessage, messageId);		
	}
	
	/**
	 * Sends photos.
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param mediaIdentifier photo to be sent
	 * @param photoCaption photo caption, 0-200 characters
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param replyToMessageId if the message is a reply, id of the original message
	 * @param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 *    
	 * @return the sent <code>Message</code>
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message sendPhoto(ChatIdentifier targetChatIdentifier, MediaIdentifier mediaIdentifier, String photoCaption,
	                  Boolean silentMessage, Integer replyToMessageId, ReplyMarkup replyMarkup) throws IOException,
			NegativeResponseException{
		return this.jbot.sendPhoto(targetChatIdentifier, mediaIdentifier, photoCaption, silentMessage, replyToMessageId, replyMarkup);
	}
	
	/**
	 * Sends audio files that Telegram clients will display them in the music player. Your audio must be in the
	 * .mp3 format. Bots can currently send audio files of up to 50 MB in size, this limit may be changed in
	 * the future.
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param mediaIdentifier audio file to be sent
	 * @param duration duration of the audio in seconds
	 * @param performer the performer
	 * @param trackTitle the track name
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param replyToMessageId if the message is a reply, id of the original message
	 * @param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 * 
	 * @return the sent <code>Message</code>   
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message sendAudio(ChatIdentifier targetChatIdentifier, MediaIdentifier mediaIdentifier, Integer duration,
	                  String performer, String trackTitle, Boolean silentMessage, Integer replyToMessageId,
	                  ReplyMarkup replyMarkup) throws IOException, NegativeResponseException{
		return this.jbot.sendAudio(targetChatIdentifier, mediaIdentifier, duration, performer, trackTitle, silentMessage, replyToMessageId, replyMarkup);
	}
	
	/**
	 * Sends general files. Bots can currently send files of any type of up to 50 MB in size, this limit may be
	 * changed in the future.
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param mediaIdentifier file to be sent
	 * @param documentCaption document caption, 0-200 characters
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param replyToMessageId if the message is a reply, id of the original message
	 * @param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 *
	 * @return the sent <code>Message</code>
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message sendDocument(ChatIdentifier targetChatIdentifier, MediaIdentifier mediaIdentifier, String documentCaption,
	                     Boolean silentMessage, Integer replyToMessageId, ReplyMarkup replyMarkup) throws IOException,
			NegativeResponseException{
		return this.jbot.sendDocument(targetChatIdentifier, mediaIdentifier, documentCaption, silentMessage, replyToMessageId, replyMarkup);
	}
	
	/**
	 * Sends .webp stickers.
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param mediaIdentifier sticker to be sent
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param replyToMessageId if the message is a reply, id of the original message
	 * @param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 *
	 * @return the sent <code>Message</code>
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message sendSticker(ChatIdentifier targetChatIdentifier, MediaIdentifier mediaIdentifier, Boolean silentMessage,
	                    Integer replyToMessageId, ReplyMarkup replyMarkup) throws IOException,
			NegativeResponseException{
		return this.jbot.sendSticker(targetChatIdentifier, mediaIdentifier, silentMessage, replyToMessageId, replyMarkup);
	}
	
	/**
	 * Sends video files. Telegram clients support mp4 videos (other formats may be sent as Document). Bots can
	 * currently send video files of up to 50 MB in size, this limit may be changed in the future.
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param mediaIdentifier video to be sent
	 * @param duration duration of sent video in seconds
	 * @param width video width
	 * @param height video height
	 * @param videoCaption video caption, 0-200 characters
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param replyToMessageId if the message is a reply, id of the original message
	 * @param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 *
	 * @return the sent <code>Message</code>
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message sendVideo(ChatIdentifier targetChatIdentifier, MediaIdentifier mediaIdentifier, Integer duration,
	                  Integer width, Integer height, String videoCaption, Boolean silentMessage, Integer replyToMessageId,
	                  ReplyMarkup replyMarkup) throws IOException, NegativeResponseException{
		return this.jbot.sendVideo(targetChatIdentifier, mediaIdentifier, duration, width, height, videoCaption, silentMessage, replyToMessageId, replyMarkup);
	}
	
	/**
	 * Sends audio files that Telegram clients will display them as playable voice messages. For this to work,
	 * your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document).
	 * Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param mediaIdentifier audio file to be sent
	 * @param duration duration of sent audio in seconds
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param replyToMessageId if the message is a reply, id of the original message
	 * @param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 *
	 * @return the sent <code>Message</code>
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message sendVoice(ChatIdentifier targetChatIdentifier, MediaIdentifier mediaIdentifier, Integer duration, Boolean silentMessage,
	                  Integer replyToMessageId, ReplyMarkup replyMarkup) throws IOException, NegativeResponseException{
		return this.jbot.sendVoice(targetChatIdentifier, mediaIdentifier, duration, silentMessage, replyToMessageId, replyMarkup);
	}
	
	/**
	 * Sends point on the map.
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param latitude latitude of location
	 * @param longitude longitude of location
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param replyToMessageId if the message is a reply, id of the original message
	 * @param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 *
	 * @return the sent <code>Message</code>
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message sendLocation(ChatIdentifier targetChatIdentifier, float latitude, float longitude, Boolean silentMessage,
	                     Integer replyToMessageId, ReplyMarkup replyMarkup) throws IOException,
			NegativeResponseException{
		return this.jbot.sendLocation(targetChatIdentifier, latitude, longitude, silentMessage, replyToMessageId, replyMarkup);
	}
	
	/**
	 * Sends information about a venue.
	 *
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param latitude latitude of the venue
	 * @param longitude longitude of the venue
	 * @param title name of the venue   
	 * @param address address of the venue
	 * @param foursquareId Foursquare identifier of the venue   
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param replyToMessageId if the message is a reply, id of the original message
	 * @param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 *
	 * @return the sent <code>Message</code>
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message sendVenue(ChatIdentifier targetChatIdentifier, float latitude, float longitude, String title,
	                  String address, String foursquareId, Boolean silentMessage, Integer replyToMessageId,
	                  ReplyMarkup replyMarkup) throws IOException, NegativeResponseException{
		return this.jbot.sendVenue(targetChatIdentifier, latitude, longitude, title, address, foursquareId, silentMessage, replyToMessageId, replyMarkup);
	}
	
	/**
	 * Sends phone contact.
	 *
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param phoneNumber contact's phone number
	 * @param firstName contact's first name
	 * @param lastName contact's last name   
	 * @param silentMessage sends the message silently. iOS users will not receive a notification, Android
	 *                      users will receive a notification with no sound
	 * @param replyToMessageId if the message is a reply, id of the original message
	 * @param replyMarkup additional instructions to create inline keyboard, create/hide custom keyboard,
	 *                    or to force a reply from the user
	 *
	 * @return the sent <code>Message</code>
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Message sendContact(ChatIdentifier targetChatIdentifier, String phoneNumber, String firstName,
						String lastName, Boolean silentMessage, Integer replyToMessageId,
						ReplyMarkup replyMarkup) throws IOException, NegativeResponseException{
		return this.jbot.sendContact(targetChatIdentifier, phoneNumber, firstName, lastName, silentMessage, replyToMessageId, replyMarkup);
	}
	
	/**
	 * Use this method when you need to tell the user that something is happening on the bot's side.
	 * The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients
	 * clear its typing status).
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param action type of action to broadcast. Choose one, depending on what the user is about to receive
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public void sendChatAction(ChatIdentifier targetChatIdentifier, ChatAction action) throws IOException,
			NegativeResponseException{
		this.jbot.sendChatAction(targetChatIdentifier, action);
	}
	
	/**
	 * Gets a list of profile pictures for a user.
	 * 
	 * @param userId unique identifier of the target user
	 * @param offset sequential number of the first photo to be returned. By default, all photos are returned
	 * @param limit limits the number of photos to be retrieved. Values between 1—100 are accepted. Defaults
	 *              to 100
	 * @return <code>UserProfilePhotos</code> object
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public UserProfilePhotos getUserProfilePhotos(int userId, Integer offset, Integer limit) throws IOException,
			NegativeResponseException{
		return this.jbot.getUserProfilePhotos(userId, offset, limit);
	}
	
	/**
	 * Gets basic info about a file and prepare it for downloading. For the moment, bots can download files
	 * of up to 20MB in size.
	 * 
	 * Note: This function may not preserve original file name. Mime type of the file and its name (if available)
	 * should be saved when the File object is received.
	 * 
	 * @param fileId file identifier to get info about
	 *    
	 * @return <code>TelegramFile</code> object
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public TelegramFile getFile(String fileId) throws IOException, NegativeResponseException{
		return this.jbot.getFile(fileId);
	}
	
	/**
	 * Kicks a user from a group or a supergroup. In the case of supergroups, the user will not be
	 * able to return to the group on their own using invite links, etc., unless unbanned first.
	 * The bot must be an administrator in the group for this to work.
	 * Note: This will method only work if the ‘All Members Are Admins’ setting is off in the target
	 * group. Otherwise members may only be removed by the group's creator or by the member that
	 * added them.
	 * 
	 * @param targetChatIdentifier unique identifier for the target group/supergroup or username of the target supergroup
	 * @param userId unique identifier of the target user
	 *                  
	 * @return <code>true</code> on success
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public boolean kickChatMember(ChatIdentifier targetChatIdentifier, int userId) throws IOException, NegativeResponseException{
		return this.jbot.kickChatMember(targetChatIdentifier, userId);
	}
	
	/**
	 * Use this method for your bot to leave a group, supergroup or channel.
	 *
	 * @param targetChatIdentifier unique identifier for the target group/supergroup or username of the target supergroup
	 *
	 * @return <code>true</code> on success
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public boolean leaveChat(ChatIdentifier targetChatIdentifier) throws IOException, NegativeResponseException{
		return this.jbot.leaveChat(targetChatIdentifier);
	}
	
	/**
	 * Unbans a previously kicked user in a supergroup. The user will not return to the group automatically,
	 * but will be able to join via link, etc. The bot must be an administrator in the group for this to work. 
	 *
	 * @param targetChatIdentifier unique identifier for the target group/supergroup or username of the target supergroup
	 * @param userId unique identifier of the target user
	 *
	 * @return <code>true</code> on success
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public boolean unbanChatMember(ChatIdentifier targetChatIdentifier, int userId) throws IOException, NegativeResponseException{
		return this.jbot.unbanChatMember(targetChatIdentifier, userId);
	}
	
	/**
	 * Use this method to get up to date information about the chat (current name of the user for one-on-one
	 * conversations, current username of a user, group or channel, etc.). 
	 *
	 * @param targetChatIdentifier unique identifier for the target group/supergroup or username of the target supergroup
	 *
	 * @return a <code>Chat</code> object on success
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public Chat getChat(ChatIdentifier targetChatIdentifier) throws IOException, NegativeResponseException{
		return this.jbot.getChat(targetChatIdentifier);
	}
	
	/**
	 * Use this method to get a list of administrators in a chat. 
	 *
	 * @param targetChatIdentifier unique identifier for the target group/supergroup or username of the target supergroup
	 *
	 * @return On success, returns an Array of <code>ChatMember</code> objects that contains information about all chat
	 * administrators except other bots. If the chat is a group or a supergroup and no administrators were appointed,
	 * only the creator will be returned.
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public ChatMember[] getChatAdministrators(ChatIdentifier targetChatIdentifier) throws IOException, NegativeResponseException{
		return this.jbot.getChatAdministrators(targetChatIdentifier);
	}
	
	/**
	 * Use this method to get the number of members in a chat. 
	 *
	 * @param targetChatIdentifier unique identifier for the target group/supergroup or username of the target supergroup
	 *
	 * @return On success, number of chat members.
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public int getChatMembersCount(ChatIdentifier targetChatIdentifier) throws IOException, NegativeResponseException{
		return this.jbot.getChatMembersCount(targetChatIdentifier);
	}
	
	/**
	 * Use this method to get information about a member of a chat. 
	 *
	 * @param targetChatIdentifier unique identifier for the target group/supergroup or username of the target supergroup
	 * @param userId unique identifier of the target user
	 *
	 * @return <code>ChatMember</code> object on success
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public ChatMember getChatMember(ChatIdentifier targetChatIdentifier, int userId) throws IOException, NegativeResponseException{
		return this.jbot.getChatMember(targetChatIdentifier, userId);
	}
	
	/**
	 * Sends answers to callback queries sent from inline keyboards. The answer will be displayed to
	 * the user as a notification at the top of the chat screen or as an alert.
	 *
	 * @param callbackQueryId unique identifier for the query to be answered
	 * @param text text of the notification. If not specified, nothing will be shown to the user
	 * @param showAlert if true, an alert will be shown by the client instead of a notification at
	 *                  the top of the chat screen. Defaults to false   
	 *
	 * @return <code>true</code> on success
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public boolean answerCallbackQuery(String callbackQueryId, String text, Boolean showAlert) throws IOException, NegativeResponseException{
		return this.jbot.answerCallbackQuery(callbackQueryId, text, showAlert);
	}
	
	/**
	 * Edits text messages sent by the bot or via the bot (for inline bots).
	 * 
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param messageId unique identifier of the sent message
	 * @param inlineMessageId identifier of the inline message
	 * @param text new text of the message
	 * @param parseMode send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width
	 *                  text or inline URLs in your bot's message
	 * @param disableLinkPreviews disables link previews for links in this message
	 * @param inlineKeyboardMarkup inlineKeyboardMarkup object
	 * 
	 * @return the edited <code>Message</code> if it is sent by the bot, otherwise true on success
	 * 
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public BooleanOrMessageResult editMessageText(ChatIdentifier targetChatIdentifier, Integer messageId, String inlineMessageId,
	                                       String text, ParseMode parseMode, Boolean disableLinkPreviews,
	                                       InlineKeyboardMarkup inlineKeyboardMarkup)
			throws IOException, NegativeResponseException{
		return this.jbot.editMessageText(targetChatIdentifier, messageId, inlineMessageId, text, parseMode, disableLinkPreviews, inlineKeyboardMarkup);
	}
	
	/**
	 * Edits captions of messages sent by the bot or via the bot (for inline bots).
	 *
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param messageId unique identifier of the sent message
	 * @param inlineMessageId identifier of the inline message
	 * @param caption new caption of the message
	 * @param inlineKeyboardMarkup inlineKeyboardMarkup object
	 *
	 * @return the edited <code>Message</code> if it is sent by the bot, otherwise true on success
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public BooleanOrMessageResult editMessageCaption(ChatIdentifier targetChatIdentifier, Integer messageId, String inlineMessageId,
	                                          String caption, InlineKeyboardMarkup inlineKeyboardMarkup)
			throws IOException, NegativeResponseException{
		return this.jbot.editMessageCaption(targetChatIdentifier, messageId, inlineMessageId, caption, inlineKeyboardMarkup);
	}
	
	/**
	 * Edits only the reply markup of messages sent by the bot or via the bot (for inline bots).
	 *
	 * @param targetChatIdentifier unique identifier for the target chat or username of the target channel
	 * @param messageId unique identifier of the sent message
	 * @param inlineMessageId identifier of the inline message
	 * @param inlineKeyboardMarkup inlineKeyboardMarkup object
	 *
	 * @return the edited <code>Message</code> if it is sent by the bot, otherwise true on success
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public BooleanOrMessageResult editMessageReplyMarkup(ChatIdentifier targetChatIdentifier, Integer messageId, String inlineMessageId,
	                                              InlineKeyboardMarkup inlineKeyboardMarkup)
			throws IOException, NegativeResponseException{
		return this.jbot.editMessageReplyMarkup(targetChatIdentifier, messageId, inlineMessageId, inlineKeyboardMarkup);
	}
	
	/**
	 * Sends answers to an inline query. No more than 50 results per query are allowed.
	 *
	 * @param inlineQueryId unique identifier for the answered query
	 * @param results array of results for the inline query
	 * @param cacheTime the maximum amount of time in seconds that the result of the inline query
	 *                  may be cached on the server. Defaults to 300
	 * @param isPersonal pass <code>true</code>, if results may be cached on the server side only
	 *                   for the user that sent the query. By default, results may be returned to
	 *                   any user who sends the same query
	 * @param nextOffset the offset that a client should send in the next query with the same text
	 *                   to receive more results. Pass an empty string if there are no more results
	 *                   or if you don‘t support pagination. Offset length can’t exceed 64 bytes
	 * @param switchPmText if passed, clients will display a button with specified text that
	 *                     switches the user to a private chat with the bot and sends the bot
	 *                     a start message with the parameter switchPmParameter
	 * @param switchPmParameter parameter for the start message sent to the bot when user presses
	 *                          the switch button.
	 *                          Example: An inline bot that sends YouTube videos can ask the user
	 *                          to connect the bot to their YouTube account to adapt search results
	 *                          accordingly. To do this, it displays a ‘Connect your YouTube
	 *                          account’ button above the results, or even before showing any.
	 *                          The user presses the button, switches to a private chat with the bot
	 *                          and, in doing so, passes a start parameter that instructs the bot to
	 *                          return an oauth link. Once done, the bot can offer a switch_inline
	 *                          button so that the user can easily return to the chat where they
	 *                          wanted to use the bot's inline capabilities.
	 *
	 * @return <code>true</code> on success
	 *
	 * @throws IOException if an I/O exception occurs
	 * @throws NegativeResponseException if 4xx-5xx HTTP response is received from Telegram server
	 */
	public boolean answerInlineQuery(String inlineQueryId, InlineQueryResult[] results, Integer cacheTime, Boolean isPersonal,
	                          String nextOffset, String switchPmText, String switchPmParameter) throws IOException,
			NegativeResponseException{
		return this.jbot.answerInlineQuery(inlineQueryId, results, cacheTime, isPersonal, nextOffset, switchPmText, switchPmParameter);
	}

	public String pinChatMessage(ChatIdentifier targetChatIdentifier, Integer messageId, boolean disable_notification) throws IOException, NegativeResponseException {
		return this.jbot.pinChatMessage(targetChatIdentifier, messageId, disable_notification);
		
	}

	public String unpinChatMessage(ChatIdentifier targetChatIdentifier) throws IOException, NegativeResponseException{
		return this.jbot.unpinChatMessage(targetChatIdentifier);
	}
//	public String sendPoll(ChatIdentifier targetChatIdentifier, String question, anywheresoftware.b4a.objects.collections.List options, boolean disable_notification, Integer replyToMessageId, ReplyMarkup replyMarkup) throws IOException, NegativeResponseException{
//		PollOption[] pollopts = new PollOption[options.getSize()];
//		for (int i = 0; i < options.getSize(); i++) {
//			PollOption opt = (PollOption) options.Get(i);
//			pollopts[i] = opt;
//		}	
//		return this.jbot.sendPoll(targetChatIdentifier, question, pollopts, disable_notification, replyToMessageId, replyMarkup);
//	}
	
}
