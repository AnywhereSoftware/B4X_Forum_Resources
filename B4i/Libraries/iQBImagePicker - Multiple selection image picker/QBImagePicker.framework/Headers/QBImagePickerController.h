//
//  QBImagePickerController.h
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class QBImagePickerController;

@protocol QBImagePickerControllerDelegate <NSObject>

@optional
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets;
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController;

- (BOOL)qb_imagePickerController:(QBImagePickerController *)imagePickerController shouldSelectAsset:(PHAsset *)asset;
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(PHAsset *)asset;
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didDeselectAsset:(PHAsset *)asset;

@end

typedef NS_ENUM(NSUInteger, QBImagePickerMediaType) {
    QBImagePickerMediaTypeAny = 0,
    QBImagePickerMediaTypeImage,
    QBImagePickerMediaTypeVideo
};

@interface QBImagePickerController : UIViewController

@property (nonatomic, weak) id<QBImagePickerControllerDelegate> delegate;

@property (nonatomic, strong, readonly) NSMutableOrderedSet *selectedAssets;

@property (nonatomic, copy) NSArray *assetCollectionSubtypes;
@property (nonatomic, assign) QBImagePickerMediaType mediaType;

@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;

@property (nonatomic, copy) NSString *prompt;
@property (nonatomic, assign) BOOL showsNumberOfSelectedAssets;

@property (nonatomic, assign) NSUInteger numberOfColumnsInPortrait;
@property (nonatomic, assign) NSUInteger numberOfColumnsInLandscape;

@property (nonatomic, assign) BOOL downloadiCloudPhotos;

@property (nonatomic, assign) NSString *albumsTitle;

@property (nonatomic, assign) NSString *assetsToolbarItemsSelected;

@property (nonatomic, assign) NSString *assetsToolbarItemSelected;

@property (nonatomic, assign) NSString *assetsFooterPhotoAndVideo;

@property (nonatomic, assign) NSString *assetsFooterPhotoAndVideos;

@property (nonatomic, assign) NSString *assetsFooterPhotosAndVideo;

@property (nonatomic, assign) NSString *assetsFooterPhotosAndVideos;

@property (nonatomic, assign) NSString *assetsFooterPhotos;

@property (nonatomic, assign) NSString *assetsFooterPhoto;

@property (nonatomic, assign) NSString *assetsFooterVideos;

@property (nonatomic, assign) NSString *assetsFooterVideo;

@property (nonatomic, assign) NSString *version;
@end
