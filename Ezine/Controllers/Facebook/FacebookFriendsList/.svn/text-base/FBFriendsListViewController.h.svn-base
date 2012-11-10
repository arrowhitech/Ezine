//
//  FBFriendsListViewController.h
//  Ezine
//
//  Created by MAC on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "EzineAppDelegate.h"
#import "FBFeedPost.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "VariableStore.h"
#import "FbFriendsListDelegate.h"


@interface FBFriendsListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FBRequestDelegate, FBSessionDelegate>{
    NSMutableArray *arrayFriends;
    VariableStore   *variabelStore;
    int             currentAPI;
}
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain)   HJObjManager* imgMan;
@property (retain, nonatomic) IBOutlet UITableView *tableListFriends;
@property(nonatomic,assign) id <FbFriendsListDelegate> delegate;
@property                   int     currentAPI;
- (IBAction)btnBackClick:(id)sender;

-(void)getApiFacebook;
-(void)getGroups;
@end
