//
//  SettingforDownloadController.h
//  Ezine
//
//  Created by Admin on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettinforDownloadMidleCell.h"
@class SettingforDownloadCell;
@class SettinforDownloadMidleCell;

@protocol SettingforDownloadControllerDelegate <NSObject>

@optional
-(void)chooseDataforDownload:(UIViewController*)array;

@end

@interface SettingforDownloadController : UIViewController<UITableViewDataSource,UITableViewDelegate,SettinforDownloadMidleCellDelegate>{
    IBOutlet UITableView *tableview;
    SettingforDownloadCell*                                     cell;
    SettinforDownloadMidleCell*                                 midleCell;
    NSMutableArray*                                             arrayChoosen;
    
    IBOutlet UINavigationBar*                                   naviBar;
    NSInteger                                                   settingSwitch;
    NSMutableArray                                              *arrayIdSiteDownload;
    
    id<SettingforDownloadControllerDelegate>delegate;
    
}

@property(nonatomic,retain)  IBOutlet UITableView*              tableview;
@property(nonatomic,retain)  NSMutableArray*                    arrayChoosen;

@property(nonatomic,retain)     IBOutlet UINavigationBar*       naviBar;
@property (nonatomic,retain)    NSMutableArray                  *arrayIdSiteDownload;

@property(nonatomic,assign) id<SettingforDownloadControllerDelegate>delegate;

@end
