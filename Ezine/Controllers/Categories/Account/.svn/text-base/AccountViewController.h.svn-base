//
//  AccountViewController.h
//  Ezine
//
//  Created by MAC on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EzineAccountViewController.h"
#import "FBFeedPost.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "AccountDetailController.h"
#import "FacebookListViewController.h"

@protocol AccountViewControllerDelegate <NSObject>

-(void)didGotoFacebook;

@end

@class EzineAccountViewController;
 
@interface AccountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FBRequestDelegate, FBSessionDelegate,AccountDetailControllerDelegate>{
     EzineAccountViewController *ezineAccount;
    BOOL    islogin;
    BOOL    isloginEzine;

}
@property (nonatomic, retain)   HJObjManager* imgMan;
@property (nonatomic, strong) UITableView *menuTable;
@property (nonatomic, assign)id <AccountDetailControllerDelegate>delegate;
@end
