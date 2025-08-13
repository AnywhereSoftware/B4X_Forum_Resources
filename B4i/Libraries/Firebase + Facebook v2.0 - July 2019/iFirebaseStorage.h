

#import <Foundation/Foundation.h>
#import "iCore.h"

//~dependson: GTMSessionFetcher.framework.3
//~dependson: FirebaseStorage.framework.3
//~shortname: FirebaseStorage
//~version: 2.00
//~event: UploadCompleted (ServerPath As String, Success As Boolean)
//~event: DownloadCompleted (ServerPath As String, Success As Boolean)
//~event: MetadataCompleted (Metadata As StorageMetadata, Success As Boolean)
//~event: DeleteCompleted (ServerPath As String, Success As Boolean)
//~event: DownloadUrlAvailable (ServerPath As String, Success As Boolean, Url As String)
@interface iFirebaseStorage : NSObject
/**
 * Initializes the object.
 *Bucket - The url from Firebase console (ex: gs://yourapp.appspot.com)
 */
- (void)Initialize:(NSString *)EventName :(NSString *)Bucket;
/**
 * Reads the data from the file and uploads it to the specified ServerPath.
 * The UploadCompleted event will be raised on the current module.
 */
- (void)UploadFile:(B4I *)bi :(NSString *)Dir :(NSString *)FileName :(NSString *)ServerPath;
/**
 * Downloads the remote resource and writes it to the specified file.
 * The DownloadCompleted event will be raised in the current module.
 */
- (void)DownloadFile:(B4I *)bi :(NSString *)ServerPath :(NSString *)Dir :(NSString *)FileName;
//Retrieves the metadata of the remote resource. The MetadataCompleted event will be raised in the current module.
- (void)GetMetadata:(B4I*)bi :(NSString *)ServerPath;
//Deletes the remote resource. The DeleteCompleted event will be raised in the current module.
- (void)DeleteFile:(B4I *)bi :(NSString *)ServerPath;
//Gets a shareable url. The DownloadUrlAvailable event will be raised in the current module.
- (void)GetDownloadUrl:(B4I *)bi :(NSString *)ServerPath;
@end

//~Shortname: StorageMetadata
//~ObjectWrapper: FIRStorageMetadata*
@interface B4IStorageMetadata : B4IObjectWrapper
//Returns the resource size in bytes.
@property (nonatomic, readonly) long long Size;
//Returns the last updated time as ticks. This method will throw an exception if the value is not available.
@property (nonatomic, readonly) long long Timestamp;
//Returns the resource name.
@property (nonatomic, readonly)NSString *Name;
//Returns the resource path.
@property (nonatomic, readonly)NSString *Path;
@end
