//
//  NotificationViewController.m
//  NotiContentExtension
//
//  Created by coderXu on 16/10/13.
//  Copyright © 2016年 coderXu. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (void)didReceiveNotification:(UNNotification *)notification {

    
    
    NSDictionary *dict =  notification.request.content.userInfo;
    // 这里可以把打印的所有东西拿出来
    NSLog(@"%@",dict);
    
    /****************************打印的信息是************
    aps =     {
        alert = "This is some fancy message.";
        badge = 1;
        from = "大家好，我是徐不同";
        imageAbsoluteString = "http://upload.univs.cn/2012/0104/1325645511371.jpg";
        "mutable-content" = 1;
        sound = default;
    };
}
    *******************************************/

    
}
 

//- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion{
//    
//    if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
//        
//        NSString* userSayStr = [(UNTextInputNotificationResponse *)response userText];
//        NSLog(@"%@",userSayStr);
//        
//    }
//    
//}



- (UNNotificationContentExtensionMediaPlayPauseButtonType)mediaPlayPauseButtonType
{
    return UNNotificationContentExtensionMediaPlayPauseButtonTypeDefault;
}

- (CGRect)mediaPlayPauseButtonFrame
{
    return CGRectMake(100, 100, 100, 100);
}

- (UIColor *)mediaPlayPauseButtonTintColor{
    return [UIColor blueColor];
}

- (void)mediaPlay{
    NSLog(@"mediaPlay,开始播放");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.extensionContext mediaPlayingPaused];
    });
    
    
}
- (void)mediaPause{
    NSLog(@"mediaPause，暂停播放");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.extensionContext mediaPlayingStarted];
    });
    

}


- (void)mediaPlayingStarted{
    NSLog(@"主动调用开始的方法");
}
- (void)mediaPlayingPaused
{
    NSLog(@"主动调用暂停的方法");
    
}




//@property (nonatomic, readonly, assign) UNNotificationContentExtensionMediaPlayPauseButtonType mediaPlayPauseButtonType;
//
//// Implementing this method and returning a non-empty frame will make
//// the notification draw a button that allows the user to play and pause
//// media content embedded in the notification.
//@property (nonatomic, readonly, assign) CGRect mediaPlayPauseButtonFrame;
//
//// The tint color to use for the button.
//@property (nonatomic, readonly, copy) UIColor *mediaPlayPauseButtonTintColor;
//
//// Called when the user taps the play or pause button.
//- (void)mediaPlay;
//- (void)mediaPause;




@end
