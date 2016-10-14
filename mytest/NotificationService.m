//
//  NotificationService.m
//  mytest
//
//  Created by coderXu on 16/9/22.
//  Copyright © 2016年 coderXu. All rights reserved.
//
#define DDLOG(...) printf("%s\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);

#import "NotificationService.h"
#import <UserNotifications/UserNotifications.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    // copy发来的通知，开始做一些处理
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    
    // 重写一些东西
    self.bestAttemptContent.title = @"我是标题";
    self.bestAttemptContent.subtitle = @"我是子标题";
    self.bestAttemptContent.body = @"来自徐不同";
    
    // 附件
    NSDictionary *dict =  self.bestAttemptContent.userInfo;
    NSDictionary *notiDict = dict[@"aps"];
    NSString *imgUrl = [NSString stringWithFormat:@"%@",notiDict[@"imageAbsoluteString"]];
   
    // 这里添加一些点击事件，可以在收到通知的时候，添加，也可以在拦截通知的这个扩展中添加
    
     self.bestAttemptContent.categoryIdentifier = @"category1";
    
    
    
    
    if (!imgUrl.length) {

        self.contentHandler(self.bestAttemptContent);

    }

    
    
    [self loadAttachmentForUrlString:imgUrl withType:@"png" completionHandle:^(UNNotificationAttachment *attach) {
        
        if (attach) {
            self.bestAttemptContent.attachments = [NSArray arrayWithObject:attach];
        }
        self.contentHandler(self.bestAttemptContent);

    }];
    
    
    
    
    
    
    
    
    
    
    
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}


- (void)loadAttachmentForUrlString:(NSString *)urlStr
                          withType:(NSString *)type
                  completionHandle:(void(^)(UNNotificationAttachment *attach))completionHandler{
    
    
    __block UNNotificationAttachment *attachment = nil;
    NSURL *attachmentURL = [NSURL URLWithString:urlStr];
    NSString *fileExt = [self fileExtensionForMediaType:type];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session downloadTaskWithURL:attachmentURL
                completionHandler:^(NSURL *temporaryFileLocation, NSURLResponse *response, NSError *error) {
                    if (error != nil) {
                        NSLog(@"%@", error.localizedDescription);
                    } else {
                        NSFileManager *fileManager = [NSFileManager defaultManager];
                        NSURL *localURL = [NSURL fileURLWithPath:[temporaryFileLocation.path stringByAppendingString:fileExt]];
                        [fileManager moveItemAtURL:temporaryFileLocation toURL:localURL error:&error];
                        
                        NSError *attachmentError = nil;
                        attachment = [UNNotificationAttachment attachmentWithIdentifier:@"" URL:localURL options:nil error:&attachmentError];
                        if (attachmentError) {
                            NSLog(@"%@", attachmentError.localizedDescription);
                        }
                    }
                    
                     completionHandler(attachment);
                    
                    
                }] resume];
    
    
    
}
- (NSString *)fileExtensionForMediaType:(NSString *)type {
    NSString *ext = type;
    
    
     if ([type isEqualToString:@"image"]) {
        ext = @"jpg";
    }
    
    if ([type isEqualToString:@"video"]) {
        ext = @"mp4";
    }
    
    if ([type isEqualToString:@"audio"]) {
        ext = @"mp3";
    }
    
    return [@"." stringByAppendingString:ext];
}




 

@end
