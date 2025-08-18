package de.donmanfred;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.TelegramBotApi;
import io.fouad.jtb.core.beans.Message;
import io.fouad.jtb.core.beans.ReplyMarkup;
import io.fouad.jtb.core.beans.TelegramFile;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.builders.ApiBuilder;
import io.fouad.jtb.core.builders.ApiBuilder.AnsweringCallbackQueryNoId;
import io.fouad.jtb.core.builders.ApiBuilder.AnsweringInlineQueryNoIdNoResults;
import io.fouad.jtb.core.builders.ApiBuilder.ApiTopLevel;
import io.fouad.jtb.core.builders.ApiBuilder.AsUserReady;
import io.fouad.jtb.core.builders.ApiBuilder.AudioSendingNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.ChatActionSendingNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.DocumentSendingNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.EditingInlineMessageNoId;
import io.fouad.jtb.core.builders.ApiBuilder.EditingNormalMessageNoIdNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.FileDownloadingNoOutputStream;
import io.fouad.jtb.core.builders.ApiBuilder.FileInfoRetrieving;
import io.fouad.jtb.core.builders.ApiBuilder.GettingChatNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.KickingChatMemberNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.LeavingChatNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.LocationSendingNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.MessageForwardingNoSourceNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.MessageSendingNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.MessageSendingReady;
import io.fouad.jtb.core.builders.ApiBuilder.PhotoSendingNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.StickerSendingNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.UnbanningChatMemberNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.UserProfilePhotosRetrieving;
import io.fouad.jtb.core.builders.ApiBuilder.VideoSendingNoTarget;
import io.fouad.jtb.core.builders.ApiBuilder.VoiceSendingNoTarget;
import io.fouad.jtb.core.enums.ChatAction;
import io.fouad.jtb.core.enums.ParseMode;
import io.fouad.jtb.core.exceptions.NegativeResponseException;

@ShortName("ApiBuilder")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class ApiBuilderwrapper extends AbsObjectWrapper<ApiTopLevel> {
	private BA ba;
	private void ApiBuilderwrapper(TelegramBotApi telegramBotApi){
		this.setObject(ApiBuilder.api(telegramBotApi));
	}
	public ApiBuilderwrapper Initialize(BA ba, TelegramBotApi telegramBotApi) {
		this.ba = ba;
		this.setObject(ApiBuilder.api(telegramBotApi));
		return this;
	}

	/**
	 * Gets basic info about the current bot as <code>User</code> object.
	 * @throws NegativeResponseException 
	 * @throws IOException 
	 */
	public User asUser() throws IOException, NegativeResponseException	{
		return getObject().asUser().execute();
	}
	
	/**
	 * Sends text message.
	 * 
	 * @param text the text message to be sent
	 * @param chatId 
	 * @param replytomessageId 
	 * @param replyMarkup 
	 * @param parseMode 
	 * @throws NegativeResponseException 
	 * @throws IOException 
	 */
	public Message sendMessage( long chatId, String text, int replytomessageId, Boolean silent, Boolean disableLinkPreviews, ReplyMarkup replyMarkup, ParseMode parseMode) throws IOException, NegativeResponseException{
		MessageSendingReady res = getObject().sendMessage(text).toChatId(chatId);
		
		res.asReplyToMessage(replytomessageId);
		if (silent == true){
			res = res.asSilentMessage();
		}
		if (disableLinkPreviews == true){
			res = res.disableLinkPreviews();
		}
		if (replyMarkup != null){
			res = res.applyReplyMarkup(replyMarkup);
		}
		res.parseMessageAs(parseMode);
		return res.execute();
	}
	
	/**
	 * Forward a message of any kind.
	 * 
	 * @param messageId id of the message to be forwarded
	 */
	public MessageForwardingNoSourceNoTarget forwardMessage(int messageId)	{
		return getObject().forwardMessage(messageId);
	}
	
	/**
	 * Sends a photo as a file.
	 * 
	 * @param photoFile photo file to be sent
	 */
	public PhotoSendingNoTarget sendPhoto2(String path, String filename) throws FileNotFoundException	{
		File photoFile = new File(path,filename);
		return getObject().sendPhoto(photoFile);
	}
	
	/**
	 * Sends a photo as an input stream.
	 * 
	 * @param photoInputStream <code>InputStream</code> of the photo to be sent
	 * @param photoName to name the photo file
	 */
	public PhotoSendingNoTarget sendPhoto(InputStream photoInputStream, String photoName)	{
		return getObject().sendPhoto(photoInputStream, photoName);
	}
	
	/**
	 * Re-sends an existing photo.
	 * 
	 * @param photoId id of the photo to be re-sent
	 */
	public PhotoSendingNoTarget resendPhoto(String photoId)	{
		return getObject().resendPhoto(photoId);
	}
	
	/**
	 * Sends an audio as a file. Telegram clients will display the audio file in the music player. Your audio
	 * must be in the .mp3 format. Bots can currently send audio files of up to 50 MB in size, this limit may
	 * be changed in the future.
	 *
	 * @param audioFile audio file to be sent
	 */
	public AudioSendingNoTarget sendAudio2(File audioFile) throws FileNotFoundException	{
		return getObject().sendAudio(audioFile);
	}
	
	/**
	 * Sends an audio as an input stream. Telegram clients will display the audio file in the music player.
	 * Your audio must be in the .mp3 format. Bots can currently send audio files of up to 50 MB in size,
	 * this limit may be changed in the future.
	 *
	 * @param audioInputStream <code>InputStream</code> of the audio to be sent
	 * @param audioName to name the audio file
	 */
	public AudioSendingNoTarget sendAudio(InputStream audioInputStream, String audioName)	{
		return getObject().sendAudio(audioInputStream, audioName);
	}
	
	/**
	 * Re-sends an existing audio. Telegram clients will display the audio file in the music player. Your audio
	 * must be in the .mp3 format. Bots can currently send audio files of up to 50 MB in size, this limit may
	 * be changed in the future.
	 *
	 * @param audioId id of the audio to be re-sent
	 */
	public AudioSendingNoTarget resendAudio(String audioId)	{
		return getObject().resendAudio(audioId);
	}
	
	/**
	 * Sends a document as a file. Bots can currently send files of any type of up to 50 MB in size, this
	 * limit may be changed in the future.
	 *
	 * @param documentFile document file to be sent
	 */
	public DocumentSendingNoTarget sendDocument2(File documentFile) throws FileNotFoundException	{
		return getObject().sendDocument(documentFile);
	}
	
	/**
	 * Sends a document as an input stream. Bots can currently send files of any type of up to 50 MB in size,
	 * this limit may be changed in the future.
	 *
	 * @param documentInputStream <code>InputStream</code> of the document to be sent
	 * @param documentName to name the document file
	 */
	public DocumentSendingNoTarget sendDocument(InputStream documentInputStream, String documentName)	{
		return getObject().sendDocument(documentInputStream, documentName);
	}
	
	/**
	 * Re-sends an existing document. Bots can currently send files of any type of up to 50 MB in size, this
	 * limit may be changed in the future.
	 *
	 * @param documentId id of the document to be re-sent
	 */
	public DocumentSendingNoTarget resendDocument(String documentId){
		return getObject().resendDocument(documentId);
	}
	
	/**
	 * Sends a sticker as a .webp file.
	 *
	 * @param stickerFile sticker file to be sent
	 */
	public StickerSendingNoTarget sendSticker(File stickerFile) throws FileNotFoundException{
		return getObject().sendSticker(stickerFile);
	}
	
	/**
	 * Sends a sticker as an input stream of .webp file.
	 *
	 * @param stickerInputStream <code>InputStream</code> of the sticker to be sent
	 * @param stickerName to name the sticker file
	 */
	public StickerSendingNoTarget sendSticker(InputStream stickerInputStream, String stickerName)	{
		return getObject().sendSticker(stickerInputStream, stickerName);
	}
	
	/**
	 * Re-sends an existing sticker (.webp file).
	 *
	 * @param stickerId id of the sticker to be re-sent
	 */
	public StickerSendingNoTarget resendSticker(String stickerId)	{
		return getObject().resendSticker(stickerId);
	}
	
	/**
	 * Sends a video as a file. Telegram clients support mp4 videos (other formats may be sent as Document).
	 * Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.
	 *
	 * @param videoFile video file to be sent
	 */
	public VideoSendingNoTarget sendVideo2(File videoFile) throws FileNotFoundException{
		return getObject().sendVideo(videoFile);
	}
	
	/**
	 * Sends a video as an input stream. Telegram clients support mp4 videos (other formats may be sent as
	 * Document). Bots can currently send video files of up to 50 MB in size, this limit may be changed in
	 * the future.
	 *
	 * @param videoInputStream <code>InputStream</code> of the video to be sent
	 * @param videoName to name the video file
	 */
	public VideoSendingNoTarget sendVideo(InputStream videoInputStream, String videoName)	{
		return getObject().sendVideo(videoInputStream, videoName);
	}
	
	/**
	 * Re-sends an existing video. Telegram clients support mp4 videos (other formats may be sent as Document).
	 * Bots can currently send video files of up to 50 MB in size, this limit may be changed in the future.
	 *
	 * @param videoId id of the video to be re-sent
	 */
	public VideoSendingNoTarget resendVideo(String videoId)	{
		return getObject().resendVideo(videoId);
	}
	
	/**
	 * Sends a voice as a file. Telegram clients will display it as playable voice message. For this to work,
	 * your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document).
	 * Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.
	 *
	 * @param voiceFile voice file to be sent
	 */
	public VoiceSendingNoTarget sendVoice2(File voiceFile) throws FileNotFoundException{
		return getObject().sendVoice(voiceFile);
	}
	
	/**
	 * Sends a voice as an input stream. Telegram clients will display it as playable voice message. For this
	 * to work, your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or
	 * Document). Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in
	 * the future.
	 *
	 * @param voiceInputStream <code>InputStream</code> of the voice to be sent
	 * @param voiceName to name the voice file
	 */
	public VoiceSendingNoTarget sendVoice(InputStream voiceInputStream, String voiceName){
		return getObject().sendVoice(voiceInputStream, voiceName);
	}
	
	/**
	 * Re-sends an existing voice. Telegram clients will display it as playable voice message. For this to work,
	 * your audio must be in an .ogg file encoded with OPUS (other formats may be sent as Audio or Document).
	 * Bots can currently send voice messages of up to 50 MB in size, this limit may be changed in the future.
	 *
	 * @param voiceId id of the voice to be re-sent
	 */
	public VoiceSendingNoTarget resendVoice(String voiceId){
		return getObject().resendVoice(voiceId);
	}
	
	/**
	 * Sends point on the map.
	 * 
	 * @param latitude latitude of location
	 * @param longitude longitude of location
	 */
	public LocationSendingNoTarget sendLocation(int latitude, int longitude){
		return getObject().sendLocation(latitude, longitude);
	}
	
	/**
	 * Use this method when you need to tell the user that something is happening on the bot's side.
	 * The status is set for 5 seconds or less (when a message arrives from your bot, Telegram clients
	 * clear its typing status).
	 * 
	 * @param chatAction the type of chat action to be sent
	 */
	public ChatActionSendingNoTarget sendChatAction(ChatAction chatAction){
		return getObject().sendChatAction(chatAction);
	}
	
	/**
	 * Gets a list of profile pictures for a user by his id.
	 * 
	 * @param userId the user id
	 */
	public UserProfilePhotosRetrieving getUserProfilePhotos(int userId)	{
		return getObject().getUserProfilePhotos(userId);
	}
	
	/**
	 * Gets a list of profile pictures for a <code>User</code>.
	 * 
	 * @param user the <code>User</code> object
	 */
	public UserProfilePhotosRetrieving getUserProfilePhotos(User user){
		return getObject().getUserProfilePhotos(user);
	}
	
	/**
	 * Gets basic info about a file and prepare it for downloading. For the moment, bots can download files
	 * of up to 20MB in size
	 *
	 * @param fileId file identifier to get info about
	 */
	public FileInfoRetrieving getFileInfo(String fileId){
		return getObject().getFileInfo(fileId);
	}
	
	/**
	 * Downloads a Telegram file. For the moment, bots can download files of up to 20MB in size.
	 * 
	 * @param telegramFile the Telegram file to be downloaded
	 */
	public FileDownloadingNoOutputStream downloadFile(TelegramFile telegramFile){
		return getObject().downloadFile(telegramFile);
	}
	
	/**
	 * Kicks a user from a group or a supergroup. In the case of supergroups, the user will not be
	 * able to return to the group on their own using invite links, etc., unless unbanned first.
	 * The bot must be an administrator in the group for this to work.
	 * 
	 * @param userId id of user that would be kicked
	 */
	public KickingChatMemberNoTarget kickChatMember(int userId)	{
		return getObject().kickChatMember(userId);
	}
	
	/**
	 * Use this method for your bot to leave a group, supergroup or channel.
	 */
	public LeavingChatNoTarget leaveChat(){
		return getObject().leaveChat();
	}
	
	/**
	 * Unbans a previously kicked user in a supergroup. The user will not return to the group
	 * automatically, but will be able to join via link, etc. The bot must be an administrator
	 * in the group for this to work. 
	 *
	 * @param userId id of user that would be unbanned
	 */
	public UnbanningChatMemberNoTarget unbanChatMember(int userId){
		return getObject().unbanChatMember(userId);
	}
	
	/**
	 * Use this method to get up to date information about the chat (current name of the user for one-on-one
	 * conversations, current username of a user, group or channel, etc.).
	 */
	public GettingChatNoTarget getChat(){
		return getObject().getChat();
	}
	
	/**
	 * Use this method to get a list of administrators in a chat.
	 */
//	public GettingChatAdministratorsNoTarget getChatAdministrators(){
//		return getObject().getChatAdministrators();
//	}
	
	/**
	 * Use this method to get the number of members in a chat.
	 */
//	public GettingChatMembersCountNoTarget getChatMembersCount(){
//		return getObject().getChatMembersCount();
//	}
	
	/**
	 * Use this method to get information about a member of a chat.
	 * 
	 * @param userId id of the user
	 */
//	public GettingChatMemberNoTarget getChatMember(int userId){
//		return getObject().getChatMember(userId);
//	}
	
	/**
	 * Sends answer to callback query sent from inline keyboard. The answer will be displayed
	 * to the user as a notification at the top of the chat screen or as an alert.
	 */
	public AnsweringCallbackQueryNoId answerCallbackQuery(){
		return getObject().answerCallbackQuery();
	}
	
	public EditingNormalMessageNoIdNoTarget editMessage()	{
		return getObject().editMessage();
	}
	
	public EditingInlineMessageNoId editInlineMessage()	{
		return getObject().editInlineMessage();
	}
	
	/**
	 * Sends answers to an inline query.
	 */
	public AnsweringInlineQueryNoIdNoResults answerInlineQuery(){
		return getObject().answerInlineQuery();
	}
}
