//
//  EditPageViewController.m
//  WordPress
//
//  Created by Chris Boyd on 9/4/10.
//

#import "EditPageViewController.h"
#import "EditPostViewController_Internal.h"
#import "AbstractPost.h"

@implementation EditPageViewController

- (id)initWithPost:(AbstractPost *)aPost
{
    self = [super initWithPost:aPost];
    if (self) {
        self.statsPrefix = @"Page Detail";
    }
    return self;
}

- (NSString *)editorTitle {
    NSString *title = @"";
    if (self.editMode == EditPostViewControllerModeNewPost) {
        title = NSLocalizedString(@"New Page", @"New Page Editor screen title.");
    } else {
        if ([self.apost.postTitle length] > 0) {
            title = self.apost.postTitle;
        } else {
            title = NSLocalizedString(@"Edit Page", @"Page Editor screen title.");
        }
    }
    self.navigationItem.backBarButtonItem.title = title;
    return title;
}

@end
