package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultArticleNoIdNoTitleNoMessageContent;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultAudioNoIdNoAudioUrlNoTitle;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultCachedDocumentNoIdNoTitleNoDocumentFileId;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultCachedGifNoIdNoGifFileId;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultCachedMpeg4GifNoIdNoMpeg4FileId;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultCachedPhotoNoIdNoPhotoFileId;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultCachedStickerNoIdNoStickerFileId;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultCachedVideoNoIdNoVideoFileIdNoTitle;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultCachedVoiceNoIdNoVoiceFileIdNoTitle;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultContactNoIdNoPhoneNumberNoFirstName;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultDocumentNoIdNoTitleNoDocumentUrlNoMimeType;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultGifNoIdNoGifUrlNoThumbUrl;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultLocationNoIdNoLatitudeNoLongitudeNoTitle;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultMpeg4NoIdNoMpeg4UrlNoThumbUrl;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultPhotoNoIdNoPhotoUrlNoThumbUrl;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultVenueNoIdNoLatitudeNoLongitudeNoTitleNoAddress;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultVideoNoIdNoVideoUrlNoMimeTypeNoThumbUrlNoTitle;
import io.fouad.jtb.core.builders.InlineQueryResultBuilder.ResultVoiceNoIdNoVoiceUrlNoTitle;

@ShortName("InlineQueryResultBuilder")

//@Permissions(values={"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})
//@Events(values={"onSigned(sign As Object)"})
//@DependsOn(values={"android-viewbadger"})

public class InlineQueryResultBuilderwrapper extends AbsObjectWrapper<InlineQueryResultBuilder> {
	private BA ba;

	/**
	 * Represents a link to an article or web page.
	 */
	public ResultArticleNoIdNoTitleNoMessageContent asArticle(){
		return InlineQueryResultBuilder.asArticle();
	}
	/**
	 * Represents a link to a photo. By default, this photo will be sent by the user with optional caption.
	 * Alternatively, you can provide messageContent to send it instead of photo.
	 */
	public ResultPhotoNoIdNoPhotoUrlNoThumbUrl asPhoto(){
		return InlineQueryResultBuilder.asPhoto();
	}
	
	/**
	 * Represents a link to an animated GIF file. By default, this animated GIF file will be sent by the user
	 * with optional caption. Alternatively, you can provide messageContent to send it instead of the animation.
	 */
	public ResultGifNoIdNoGifUrlNoThumbUrl asGif(){
		return InlineQueryResultBuilder.asGif();
	}
	
	/**
	 * Represents a link to a video animation (H.264/MPEG-4 AVC video without sound). By default, this animated
	 * MPEG-4 file will be sent by the user with optional caption. Alternatively, you can provide messageContent
	 * to send it instead of the animation.
	 */
	public ResultMpeg4NoIdNoMpeg4UrlNoThumbUrl asMpeg4Gif(){
		return InlineQueryResultBuilder.asMpeg4Gif();
	}
	
	/**
	 * Represents a link to a page containing an embedded video player or a video file. By default, this video
	 * file will be sent by the user with an optional caption. Alternatively, you can use messageContent to send
	 * a message with the specified content instead of the video.
	 */
	public ResultVideoNoIdNoVideoUrlNoMimeTypeNoThumbUrlNoTitle asVideo(){
		return InlineQueryResultBuilder.asVideo();
	}
	
	/**
	 * Represents a link to an mp3 audio file. By default, this audio file will be sent by the user. Alternatively,
	 * you can use messageContent to send a message with the specified content instead of the audio.
	 */
	public ResultAudioNoIdNoAudioUrlNoTitle asAudio(){
		return InlineQueryResultBuilder.asAudio();
	}
	
	/**
	 * Represents a link to a voice recording in an .ogg container encoded with OPUS. By default, this voice
	 * recording will be sent by the user. Alternatively, you can use messageContent to send a message
	 * with the specified content instead of the the voice message.
	 */
	public ResultVoiceNoIdNoVoiceUrlNoTitle asVoice()	{
		return InlineQueryResultBuilder.asVoice();
	}
	
	/**
	 * Represents a link to a file. By default, this file will be sent by the user with an optional caption.
	 * Alternatively, you can use messageContent to send a message with the specified content instead
	 * of the file. Currently, only .PDF and .ZIP files can be sent using this method.
	 */
	public ResultDocumentNoIdNoTitleNoDocumentUrlNoMimeType asDocument()	{
		return InlineQueryResultBuilder.asDocument();
	}
	
	/**
	 * Represents a location on a map. By default, the location will be sent by the user. Alternatively,
	 * you can use messageContent to send a message with the specified content instead of the location.
	 */
	public ResultLocationNoIdNoLatitudeNoLongitudeNoTitle asLocation()	{
		return InlineQueryResultBuilder.asLocation();
	}
	
	/**
	 * Represents a venue. By default, the venue will be sent by the user. Alternatively, you can use
	 * messageContent to send a message with the specified content instead of the venue.
	 */
	public ResultVenueNoIdNoLatitudeNoLongitudeNoTitleNoAddress asVenue()	{
		return InlineQueryResultBuilder.asVenue();
	}
	
	/**
	 * Represents a contact with a phone number. By default, this contact will be sent by the user.
	 * Alternatively, you can use messageContent to send a message with the specified content
	 * instead of the contact.
	 */
	public ResultContactNoIdNoPhoneNumberNoFirstName asContact()	{
		return InlineQueryResultBuilder.asContact();
	}
	
	/**
	 * Represents a link to a photo stored on the Telegram servers. By default, this photo will be
	 * sent by the user with an optional caption. Alternatively, you can use messageContent to
	 * send a message with the specified content instead of the photo.
	 */
	public ResultCachedPhotoNoIdNoPhotoFileId asCachedPhoto()	{
		return InlineQueryResultBuilder.asCachedPhoto();
	}
	
	/**
	 * Represents a link to an animated GIF file stored on the Telegram servers. By default, this
	 * animated GIF file will be sent by the user with an optional caption. Alternatively, you can
	 * use messageContent to send a message with specified content instead of the animation.
	 */
	public ResultCachedGifNoIdNoGifFileId asCachedGif()	{
		return InlineQueryResultBuilder.asCachedGif();
	}
	
	/**
	 * Represents a link to a video animation (H.264/MPEG-4 AVC video without sound) stored on the
	 * Telegram servers. By default, this animated MPEG-4 file will be sent by the user with an
	 * optional caption. Alternatively, you can use messageContent to send a message with the
	 * specified content instead of the animation.
	 */
	public ResultCachedMpeg4GifNoIdNoMpeg4FileId asCachedMpeg4Gif()	{
		return InlineQueryResultBuilder.asCachedMpeg4Gif();
	}
	
	/**
	 * Represents a link to a sticker stored on the Telegram servers. By default, this sticker will
	 * be sent by the user. Alternatively, you can use messageContent to send a message with the
	 * specified content instead of the sticker.
	 */
	public ResultCachedStickerNoIdNoStickerFileId asCachedSticker()	{
		return InlineQueryResultBuilder.asCachedSticker();
	}
	
	/**
	 * Represents a link to a file stored on the Telegram servers. By default, this file will be sent
	 * by the user with an optional caption. Alternatively, you can use messageContent to send
	 * a message with the specified content instead of the file. Currently, only pdf-files and zip
	 * archives can be sent using this method.
	 */
	public ResultCachedDocumentNoIdNoTitleNoDocumentFileId asCachedDocument()	{
		return InlineQueryResultBuilder.asCachedDocument();
	}
	
	/**
	 * Represents a link to a video file stored on the Telegram servers. By default, this video file
	 * will be sent by the user with an optional caption. Alternatively, you can use messageContent
	 * to send a message with the specified content instead of the video.
	 */
	public ResultCachedVideoNoIdNoVideoFileIdNoTitle asCachedVideo()	{
		return InlineQueryResultBuilder.asCachedVideo();
	}
	

	/**
	 * Represents a link to a voice message stored on the Telegram servers. By default, this voice
	 * message will be sent by the user. Alternatively, you can use messageContent to send a message
	 * with the specified content instead of the voice message.
	 */
	public ResultCachedVoiceNoIdNoVoiceFileIdNoTitle asCachedVoice()	{
		return InlineQueryResultBuilder.asCachedVoice();
	}

	
}
