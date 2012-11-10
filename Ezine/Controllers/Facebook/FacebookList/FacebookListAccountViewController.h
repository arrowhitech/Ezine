//
//  FacebookListAccountViewController.h
//  Ezine
//
//  Created by MAC on 7/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "EzineAppDelegate.h"
#import "FBFeedPost.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "FBFriendsListViewController.h"
#import "FbFriendsListDelegate.h"
#import "FacebookDetailViewController.h"


@interface FacebookListAccountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FBRequestDelegate, FBSessionDelegate,FbFriendsListDelegate>{
    UIActivityIndicatorView *activityIndicator;
    int currentAPICall;
    NSString *urlImage;
}
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong)  IBOutlet  UITableView     *menuTable;
@property (nonatomic, retain)   HJObjManager* imgMan;
@property (retain, nonatomic) IBOutlet UIImageView *bgImage;
@property (retain, nonatomic) IBOutlet UIButton *btn_signOutClick;
@property (retain, nonatomic) IBOutlet UIButton *backClick;
- (IBAction)btnBackClick:(id)sender;

- (IBAction)btn_SignOutClick:(id)sender;
+(FacebookListAccountViewController*)shareInstance; 
-(void) getFbDetail;
@end
