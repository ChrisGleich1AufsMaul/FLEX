#import <UIKit/UIKit.h>
#import "FLEXManager.h"

%ctor {
    if (NSProcessInfo.processInfo.environment[@"FLEX_LOADER_DISABLED"]) {
        return;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                          object:nil
                                                           queue:NSOperationQueue.mainQueue
                                                      usingBlock:^(__unused NSNotification *notification) {
            [[FLEXManager sharedManager] showExplorer];
        }];
    });
}
