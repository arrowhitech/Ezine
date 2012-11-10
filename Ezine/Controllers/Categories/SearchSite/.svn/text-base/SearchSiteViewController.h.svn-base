//
//  SearchSiteViewController.h
//  Ezine
//
//  Created by MAC on 8/15/12.
//
//

#import <UIKit/UIKit.h>
#import "MKNetworkKit.h"
#import "EzineAppDelegate.h"
#import "SourceCell.h"
#import "SiteObject.h"
#import "EzineAppDelegate.h"
@interface SearchSiteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
        
    NSMutableArray      *_arrayDataSite;
    NSString            *_nameSearch;
}

@property (nonatomic, strong) UITableView *menuTable;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;

-(void)fetchedData:(NSMutableArray *)data;
-(void)startSearchSite:(NSString *)nameSite;
@end
