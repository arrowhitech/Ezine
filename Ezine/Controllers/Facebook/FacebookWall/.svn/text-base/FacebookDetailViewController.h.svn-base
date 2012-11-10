//
//  FacebookDetailViewController.h
//  Ezine
//
//  Created by MAC on 7/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FBFeedPost.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "AFKPageFlipper.h"
#import "FbListPopUpViewController.h"
#import "FbListPopUpDelegate.h"

@protocol FacebookDetailViewControllerDelegate <NSObject>

-(void)backToMainView;

@end

@interface FacebookDetailViewController : UIViewController<FBRequestDelegate, FBSessionDelegate,AFKPageFlipperDataSource,FbListPopUpDelegate>{
    int currentAPICall;
    AFKPageFlipper *flipper;
    NSMutableArray *arrayNewFeed;
    NSMutableArray *arrayViewController;
    HJManagedImageV *ImageProlife;
    FbListPopUpViewController *fbListView;
    BOOL            isGetFriendsList;
}
@property     int currentAPICall;
@property (nonatomic, assign)id<FacebookDetailViewControllerDelegate>delegate;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UIButton *btn_showList;
@property (retain, nonatomic) IBOutlet UILabel *lableFbList;
@property (nonatomic, retain)    HJObjManager* imgMan;



- (IBAction)btnShowListClick:(id)sender;

-(void)getApifeedFacebook:(int)ApiGet;

@end
