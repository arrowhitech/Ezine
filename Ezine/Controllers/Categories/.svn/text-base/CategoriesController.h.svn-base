//
//  CategoriesController.h
//  Ezine
//
//  Created by MAC on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YourEzineControllerViewController.h"
#import "SourceNewsController.h"
#import "AccountViewController.h"
#import "SalientNewsViewController.h"
#import "MKNetworkKit.h"
#import "SearchSiteViewController.h"
#import "CategoriesCell.h"

@class AccountViewController;
@protocol CategoriesControllerDelegate <NSObject>

-(void) dismissCategories;

@end

@interface CategoriesController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SourceNewControllerDelegate,SalientNewsViewControllerDelegate>{
    
    UITableView *menuTables;
    SourceNewsController *sourceNews;
    YourEzineControllerViewController *yourEzine;
    AccountViewController   *accountScreen;
    SalientNewsViewController *salientNewsScreen;
    BOOL isShowMenu;
    NSMutableArray  *CategoriesInform;
    int weight;
    SearchSiteViewController    *searchSite;
    CategoriesCell *currentCell;
}
@property (assign, nonatomic) id<CategoriesControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UISearchBar *searchInformation;
@property (retain, nonatomic) IBOutlet UILabel *labelDetail;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain)    UITableView *menuTables;
@property (retain, nonatomic) IBOutlet UIImageView *bg_image;


- (void)fetchedData;
-(void)changedLandScape;
-(void)changePortrait;
-(void)orientationChanged;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
