//
//  FirtViewController.h
//  Ezine
//
//  Created by MAC on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EzineAppDelegate.h"
#import "AFKPageFlipper.h"
#import "CategoriesController.h"
#import "MKNetworkKit.h"
#import "MyLauncherViewController.h"
#import "MPFlipViewController.h"
#import "MylauncherPageViewController.h"
#import "CoverViewController.h"

@interface FirtViewController : UIViewController<MPFlipViewControllerDelegate,MyLauncherViewControllersDelegate,MPFlipViewControllerDataSource,MylauncherPageViewControllerDelegate,CoverViewControllerDelegate>{
    CoverViewController             *result;
    MyLauncherViewController        *_currentLaucherView;
    

    NSDictionary                    *_dictFromService;
    NSMutableArray                  *_arrayMyLauncherViewController;

    int                             _currentPage;
    NSInteger                       activeIndex;
    BOOL                            _isTypeList;
    MylauncherPageViewController    *pageViewController;
    NSDictionary                    *cachedDataListAllsite;
    BOOL                            finishedBuildPage;
    BOOL                            isBuildingPage;
}
@property (nonatomic, retain)    NSDictionary                    *cachedDataListAllsite;

@property (strong, nonatomic) MPFlipViewController *flipViewController;
@property (nonatomic, retain)    CoverViewController             *result;

- (void) parseData:(NSDictionary*)dict;
- (void) showSettingViewcontroller;
- (void) loadDataWhenError;
- (void) didDeleteSite:(NSNotification *)notification;
- (void) didBeginEdittingSite:(NSNotification *)notification;
- (void) didEndEdittingSite:(NSNotification *)notification;
- (void) didChangeOrderSite:(NSNotification *)notification;
- (void) didAddSite:(NSNotification *)notification;
- (void) nextPage:(NSNotification *)notification;
- (void)didReloadSite:(NSNotification*)notification;
- (void)LoadTypeList;
- (void)updateMyLaucherView;
//- (void) previousPage:(NSNotification *)notification;

@end
