//
//  AppDelegate.m
//  FitEmily
//
//  Created by Aaven Jin on 2/2/15.
//  Copyright (c) 2015 FE. All rights reserved.
//

#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "FYWeChatNetwork.h"
#import "Define.h"

@interface AppDelegate ()
{
    //FYWeChatNetwork *FYWeChatNetwork;
}
@end

@implementation AppDelegate

- (void)navigateWithAuthState {
    UIStoryboard *storyboard = ([PFUser currentUser] == nil)
    ? [UIStoryboard storyboardWithName:@"Auth" bundle:nil]
    : [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *rootVc;
    rootVc = [storyboard instantiateInitialViewController];
    
    [self.window setRootViewController:rootVc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:WeiXinAppId withDescription:AppDescription];

    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
//    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"rltt2RWp0rL6foHhe0LDTM080TEfdKjGKa8hTcqA"
                  clientKey:@"URv7Piz66urd7m54JB5IObyB1TsJDGq1av4DCeuW"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [self navigateWithAuthState];
    
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onReq:(BaseReq*)req{
    /*
    onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
    */
}

- (void)onResp:(BaseResp*)resp{
    /*
    如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
    */
    [[FYWeChatNetwork sharedManager] getWeiXinCodeFinishedWithResp:resp];
}

@end
