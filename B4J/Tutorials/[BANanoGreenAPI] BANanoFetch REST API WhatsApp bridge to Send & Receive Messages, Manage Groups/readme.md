### [BANanoGreenAPI] BANanoFetch REST API WhatsApp bridge to Send & Receive Messages, Manage Groups by Mashiane
### 01/20/2025
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/165177/)

Hi Fam  
  
[Download](https://github.com/Mashiane/BANanoGreenAPI)  
  
Many thanks to [USER=115245]@Mariano Ismael Castro[/USER]  
  
This is a wrap of the [B4xGreenAPI](https://www.b4x.com/android/forum/threads/b4x-greenapi-whatsapp-api.157101/#content) for BANAno, internally it uses BANanoFetch to execute REST API calls to the GreenAPI to send & receive messages and manage groups on WhatsApp.  
  
**Requirements**  
  
1. A GreenAPI account. Developers get a free developer account.  
2. A GreenAPI account instance. When you create an account, you will need to create an instance.  
3. Extra - In each instance you can set a hook to receive incoming & outgoing messages & statuses like read, delivered etc. This can point to a b4j server controller or whatever back-end you use. That way you can store whatsapp messages on a back-end.  
  
*Things to note*  
  
**Contact** - a contact or chatID is the country code without the +, suffixed with **@c.us,** e.g. [email]27827366700@c.us[/email] (not my real number)  
**Group** - a group ID is the country code without the +, suffixed with **@g.us,** (you get these when reading contacts as they are created by whatsapp)  
**Each message you receive / send is allocated a messageID  
  
Available Methods  
  
1. Account**  
1.1 GetSettings  
1.2 SetSettings  
1.3 GetStateInstance  
1.4 Reboot  
1.5 Logout  
1.6 QR  
1.7 GetAuthorizatioCode  
1.8 SetProfilePicture  
1.9 GetWaSettings  
  
**2. Sending**  
2.1 SendMessage  
2.2 SendPoll  
2.3 SendFileByUpload  
2.4 SendFileByURL  
2.5 UploadFile  
2.6 SendLocation  
2.7 SendContact  
2.8 ForwardMessages  
  
**3. Receiving**  
3.1 ReceiveIncomingNotifications  
3.2 ReceiveNotification  
3.3 DeleteNotification  
3.4 DownloadFile  
3.5 ReadChat  
3.6 ReadChats  
  
**4. Journals**  
4.1 GetChatHistory  
4.2 GetMessage  
4.3 LastIncomingMessages  
4.4 LastOutgoingMessages  
  
**5. Que**  
5.1. ShowMessageQue  
5.2 ClearMessagesQue  
  
**6. Groups**  
6.1. CreateGroup  
6.2. UpdateGroupName  
6.3. GetGroupData  
6.4. AddGroupParticipant  
6.5. RemoveGroupParticipant  
6.6. SetGroupAdmin  
6.7. RemoveAdmin  
6.8. SetGroupPicture  
6.9. LeaveGroup  
  
**7. Statuses (BETA)**  
7.1. SendTextStatus  
7.2. SendVoiceStatus  
7.3. SendMediaStatus  
7.4. GetOutgoingStatuses  
7.5. GetIncomingStatuses  
7.6. GetStatusStatistic  
7.7. DeleteStatus  
  
8. Services  
8.1 CheckWhatsApp  
8.2 GetAvatar  
8.3. GetContacts  
8.4 GetContactInfo  
8.5 DeleteMessage  
8.6. EditMessage (BETA)  
8.7 ArchiveChat  
8.8 UnArchiveChat  
8.9 SetDisappearingChat  
  
**GreenAPI RoadMap**  
  

- As of 20 Jan 2025, there are 344 open issues on their [GitHub](https://github.com/green-api/issues/issues) repo and some pull requests.
- There are some features that have been requested and are pending due to some limitations of some of the available methods in the REST API

  
**Appreciation**  
  
If you find my posts useful, please consider supporting with a certificate of appreciation. This helps with research & development and ensures you have useful tools for developing your apps.  
  
<https://paypal.me/anelembanga?country.x=ZA&locale.x=en_US>  
  
All the best