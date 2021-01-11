
#import "StoreInformationViewController.h"
#import "CameraViewController.h"
#import "CameraViewController.h"
#import "Loja.h"

@implementation StoreInformationViewController

- (void)viewDidLoad {
    self.idTextView.text = _idText;
    self.nameTextView.text = _nameText;
    self.cellphoneTextView.text = _cellponeText;
    self.addressTextView.text = [NSString stringWithFormat: @"%@, %li - %@, %@", _logradouroText, _numeroText, _bairroText, _complementoText];
    
    self.StoreService = [StoresService storesServiceInstance];
    
    Loja * loja = self.StoreService.stores[(int)self.StoreService.indexSelected];
    
    if(loja != nil && loja.foto != nil) {
        self.imgView.image = loja.foto;
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCameraView:)];
    [self.imgView addGestureRecognizer:tapGesture];
}

- (void)openCameraView:(UITapGestureRecognizer*)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CameraViewController *cameraViewController = [storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    cameraViewController.delegate = self;
    [self.navigationController pushViewController:cameraViewController animated:YES];

}

- (void)grabPhoto:(CameraViewController *)controller didFinishEnteringItem:(UIImage *)item {
    NSLog(@"Cegouuu");
    self.imgView.image = item;
}
@end
