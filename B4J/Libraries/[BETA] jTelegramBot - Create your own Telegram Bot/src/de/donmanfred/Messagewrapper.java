package de.donmanfred;

import anywheresoftware.b4a.AbsObjectWrapper;
import anywheresoftware.b4a.BA;
import anywheresoftware.b4a.BA.ShortName;
import anywheresoftware.b4a.objects.collections.List;
import io.fouad.jtb.core.beans.Audio;
import io.fouad.jtb.core.beans.Chat;
import io.fouad.jtb.core.beans.Contact;
import io.fouad.jtb.core.beans.Document;
import io.fouad.jtb.core.beans.Location;
import io.fouad.jtb.core.beans.Message;
import io.fouad.jtb.core.beans.MessageEntity;
import io.fouad.jtb.core.beans.PhotoSize;
import io.fouad.jtb.core.beans.Sticker;
import io.fouad.jtb.core.beans.User;
import io.fouad.jtb.core.beans.Venue;
import io.fouad.jtb.core.beans.Video;
import io.fouad.jtb.core.beans.Voice;

@ShortName("Message")
public class Messagewrapper extends AbsObjectWrapper<Message> {
	private BA ba;
	private String eventName;
	
	private void Messagewrapper(Message msg){
		this.setObject(msg);
	}
	
	public void Initialize(BA ba, String EventName) {
		this.eventName = EventName.toLowerCase(BA.cul);
		this.ba = ba;
		this.setObject(new Message());
	}

	public User getNewChatParticipant(){
		return getObject().getNewChatParticipant();
	}
	public User[] getNewChatMembers(){
		return getObject().getNewChatMembers();
	}

	
	public int getMessageId(){
		return getObject().getMessageId();
	}
	public User getFrom(){
		return getObject().getFrom();
	}
	public int getDate(){
		return getObject().getDate();
	}
	public Chat getChat(){
		return getObject().getChat();
	}
	public Object getGame(){
		return getObject().getGame();
	}
	public User getForwardFrom(){
		return getObject().getForwardFrom();
	}
	public int getForwardFromMessageID(){
		return getObject().getForwardFromMessageID();
	}
	public Chat getForwardFromChat(){
		return getObject().getForwardFromChat();
	}
	public Integer getForwardDate(){
		return getObject().getForwardDate();
	}
	public Message getReplyToMessage(){
		return getObject().getReplyToMessage();
	}
//	public int getEditDate(){
//		return getObject().getEditDate();
//	}
	public String getText(){
		return getObject().getText();
	}
//	public Object getAnimation(){
//		return getObject().getAnimation();
//	}
	public java.util.List<Object> getEntities(){
		MessageEntity[] entities = getObject().getEntities();
		List l = new List();
		l.Initialize();
		if (entities != null){
			for (MessageEntity s : entities) {
				l.Add(s);
			}
		}
		return l.getObject();
	}
	public Audio getAudio(){
		return getObject().getAudio();
	}
	public Document getDocument(){
		return getObject().getDocument();
	}
	public PhotoSize[] getPhoto(){
		return getObject().getPhoto();
	}
	public Sticker getSticker(){
		return getObject().getSticker();
	}
	public Video getVideo(){
		return getObject().getVideo();
	}
	public Voice getVoice(){
		return getObject().getVoice();
	}
	public String getCaption(){
		return getObject().getCaption();
	}
	public Contact getContact(){
		return getObject().getContact();
	}
	public Location getLocation(){
		return getObject().getLocation();
	}
	public Venue getVenue(){
		return getObject().getVenue();
	}
	public User getNewChatMember(){
		return getObject().getNewChatMember();
	}
	public User getLeftChatMember(){
		return getObject().getLeftChatMember();
	}
	public String getNewChatTitle(){
		return getObject().getNewChatTitle();
	}
	public PhotoSize[] getNewChatPhoto(){
		return getObject().getNewChatPhoto();
	}
	public Boolean getDeleteChatPhoto(){
		return getObject().getDeleteChatPhoto();
	}
	public Boolean getGroupChatCreated(){
		return getObject().getGroupChatCreated();
	}
	public Boolean getSuperGroupChatCreated(){
		return getObject().getSuperGroupChatCreated();
	}
	public Boolean getChannelChatCreated(){
		return getObject().getChannelChatCreated();
	}
	public Long getMigrateToChatId(){
		return getObject().getMigrateToChatId();
	}
	public Long getMigrateFromChatId(){
		return getObject().getMigrateFromChatId();
	}
	public Message getPinnedMessage(){
		return getObject().getPinnedMessage();
	}	
}
