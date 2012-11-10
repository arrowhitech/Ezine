//
//  SettingforDownloadCell.h
//  Ezine
//
//  Created by Admin on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingforDownloadCell : UITableViewCell{
    
    IBOutlet UILabel  *titleName;
    IBOutlet UISwitch *Swcell;
    
}

@property(nonatomic,retain) IBOutlet UILabel  *titleName;
@property(nonatomic,retain) IBOutlet UISwitch *Swcell;


@end
