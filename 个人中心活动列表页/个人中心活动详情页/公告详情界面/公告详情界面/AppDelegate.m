//
//  AppDelegate.m
//  公告详情界面
//
//  Created by apple on 2016/12/26.
//  Copyright © 2016年 xkd. All rights reserved.
//

#import "AppDelegate.h"
#import "hdxViewController.h"
@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Override point for customization after application launch.
    [self setWindow:[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds]];
    [self.window makeKeyAndVisible];//去使被使用对象的主窗口显示到屏幕的最前端。你也可以使用hiddenUIView方法隐藏这个窗口
    UINavigationController*navcontroller=[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc]init] ];//UINavigationController本身没有显示的内容，所以它需要另外一个ViewController结合一起，initWithRootViewController是指定显示的第一个viewController
    [self.window setRootViewController:navcontroller];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
