//
//  AppDelegate.h
//  XZPushTest
//
//  Created by coderXu on 16/9/18.
//  Copyright © 2016年 coderXu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DDLOG(...) printf("%s\n",[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

