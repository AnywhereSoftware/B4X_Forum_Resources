
#import <Foundation/Foundation.h>
#import <CoreNFC/CoreNFC.h>
#import "iCore.h"

@class B4I;

//~event: TagDetected (Messages As List)
//~event: SessionClosed
//~dependson: CoreNFC.framework
//~shortname: NFC
@interface B4INFC : NSObject<NFCNDEFReaderSessionDelegate>
- (void)Initialize:(B4I *)bi :(NSString *)EventName;
/**
 * Starts a scan session. The SessionClosed event will be raised when the session is closed.
 *Message - The dialog message.
 */
- (void)Scan:(NSString *)Message;
//Stops scanning.
- (void)StopScan;
//Returns true if NFC is supported.
@property (nonatomic, readonly)BOOL Supported;
@end


//~shortname: NdefRecord
//~objectwrapper: NFCNDEFPayload*
@interface B4INdefRecord : B4IObjectWrapper
@property (nonatomic, readonly)int FORMAT_Empty;
@property (nonatomic, readonly)int FORMAT_NFCWellKnown;
@property (nonatomic, readonly)int FORMAT_Media;
@property (nonatomic, readonly)int FORMAT_AbsoluteURI;
@property (nonatomic, readonly)int FORMAT_NFCExternal;
@property (nonatomic, readonly)int FORMAT_Unknown;
@property (nonatomic, readonly)int FORMAT_Unchanged;
//Returns the record payload.
- (B4IArray */*unsigned char,1*/)GetPayload;
//Returns the record type. One of the FORMAT constants.
@property (nonatomic, readonly)int RecordType;
//Returns the known type field.
- (B4IArray */*unsigned char,1*/)GetKnownType;
@end
