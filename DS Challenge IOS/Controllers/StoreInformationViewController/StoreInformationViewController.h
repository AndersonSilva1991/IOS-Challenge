
#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "StoresService.h"

@interface StoreInformationViewController : UIViewController<PhotoDelegateProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *idTextView;
@property (weak, nonatomic) IBOutlet UILabel *nameTextView;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UILabel *cellphoneTextView;
@property (nonatomic, assign) NSString *idText;
@property (nonatomic, assign) NSString *nameText;
@property (nonatomic, assign) NSString *bairroText;
@property (nonatomic, assign) NSString *logradouroText;
@property (nonatomic, assign) NSInteger *numeroText;
@property (nonatomic, assign) NSString *complementoText;
@property (nonatomic, assign) UIImage *photo;
@property (nonatomic, assign) NSString *cellponeText;
@property StoresService *StoreService;

@end
