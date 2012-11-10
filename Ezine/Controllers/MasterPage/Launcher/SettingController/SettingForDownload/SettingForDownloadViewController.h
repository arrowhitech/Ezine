//
//  SettingForDownloadViewController.h
//  Ezine
//
//  Created by Admin on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IASKAppSettingsViewController.h"

@interface SettingForDownloadViewController : IASKAppSettingsViewController <IASKSettingsDelegate>
{
    
    IBOutlet UINavigationBar *naviBar;
    
}

@property(nonatomic,retain) IBOutlet UINavigationBar *naviBar;




@end
