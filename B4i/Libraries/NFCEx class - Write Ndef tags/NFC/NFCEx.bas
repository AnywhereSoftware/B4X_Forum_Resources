B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=6
@EndOfDesignText@
Sub Class_Globals
	Public NFC As NFC
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	NFC.Initialize("nfc")
End Sub

Public Sub Scan (DialogMessage As String)
	NFC.Scan(DialogMessage)
	Wait For NFC_TagConnected (Success As Boolean, Tag As Object)
	If Success Then
		Dim no As NativeObject = NFC
		no.RunMethod("checkStatus:", Array(Tag))
		Wait For NFC_Status(Success As Boolean, Status As Int, Capacity As Int)
		'1 = not supported
		'2 = read / wrute
		'3 = read only
		Main.LogMsg("Status: " & Status)
		no.RunMethod("read:", Array(Tag)) 'read previous value
		Wait For NFC_TagRead (Success As Boolean, Messages As List)
		If Success Then
			ReadMessages (Messages)
			If Status = 2 Then
				Dim msg As Object = CreateTextNdefMessage("This is the value that will be written") '<-- write new value
				no.RunMethod("write::", Array(Tag, msg))
				Wait For NFC_WriteComplete (Success As Boolean)
				Main.LogMsg("Write complete: " & Success)
			End If
		End If
	End If
	NFC.StopScan
End Sub

Private Sub CreateTextNdefMessage (Text As String) As Object
	Dim locale As NativeObject
	locale = locale.Initialize("NSLocale").RunMethod("localeWithLocaleIdentifier:", Array("en_US"))
	Dim payload As NativeObject
	payload = payload.Initialize("NFCNDEFPayload").RunMethod("wellKnownTypeTextPayloadWithString:locale:", Array(Text, locale))
	Dim payloads As List = Array(payload)
	Dim ndef As NativeObject
	ndef = ndef.Initialize("NFCNDEFMessage").RunMethod("alloc", Null).RunMethod("initWithNDEFRecords:", Array(payloads))
	Return ndef
End Sub

	

Private Sub ReadMessages (Messages As List)
	Dim bc As ByteConverter
	For Each msg As NdefRecord In Messages
		Main.LogMsg("Payload: " & bc.HexFromBytes(msg.GetPayload))
		Main.LogMsg("Type: " & msg.RecordType)
		Try
			If msg.RecordType = msg.FORMAT_NFCWellKnown Then
				Main.LogMsg("Known type: " & KnownType(msg.GetPayload, msg.GetKnownType))
			Else
				Main.LogMsg("As text: " & bc.StringFromBytes(msg.GetPayload, "utf8"))
			End If
		Catch
			Log(LastException)
		End Try
	Next
	
End Sub

Private Sub KnownType(payload() As Byte, ktype() As Byte) As String
	Dim c As String = BytesToString(ktype, 0, 1, "utf8")
	Select c
		Case "U"
			Dim types As List = Array("", "http://www.", "https://www." , "http://" , "https://" , "tel:", "mailto:" _
		 , "ftp://anonymous:anonymous@", "ftp://ftp.", "ftps://" , "sftp://" , "smb://" , "nfs://", "ftp://" _
		 , "dav://", "news:" , "telnet://" , "imap:" , "rtsp://" , "urn:" , "pop:" , "sip:" , "sips:" _
		  , "tftp:" , "btspp://" , "btl2cap://" , "btgoep://" , "tcpobex://" , "irdaobex://" , "file://" _
		 , "urn:epc:id:" , "urn:epc:tag:" , "urn:epc:pat:" , "urn:epc:raw:" , "urn:epc:" , "urn:nfc:")
			Dim sb As StringBuilder
			sb.Initialize
			sb.Append(types.Get(payload(0)))
			sb.Append(BytesToString(payload, 1, payload.Length - 1, "utf8"))
			Return sb.ToString
		Case "T"
			Dim encoding As String
			If Bit.And(payload(0), 0x80) = 0 Then encoding = "UTF-8" Else encoding = "UTF-16"
			Dim languageCodeLength As Int = Bit.And(payload(0), 0x3f)
			Return BytesToString(payload, languageCodeLength + 1, payload.Length - 1 - languageCodeLength, encoding)
		Case Else
			Return "Unknown type: " & c
	End Select
		
End Sub

Private Sub NFC_SessionClosed
	Log("SessionClosed: " & LastException)
End Sub


#if OBJC

@end
@interface B4INFC (write)
@end
@implementation B4INFC (write)
- (void)readerSession:(NFCNDEFReaderSession *)session 
        didDetectTags:(NSArray<__kindof id<NFCNDEFTag>> *)tags {
	if (tags.count == 1) {
		NSObject* tag = tags[0];
		[session connectToTag:tag completionHandler:^(NSError* error) {
			if (error != nil)
				NSLog(@"Error %@", error);
			[B4IObjectWrapper raiseEventFromDifferentThread:self :@"_tagconnected::" :@[@(error == nil), tag]];
		}];
	}
}
- (void) checkStatus:(NSObject<NFCNDEFTag>*)tag {
	[tag queryNDEFStatusWithCompletionHandler:^(NFCNDEFStatus status, NSUInteger capacity, NSError *error) {
		if (error != nil)
				NSLog(@"Error %@", error);
		[B4IObjectWrapper raiseEventFromDifferentThread:self :@"_status:::" :@[@(error == nil), @(status), @(capacity)]];
	}];
}
- (void) read:(NSObject<NFCNDEFTag>*)tag {
	[tag readNDEFWithCompletionHandler:^(NFCNDEFMessage * msg, NSError * error) {
		B4IList* payloads = [B4IList new];
		[payloads Initialize];
		if (error != nil)
			NSLog(@"Error %@", error);
		else {
			for (NFCNDEFPayload *p in msg.records)
				[payloads Add:p];
		}
		[B4IObjectWrapper raiseEventFromDifferentThread:self :@"_tagread::" :@[@(error == nil), payloads]];
	}];
}
- (void) write:(NSObject<NFCNDEFTag>*)tag :(NFCNDEFMessage*) msg{
	[tag writeNDEF:msg completionHandler:^(NSError *error) {
		if (error != nil)
			NSLog(@"Error %@", error);
		[B4IObjectWrapper raiseEventFromDifferentThread:self :@"_writecomplete:" :@[@(error == nil)]];
	}];
}
#End If