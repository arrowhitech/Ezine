//
//  FbListPopUpViewController.h
//  Ezine
//
//  Created by MAC on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VariableStore.h"
#import <CoreLocation/CoreLocation.h>
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "FBFriendsListViewController.h"
#import "FbFriendsListDelegate.h"
#import "FbListPopUpDelegate.h"

@interface FbListPopUpViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FbFriendsListDelegate>{
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableListFb;
@property (nonatomic, retain)   HJObjManager* imgMan;
@property(nonatomic,assign) id <FbListPopUpDelegate> delegate;
@property   BOOL  isShowMenu;
@property (retain, nonatomic) IBOutlet UIImageView *bgImage;

-(void)showin;
-(void)showout;
@end
