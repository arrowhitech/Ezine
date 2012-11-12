//
//  MylauncherPageViewController.h
//  Ezine
//
//  Created by MAC on 9/28/12.
//
//

#import <UIKit/UIKit.h>
#import "EzineAppdelegate.h"
#import "MKNetworkKit.h"
#import "MyLauncherFooter.h"
#import "MyLauncherHeader.h"
#import "LaucherViewPageCell.h"
#import "CategoriesController.h"
#import "IASKAppSettingsViewController.h"
#import "SearchKeyWordViewController.h"
#import "ListArticleViewController.h"
#import "SettingforDownloadController.h"
#import "IASKSpecifier.h"
#import "SettingDeleteDataView.h"

@protocol MylauncherPageViewControllerDelegate <NSObject>

- (void) finishSettingClickInPageView:(BOOL)ischangetypeShow fontsize:(BOOL) ischangeFontSize;
@optional

@end

@interface MylauncherPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MyLauncherFooterDelegate,MyLauncherHeaderDelegate,CategoriesControllerDelegate,SearchKeyWordViewControllerDelegate,UIPopoverControllerDelegate,IASKSettingsDelegate,UIGestureRecognizerDelegate,SettingforDownloadControllerDelegate>{
    UITableView *_tableviewSite;
    int         _site;
    NSMutableArray  *_arraySiteUSer;
    MyLauncherFooter                            *footer;
    CGRect                                      screenBounds;
    LaucherViewPageCell *_currentCell;
    IASKAppSettingsViewController               *appSettingController;
    int                                         _currentFontSize;
    
    NSMutableArray*                              arrForDownloadoff;

    NSIndexPath *indexPath2;
}
@property(nonatomic, retain) UITableView *_tableviewSite;
@property (nonatomic, strong) MKNetworkOperation*   imageLoadingOperation;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain) IASKAppSettingsViewController                   *appSettingController;
@property (nonatomic,retain)  UIPopoverController *popovercontroller;
@property (nonatomic,assign) id<MylauncherPageViewControllerDelegate>delegate;
@property (nonatomic, retain)    LaucherViewPageCell *_currentCell;

-(void) LoadDataSiteUser;
- (void)showActivityIndicator;
- (void)hideActivityIndicator;
-(void)SetFooterView;
-(void)setHeaderView;
- (void)rejustLayout:(UIInterfaceOrientation)interfaceOroemtation;
@end
