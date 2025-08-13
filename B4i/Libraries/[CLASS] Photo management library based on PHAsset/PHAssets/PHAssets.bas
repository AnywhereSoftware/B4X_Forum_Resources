B4i=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=5
@EndOfDesignText@
'************************************************************************************
'
'This class module provides control of iPhone photo library assets via PhotoKit
'
'Features:
'
'   o Objective C and basic architecture of this class provided by Narek Adonts
'
'   o Album creation, enumeration, deletion
'
'   o Photo creation, enumeration by album and retrieval as full size photo
'
'   o Video creation, enumeration by album and retrieval
'
'Methods:
'
'   Initialize
'
'   PermissionGet
'
'   SmartAlbumsGet - get all 'smart' albums and contents
'
'   UserAlbumsGet - get all 'user' albums and contents
'
'   UserAlbumAdd - add a user album by its name
'
'   UserAlbumExists - check if a user album exists by its name
'
'   UserAlbumDelete - delete a user album by its name
'
'   PhotoAdd - add a photo as bitmap to a user album by its name - returns saved photos GUID
'
'   PhotoGet - get a photo as bitmap by its GUID
'
'   VideoAdd - add a video to a user album by its name - returns saved videos GUID
'
'   VideoGet - get a video by its GUID
'
'   AssetExists - check if photo or video exists by its GUID
'
'   AssetDelete - delete a photo or video by its GUID
'
'Events:
'
'   _PermissionGet_done - response to PermissionGet call
'
'   _SmartAlbumsGet_done - response to SmartAlbumsGet call
'
'   _UserAlbumsGet_done - response to UserAlbumsGet call
'
'   _UserAlbumAdd_done - response to UserAlbumAdd call
'
'   _UserAlbumExists_done - response to UserAlbumExists call
'
'   _UserAlbumDelete_done - response to UserAlbumDelete call
'
'   _BitMapAdd_done - response to BitMapAdd call
'
'   _BitMapGet_done - response to BitMapGet call
'
'   _VideoAdd_done - response to VideoAdd call
'
'   _VideoGet_done - response to VideoGet call
'
'   _AssetExists_done - response to AssetExists call
'
'   _AssetDelete_done - response to AssetDelete call
'
'Properties:
'   
'   PermissionGet_result - available after _PermissionGet_done event
'                        - Boolean (True = permission given)
'   
'   PermissionGet_status - available after _PermissionGet_done event
'                        - Integer
'                              0 = not determined (user permission is required
'                                  for photo library access but user has not 
'                                  yet granted or denied such permission)
'                              1 = restricted (app is not authorized to access
'                                  photo library and user cannot grant such
'                                  permission)
'                              2 = denied (user has explicitly denied app access
'                                  to photo library)
'                              3 = authorized (user has explicitly granted app
'                                  access to photo library)
'	
'   SmartAlbumsGet_result - available after _SmartAlbumsGet_done event
'                         - list of PHAlbums 
'                         - if SmartAlbumsGet_result.IsInitialized = True - call successful
'	
'   UserAlbumsGet_result - available after _UserAlbumsGet_done event
'                        - list of PHAlbums 
'                        - if UserAlbumsGet_result.IsInitialized = True - call successful
'
'   UserAlbumAdd_result - available after _UserAlbumAdd_done event
'                       - Boolean (True = user album added/already exists)
'
'   UserAlbumExists_result - available after _UserAlbumExists_done event
'                          - Boolean (True = user album exists)
'
'   UserAlbumDelete_result - available after _UserAlbumDelete_done event
'                          - Boolean (True = user album deleted/did not exist)
'
'   PhotoAdd_result - available after _PhotoAdd_done event
'                   - String, GUID by which photo can be accessed forever 
'                   - if PhotoAdd_result = "" - call not successful
'
'   PhotoGet_result - available after _PhotoGet_done event
'                   - Bitmap
'                   - if PhotoGet_result.IsInitialized = True - call successful
'
'   VideoAdd_result - available after _VideoAdd_done event
'                   - String, GUID by which video can be accessed forever 
'                   - if VideoAdd_result = "" - call not successful
'
'   VideoGet_result - available after _VideoGet_done event
'                   - Boolean (True = video got)
'	
'   AssetExists_result - available after _AssetExists_done event
'                      - Boolean (True = asset exists)
'	
'   AssetDelete_result - available after _AssetDelete_done event
'                      - Boolean (True = asset deleted/did not exist)
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
' o Albums are of 2 types:
'     o 'Smart' albums are ones which are created by iOS that you can not create/
'       delete either via the Photos app or code such as this
'     o 'User' albums are ones which you can create/delete either via the Photos
'       app or code such as this
' o When you call BitMapAdd or similar, physical assets (photos, videos) are saved 
'   in a 'smart' album called [All Photos], and a pointer to this actual physical
'   photo is saved in user album nominated in BitMapAdd call
' o When enumerating assets (photos, videos) all you get for identification are asset 
'   GUIDs which you can plug into various methods
'   o there is no mechanism supplied here to tie these GUIDs back to photos origin
'     info
'   o so for any bitmaps you put into photo library you have to maintain your own
'     "origin info" vs GUIDs table - possibly in a Dir...
'
'Update history:
'
'Version 1.0 - 17/4/19 - 1.0
'        2.0 - 18/3/25 - 2.0 - complete revision courtesy of MS Copilot rework of
'                              objective c code
'
'************************************************************************************
Private Sub Class_Globals
	
	Public PermissionGet_result As Boolean
	Public PermissionGet_status As Int
	Public SmartAlbumsGet_result As List
	Public UserAlbumsGet_result As List
	Public UserAlbumExists_result As Boolean
	Public UserAlbumAdd_result As Boolean
	Public UserAlbumDelete_result As Boolean
	Public PhotoAdd_result As String
	Public PhotoGet_result As Bitmap
	Public VideoAdd_result  As String
	Public VideoGet_result As Boolean
	Public AssetExists_result As Boolean
	Public AssetDelete_result As Boolean
	
	Private UserAlbumFind_result As NativeObject
	Private AssetFind_result As NativeObject
	
	'For meaning of each flag, see:
	'https://developer.apple.com/documentation/photokit/phassetcollectionsubtype?language=objc
	Public PHAssetCollectionSubtypeAny As Int = 0
	Public PHAssetCollectionSubtypeAlbumRegular As Int = 2
	Public PHAssetCollectionSubtypeAlbumSyncedEvent As Int = 3
	Public PHAssetCollectionSubtypeAlbumSyncedFaces As Int = 4
	Public PHAssetCollectionSubtypeAlbumSyncedAlbum As Int = 5
	Public PHAssetCollectionSubtypeAlbumImported As Int = 6
	Public PHAssetCollectionSubtypeAlbumMyPhotoStream As Int = 100
	Public PHAssetCollectionSubtypeAlbumCloudShared As Int = 101
	Public PHAssetCollectionSubtypeSmartAlbumGeneric As Int = 200
	Public PHAssetCollectionSubtypeSmartAlbumPanoramas As Int = 201
	Public PHAssetCollectionSubtypeSmartAlbumVideos As Int = 202
	Public PHAssetCollectionSubtypeSmartAlbumFavorites As Int = 203
	Public PHAssetCollectionSubtypeSmartAlbumTimelapses As Int = 204
	Public PHAssetCollectionSubtypeSmartAlbumAllHidden As Int = 205
	Public PHAssetCollectionSubtypeSmartAlbumRecentlyAdded As Int = 206
	Public PHAssetCollectionSubtypeSmartAlbumBursts As Int = 207
	Public PHAssetCollectionSubtypeSmartAlbumSlomoVideos As Int = 208
	Public PHAssetCollectionSubtypeSmartAlbumUserLibrary As Int = 209
	Public PHAssetCollectionSubtypeSmartAlbumSelfPortraits As Int = 210
	Public PHAssetCollectionSubtypeSmartAlbumScreenshots As Int = 211
	Public PHAssetCollectionSubtypeSmartAlbumDepthEffect As Int = 212
	Public PHAssetCollectionSubtypeSmartAlbumLivePhotos As Int = 213
	Public PHAssetCollectionSubtypeSmartAlbumAnimated As Int = 214
	Public PHAssetCollectionSubtypeSmartAlbumLongExposures As Int = 215
	
	Type PHAlbum(Name As String, PHAssetsList As List, iOS_Album As Object)
	Type PHAsset(GUID As String, Width As Float, Height As Float, isVideo As Boolean, Duration As Float, iOS_Asset As Object)

End Sub

'************************************************************************************
'
'This procedure gets control when Initialize method is called by parent module
'
'Input parameters are:
'
'       Handler = pointer to parent module (module creating instance of this class)
'       Event_Name_Stub = event name stub
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
'[Method] - initializes PHAssets
'
'Handler = pointer to parent module (module creating instance of this class)
'Eventnamestub = event name stub
Public Sub Initialize
	
	SmartAlbumsGet_result.Initialize
	UserAlbumsGet_result.Initialize
	
End Sub

'************************************************************************************
'
'This procedure gets control when PermissionGet method is called by parent module
'
'Input parameters are:
'
'       Ask = flag to indicate if permission is to be asked for if current 
'             authorization status is 0 (not determined)
'
'Returns:
'
'       PermissionGet_result = Boolean (True = permission given)
'       PermissionGet_status = Integer
'                              0 = not determined (user permission is required
'                                  for photo library access but user has not 
'                                  yet granted or denied such permission)
'                              1 = restricted (app is not authorized to access
'                                  photo library and user cannot grant such
'                                  permission)
'                              2 = denied (user has explicitly denied app access
'                                  to photo library)
'                              3 = authorized (user has explicitly granted app
'                                  access to photo library)
'
'Notes on this procedure:
'
'       o Attempts to get appropriate permisions
'
'************************************************************************************

'
'[Method] - attempts to get appropriate permissions, results returned in PermissionGet_result, after _PermissionGet_done event
Public Sub PermissionGet (Ask As Boolean) As ResumableSub
	
	'Get current authorization status
	Private wrk_no As NativeObject
	Private wrk_status As Int = wrk_no.Initialize("PHPhotoLibrary").RunMethod("authorizationStatus", Null).AsNumber

	'Possible authorization status values (PermissionGet_status) are:
	'   0 = not determined (user permission is required for photo library access but
	'       user has not yet granted or denied such permission)
	'   1 = restricted (app is not authorized to access photo library and user cannot 
	'       grant such permission)
	'   2 = denied (user has explicitly denied app access to photo library)
	'   3 = authorized (user has explicitly granted app access to photo library)

	PermissionGet_status = wrk_status

	'If authorization status is not determined...
	If wrk_status = 0 Then
		
		If Ask Then
		
			'Prompt user for authorization
			Private wrk_no As NativeObject = Me
			wrk_no.RunMethod("objc_requestpermission", Null)
			Wait For objc_requestpermission_done(wrk_status As Int)
		
			'Set permission result
			PermissionGet_result = (wrk_status = 3)

			PermissionGet_status = wrk_status
		
		End If
	
	'Otherwise, if authorization status is already authorized...
	Else If wrk_status = 3 Then
		
		PermissionGet_result = True
	
	'Otherwise, if authorization is denied...
	Else If wrk_status = 2 Then
		
		'You can not reverse this via another go at prompting user, you have to 
		'resort to directing user to settings for app
		PermissionGet_result = False
		
	'Otherwise authorization is restricted...
	Else
		
		'You are out of luck
		PermissionGet_result = False
		
	End If
	
	Return True
	
End Sub

'************************************************************************************
'
'This procedure gets control when SmartAlbumsGet method is called by parent module
'
'Input parameters are:
'
'       iOS_Albumtype = one of PHAssetCollectionSubtypeSmartAlbum... or 
'                       PHAssetCollectionSubtypeAny
'
'Returns:
'
'       SmartAlbumsGet_result = list of PHAlbums 
'       if SmartAlbumsGet_result.IsInitialized = True - call successful
'
'Notes on this procedure:
'
'       o Enumerates all 'smart' albums
'
'************************************************************************************

'
'[Method] - enumerates all 'smart' albums, results returned in SmartAlbumsGet_result after _SmartAlbumsGet_done event
Public Sub SmartAlbumsGet(iOS_Albumtype As Int) As ResumableSub

	'Clear any previous results of this subroutine
	SmartAlbumsGet_result.Clear
	
	'If supplied iOS_Albumtype is valid...
	If iOS_Albumtype = PHAssetCollectionSubtypeAny Or iOS_Albumtype >= PHAssetCollectionSubtypeSmartAlbumGeneric Then

		'Get iOS list of 'smart' iOS albums
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_listsmartalbums:", Array(iOS_Albumtype))
		Wait For objc_listsmartalbums_done(wrk_obj As Object)

		'Convert iOS list of 'smart' iOS albums into B4i list
		Private wrk_no As NativeObject = wrk_obj
		Private wrk_ios_albums As List = wrk_no

		Private wrk_no As NativeObject = Me
		Private wrk_i As Int
		
		'For each 'smart' iOS album...
		For wrk_i = 0 To wrk_ios_albums.Size - 1
			
			'Get list of iOS assets
			wrk_no.RunMethod("objc_listalbumassets:", Array(wrk_ios_albums.Get(wrk_i)))
			Wait For objc_listalbumassets_done(wrk_obj As Object)
			
			'Convert iOS list of iOS assets into B4i list
			Private wrk_no2 As NativeObject = wrk_obj
			Private wrk_ios_assets As List = wrk_no2
			
			'Flesh out 'smart' album as a PHAlbum
			SmartAlbumsGet_result.Add(BuildPHAlbum(wrk_ios_albums.Get(wrk_i), wrk_ios_assets))
		
		Next
	
	End If

	Return True

End Sub

'************************************************************************************
'
'This procedure gets control when UserAlbumsGet method is called by parent module
'
'Input parameters are:
'
'       iOS_Albumtype = one of PHAssetCollectionSubtypeAlbum... or 
'                       PHAssetCollectionSubtypeAny
'
'Returns:
'
'       UserAlbumsGet_result = list of PHAlbums 
'       if UserAlbumsGet_result.IsInitialized = True - call successful
'
'Notes on this procedure:
'
'       o Enumerates all 'user' albums
'
'************************************************************************************

'
'[Method] - enumerates all 'user' albums, results returned in UserAlbumsGet_result after _UserAlbumsGet_done event
Public Sub UserAlbumsGet(iOS_Albumtype As Int) As ResumableSub

	'Clear any previous results of this subroutine
	UserAlbumsGet_result.Clear

	'If supplied iOS_Albumtype is valid...
	If iOS_Albumtype < PHAssetCollectionSubtypeSmartAlbumGeneric Then
		
		'Get iOS list of 'user' iOS albums
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_listuseralbums:", Array(iOS_Albumtype))
		Wait For objc_listuseralbums_done(wrk_obj As Object)

		'Convert iOS list of 'user' iOS albums into B4i list
		Private wrk_no As NativeObject = wrk_obj
		Private wrk_ios_albums As List = wrk_no

		Private wrk_no As NativeObject = Me
		Private wrk_i As Int

		'For each 'user' iOS album...
		For wrk_i = 0 To wrk_ios_albums.Size - 1
			
			'Get list of iOS assets
			wrk_no.RunMethod("objc_listalbumassets:", Array(wrk_ios_albums.Get(wrk_i)))
			Wait For objc_listalbumassets_done(wrk_obj As Object)

			'Convert list of iOS assets into B4i list
			Private wrk_no2 As NativeObject = wrk_obj
			Private wrk_ios_assets As List = wrk_no2

			'Flesh out 'user' album as a PHAlbum
			UserAlbumsGet_result.Add(BuildPHAlbum(wrk_ios_albums.Get(wrk_i), wrk_ios_assets))

		Next

	End If
	
	Return True
	
End Sub

'************************************************************************************
'
'This procedure gets control when UserAlbumAdd method is called by parent module
'
'Input parameters are:
'
'       Albumname = 'user' album name
'
'Returns:
'
'       UserAlbumAdd_result = Boolean (True = user album added)
'
'Notes on this procedure:
'
'       o Adds a 'user' album
'
'************************************************************************************

'
'[Method] - adds a 'user' album, results returned in UserAlbumAdd_result after _UserAlbumAdd_done event
Public Sub UserAlbumAdd(Albumname As String) As ResumableSub
	
	'Check if 'user' album already exists
	Wait For (UserAlbumFind(Albumname)) Complete (success_flag As Boolean)
	
	'If 'user' album does not already exist...
	If Not(UserAlbumFind_result.IsInitialized) Then
		
		'Create 'user' album
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_createuseralbum:", Array(Albumname))
		Wait For objc_createuseralbum_done(wrk_success As Boolean)
		
		UserAlbumAdd_result = wrk_success
		
	'Otherwise...
	Else
		
		UserAlbumAdd_result = True
		
	End If
	
	Return True
	
End Sub

'************************************************************************************
'
'This procedure gets control when UserAlbumExists method is called by parent module
'
'Input parameters are:
'
'       Albumname = 'user' album name
'
'Returns:
'
'       UserAlbumExists_result = Boolean (True = user album exists)
'
'Notes on this procedure:
'
'       o Checks if a 'user' album exists
'
'************************************************************************************

'
'[Method] - checks if a 'user' album exists, results returned in UserAlbumExists_result after _UserAlbumExists_done event
Public Sub UserAlbumExists(Albumname As String) As ResumableSub
	
	'Check if 'user' album already exists
	Wait For (UserAlbumFind(Albumname)) Complete (success_flag As Boolean)
	
	UserAlbumExists_result = (UserAlbumFind_result.IsInitialized)

	Return True

End Sub

'************************************************************************************
'
'This procedure gets control when UserAlbumDelete method is called by parent module
'
'Input parameters are:
'
'       Albumname = 'user' album name
'
'Returns:
'
'       UserAlbumDelete_result = Boolean (True = user album deleted)
'
'Notes on this procedure:
'
'       o Deletes a 'user' album, note that 'user' albums only contain pointers to
'         physical assets (photos, videos) saved in 'smart' album [All Photos], so 
'         deleting a 'user' album does not delete any physical assets
'
'************************************************************************************

'
'[Method] - deletes a 'user' album, results returned in UserAlbumDelete_result after _UserAlbumDelete_done event
Public Sub UserAlbumDelete(Albumname As String) As ResumableSub
	
	'Check if 'user' album exists
	Wait For (UserAlbumFind(Albumname)) Complete (success_flag As Boolean)
	
	'If 'user' album exists...
	If UserAlbumFind_result.IsInitialized Then
		
		'Set up B4i list of 1, being iOS album returned by UserAlbumFind
		Private wrk_list As List
		wrk_list.Initialize
		wrk_list.Add(UserAlbumFind_result)
		
		'Delete 'user' album
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_deleteuseralbum:", Array(wrk_list))
		Wait For objc_deleteuseralbum_done(wrk_success As Boolean)
		
		UserAlbumDelete_result = wrk_success

	'Otherwise...
	Else
		
		UserAlbumDelete_result = True
	
	End If
	
	Return True
	
End Sub

'************************************************************************************
'
'This internal procedure gets control when UserAlbumFind method is called
'
'Input parameters are:
'
'       Albumname = 'user' album name
'
'Returns:
'
'       UserAlbumFind_result = NativeObject iOS form of album 
'       if UserAlbumFind_result.IsInitialized = True - call successful
'
'Notes on this procedure:
'
'       o Finds iOS form of album with specified name
'
'************************************************************************************
Private Sub UserAlbumFind(Albumname As String) As ResumableSub

	'Assume 'user' album does not exist
	UserAlbumFind_result = Null
		
	'Get list of 'user' iOS albums
	Private wrk_no As NativeObject = Me
	wrk_no.RunMethod("objc_listuseralbums:", Array(PHAssetCollectionSubtypeAny))
	Wait For objc_listuseralbums_done(wrk_obj As Object)

	'Convert list of 'user' iOS albums into B4i list
	Private wrk_no As NativeObject = wrk_obj
	Private wrk_ios_albums As List = wrk_no

	Private wrk_no As NativeObject
	Private wrk_i As Int

	'For each 'user' iOS album...
	For wrk_i = 0 To wrk_ios_albums.Size - 1

		'Get 'user' iOS album
		wrk_no = wrk_ios_albums.Get(wrk_i)

		'If 'user' iOS albums name is a match...
		If wrk_no.GetField("localizedTitle").AsString.ToLowerCase = Albumname.ToLowerCase Then

			'Save result as 'user' iOS album
			UserAlbumFind_result = wrk_no

			'Quit For loop
			Exit

		End If

	Next

	Return True

End Sub

'************************************************************************************
'
'This internal procedure gets control when BuildPHAlbum method is called
'
'Input parameters are:
'
'       iOS_album = NativeObject iOS form of album
'       iOS_assets = list of NativeObject iOS form of album assets
'
'Returns:
'
'       wrk_album = PHAlbum form of album with assets in PHAsset form
'
'Notes on this procedure:
'
'       o Creates PHAlbum/PHAsset form of iOS_album/iOS_assets
'
'************************************************************************************
Private Sub BuildPHAlbum(iOS_album As NativeObject, iOS_assets As List) As PHAlbum
	
	'Start building PHAlbum by adding non-asset bits
	Private wrk_album As PHAlbum
	wrk_album.Initialize
	wrk_album.Name = iOS_album.GetField("localizedTitle").AsString
	wrk_album.iOS_Album = iOS_album
	wrk_album.PHAssetsList.Initialize
	
	Private wrk_i As Int
	
	'For all iOS assets of PHAlbum...
	For wrk_i = 0 To iOS_assets.Size - 1
		
		'Get iOS asset
		Private wrk_ios_asset As NativeObject = iOS_assets.Get(wrk_i)
		
		Private wrk_asset As PHAsset
		wrk_asset.Initialize
		
		'Flesh out asset as PHAsset
		wrk_asset.GUID = BuildGUID(wrk_ios_asset)
		wrk_asset.Width = wrk_ios_asset.GetField("pixelWidth").AsNumber
		wrk_asset.Height = wrk_ios_asset.GetField("pixelHeight").AsNumber
		If 2 = wrk_ios_asset.GetField("mediaType").AsNumber Then
			wrk_asset.isVideo=True
			wrk_asset.Duration = wrk_ios_asset.GetField("duration").AsNumber
		End If
		wrk_asset.iOS_Asset = wrk_ios_asset
		
		'Add to list of PHAssets for PHAlbum
		wrk_album.PHAssetsList.Add(wrk_asset)

	Next
	
	Return wrk_album
	
End Sub

'************************************************************************************
'
'This internal procedure gets control when BuildGUID method is called
'
'Input parameters are:
'
'       iOS_asset = NativeObject iOS form of asset
'
'Returns:
'
'       GUID of iOS_asset
'
'Notes on this procedure:
'
'       o Creates GUID of iOS_asset
'
'************************************************************************************
Private Sub BuildGUID(iOS_Asset As NativeObject) As String
	
	Private wrk_str As String = iOS_Asset.GetField("localIdentifier").AsString
	Return wrk_str.SubString2(0, wrk_str.IndexOf("/"))
	
End Sub

'************************************************************************************
'
'This procedure gets control when PhotoAdd method is called by parent module
'
'Input parameters are:
'
'       Albumname = 'user' album name
'       Bitmap = bitmap representation of photo to be added
'
'Returns:
'
'       PhotoAdd_result = String, GUID by which photo can be accessed forever 
'       if PhotoAdd_result = "" - call not successful
'
'Notes on this procedure:
'
'       o Adds a photo as bitmap to 'smart' album [All Photos] and a pointer to 
'         nominated 'user' album
'
'************************************************************************************

'
'[Method] - adds a photo as bitmap to 'smart' album [All Photos] and a pointer to nominated 'user' album, results returned in PhotoAdd_result after _PhotoAdd_done event
Public Sub PhotoAdd(Albumname As String, Bitmap As Bitmap) As ResumableSub
	
	'Assume subroutine will fail
	PhotoAdd_result = ""

	'Check if 'user' album already exists
	Wait For (UserAlbumFind(Albumname)) Complete (success_flag As Boolean)

	'If 'user' album exists...
	If UserAlbumFind_result.IsInitialized Then

		Private wrk_guids As Map
		wrk_guids.Initialize
		
		'Get iOS list of 'smart' iOS album [All Photos]
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_listsmartalbums:", Array(PHAssetCollectionSubtypeSmartAlbumUserLibrary))
		Wait For objc_listsmartalbums_done(wrk_obj As Object)
		
		'Convert iOS list of 'smart' iOS albums into B4i list (should be just
		'[All Photos])
		Private wrk_no As NativeObject = wrk_obj
		Private wrk_ios_albums As List = wrk_no
		
		'Get list of iOS assets in 'smart' album [All Photos])
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_listalbumassets:", Array(wrk_ios_albums.Get(0)))
		Wait For objc_listalbumassets_done(wrk_obj As Object)
		
		'Convert iOS list of iOS assets into B4i list
		Private wrk_no As NativeObject = wrk_obj
		Private wrk_ios_assets As List = wrk_no
		
		Private wrk_i As Int
		
		'For all iOS assets...
		For wrk_i = 0 To wrk_ios_assets.Size - 1
			
			'Save GUID in 'before' list
			wrk_guids.Put(BuildGUID(wrk_ios_assets.Get(wrk_i)), "")
		
		Next

		'Add bitmap to 'user' album - bitmap is actually saved in 'smart' album [All 
		'Photos] and a pointer is saved in nominated 'user' album
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_addbitmaptoalbum::", Array(Bitmap, UserAlbumFind_result))
		Wait For objc_addbitmaptoalbum_done(wrk_success As Boolean)
		
		'If successfully added bitmap...
		If wrk_success Then 
			
			'Get new list of iOS assets in 'smart' album [All Photos]
			Private wrk_no As NativeObject = Me
			wrk_no.RunMethod("objc_listalbumassets:", Array(wrk_ios_albums.Get(0)))
			Wait For objc_listalbumassets_done(wrk_obj As Object)
			
			'Convert new iOS list of iOS assets into B4i list
			Private wrk_no As NativeObject = wrk_obj
			Private wrk_ios_assets As List = wrk_no
			
			'For all new iOS assets, starting at the end...
			For wrk_i = wrk_ios_assets.Size - 1 To 0 Step -1
				
				'Quit For loop if GUID of iOS asset not found in 'before' list
				If Not(wrk_guids.ContainsKey(BuildGUID(wrk_ios_assets.Get(wrk_i)))) Then Exit
				
			Next
	
			'If GUID of iOS asset not found in 'before' list...
			If wrk_i < wrk_ios_assets.Size Then
			
				'Save GUID of newly added bitmap as result
				PhotoAdd_result = BuildGUID(wrk_ios_assets.Get(wrk_i))

			End If

		End If

	End If
	
	Return True
	
End Sub

'************************************************************************************
'
'This procedure gets control when PhotoGet method is called by parent module
'
'Input parameters are:
'
'       GUID = unique ID by which photo can be accessed forever
'
'Returns:
'
'       PhotoGet_result = Bitmap representation of photo extracted
'       if PhotoGet_result.IsInitialized = True - call successful
'
'Notes on this procedure:
'
'       o Extracts a photo from 'smart' album [All Photos]
'
'************************************************************************************

'
'[Method] - extracts a photo from 'smart' album [All Photos], results returned in PhotoGet_result after _PhotoGet_done event
Public Sub PhotoGet(GUID As String) As ResumableSub
	
	'Assume subroutine will fail
	PhotoGet_result = Null

	'Check if asset exists
	Wait For (AssetFind(GUID)) Complete (success_flag As Boolean)

	'If asset exists...
	If AssetFind_result.IsInitialized Then
		
		'If asset is photo...
		If 1 = AssetFind_result.GetField("mediaType").AsNumber Then
		
			'Extract bitmap
			Private wrk_no As NativeObject = Me
			PhotoGet_result = wrk_no.RunMethod("objc_getbitmapfromasset:", Array(AssetFind_result))

		End If
		
	End If
	
	Return True

End Sub

'************************************************************************************
'
'This procedure gets control when VideoAdd method is called by parent module
'
'Input parameters are:
'
'       Albumname = 'user' album name
'       Videopath = path to video on storage
'
'Returns:
'
'       VideoAdd_result = String, GUID by which video can be accessed forever 
'       if VideoAdd_result = "" - call not successful
'
'Notes on this procedure:
'
'       o Adds a video to 'smart' album [All Photos] and a pointer to nominated
'         'user' album
'
'************************************************************************************

'
'[Method] - adds a video to 'smart' album [All Photos] and a pointer to nominated 'user' album, results returned in VideoAdd_result after _VideoAdd_done event
Public Sub VideoAdd(Albumname As String, Videopath As String) As ResumableSub
	
	'Assume subroutine will fail
	VideoAdd_result = ""

	'Check if 'user' album already exists
	Wait For (UserAlbumFind(Albumname)) Complete (success_flag As Boolean)

	'If 'user' album exists...
	If UserAlbumFind_result.IsInitialized Then

		Private wrk_guids As Map
		wrk_guids.Initialize
		
		'Get iOS list of 'smart' iOS album [All Photos]
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_listsmartalbums:", Array(PHAssetCollectionSubtypeSmartAlbumUserLibrary))
		Wait For objc_listsmartalbums_done(wrk_obj As Object)
		
		'Convert iOS list of 'smart' iOS albums into B4i list (should be just
		'[All Photos])
		Private wrk_no As NativeObject = wrk_obj
		Private wrk_ios_albums As List = wrk_no
		
		'Get list of iOS assets in 'smart' album [All Photos])
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_listalbumassets:", Array(wrk_ios_albums.Get(0)))
		Wait For objc_listalbumassets_done(wrk_obj As Object)
		
		'Convert iOS list of iOS assets into B4i list
		Private wrk_no As NativeObject = wrk_obj
		Private wrk_ios_assets As List = wrk_no
		
		Private wrk_i As Int
		
		'For all iOS assets...
		For wrk_i = 0 To wrk_ios_assets.Size - 1
			
			'Save GUID in 'before' list
			wrk_guids.Put(BuildGUID(wrk_ios_assets.Get(wrk_i)), "")
		
		Next

		'Add video to 'user' album - video is actually saved in 'smart' album [All 
		'Photos] and a pointer is saved in nominated 'user' album
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("objc_addvideotoalbum::", Array(Videopath, UserAlbumFind_result))
		Wait For objc_addvideotoalbum_done(wrk_success As Boolean)
		
		'If successfully added video...
		If wrk_success Then
		
			'Get new list of iOS assets in 'smart' album [All Photos]
			Private wrk_no As NativeObject = Me
			wrk_no.RunMethod("objc_listalbumassets:", Array(wrk_ios_albums.Get(0)))
			Wait For objc_listalbumassets_done(wrk_obj As Object)
			
			'Convert new iOS list of iOS assets into B4i list
			Private wrk_no As NativeObject = wrk_obj
			Private wrk_ios_assets As List = wrk_no
			
			'For all new iOS assets, starting at the end...
			For wrk_i = wrk_ios_assets.Size - 1 To 0 Step -1
				
				'Quit For loop if GUID of iOS asset not found in 'before' list
				If Not(wrk_guids.ContainsKey(BuildGUID(wrk_ios_assets.Get(wrk_i)))) Then Exit
				
			Next
	
			'If GUID of iOS asset not found in 'before' list...
			If wrk_i < wrk_ios_assets.Size Then
			
				'Save GUID of newly added video as result
				VideoAdd_result = BuildGUID(wrk_ios_assets.Get(wrk_i))

			End If
		
		End If

	End If
	
	Return True
	
End Sub

'************************************************************************************
'
'This procedure gets control when VideoGet method is called by parent module
'
'Input parameters are:
'
'       GUID = unique ID by which video can be accessed forever
'       Videopath = path to video on storage
'
'Returns:
'
'       VideoGet_result = Boolean (True = video got)
'
'Notes on this procedure:
'
'       o Extracts a video from 'smart' album [All Photos]
'
'************************************************************************************

'
'[Method] - extracts a video from 'smart' album [All Photos], results returned in VideoGet_result after _VideoGet_done event
Public Sub VideoGet(GUID As String, Videopath As String) As ResumableSub
	
	'Assume subroutine will fail
	VideoGet_result = False

	'Check if asset exists
	Wait For (AssetFind(GUID)) Complete (success_flag As Boolean)

	'If asset exists...
	If AssetFind_result.IsInitialized Then
		
		'If asset is video...
		If 2 = AssetFind_result.GetField("mediaType").AsNumber Then
		
			'Extract video
			Private wrk_no As NativeObject = Me
			wrk_no.RunMethod("objc_getvideofromasset::", Array(Videopath, AssetFind_result))
			Wait For objc_getvideofromasset_done(wrk_success As Boolean)

			VideoGet_result = wrk_success

		End If
		
	End If
	
	Return True

End Sub

'************************************************************************************
'
'This procedure gets control when AssetExists method is called by parent module
'
'Input parameters are:
'
'       GUID = unique ID by which asset can be accessed forever
'
'Returns:
'
'       AssetExists_result = Boolean (True = asset exists)
'
'Notes on this procedure:
'
'       o Checks if an asset exists in 'smart' album [All Photos]
'
'************************************************************************************

'
'[Method] - checks if an asset exists in 'smart' album [All Photos], results returned in AssetExists_result after _AssetExists_done event
Public Sub AssetExists(GUID As String) As ResumableSub
	
	'Check if asset exists
	Wait For (AssetFind(GUID)) Complete (success_flag As Boolean)
	
	AssetExists_result = (AssetFind_result.IsInitialized)

	Return True

End Sub

'************************************************************************************
'
'This procedure gets control when AssetDelete method is called by parent module
'
'Input parameters are:
'
'       GUID = unique ID by which asset can be accessed forever
'
'Returns:
'
'       AssetDelete_result = Boolean (True = asset deleted)
'
'Notes on this procedure:
'
'       o Deletes an asset from 'smart' album [All Photos] and any pointers to it in
'         any other 'smart' or 'user' album
'
'************************************************************************************

'
'[Method] - deletes an asset from 'smart' album [All Photos] and any pointers to it in any other 'smart' or 'user' album, results returned in AssetDelete_result after _AssetDelete_done event
Public Sub AssetDelete(GUID As String) As ResumableSub

	'Check if asset exists
	Wait For (AssetFind(GUID)) Complete (success_flag As Boolean)

	'If asset exists...
	If AssetFind_result.IsInitialized Then
		
		'Set up B4i list of 1, being iOS asset returned by AssetFind
		Private wrk_assets As List
		wrk_assets.Initialize
		wrk_assets.Add(AssetFind_result)

		'Delete asset
		Private wrk_no As NativeObject = Me
		wrk_no.RunMethod("deleteasset:", Array(wrk_assets))
		Wait For deleteasset_done(wrk_success As Boolean)
		
		AssetDelete_result = wrk_success
		
	'Otherwise...
	Else
		
		AssetDelete_result = True

	End If
	
	Return True

End Sub

'************************************************************************************
'
'This internal procedure gets control when AssetFind method is called
'
'Input parameters are:
'
'       GUID = unique ID by which asset can be accessed forever
'
'Returns:
'
'       AssetFind_result = NativeObject iOS form of asset
'       if AssetFind_result.IsInitialized = True - call successful
'
'Notes on this procedure:
'
'       o Finds iOS form of asset with specified GUID
'
'************************************************************************************
Private Sub AssetFind(GUID As String) As ResumableSub
	
	'Assume asset does not exist
	AssetFind_result = Null
		
	'Get iOS list of 'smart' iOS album [All Photos]
	Private wrk_no As NativeObject = Me
	wrk_no.RunMethod("objc_listsmartalbums:", Array(PHAssetCollectionSubtypeSmartAlbumUserLibrary))
	Wait For objc_listsmartalbums_done(wrk_obj As Object)
	
	'Convert iOS list of 'smart' iOS albums into B4i list (should be just
	'[All Photos])
	Private wrk_no As NativeObject = wrk_obj
	Private wrk_ios_albums As List = wrk_no
	
	'Get list of iOS assets in 'smart' album [All Photos]
	Private wrk_no As NativeObject = Me
	wrk_no.RunMethod("objc_listalbumassets:", Array(wrk_ios_albums.Get(0)))
	Wait For objc_listalbumassets_done(wrk_obj As Object)
	
	'Convert iOS list of iOS assets into B4i list
	Private wrk_no As NativeObject = wrk_obj
	Private wrk_ios_assets As List = wrk_no
	
	Private wrk_i As Int

	'For all iOS assets...
	For wrk_i = 0 To wrk_ios_assets.Size - 1
	
		'Quit For loop if matching GUID of iOS asset found
	    If BuildGUID(wrk_ios_assets.Get(wrk_i)) = GUID Then Exit
		
	Next
	
	'If matching GUID of iOS asset found...
	If wrk_i < wrk_ios_assets.Size Then
		
		'Save result as iOS asset
		AssetFind_result = wrk_ios_assets.Get(wrk_i)
		
	End If
	
	Return True
	
End Sub

#if OBJC

@import Photos;

/////////////////////////////////////////////////////////////////////////////////////

- (void)objc_requestpermission 
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) 
	{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.bi raiseUIEvent:nil
                            event:@"objc_requestpermission_done:"
                           params:@[@((int)status)]];
        });
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

- (void)objc_listuseralbums:(NSInteger)albumtype 
{
    if (albumtype == 0) {
        albumtype = PHAssetCollectionSubtypeAny;
    }
    NSMutableArray *albums = [NSMutableArray array];
    PHFetchOptions *userAlbumsOptions = [PHFetchOptions new];
    PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum 
                                                                         subtype:albumtype 
                                                                         options:userAlbumsOptions];
    [userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection *album, NSUInteger idx, BOOL *stop) {
        [albums addObject:album];
    }];
    [self.bi raiseUIEvent:nil event:@"objc_listuseralbums_done:" params:@[albums]];
}

/////////////////////////////////////////////////////////////////////////////////////

- (void)objc_listsmartalbums:(NSInteger)albumtype 
{
    if (albumtype == 0) {
        albumtype = PHAssetCollectionSubtypeAny;
    }
    NSMutableArray *albums = [NSMutableArray array];
    PHFetchOptions *userAlbumsOptions = [PHFetchOptions new];
    PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                         subtype:albumtype
                                                                         options:userAlbumsOptions];
    [userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection *album, NSUInteger idx, BOOL *stop) 
	{
        [albums addObject:album];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.bi raiseUIEvent:nil
                        event:@"objc_listsmartalbums_done:"
                       params:@[albums]];
    });
}

/////////////////////////////////////////////////////////////////////////////////////

- (void)objc_listalbumassets:(PHAssetCollection *)album 
{
    NSMutableArray *assets = [NSMutableArray array];
    PHFetchResult *albumResult = [PHAsset fetchAssetsInAssetCollection:album options:nil];
    [albumResult enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL *stop) 
	{
        [assets addObject:asset];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.bi raiseUIEvent:nil
                        event:@"objc_listalbumassets_done:"
                       params:@[assets]];
    });
}

/////////////////////////////////////////////////////////////////////////////////////

- (void)objc_createuseralbum:(NSString *)name 
{
    __block PHObjectPlaceholder *placeholderAlbum;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
	{
        PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:name];
        placeholderAlbum = changeRequest.placeholderForCreatedAssetCollection;
    } completionHandler:^(BOOL success, NSError *error) 
	{
        dispatch_async(dispatch_get_main_queue(), ^
		{
            [self.bi raiseUIEvent:nil
                            event:@"objc_createuseralbum_done:"
                           params:@[@(success)]];
        });
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

- (void)objc_deleteuseralbum:(NSArray<PHAssetCollection *> *)albums 
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
	{
        [PHAssetCollectionChangeRequest deleteAssetCollections:albums];
    } 
	completionHandler:^(BOOL success, NSError *error) 
	{
        dispatch_async(dispatch_get_main_queue(), ^
		{
            [self.bi raiseUIEvent:nil
                            event:@"objc_deleteuseralbum_done:"
                           params:@[@(success)]];
        });
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

- (void)objc_addbitmaptoalbum:(UIImage *)image :(PHAssetCollection *)album 
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
	{
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
        [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
    } 
	completionHandler:^(BOOL success, NSError *error) 
	{
        dispatch_async(dispatch_get_main_queue(), ^
		{
            [self.bi raiseUIEvent:nil
                            event:@"objc_addbitmaptoalbum_done:"
                           params:@[@(success)]];
        });
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

- (UIImage *)objc_getbitmapfromasset:(PHAsset *)asset 
{
    __block UIImage *imgFull = nil;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.networkAccessAllowed = YES;
    options.synchronous = YES;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:PHImageManagerMaximumSize
                                              contentMode:PHImageContentModeDefault
                                                  options:options
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
        imgFull = result;
    }];
    return imgFull;
}

/////////////////////////////////////////////////////////////////////////////////////

- (void)objc_addvideotoalbum:(NSString *)videopath :(PHAssetCollection *)album 
{
    NSURL *videourl = [NSURL fileURLWithPath:videopath];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
	{
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:videourl];
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:album];
        [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
    } 
	completionHandler:^(BOOL success, NSError *error) 
	{
        dispatch_async(dispatch_get_main_queue(), ^
		{
            [self.bi raiseUIEvent:nil
                            event:@"objc_addvideotoalbum_done:"
                           params:@[@(success)]];
        });
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

- (void)objc_getvideofromasset:(NSString *)videopath :(PHAsset *)asset 
{
    NSURL *videourl = [NSURL fileURLWithPath:videopath];
    PHVideoRequestOptions *options = [PHVideoRequestOptions new];
    options.version = PHVideoRequestOptionsVersionOriginal;
    
    [[PHImageManager defaultManager] requestAVAssetForVideo:asset
                                                   options:options
                                             resultHandler:^(AVAsset * _Nullable avasset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) 
	{
        BOOL success = NO;
        if ([avasset isKindOfClass:[AVURLAsset class]]) 
		{
            AVURLAsset *avurlasset = (AVURLAsset *)avasset;
            NSError *error = nil;
            success = [[NSFileManager defaultManager] copyItemAtURL:avurlasset.URL
                                                             toURL:videourl
                                                             error:&error];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^
		{
            [self.bi raiseUIEvent:nil
                            event:@"objc_getvideofromasset_done:"
                           params:@[@(success)]];
        });
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

- (void)deleteasset:(NSArray<PHAsset *> *)assets 
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^
	{
        [PHAssetChangeRequest deleteAssets:assets];
    } completionHandler:^(BOOL success, NSError *error) 
	{
        dispatch_async(dispatch_get_main_queue(), ^
		{
            [self.bi raiseUIEvent:nil
                            event:@"deleteasset_done:"
                           params:@[@(success)]];
        });
    }];
}

/////////////////////////////////////////////////////////////////////////////////////

#end if