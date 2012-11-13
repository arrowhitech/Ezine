//
//  EzineAppDelegate.m
//  Ezine
//
//  Created by PDG2 on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "ListArticleViewController.h"
#import "EzineAppDelegate.h"
#import "SDURLCache.h"
#import "KVImageCache.h"
#import "CoverViewController.h"
#import "FirtViewController.h"
#import "MyLauncherViewController.h"
#import "SettingsViewController.h"
@implementation EzineAppDelegate

@synthesize window ;
@synthesize viewController ;
@synthesize navigationController;
@synthesize serviceEngine = serviceEngine;
@synthesize arrayIdSite,_arrayAllSite,_arrayAlldetailSiteID,_arrayAlldetailArticleData;
@synthesize database,isAddKeyword;
@synthesize _typeshowSite,_isgotoListArticle;

//Hieu Extra ======
@synthesize _spinner;

@synthesize appFontSize;
+ (EzineAppDelegate *) instance {
	return (EzineAppDelegate *) [[UIApplication sharedApplication] delegate];
}

-(void)initServiceEngine{
    self.serviceEngine = [[ServiceEngine alloc] initWithHostName:@"api.ezine.vn" customHeaderFields:nil];
    [self.serviceEngine useCache];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
     [TestFlight takeOff:@"56d7fec6ce5b27f335ffa7d32b03e6e0_MTUyNzk3MjAxMi0xMS0wOCAyMzozNzoxNy43Nzc1MzM"];
    
    arrayIdSite=[[NSMutableArray alloc] init];
    _arrayAllSite=[[NSMutableArray alloc] init];
    _arrayAlldetailSiteID=[[NSMutableArray alloc] init];
    _arrayAlldetailArticleData=[[NSMutableArray alloc] init];
    _isgotoListArticle=NO;
    isAddKeyword=NO;
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"KEYWORDSEARCHALLSITE"];
    NSNumber *fontsize =[[NSUserDefaults standardUserDefaults] objectForKey:@"AppfontSize"];
    if (fontsize==nil) {
        // NSLog(@"nilllllllll");
        appFontSize =0;
    }
    appFontSize=[fontsize intValue];
    NSString   *sessionID=[[NSUserDefaults standardUserDefaults] objectForKey:@"EzineAccountSessionId"];
    if (sessionID) {
        NSLog(@"sessionID===%@",sessionID);
        NSDictionary *header=[[NSDictionary alloc] initWithObjectsAndKeys:sessionID,@"ASP.NET_SessionId", nil];
        self.serviceEngine = [[ServiceEngine alloc] initWithHostName:@"api.ezine.vn" customHeaderFields:header];
        [self.serviceEngine useCache];
        arrayIdSite= nil;

        
    }else{
        self.serviceEngine = [[ServiceEngine alloc] initWithHostName:@"api.ezine.vn" customHeaderFields:nil];
        [self.serviceEngine useCache];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSData *data = [defaults objectForKey:@"IdAllSite"];
//        NSMutableArray* arraySite = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        arrayIdSite=[arraySite mutableCopy];
        arrayIdSite= nil;

    }
    // Activity Indicator==========OKey==================
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.autoresizingMask =UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    
       // database
    db =[[Database alloc]init];
	[db createEditableCopyOfDatabaseIfNeeded];
	database = [db openDatabase];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[FirtViewController alloc] initWithNibName:@"FirtViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.navigationController.navigationBarHidden = YES;
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
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
    [[NSNotificationCenter defaultCenter] postNotificationName: @"didEnterBackground"
                                                        object: nil
                                                      userInfo: nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground");
    [[NSNotificationCenter defaultCenter] postNotificationName: @"WillEnterForeground"
                                                        object: nil
                                                      userInfo: nil];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)showViewInFullScreen:(UIView*)viewToShow withModel:(ArticleModel*)model{
    NSLog(@"Applidelegate showViewInFullScreen ");
 	for (int i= self.navigationController.viewControllers.count-1;i>=0;i--) {
        UIViewController *vc =[self.navigationController.viewControllers objectAtIndex:i];
        if ([vc isMemberOfClass:[ListArticleViewController class]]) {
            ListArticleViewController *la=(ListArticleViewController*)vc;
            if (viewToShow==nil) {
                UIView *view=[la.flipViewController.view.subviews lastObject];
                NSLog(@"aaaaa wwwfffff===%@",view.subviews);
                [la showViewInFullScreen:[view.subviews objectAtIndex:0] withModel:model];
                
            }else{
                [la showViewInFullScreen:viewToShow withModel:model];
            }
            break;
        }
    }
// show in coverView Controller
    UIViewController *listview=nil;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isMemberOfClass:[ListArticleViewController class]]){
            listview=vc;
        }
    }
    if(listview==nil){
        ListArticleViewController *vc=[[ListArticleViewController alloc] initWithNibName:@"ListArticleViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc showViewInFullScreen:viewToShow withModel:model];

    }
    
}
-(void)closeFullScreen {
    NSLog(@"Applidelegate closeFullScreen ");
    for (int i=[self.navigationController.viewControllers count]-1;i>=0;i--) {
        UIViewController *vc=[self.navigationController.viewControllers objectAtIndex:i];
        if ([vc isMemberOfClass:[ListArticleViewController class]]) {
            ListArticleViewController *la=(ListArticleViewController*)vc;
            [la closeFullScreen];
            break;
        }
    }
    [self.viewController.result closeFullScreen];
}

-(void)dealloc{
    [window dealloc];
    [navigationController dealloc];
    [viewController release];
    [super dealloc];
}

#pragma mark============Hieu extra===========Okey===========
- (void)showActivityIndicator {
    if (![_spinner isAnimating]) {
        [_spinner startAnimating];
    }
}

/*
 * This method hides the activity indicator
 * and enables user interaction once more.
 */
- (void)hideActivityIndicator {
    if ([_spinner isAnimating]) {
        [_spinner stopAnimating];
    }
    
}

@end
