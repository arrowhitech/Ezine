//
//  EzineAppDelegate.h
//  Ezine
//
//  Created by PDG2 on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingInformationController.h"
#import "ServiceEngine.h"
#import "Database.h"
#import "GooglePlusShare.h"
#import "TestFlight.h"

#define XAppDelegate ((EzineAppDelegate *)[[UIApplication sharedApplication] delegate])
#define KDidLogoutEzineNotification @"KDidLogOutEzineNotification"
#define KDidLoginEzineNotification @"KDidLogInEzineNotification"

@class ListArticleViewController;
@class ArticleModel;
@class EzineViewController;
@class MessageModel;
@class UIViewExtention;
@class CoverViewController;
@class FirtViewController;

@interface EzineAppDelegate : UIResponder <UIApplicationDelegate>{
    
    Database *db;
    ServiceEngine *serviceEngine;
    int appFontSize;
    //Activity Indicator
     UIActivityIndicatorView* _spinner;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (strong, nonatomic) FirtViewController *viewController;
@property (strong, nonatomic) ServiceEngine *serviceEngine;
@property (retain, nonatomic) NSMutableArray *arrayIdSite;
@property (retain, nonatomic) NSMutableArray *_arrayAllSite;
@property (retain, nonatomic) NSMutableArray *_arrayAlldetailSiteID;
@property (retain, nonatomic) NSMutableArray *_arrayAlldetailArticleData;
//Hieu extra==========Activity Indicator=========
@property(nonatomic,retain)   UIActivityIndicatorView* _spinner;



@property (retain, nonatomic) NSString      *_typeshowSite;
@property(nonatomic,assign) int appFontSize;
@property sqlite3* database;
@property (nonatomic) BOOL  isAddKeyword;
// check if go to screen list article  don't update list site
@property BOOL      _isgotoListArticle;
+ (EzineAppDelegate *) instance;
-(void)showViewInFullScreen:(UIView*)viewToShow withModel:(ArticleModel*)model;
-(void)closeFullScreen;
-(void)initServiceEngine;
//Hieu
- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
