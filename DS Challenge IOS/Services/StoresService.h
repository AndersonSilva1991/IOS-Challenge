#import <Foundation/Foundation.h>

@interface StoresService : NSObject
@property NSMutableArray *stores;
@property NSInteger *indexSelected;
+ (StoresService *) storesServiceInstance;

@end
