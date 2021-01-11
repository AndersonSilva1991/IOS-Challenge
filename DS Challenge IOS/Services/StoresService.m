#import <Foundation/Foundation.h>
#import "StoresService.h"
#import "StoryRepository.h"

@implementation StoresService

static StoresService *defaultStoresService = nil;

- (id) init {
    self = [super init];
    if (self) {
        StoryRepository * storyRepository = [[StoryRepository alloc]init];
        self.stores = [storyRepository getAll];
    }
    
    return self;
}

+ (StoresService *) storesServiceInstance {
    if (!defaultStoresService) {
        defaultStoresService = [StoresService new];
    }
    return defaultStoresService;
}

@end
