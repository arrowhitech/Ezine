//
//  MyLauncherViewController.h
//  Ezine
//
//  Created by PDG2 on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLauncherView.h"
#import "AFKPageFlipper.h"
#import "MyLauncherHeader.h"
#import "MyLauncherFooter.h"
#import "IASKAppSettingsViewController.h"
#import "CategoriesController.h"
#import "SearchKeyWordViewController.h"
#import "SettingforDownloadController.h"
#import "EzineAccountViewController.h"

@protocol MyLauncherViewControllersDelegate <NSObject>
@optional
- (void) finishSettingClick:(BOOL)ischangetypeShow fontsize:(BOOL) ischangeFontSize;
@end


@interface MyLauncherViewController : UIViewController<MyLauncherViewDelegate,MyLauncherHeaderDelegate,MyLauncherFooterDelegate,IASKSettingsDelegate,UITextViewDelegate,CategoriesControllerDelegate,UIPopoverControllerDelegate,SearchKeyWordViewControllerDelegate,SettingforDownloadControllerDelegate>{

    IASKAppSettingsViewController               *appSettingController;
    MyLauncherView                              *launcherView;
    CategoriesController                        *category;
    MyLauncherFooter                            *footer;
    
    EzineAccountViewController                  *ezineAccount;

    
    CGRect                                      screenBounds;
    int                                         _currentPage;
    int                                         _numberpage;
    
    int                                         _currentFontSize;
    
    NSMutableArray*                             arrForDownloadoff;
    
}
@property(nonatomic,retain) IASKAppSettingsViewController                   *appSettingController;
@property(nonatomic, retain) MyLauncherView                                 *launcherView;
@property  int                                                              _currentPage;

@property(nonatomic,assign)      id<MyLauncherViewControllersDelegate> delegate;
@property (nonatomic,retain)  UIPopoverController *popovercontroller;

-(void) initFooterView;
-(void) initalizeViews;
-(void) reLoad;
-(void) rotate;
-(void) reloadFontSize;

///===================
-(void)gotoFaceAcc;
-(void)gotoEzineAcc;

///=================
-(BOOL)checkUserEzineLogin;
-(BOOL)checkFBlogin;

@end

