//
//  SettinforDownloadMidleCell.h
//  Ezine
//
//  Created by Admin on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettinforDownloadMidleCellDelegate <NSObject>

-(void)chooseAllSite:(id)sender;
-(void)disableAllsite:(id)sender;

@end

@interface SettinforDownloadMidleCell : UITableViewCell{
    
    IBOutlet UIButton *btnChooseAll;
    IBOutlet UIButton *btnDisableAll;
    
}
@property (nonatomic, assign)id <SettinforDownloadMidleCellDelegate> delegate;
@property(nonatomic,retain)   IBOutlet UIButton *btnChooseAll;
@property(nonatomic,retain)   IBOutlet UIButton *btnDisableAll;
-(IBAction)btnChooseAllClick:(id)sender;
-(IBAction)btnDisableAllClick:(id)sender;

@end

