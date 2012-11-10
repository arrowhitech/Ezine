//
//  SourceNewsController.h
//  Ezine
//
//  Created by MAC on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"
#import "EzineAppDelegate.h"

@protocol SourceNewControllerDelegate <NSObject>

-(void)didSelectSite;

@end

@interface SourceNewsController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray          *_arrayDataListSite;
    NSMutableArray          *arrayNews;
    int                     _categoryID;
    NSDictionary            *_dataListSiteByCategoryID;
    EzineAppDelegate        *ezineDelegate;
}
@property (nonatomic, assign)id <SourceNewControllerDelegate>delegate;
@property (nonatomic, strong) UITableView *menuTable;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property                     int         _categoryID;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;
@end
