//
//  AppDelegate.m
//  RevistaCulturaCia
//
//  Created by Fabricio Padua on 21/05/16.
//  Copyright © 2016 Pro Master Solution. All rights reserved.
//

#import "AppDelegate.h"


@import Firebase;
@import FirebaseMessaging;


#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    sleep(3);
    
    // Configure the view for the selected state
    UIColor *CorVerde = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:34/255.0 alpha:1];
    
    [[UINavigationBar appearance] setBarTintColor:CorVerde];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"helveticaneue-condensedbold" size:21.0], NSFontAttributeName, nil]];
    
    [[UITabBar appearance] setSelectedImageTintColor:CorVerde];
    
    [FIRApp configure];
    
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-6439752646521747~2431612917"];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshCallBack:) name:kFIRInstanceIDTokenRefreshNotification object:nil];
    
    UIUserNotificationType allNotificationTypes =
    (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
    
    UIUserNotificationSettings *settings =
    [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    

    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[FIRMessaging messaging] disconnect];
    NSLog(@"Disconect From FMC");
}

- (void)tokenRefreshCallBack:(NSNotification *)notification {
    
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    NSLog(@"InstanceID token: %@", refreshedToken);
    
    // Connect to FCM since connection may have failed when attempted before having a token.
    [self connectToFcm];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    // [Appirater appEnteredForeground:YES];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self connectToFcm];
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    
    NSLog(@"Message Id: %@", userInfo[@"gcm.message_id"]);
    
    NSLog(@"%@", userInfo[@"gcm.message_id"]);
    
}

- (void)connectToFcm {
    [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Unable to connect to FCM. %@", error);
        } else {
            NSLog(@"Connected to FCM.");
        }
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
