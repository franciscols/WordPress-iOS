//
//  UINavigationController+Rotation.m
//  WordPress
//
//  Created by Eric J on 9/19/12.
//  Copyright (c) 2012 WordPress. All rights reserved.
//

#import "UINavigationController+Rotation.h"
#import <objc/runtime.h>

@implementation UINavigationController (Rotation)


- (NSUInteger)mySupportedInterfaceOrientations {
    
    // Respect the top child's orientation prefs.
    if ([self respondsToSelector:@selector(topViewController)] && self.topViewController && [self.topViewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.topViewController supportedInterfaceOrientations];
    }
    
    if (IS_IPHONE) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)myShouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    NSUInteger mask = [self mySupportedInterfaceOrientations];
    NSUInteger orientation = 1 << toInterfaceOrientation;
    return (mask & orientation) ? YES : NO;
}

+ (void)load {    
    Method origMethod = class_getInstanceMethod(self, @selector(supportedInterfaceOrientations));
    Method newMethod = class_getInstanceMethod(self, @selector(mySupportedInterfaceOrientations));
    method_exchangeImplementations(origMethod, newMethod);

    origMethod = class_getInstanceMethod(self, @selector(shouldAutorotateToInterfaceOrientation:));
    newMethod = class_getInstanceMethod(self, @selector(myShouldAutorotateToInterfaceOrientation:));
    method_exchangeImplementations(origMethod, newMethod);
}


@end
