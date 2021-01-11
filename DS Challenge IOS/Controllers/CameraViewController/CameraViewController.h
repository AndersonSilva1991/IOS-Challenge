#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "StoresService.h"

@class CameraViewController;

@protocol PhotoDelegateProtocol <NSObject>

- (void)grabPhoto:(CameraViewController *) controller didFinishEnteringItem: (UIImage *) item;

@end

@interface CameraViewController : UIViewController<AVCapturePhotoCaptureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (weak, nonatomic) IBOutlet UIButton *takePhoto;
@property (weak, nonatomic) IBOutlet UIImageView *captureImageView;
@property (nonatomic, weak) id <PhotoDelegateProtocol> delegate;
@property (nonatomic, strong) PHFetchResult *assetsFetcResults;
@property (weak, nonatomic) IBOutlet UIButton *GalleryButton;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property StoresService *StoreService;
@end
