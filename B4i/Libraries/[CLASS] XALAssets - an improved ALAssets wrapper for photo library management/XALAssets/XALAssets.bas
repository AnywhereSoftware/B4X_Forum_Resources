B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.4
@EndOfDesignText@
'************************************************************************************
'
'This class module provides control of iPhone photo library assets
'
'Features:
'
'   o Shamelessly has its origins in Narek Adonts ALAssets wrapper:
'     https://www.b4x.com/android/forum/threads/alassets-wraps-the-native-alassets-framework-photos.65231/
'
'   o Album creation and enumeration
'
'   o Photo creation, enumeration by album and retrieval as either thumbnail or full
'     size photo
'
'Methods:
'
'   Initialize
'
'   CreateAlbum - not photo or video specific
'
'   GetAlbums - not photo or video specific
'
'   GetAlbumName - not photo or video specific
'
'   GetAlbumPhotoVideoCount - not photo or video specific - NOT tested
'
'   GetPhotoVideos - not photo or video specific - NOT tested
'
'	GetPhotoVideoURL - not photo or video specific
'
'   GetPhotoVideoFromURL - not photo or video specific
'
'   SaveBitMap - is photo specific 
'
'   GetBitmap - is photo specific
'
'   SaveVideo - is video specific
'
'   GetVideo - is video specific
'
'Events:
'
'   _CreateAlbum_Result - response to CreateAlbum call
'
'   _GetAlbums_Result - response to GetAlbums call
'
'   _GetPhotoVideos_Result - response to GetPhotoVideos call - NOT tested
'
'   _GetPhotoVideoFromURL_Result - response to GetPhotoVideoFromURL call
'
'   _SaveBitMap_Result - response to SaveBitMap call
'
'   _SaveVideo_Result - response to SaveVideo call
'
'Properties:
'   
'   Returned_album_handle - available after _CreateAlbum_Result event
'	
'   Returned_album_handle_list - available after _GetAlbums_Result event
'
'   Returned_photovideo_handle - available after _GetPhotoVideoFromURL_Result event
'
'   Returned_photovideo_handle_list - available after _GetPhotoVideos_Result event - NOT tested
'
'   Returned_photo_handle - available after _SaveBitMap_Result event
'	
'   Returned_video_handle - available after _SaveVideo_Result event
'
'Requirements:
'
'   o B4i libraries:
'
'         None
'
'Photo library structure:
'
'It would appear that iPhone photo library is structured as follows (at least on an
'iPhone 5 running 10.3.3):
'
' o All actual physical photos (as suppled via MyALAssets.SaveBitmap) reside
'   in an album called [Camera Roll], regardless of what you define in Album_handle
'   parameter of MyALAssets.SaveBitmap
' o If you give an Album_handle parameter to MyALAssets.SaveBitmap that was
'   created by MyALAssets.CreateAlbum (or manually?) then that album merely holds a 
'   pointer to the actual physical photo stored in [Camera Roll]
' o So you can have a photo in multiple albums but only have one physical copy
'
'Shortcomings
'
' o Firstly note that the ALAssets framework was deprecated some time ago in favour
'   of PHAsset
' o When enumerating photos all you get are photo "handles" which you can plug into
'   various methods
'   o there is no mechanism supplied here to tie these handles back to photos origin
'     info - this might be possible via the metadata stuff but that is way beyond my
'     pay grade
'   o so for any bitmaps you put into photo library you have to maintain your own
'     "origin info" vs "photo handle" table - possibly in a Dir...
' o For some idiot reason it seems that MyALAssets.CreateAlbum can not recreate an
'   album with a name that has been previously used and subsequently deleted - but
'   you can do this manually in Photo app
'
'Update history:
'
'Version 1.0 - 20/8/17 - 1.0
'Version 2.0 - 22/8/17 - added GetPhotoVideoURL to create a URL from a photo or video
'                        "handle" (these URL are just strings and therefor can be 
'                        saved /retrieved by B4i file system) 
'                      - added GetPhotoVideoFromURL to recreate a photo or video 
'                        "handle" from its URL so photo can be accessed by its 
'                        "handle"
'Version 3.0 - 13/9/18 - extensive tidy up and broadening of several procedures from
'                        "photo" to "photovideo" 
'                      - added SaveVideo and GetVideo for saving and getting videos 
'                        to/from an album from/to a file  
'
'************************************************************************************
Private Sub Class_Globals

	Private ASAssets_Parent As Object
	Private ASAssets_Event_Name_Stub As String

	Public Returned_photovideo_handle_list, Returned_album_handle_list As List
	
	Public Returned_photovideo_handle, Returned_photo_handle, Returned_video_handle, Returned_album_handle As Object
		
	Private noMe As NativeObject = Me

End Sub

'************************************************************************************
'
'This procedure gets control when Initialize method is called by parent module
'
'Input parameters are:
'
'       XASAssets_Parent = pointer to parent module (module creating instance of this
'                          class)
'       ASAssets_ASAssets_Event_Name_Stub = event name stub
'
'Returns:
'
'       None
'
'Notes on this procedure:
'
'       o None
'
'************************************************************************************

'
'[Method] - initializes XASAssets
'
'XASAssets_Parent = pointer to parent module (module creating instance of this class)
'XASAssets_ASAssets_Event_Name_Stub = event name stub
Public Sub Initialize(XASAssets_Parent As Object, XASAssets_Event_Name_Stub As String)
    
	ASAssets_Parent = XASAssets_Parent
	ASAssets_Event_Name_Stub = XASAssets_Event_Name_Stub
	
End Sub

'************************************************************************************
'
'This procedure gets control when CreateAlbum method is called by parent module
'
'Input parameters are:
'
'       AlbumName = album name
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Creates an album
'
'************************************************************************************

'
'[Method] - creates an album, results returned via _CreateAlbum_Result event
Public Sub CreateAlbum(Album_name As String)
	
	noMe.RunMethod("createalbum:", Array(Album_name))
	
End Sub

Private Sub CreateAlbum_Result(Album_handle As Object, Status As Int)
	'Album_handle = handle of album created 
	'Status = 0 => Album_handle was created
	'       = 1 => Album_handle is Null because:
	'              o album already exists - check if in Returned_album_handle_list
	'                created by GetAlbums
	'              o album has previously existed but has been deleted - this code
	'                does not appear to be able to recreate it - but it can be 
	'                created manually
	'       = 2 => Album_handle is Null for some low level reason (see log)
	
	'Save handle of album created
	Returned_album_handle = Album_handle
	
	CallSub2(ASAssets_Parent, ASAssets_Event_Name_Stub & "_CreateAlbum_Result", Status)
	
End Sub

'************************************************************************************
'
'This procedure gets control when GetAlbums method is called by parent module
'
'Input parameters are:
'
'       None
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Enumerates all albums
'
'************************************************************************************

'
'[Method] - enumerates all albums, results returned via _GetAlbums_Result event
Public Sub GetAlbums
	
	noMe.RunMethod("getalbums", Null)
	
End Sub

Private Sub GetAlbums_Result(Album_handles As Object, Status As Int)
	'Album_handles = list of handles of albums
	'Status = 0 => Album_handles was created
	'       = 1 => Album_handles is Null for some low level reason (see log)

	If Status = 0 Then

		'Save album handle list
		Private wrk_no As NativeObject = Album_handles
		Returned_album_handle_list = wrk_no

		wrk_no = Null

	End If

	CallSub2(ASAssets_Parent, ASAssets_Event_Name_Stub & "_GetAlbums_Result", Status)

End Sub

'************************************************************************************
'
'This procedure gets control when GetAlbumName method is called by parent module
'
'Input parameters are:
'
'       Album_handle = handle of album
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Returns name of supplied album handle
'
'************************************************************************************

'
'[Method] - returns name of supplied album handle
Public Sub GetAlbumName(Album_handle As Object) As String
	
	'Convert album handle to string
	Private wrk_str As String = Album_handle
	
	Return wrk_str.SubString2(wrk_str.IndexOf("Name") + 5, wrk_str.IndexOf2(",", wrk_str.IndexOf("Name") + 5))
	
End Sub

'************************************************************************************
'
'This procedure gets control when GetAlbumPhotoVideoCount method is called by parent 
'module
'
'Input parameters are:
'
'       Album_handle = handle of album created
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Returns photo+video count of supplied album handle
'
'************************************************************************************

'
'[Method] - returns photo+video count of supplied album handle
Public Sub GetAlbumPhotoVideoCount(Album_handle As Object) As Int
	
	'Convert album handle to string
	Private wrk_str As String = Album_handle
	
	Return wrk_str.SubString(wrk_str.IndexOf("count") + 6)

End Sub

'************************************************************************************
'
'This procedure gets control when GetPhotoVideos method is called by parent module
'
'Input parameters are:
'
'       Album_handle = handle of album
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Enumerates all photos in album
'
'************************************************************************************

'
'[Method] - enumerates all photos in album, results returned via _GetPhotoVideos_Result event
Public Sub GetPhotoVideos(Album_handle As Object)
	
	noMe.RunMethod("getphotovideos:", Array(Album_handle))
	
End Sub

Private Sub GetPhotoVideos_Result(PhotoVideo_handles As Object, Status As Int)
	'Photo_handles = list of handles of photos in album
	'Status = 0 => Photo_handles was created
	'       = 1 => Photo_handles is Null for some low level reason (see log)

	If Status = 0 Then

		'Save photo handle list
		Private wrk_no As NativeObject = PhotoVideo_handles
		Returned_photovideo_handle_list = wrk_no

		wrk_no = Null

	End If

	CallSub2(ASAssets_Parent, ASAssets_Event_Name_Stub & "_GetPhotoVideos_Result", Status)

End Sub

'************************************************************************************
'
'This procedure gets control when GetPhotoVideoURL method is called by parent module
'
'Input parameters are:
'
'       PhotoVideo_handle = handle of photo or video
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Returns URL of photo or video with supplied handle
'
'************************************************************************************

'
'[Method] - returns URL of photo or video with supplied handle
Public Sub GetPhotoVideoURL(PhotoVideo_handle As Object) As String
	
	'Convert photo or video handle to string
	Private wrk_str As String = PhotoVideo_handle
	
	If wrk_str.ToLowerCase.IndexOf("&ext=jpg") > -1 Then
	
		Return wrk_str.SubString2(wrk_str.IndexOf("assets-library"), wrk_str.ToLowerCase.IndexOf("&ext=jpg") + 8)

	Else If wrk_str.ToLowerCase.IndexOf("&ext=mp4") > -1 Then
	
		Return wrk_str.SubString2(wrk_str.IndexOf("assets-library"), wrk_str.ToLowerCase.IndexOf("&ext=mp4") + 8)

'	Else If wrk_str.ToLowerCase.IndexOf("&ext=mov") > -1 Then
'	
'		Return wrk_str.SubString2(wrk_str.IndexOf("assets-library"), wrk_str.ToLowerCase.IndexOf("&ext=mov") + 8)

	Else
		
		Return ""
		
	End If
		
End Sub

'************************************************************************************
'
'This procedure gets control when GetPhotoVideoFromURL method is called by parent 
'module
'
'Input parameters are:
'
'       PhotoVideo_URL = handle of photo or video
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Returns handle of photo or video with supplied URL
'
'************************************************************************************

'
'[Method] - finds handle of photo or video with supplied URL, results returned via _GetPhotoVideoFromURL_Result event
Public Sub GetPhotoVideoFromURL(PhotoVideo_URL As String)
	
	noMe.RunMethod("getphotovideofromurl:", Array(PhotoVideo_URL))
	
End Sub

Private Sub GetPhotoVideoFromURL_Result(PhotoVideo_handle As Object, Status As Int)
	'Photo_handle = handle of photo
	'Status = 0 => Photo_handle was created
	'       = 1 => Photo_handle is Null for some low level reason (see log)

	If Status = 0 Then

		'Save photo handle
		Private wrk_no As NativeObject = PhotoVideo_handle
		Returned_photovideo_handle = wrk_no

		wrk_no = Null

	End If

	CallSub2(ASAssets_Parent, ASAssets_Event_Name_Stub & "_GetPhotoVideoFromURL_Result", Status)

End Sub

'************************************************************************************
'
'This procedure gets control when SaveBitmap method is called by parent module
'
'Input parameters are:
'
'       Album_handle = handle of album
'       Image = bitmap
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Saves bitmap as photo in album
'
'************************************************************************************

'
'[Method] - saves bitmap as photo in album, results returned via _SaveBitmap_Result event
Public Sub SaveBitmap(Album_handle As Object, Image As Bitmap)

	noMe.RunMethod("savebitmap::", Array(Album_handle, Image))
	
End Sub

Private Sub SaveBitmap_Result(Photo_handle As Object, Status As Int)
	'Photo_handle = handle of photo just saved in album
	'Status = 0 => bitmap saved, Photo_handle was created
	'       = 1 => bitmap saved, Photo_handle is Null for some low level reason (see
	'              log)
	'       = 2 => bitmap not saved, Photo_handle is Null for some low level reason
	'              (see log)
	
	'Save photo handle
	Returned_photo_handle = Photo_handle
	
	CallSub2(ASAssets_Parent, ASAssets_Event_Name_Stub & "_SaveBitmap_Result", Status)
	
End Sub

'************************************************************************************
'
'This procedure gets control when GetBitmap method is called by parent module
'
'Input parameters are:
'
'       Photo_handle = handle of photo
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Returns bitmap of supplied photo handle
'
'************************************************************************************

'
'[Method] - returns bitmap of supplied photo handle
Public Sub GetBitmap(Photo_handle As Object) As Bitmap
	
	Return noMe.RunMethod("getbitmap:", Array(Photo_handle))

End Sub

'************************************************************************************
'
'This procedure gets control when SaveVideo method is called by parent module
'
'Input parameters are:
'
'       Album_handle = handle of album
'       Path = path to video on storage
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Saves video at defined path as video in album
'
'************************************************************************************

'
'[Method] - saves video at defined path as video in album, results returned via _SaveVideo_Result event
Public Sub SaveVideo(Album_handle As Object, Path As String)

	noMe.RunMethod("savevideo::", Array(Album_handle, Path))
	
End Sub

Private Sub SaveVideo_Result(Video_handle As Object, Status As Int)
	'Video_handle = handle of video just saved in album
	'Status = 0 => video saved, Video_handle was created
	'       = 1 => video saved, Video_handle is Null for some low level reason (see
	'              log)
	'       = 2 => video not saved, Video_handle is Null for some low level reason
	'              (see log)
	
	'Save video handle
	Returned_video_handle = Video_handle
	
	CallSub2(ASAssets_Parent, ASAssets_Event_Name_Stub & "_SaveVideo_Result", Status)
	
End Sub

'************************************************************************************
'
'This procedure gets control when GetVideo method is called by parent module
'
'Input parameters are:
'
'       Video_handle = handle of video
'       Path = path to video on storage
'
'Returns:
'
'       -
'
'Notes on this procedure:
'
'       o Returns video of supplied video handle to defined path
'
'************************************************************************************

'
'[Method] - returns video of supplied video handle to defined path
Public Sub GetVideo(Video_handle As Object, Path As String) 
Log(Video_handle)
Log(Path)
Log(" ")	
	noMe.RunMethod("getvideo::", Array(Video_handle, Path))

End Sub

''************************************************************************************
''
''This procedure gets control when GetThumbForPhoto method is called by parent module
''
''Input parameters are:
''
''       Photo_handle = handle of photo
''
''Returns:
''
''       -
''
''Notes on this procedure:
''
''       o Returns thumb bitmap of supplied photo handle
''
''************************************************************************************
'
''
''[Method] - returns thumb bitmap of supplied photo handle
'Public Sub GetThumb(Photo_handle As Object) As Bitmap
'	
'	Return noMe.RunMethod("getthumb:", Array(Photo_handle))
'
'End Sub

#If OBJC

#import <AssetsLibrary/AssetsLibrary.h>

/////////////////////////////////////////////////////////////////////////////////////

-(void)createalbum :(NSString*) albumname 
{
    ALAssetsLibrary *library = [self defaultAssetsLibrary];
    [library addAssetsGroupAlbumWithName:albumname 
        resultBlock:^(ALAssetsGroup* albumhandle) {
		    if(albumhandle != nil) {
	 			[self.bi raiseEvent:nil event:@"createalbum_result::" params:@[(albumhandle), @0]];
		    } else {
			    [self.bi raiseEvent:nil event:@"createalbum_result::" params:@[([NSNull null]), @1]];
		    }
        }
        failureBlock:^(NSError* error) {
        	NSLog(@"CREATEALBUM ERROR\nerror code %i\n%@", error.code, [error localizedDescription]);
		    [self.bi raiseEvent:nil event:@"createalbum_result::" params:@[([NSNull null]), @2]];
        }
    ];
}

/////////////////////////////////////////////////////////////////////////////////////

-(void)getalbums
{
	dispatch_group_t loadingGroup = dispatch_group_create();
	NSMutableArray * albums = [[NSMutableArray array] init];

void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *albumhandle, BOOL *stop) 
{
    if(albumhandle != nil) {
        [albums addObject: albumhandle];
    } else {
        dispatch_group_notify(loadingGroup, dispatch_get_main_queue(), ^{
	 		[self.bi raiseEvent:nil event:@"getalbums_result::" params:@[(albums), @0]];
        });
    }
};

ALAssetsLibrary * library=[self defaultAssetsLibrary];
    [library enumerateGroupsWithTypes: ALAssetsGroupAll
        usingBlock:assetGroupEnumerator
        failureBlock: ^(NSError *error) {
    	NSLog(@"GETALBUMS ERROR\nerror code %i\n%@", error.code, [error localizedDescription]);
	    [self.bi raiseEvent:nil event:@"getalbums_result::" params:@[([NSNull null]), @1]];
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

//I suspect there is a much neater way to do this but I am at the limit of my
//Objective C skills (about the same level as Swahili)

-(void)getphotovideos :(ALAssetsGroup*) albumhandle
{
	dispatch_group_t loadingGroup = dispatch_group_create();
	NSMutableArray * photovideos = [[NSMutableArray array] init];
	NSMutableArray * albums = [[NSMutableArray array] init];

void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *asset, NSUInteger index, BOOL *stop) 
{
    if(index != NSNotFound) {
		if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
		   [photovideos addObject:asset];
		} 
		if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
		   [photovideos addObject:asset];
		} 
		dispatch_async(dispatch_get_main_queue(), ^{ });
    } else {
        dispatch_group_leave(loadingGroup);
    }
};

void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *albumhandle, BOOL *stop) 
{
    if(albumhandle != nil) {
        [albums addObject: albumhandle];
    } else {
        for (ALAssetsGroup * album in albums) {
            if([album valueForProperty:ALAssetsGroupPropertyName] == [albumhandle valueForProperty:ALAssetsGroupPropertyName]) {
				dispatch_group_enter(loadingGroup);
	            [album enumerateAssetsUsingBlock: assetEnumerator];
			}
        }
        dispatch_group_notify(loadingGroup, dispatch_get_main_queue(), ^{
	 		[self.bi raiseEvent:nil event:@"getphotovideos_result::" params:@[(photovideos), @0]];
        });
    }
};

ALAssetsLibrary * library=[self defaultAssetsLibrary];
    [library enumerateGroupsWithTypes: ALAssetsGroupAll
        usingBlock:assetGroupEnumerator
        failureBlock: ^(NSError *error) {
    	NSLog(@"GETPHOTOVIDEOS ERROR\nerror code %i\n%@", error.code, [error localizedDescription]);
	    [self.bi raiseEvent:nil event:@"getphotovideos_result::" params:@[([NSNull null]), @1]];
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

-(void)getphotovideofromurl :(NSString*) photovideourlstring
{
    NSURL *photovideourl = [NSURL URLWithString:photovideourlstring];
	ALAssetsLibrary *library = [self defaultAssetsLibrary];
    [library assetForURL:photovideourl
        resultBlock:^(ALAsset* asset) {
		    if(asset != nil) {
	 			[self.bi raiseEvent:nil event:@"getphotovideofromurl_result::" params:@[(asset), @0]];
		    } else {
			    [self.bi raiseEvent:nil event:@"getphotovideofromurl_result::" params:@[([NSNull null]), @1]];
		    }
        }
        failureBlock:^(NSError* error) {
        	NSLog(@"GETPHOTOVIDEOFROMURL ERROR\nerror code %i\n%@", error.code, [error localizedDescription]);
		    [self.bi raiseEvent:nil event:@"getphotovideofromurl_result::" params:@[([NSNull null]), @2]];
        }
    ];
}

/////////////////////////////////////////////////////////////////////////////////////

-(void)savebitmap :(ALAssetsGroup*) albumhandle :(UIImage*) image
{
    CGImageRef img = [image CGImage];
	ALAssetsLibrary *library = [self defaultAssetsLibrary];
	[library writeImageToSavedPhotosAlbum:img 
                                  metadata:nil
                           completionBlock:^(NSURL* assetURL, NSError* error) {
	    if (error.code == 0) {
			 ALAssetsLibrary *library = [self defaultAssetsLibrary];
	         [library assetForURL:assetURL
	                       resultBlock:^(ALAsset* asset) {
	              [albumhandle addAsset:asset];
				  [self.bi raiseEvent:nil event:@"savebitmap_result::" params:@[(asset), @0]];
	         }
	                      failureBlock:^(NSError* error) {
    	          NSLog(@"SAVEBITMAP ERROR - failed to retrieve photo handle\nerror code %i\n%@", error.code, [error localizedDescription]);
				  [self.bi raiseEvent:nil event:@"savebitmap_result::" params:@[([NSNull null]), @1]];
	         }];
	    }
	    else {
			NSLog(@"SAVEBITMAP ERROR - failed to save bitmap\nerror code %i\n%@", error.code, [error localizedDescription]);
		    [self.bi raiseEvent:nil event:@"savebitmap_result::" params:@[([NSNull null]), @2]];
	    }
	}];
}

/////////////////////////////////////////////////////////////////////////////////////

-(UIImage*)getbitmap :(ALAsset*) photo
{  
    ALAssetRepresentation *defaultRep = [photo defaultRepresentation];
    UIImage *_image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
	return _image;
}

/////////////////////////////////////////////////////////////////////////////////////

-(void)savevideo :(ALAssetsGroup*) albumhandle :(NSString*) path
{
    ALAssetsLibrary *library = [self defaultAssetsLibrary];
    [library writeVideoAtPathToSavedPhotosAlbum:[NSURL URLWithString:path] 
                           completionBlock:^(NSURL *assetURL, NSError *error) {
	    if (error.code == 0) {
			 ALAssetsLibrary *library = [self defaultAssetsLibrary];
	         [library assetForURL:assetURL
	                       resultBlock:^(ALAsset* asset) {
	              [albumhandle addAsset:asset];
				  [self.bi raiseEvent:nil event:@"savevideo_result::" params:@[(asset), @0]];
	         }
	                      failureBlock:^(NSError* error) {
    	          NSLog(@"SAVEVIDEO ERROR - failed to retrieve video handle\nerror code %i\n%@", error.code, [error localizedDescription]);
				  [self.bi raiseEvent:nil event:@"savevideo_result::" params:@[([NSNull null]), @1]];
	         }];
	    }
	    else {
			NSLog(@"SAVEVIDEO ERROR - failed to save video\nerror code %i\n%@", error.code, [error localizedDescription]);
		    [self.bi raiseEvent:nil event:@"savevideo_result::" params:@[([NSNull null]), @2]];
	    }
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

-(void)getvideo :(ALAsset*) video :(NSString*) path
{  
    ALAssetRepresentation *defaultRep = [video defaultRepresentation];
    long long length = [defaultRep size];
	
    NSFileHandle *file = [NSFileHandle fileHandleForWritingAtPath:path];

    if(file == nil) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        file = [NSFileHandle fileHandleForWritingAtPath:path];
    }
	
    NSUInteger chunkSize = 100 * 1024;
    uint8_t *buffer = malloc(chunkSize * sizeof(uint8_t));
    NSUInteger offset = 0;

    do {
        NSUInteger bytesCopied = [defaultRep getBytes:buffer fromOffset:offset length:chunkSize error:nil];
        offset += bytesCopied;
        NSData *data = [[NSData alloc] initWithBytes:buffer length:bytesCopied];
        [file writeData:data];
        } while (offset < length);

    [file closeFile];
    free(buffer);
    buffer = NULL;
	
}

/////////////////////////////////////////////////////////////////////////////////////

-(ALAssetsLibrary*) defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library; 
}

/////////////////////////////////////////////////////////////////////////////////////

//-(UIImage*)getthumb :(ALAsset*) photo
//{
//    UIImage* _image = [UIImage imageWithCGImage:photo.thumbnail];
//    return _image;
//}


#End If