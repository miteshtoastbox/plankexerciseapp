//
//  MWAppDelegate.m
//  MW
//
//  Created by Emil Izgin on 10/01/14.
//  Copyright (c) 2014 Emil Izgin. All rights reserved.
//

#import "MWAppDelegate.h"
#import "Appirater.h"
#import <Parse/Parse.h>

@implementation MWAppDelegate

@synthesize databaseName;
@synthesize databasePath;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //Parse Integration
    [Parse setApplicationId:@"8BDksGMSzBdV8GQEiJ11m60X34OnPyPocmFLR9oW"
                  clientKey:@"8NBTpGlblyxd9ahbHCWPWEx4Nxm7S0MmZlxVxQWX"];
    
    //And to track statistics around application opens
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Use the product identifier from iTunes to register a handler.
    [PFPurchase addObserverForProduct:INAPP_PRODUCT_ID block:^(SKPaymentTransaction *transaction) {
        // Write business logic that should run once this product is purchased.
        //isPro = YES; ??? do i need this ???
        //[[NSNotificationCenter defaultCenter] postNotificationName:INAPP_ENABLE object:nil];
    }];
    
    
    // App Rating
    [Appirater setAppId:@"622795937"];
    [Appirater setDaysUntilPrompt:7];
    [Appirater setUsesUntilPrompt:5];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:2];
    [Appirater setDebug:NO];
    
    // Set Database
    self.databaseName = @"mw.db";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [documentPaths objectAtIndex:0];
    
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    
    [self createAndCheckDatabase];
    
    // keep device active at all times
    application.idleTimerDisabled = YES;
    
    /* set navigation colors. check version first */
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    int ver_int = [ver intValue];
    
    if (ver_int < 7) {
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    }
    
    else {
        // do nothing for now.
        //[[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
        //[[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }

    
    [Appirater appLaunched:YES];
    return YES;
}


							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) createAndCheckDatabase
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success) return;
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:self.databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}

@end
