#import "CameraViewController.h"
#import "StoreInformationViewController.h"
#import <Photos/Photos.h>
#import "StoresService.h"
#import "Loja.h"

@implementation CameraViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.StoreService = [StoresService storesServiceInstance];
    self.captureSession = [AVCaptureSession new];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    
    AVCaptureDevice *deviceCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!deviceCamera) {
        NSLog(@"Nao pode utilizar a camera");
        return;
    }
    
    NSError *error;
    AVCaptureDeviceInput *inputCamera = [AVCaptureDeviceInput deviceInputWithDevice:deviceCamera error:&error];
    
    if (!error) {
        self.stillImageOutput = [AVCapturePhotoOutput new];
        
        if ([self.captureSession canAddInput:inputCamera] && [self.captureSession canAddOutput:self.stillImageOutput]) {
            [self.captureSession addInput:inputCamera];
            [self.captureSession addOutput:self.stillImageOutput];
            [self setupLivePreview];
        }
    } else {
        NSLog(@"Nao foi possivel inicializar a camera: %@", error.localizedDescription);
    }
}

- (void) setupLivePreview {
    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    if(self.videoPreviewLayer) {
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        [self.captureSession startRunning];
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.videoPreviewLayer.frame = self.view.layer.bounds;
        [self.view.layer addSublayer:self.videoPreviewLayer];
        [self.view bringSubviewToFront:self.takePhoto];
        [self.view bringSubviewToFront:self.GalleryButton];
        [self.view bringSubviewToFront:self.captureImageView];

    }
}

- (IBAction)didTakePhoto:(id)sender {
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{
        AVVideoCodecKey: AVVideoCodecTypeJPEG
    }];
    [self.stillImageOutput capturePhotoWithSettings: settings delegate:self];
}

- (IBAction)openGallery:(id)sender {
    UIImagePickerController *imagePickerConroller = [[UIImagePickerController alloc] init];
    imagePickerConroller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerConroller.delegate = self;
    imagePickerConroller.allowsEditing=TRUE;
    [self presentModalViewController:imagePickerConroller animated:YES];
    //[imagePickerConroller release];
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error {
    NSData *imageData = photo.fileDataRepresentation;
    
    if(imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        [self.delegate grabPhoto:self didFinishEnteringItem:image];
        Loja *loja = self.StoreService.stores[(int)self.StoreService.indexSelected];
        loja.foto = image;
        [self.navigationController popViewControllerAnimated:true];
        self.captureImageView.image = image;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.delegate grabPhoto:self didFinishEnteringItem:image];
    
    Loja *loja = self.StoreService.stores[(int)self.StoreService.indexSelected];
    loja.foto = image;
    
    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];
}
@end
