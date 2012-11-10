//
//  YourEzineControllerViewController.h
//  Ezine
//
//  Created by MAC on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"
#import "SectionHeaderView.h"
#import "SectionInfo.h"
@interface YourEzineControllerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SectionHeaderViewDelegate>{
    NSMutableArray  *_arraySiteUSer;
    NSMutableArray  *_arraySiteUSerAdd;
    int             _site;
    BOOL            _isLoginFacebook;
}
@property (nonatomic, strong) UITableView *menuTable;
@property (nonatomic, strong) MKNetworkOperation*   imageLoadingOperation;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSMutableArray* plays;

-(void) LoadDataSiteUser;
-(IBAction)btnModify:(id)sender;
- (void)showActivityIndicator;
- (void)hideActivityIndicator;


@end
