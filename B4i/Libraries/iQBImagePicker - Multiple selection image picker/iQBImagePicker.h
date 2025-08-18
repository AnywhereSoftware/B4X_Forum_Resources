//
//  iQBImagePicker.h
//  iQBImagePicker
//
//  Created by CaptKronos on 14/03/2019.
//

#import <Foundation/Foundation.h>
#import <QBImagePicker/QBImagePicker.h>
#import <UIKit/UIKit.h>

@class B4I;

//~shortname:QBImagePicker
//~event:picked (assets as list)
//~event:cancelled
//~version:1.20
//~dependsOn:QBImagePicker.framework.swift.3

@interface iQBImagePicker : NSObject
//Initialises the picker.
//Example:<code>aQBImagePicker.initialize("qbimagepicker")</code>
- (void)initialize:(B4I *)bi :(NSString *) eventName;
//Displays the picker
//MyViewController: The page to host the picker
//MediaType: 1 - images; 2 - videos; 0 - any
//SubType: a list of PHAssetCollectionSubtypes - see below for the values
//    <link>github.com/mstg/iOS-full-sdk/blob/master/iPhoneOS9.3.sdk/System/Library/Frameworks/Photos.framework/Headers/PhotosTypes.h</link>
//MultiSelect: True - allows more than one asset to be selected
//MinNumber: The minimum number of assets that must be selected
//MaxNumber: The maximum number of assets that can be selected
//NumColsInPortrait: The number of assets to display horizontally when in portrait (0 for default value)
//NumColsInLandscape: The number of assets to display horizontally when in landscape (0 for default value)
//useiCloud: True - will display assets on iCloud
//Example:<code>
//aQBImagePicker.load(pg, 1, subType, True, 1, 100, 0, 0)</code>
- (void) load: (UIViewController *) myViewController  : (int) mediaType : (NSArray*) subType : (BOOL) multiSelect : (int) minNumber : (int) maxNumber : (int) numColsInPortrait : (int) numColsInLandscape : (BOOL) useiCloud;
//Be very careful with this one. Depending on which key you inspect, it can crash your app.
//<code>Dim dict As Object, dictMap As Map
//dict=QBImagePicker.getImageDataFromAsset(assets.Get(0))
//dictMap=NSDictionaryToMap(dict)
//Log(dictMap.Get("PHImageFileUTIKey"))</code>
- (NSDictionary *) getImageDataFromAsset:(PHAsset *) thePHAsset;
//<code>dim bmp as bitmap = aQBImagePicker.ConvertPHAssetToImage(assets.Get(i))</code>
- (UIImage *) convertPHAssetToImage:(PHAsset *) thePHAsset;
//<code>Dim url As String=QBPicker.getImageURLFromAsset(assets.Get(i))
//url=url.SubString(7) 'convert to regular path and filename</code>
- (NSString *) getImageURLFromAsset:(PHAsset *) thePHAsset;
//<code>aQBImagePicker.CopyPHAssetToFile(assets.Get(i), "filename")</code>
- (void) copyPHAssetToFile:(PHAsset *) ThePHAsset :(NSString*) destination;
//<code>aQBImagePicker.saveImageFileToAlbum("myalbum", File.Combine(File.DirDocuments,"myimage.jpg"))</code>
- (BOOL) saveImageFileToAlbum:(NSString *) albumName :(NSString *) imageURL;
//<code>aQBImagePicker.saveImageToAlbum("myalbum", bmp)</code>
- (BOOL) saveImageToAlbum:(NSString *) albumName :(UIImage *) image;
//<code>aQBImagePicker.saveVideoFileToAlbum("myalbum", File.Combine(File.DirDocuments,"myvideo.mp4"))</code>
- (BOOL) saveVideoFileToAlbum:(NSString *) albumName :(NSString *) videoURL;
//<code>aQBImagePicker.createAlbum("myalbum") 'if myalbum already exists another album of the same name will be created</code>
- (BOOL) createAlbum:(NSString *)albumName;
//<code>aQBImagePicker.existsAlbum("myalbum") 'returns true if myalbum exists</code>
- (BOOL) existsAlbum:(NSString *)albumName;
//Overrides built-in translations
//<code>aQBImagePicker.translations( _ 
//"Photos", _
//"%ld Items Selected", _
//"%ld Item Selected", _
//"%ld Photo, %ld Video", _
//"%ld Photo, %ld Videos", _
//"%ld Photos, %ld Video", _
//"%ld Photos, %ld Videos", _
//"%ld Photo", _
//"%ld Photos", _
//"%ld Video", _
//"%ld Videos")</code>
- (void) translations:(NSString*) albumstitle :(NSString*) assetsToolbarItemsSelected :(NSString*) assetsToolbarItemSelected :(NSString*) assetsFooterPhotoAndVideo :(NSString*) assetsFooterPhotoAndVideos :(NSString*) assetsFooterPhotosAndVideo :(NSString*) assetsFooterPhotosAndVideos :(NSString*) assetsFooterPhoto :(NSString*) assetsFooterPhotos :(NSString*) assetsFooterVideos :(NSString*) assetsFooterVideos;

//Returns the version of the framework.
- (NSString *) frameworkVersion;

@end
