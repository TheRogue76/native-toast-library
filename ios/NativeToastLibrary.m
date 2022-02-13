#import "NativeToastLibrary.h"
#import <UIKit/UIKit.h>

@implementation NativeToastLibrary

static double const DEFAULT_TOAST_DURATION = 3.5;

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(show:(NSString *) msg) {
    [self showToast:msg duration:DEFAULT_TOAST_DURATION];
}

-(void) showToast:(NSString *)msg duration:(double)duration {
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIViewController *rootVC = [[UIViewController alloc] init];
    if (rootVC == nil || window == nil) {
        return;
    }
    window.backgroundColor = [UIColor clearColor];
    window.rootViewController = rootVC;
    [window makeKeyAndVisible];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    [rootVC presentViewController:alert animated:YES completion:nil];
    [self closeToast:window alert:alert duration:DEFAULT_TOAST_DURATION];
}

-(void) closeToast:(UIWindow *)window alert:(UIAlertController *) alert duration:(double) duration {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
        [window removeFromSuperview];
    });
}

@end
