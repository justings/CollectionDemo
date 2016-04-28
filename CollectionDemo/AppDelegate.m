//
//  AppDelegate.m
//  CollectionDemo
//
//  Created by guowei on 15/4/16.
//  Copyright (c) 2015年 guowei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NotePadViewController.h"
#import "MenuTableViewController.h"
#import "CalendarViewController.h"

#import "PKRevealController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MenuTableViewController *left = [[MenuTableViewController alloc] init];
//    CalendarViewController *vc = [[CalendarViewController alloc] init];
    NotePadViewController *noteVC = [[NotePadViewController alloc] init];
    
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:noteVC];
    
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:navc leftViewController:left rightViewController:nil];
    
    [revealController setMinimumWidth:230 maximumWidth:300 forViewController:left];
    
    self.window.rootViewController = revealController;
//    self.window.rootViewController = navc;
    [self.window makeKeyAndVisible];
    
    //设置栏标题颜色
    UINavigationBar * navBar = [[UINavigationBar alloc] init];
    if([navBar respondsToSelector:@selector(setBarTintColor:)]){
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f]];
    }else if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [[UINavigationBar appearance] setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:42/255.f green:104/255.f blue:217/255.f alpha:1.f]] forBarMetrics:UIBarMetricsDefault];
    }
    
    //导航栏标题颜色默认为白色
    [UINavigationBar appearance].titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}






@end
