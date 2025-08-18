### TapCard - scan your NFC enabled Bank Card with your NFC enable device (EMV) by Johan Schoeman
### 03/12/2022
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/139105/)

A wrap for [**this Github project**](https://github.com/TapCard/TapCard). Scan your NFC enabled Bank Card with your NFC enable device.  
  
Enable NFC on your Nfc enable device before trying to scan a card. I have not added any code to check if you have NFC enabled or not. Browse the forum to figure out how you can do it programmatically.  
  
Attached the following  
1. B4A sample project  
2. B4A (wrapper) library files - extract them from attached B4ATapCardLibFiles.zip (jar and xml) and copy them to your additional libs folder.  
3. Java Code - use and amend it to your liking (I am not going to modify any further or maintain it)  
  
You also need to download the following two jar and add them to your additional library folder:  
1. <http://www.java2s.com/example/jar/r/download-rxjava1017jar-file.html>  
2. <http://www.java2s.com/example/jar/r/download-rxjava202jar-file.html>  
  
I cannot guarantee that it will read all cards - I have wrapped whatever is in the Github project.  
  
Sure you will figure out how to use it. The B4A code is very well commented to make sense of how it works.  
  
Top UI - a Label with basic Info from the card  
Middle (EditText1) - Command / Response comms between the card and the device (scroll the EditText up/down with your finger to view the complete conversation)  
Bottom (EditText2) - the tag names, tags, tag lengths, and tag values read from the card.  
  
Enjoy!  
  
??  
  
  
![](https://www.b4x.com/android/forum/attachments/126568)  
  
Sample Code:  
  

```B4X
#Region  Project Attributes  
    #ApplicationLabel: b4aTapCard  
    #VersionCode: 1  
    #VersionName:  
    'SupportedOrientations possible values: unspecified, landscape or portrait.  
    #SupportedOrientations: unspecified  
    #CanInstallToExternalStorage: False  
#End Region  
  
#Region  Activity Attributes  
    #FullScreen: False  
    #IncludeTitle: True  
#End Region  
  
Sub Process_Globals  
    'These global variables will be declared once when the application starts.  
    'These variables can be accessed from all modules.  
    Private xui As XUI  
End Sub  
  
Sub Globals  
    'These global variables will be redeclared each time the activity is created.  
                                                                         'MAKE SURE YOU ENABLE NFC ON YOUR DEVICE BEFORE SCANNING A CARD. THE APP WILL NOT PROMPT YOU TO ENABLE NFC CAPABILITY. YOU CAN ADD IT YOURSELF.  
    Dim tapcard As TapCard                                               'declare TapCard  
    Dim prevIntent As Intent                                             'see "If si.IsInitialized = False Or si = prevIntent Then Return"……  
    Dim ips As InputStream                                               'declare InputStream  
    Private Label1 As Label                                              'declare Label1 - it will display the infor returned in event "ips_scan_result(cardNumber As String, cardType As String, expireDate As String, cardHolderLastname As String, cardHolderFirstname As String, isNfcLocked As Boolean)"  
    Dim mbm As Bitmap                                                    'declare bitmap that indicates to scan the card. It will be displayed when app is started and also if you click on Label1 after a scan  
                                                                         'you can at any time scan a new card after you have scanned a card - no need to click on Lable1 to show the bitmap  
    Private ImageView1 As ImageView                                      'imageview that will display the bitmap  
    Private EditText1, EditText2 As EditText                                        'used to display the command / response between the card and the device - it is scrollable so that you can voew the entire comms between the card and the device  
  
    Dim tgname As List                                                   'a list to hold the tagnames  
    Dim tg As List                                                       'a list to hold the tags  
    Dim tglength As List                                                 'a list to hold the tag lengths  
    Dim tgvalue As List                                                  'a list to hold the tag values  
   
  
End Sub  
  
Sub Activity_Create(FirstTime As Boolean)  
   
    tgname.Initialize                                                     'initialize an empty list for the tagnames  
    tg.Initialize                                                         'initialise an empty list for the tags  
    tglength.Initialize                                                   'initilaize an empty list for the tag lengths  
    tgvalue.Initialize                                                    'initialize an empty list for the tag values  
   
    Activity.LoadLayout("Layout")  
    Label1.Visible = False  
    EditText1.Color = Colors.LightGray  
    EditText2.Color = Colors.Cyan  
   
    tapcard.Initialize("ips")                                             'initialize TapCard  
    ips = File.OpenInput(File.DirAssets,"smartcard_list.txt")             'Load the lookup list as an inputstream for various cards from smartcard_list.txt in the asset folder  
    mbm.Initialize(File.DirAssets, "tapimage.png")                        'load the bitmap into mbm  
    ImageView1.Bitmap = mbm                                               'set the bitmap to be dispalyes by Imageview1  
    ImageView1.Visible = True                                             'show the bitmap  
    Label1.Visible = False                                                'hide the label  
    EditText1.Visible = False                                             'hide the scrollable edittext  
    EditText2.Visible = False  
   
    tapcard.IPS = ips                                                     'pass the InputStream to the library - the library needs the inputstream from the text file.                                               '  
   
End Sub  
  
Sub Activity_Resume  
  
    tgname.Clear                                                        'clear the list that holds the tag names  
    tg.Clear                                                            'clear the list that holds the tags  
    tglength.clear                                                      'clear the list that holds the tag lengths  
    tgvalue.clear                                                       'clear the list that holds the tag values  
   
    EditText1.Text = "YOU CAN SCROLL ME UP/DOWN TO VIEW ALL COMMANDS/RESPONSES" & CRLF & CRLF  
    EditText2.Text = "YOU CAN SCROLL ME UP/DOWN TO VIEW ALL TAG INFO" & CRLF & CRLF  
'    EditText1.Text = ""                                                   'a new scan occurred or app started - set edittext1.text to nothing  
    Dim si As Intent = Activity.GetStartingIntent  
    'check that the intent is a new intent  
    If si.IsInitialized = False Or si = prevIntent Then Return            'no intent received or intent is the same as previous intent  
    prevIntent = si                                                       'set previntent to the starting intent  
    If si.Action.EndsWith("TECH_DISCOVERED") Or si.Action.EndsWith("NDEF_DISCOVERED") Or si.Action.EndsWith("TAG_DISCOVERED") Then   'check what action is available in the intent received  
        If si.Action.EndsWith("TECH_DISCOVERED") Then                     'show a toast message of the action available in the intent received.          
            ToastMessageShow("TECH_DISCOVERED", False)  
        Else If si.Action.EndsWith("NDEF_DISCOVERED") Then  
            ToastMessageShow("NDEF_DISCOVERED", False)  
        Else If si.Action.EndsWith("TAG_DISCOVERED") Then  
            ToastMessageShow("TAG_DISCOVERED", False)  
        Else  
            ToastMessageShow("NOTHING_DISCOVERED", False)      
        End If  
        Label1.Visible = True                                            'make label1 visible  
        ImageView1.Visible = False                                       'hide imageview1  
        EditText1.Visible = False                                        'hide edittext1  
    End If  
  
End Sub  
  
Sub Activity_Pause (UserClosed As Boolean)  
  
End Sub  
  
'Event that will be raised when a card has been scanned - it brings back the CardNumber, CardType, CardExpityDate, CardHolderLastName, CardHolderFirstName, if the card is NFC locked  
Sub ips_scan_result(cardNumber As String, cardType As String, expireDate As String, cardHolderLastname As String, cardHolderFirstname As String, isNfcLocked As Boolean)  
    Label1.Text = ""                         'set the text in label1.text to nothing  
    ImageView1.Visible = False               'hide imageview1  
    Label1.Visible = True                    'make labe11 visible  
  
    'set the text of label1 to the values receive from the event  
    Label1.Text = "CardNumber: " & cardNumber & CRLF & "cardType: " & cardType & CRLF & "expireDate: " & expireDate & CRLF  _  
                  & "Card Holder Last Name: " & cardHolderLastname & CRLF & "Card Holder First Name : " & cardHolderFirstname _  
                  & CRLF & "isNfcLocked : " & isNfcLocked  
    EditText1.Visible = True       'make edittext1 visible.  
   
End Sub  
  
'the commands and responses between the card and the device - it will be dispalyed in EditText1 (it is scrollable so that you can view all commands/responses  
Sub ips_command_response(command As String, response As String)  
    Log("COMMAND = " & command)                       'log command from device to the card in the B4A log  
    Log("RESPONSE = " & response)                     'log response from the card to the device in the B4A log  
   
    'set the command / response comms in edittext1  
    'note that there are numerous commands sent / responses received from a single card scan - the code below just adds to the empty string so that you can see the entire conversation  
    'EditeText1 will be "reset" to "" when a new scan occurs so that a new command/response string can be built.  
    EditText1.Text = EditText1.Text & "COMMAND: " & CRLF & command & CRLF & "RESPONSE: " & response & CRLF & CRLF  
    Log(" ")  
   
   
End Sub  
  
'this event bring back tagName, the Tag itself (HEX), the Tag length (HEX), and the Tag values (HEX) to the B4A project (from the library)  
Sub ips_tag_data (tagname As String, tags As String, taglengths As String, tagvalues As String)  
  
    EditText2.Visible = True                 'make edittext2 visible  
    tgname.Add(tagname)                      'add a tag name  
    tg.Add(tags)                             'add the tag  
    tglength.Add(taglengths)                 'add the tag length  
    tgvalue.Add(tagvalues)                   'add the tag value  
   
End Sub  
  
'this event will be raised once the card has been read - i.e all comms between the card and the device have been completed  
Sub ips_scan_completed  
   
    Log("In B4A and scan completed")                      'the card scan is completed  
   
    For i = 0 To tgname.Size - 1                          'going to log all the tag names, tags, tag lengths, tag values  
        EditText2.Text = EditText2.Text & CRLF &"TagName: " &tgname.Get(i)  
        EditText2.Text = EditText2.Text & CRLF & "Tag: " & tg.Get(i)  
        EditText2.Text = EditText2.Text & CRLF & "TagLength: " & tglength.Get(i)  
        EditText2.Text = EditText2.Text & CRLF & "TagValue: " & tgvalue.Get(i) & CRLF  
    Next  
   
   
End Sub  
  
'these are hooks to the wrapper as the wrapper uses for eg onNewIntent, onResume, onPause and dont want to extend the wrapper with Activity  
#If Java  
  
    public void _onnewintent (android.content.Intent intent) {  
  
    }  
   
    public void _onresume () {  
  
    }  
   
    public void _onpause () {  
  
    }  
  
#End If  
  
Private Sub Label1_Click  
   
    Label1.Visible = False                                              'hide label1  
    ImageView1.Visible = True                                           'show imageview1  
    EditText1.Visible = False                                           'hide edittext1  
    EditText1.Text = ""                                                 'set edittext1.text to nothing  
   
    EditText2.Visible = False                                           'hide edittext2  
    EditText2.Text = ""                                                 'set edittext2.text to nothing  
   
    tgname.Clear                                                        'clear the list that holds the tag names  
    tg.Clear                                                            'clear the list that holds the tags  
    tglength.clear                                                      'clear the list that holds the tag lengths  
    tgvalue.clear                                                       'clear the list that holds the tag values  
   
End Sub
```