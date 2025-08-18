### Full private chat and multi-chat (similar to Whatsapp) by Serge Nova
### 08/17/2021
[B4X Forum - B4A - Tutorials](https://www.b4x.com/android/forum/threads/133519/)

NovaChat is a private chat class module (Multi-User in next version) that has almost all the functionality of instant messaging.  
  
![](https://www.b4x.com/android/forum/attachments/117928)![](https://www.b4x.com/android/forum/attachments/117929)![](https://www.b4x.com/android/forum/attachments/117930)  
NovaChat uses the phone as a Server, specifically Erel's HttpServer library.  
  
The data is stored in the phone's memory, and can be limited if desired so as not to use a lot of space.  
  
Four biggest advantages of this Chat are:  
  

- 1. Chat is simple to use and can be used free of charge over the internet using the No-IP Service [Replace Everywhere where the Ip address is by the domain name obtained in No-Ip and add the port at the end (For example: <http://mymane.ddns.net:5588/>) and go to put the Ip address by default (127.0.0.1) in your domain name configuration];
- 2. The data to be sent leaves from the phone to another phone without going through a Server somewhere, so a message cannot be intercepted while being sent, even without encryption the data is safe;
- 3. Each phone is a Server for the other phones and a client for itself;
- 4. Chat Brain is a class module that you can modify as you wish.

The advantage is that you can change the data storage to any host or database you want, just change a few lines of code.  
  
For the chat to work, this 3 modules must be able to be: NovaChat, ChatServer and AudioCall.  
  
Detail of Nova Chat:  
  

- **AcceptVoiceCall** ' Accept the voice call
- **BlockUser** (UserName As String) ' Block a contact
- **CallAccepted** ' When the contact accept my voice call
- **CloseWaveFile**(Dir As String, FileName As String) ' Finish a recording voice message and save to the phone storage
- **ConvertToTimeFormat**(ms As Int) As String ' Covert seconds to time. Example: 2:35
- **CreateFileNameImage** (MessageImageTo As String, FileNameImage As String) As String ' Create a file name image
- **DeblockUser** (ListUserBloquer As List, UserName As String) ' Deblock a contact
- **DeleteDuplicateMessage** (FriendName As String) ' Delete all duplicated messages
- **DeleteMessage** (FriendUser As String, TextMessage As String) ' Delete a specified message
- **DesactiveUserOnMuteNoctification** (ListUserEnSilence As List, UserName As String) ' Desactive a contact to the mute noctification
- **DownloadMessageComplet** ' Download message success
- **DownloadMessageFile** ' Download a file message
- **FileNameAudio** ' Create a file name audio
- **FinishedToRecordForYou** (FriendName As String) ' Send a message when i finish to record for a friend
- **FinishedToWriteForYou** (FriendName As String) ' Send a signal when i finish to write for a contact
- **FriendWriteForMe** (yesWriting As Boolean, YesRecording As Boolean) ' When a contact write for me
- **FrienFinishedToWriteOrRecordForMe** ' When a contact finish to write or record for me
- **GetAllProfilImgeFriends** ' Get images profil of all contacts
- **GetAudioDuration** (FileName As String) As String ' Get audio file duration
- **GetContactNameByPhoneNumber** (FriendNumber1 As String) As String ' Get contact name by your phone number
- **GetContactsSize** As Int ' Get contacts friend size
- **GetImageType** (FriendName As String) As String ' Get the image type
- **GetMessageHeight** (FriendUser As String, MessageSize As Int) As Int ' Get height of message already saved
- **GetProfileImage** (FriendName As String) As Bitmap ' Go to take the image profil of a contact
- **GetUserBlocked** As List ' Get the list of contacts blocked
- **GetUserOnMuteNoctification** As List ' Get the contacts list of the mute noctification
- **GetVoiceDuration** (FileName As String) As String ' Get voice message duration
- **GoToTakeFileName** ' Go to take a file name to the contact before to send
- **GoToTakeNewMessage** ' Go to take a message
- **GoToTakeNewMessageSize** ' Go to take the message height
- **Initialize**
- **isFileMessage** (Message As String) As Boolean ' Verify if the message is a file
- **LastContacts** As List ' List of last contacts already on conversation
- **LastMessages** As List ' List of last messages
- **ListAudioFile** As List ' List of audio type accepted
- **ListContacts** As List ' List of contacts friend
- **ListFile** As List ' List of documents type accepted
- **ListImageFile** As List ' List of images type accepted
- **ListVideoFile** As List ' List of videos type accepted
- **LoadAndPlayAudio** (FileName As String) ' Load and play an audio file
- **LoadAndPlayVoiceMessage** (FileName As String) ' Load and play a voice message
- **MediaPlayer\_Complete** ' Playing complete
- **MessagesNoRead** As List ' List of messages no read
- **MessagesWaiting** (FriendName As String, MessageText As String) ' Add a message to waiting messages
- **NewMessage** (FriendName As String) ' Add the contact in the list of contacts already on conversation
- **NewMessageText** (FriendName As String) ' Send a message to a contact
- **PauseAudio** ' Pause a voice message
- **ReadMessage** (ContactName As String) As List ' List of messages with a contact
- **RecordingFinish** ' Recording finish
- **RecordNewVoiveMessage** (FriendName As String) ' Send a signal when i record for a contact
- **RecordNewVoiveMessageFinish** (FriendName As String) ' Send a signal when i finish to record for a contact
- **RefreshContacts** ' Refresh contacts friend
- **ReplyMessage** (FriendUser As String, Message As String, TextMessage As String) ' Reply to a specified message
- **SaveTimeToSend** (FriendUser As String, TextMessage As String) ' Save time to send message
- **SendAudio** (DirFileAudio As String, FileNameAudioFile As String, MessageAudioTo As String) ' Send a audio to a contact
- **SendFile** (DirFileText As String, FileNameText As String, MessageTextTo As String) ' Send a document to a contact
- **SendImage** (DirFileImage As String, FileNameImage As String, MessageImageTo As String) ' Send an image to a contact
- **SendMessage** (FriendUser As String, TextMessage As String) 'Send a message
- **SendVideo** (DirFileVideo As String, FileNameVideo As String, MessageVideoTo As String) ' Send a video to a contact
- **SetMessageNoctification** (Friend As String, Message As String) ' Set the noctification when a message arrive
- **ShareMessage** (Message As String) ' Share a specified message
- **SingUp** (MyUserName As String ,Number As String) ' Subscribe to chat
- **StartRecording** (FriendUser As String) ' Start recording voice message
- **StartWaveFile**(Dir As String, FileName As String, SampleRate As Int, Mono As Boolean, BitsPerSample As Int) As OutputStream ' Create a wave file for voice message
- **StopRecording** ' Stop a recording voice message
- **streamer\_RecordBuffer** (Buffer() As Byte) ' The above check is required as the last message will arrive after we call StopRecording
- **TimerRecordingTime\_Tick** ' Get voice message duration
- **tmrGetNewProfil\_Tick** ' Get images profil of all contacts each 20 minutes
- **tmrResendMessage\_Tick** ' Resend the waiting messages each 5 minutes
- **TypeFiles** (Message As String) As String ' Get a type of file in all types accepted
- **UserOnMuteNoctification** (UserName As String) ' Mute noctifications of a contact
- **verifyIsFriendIsOnLine** (FriendName As String) ' Verify if friend is online
- **VideoCall** (FriendName As String) 'Call a contact by video call
- **VideoCallReceived** ' When i receive a video call
- **VoiceCall** (FriendName As String) ' Call a contat by voice call
- **VoiceCallReceived** ' When i receive a voice call
- **WriteLabelMessageHeight** (FriendUser As String, Height As Int) ' Write message height
- **WritingNewMessage** (FriendName As String) ' Send a signal to a contact when i write for him

It took me over 5 days to write this code for everything to work properly, so I think it's worth a little donation before to get it:  
  
[[SIZE=7]**Donation**[/SIZE]](https://www.paypal.com/donate?hosted_button_id=8NJ62XGVMF4CY)