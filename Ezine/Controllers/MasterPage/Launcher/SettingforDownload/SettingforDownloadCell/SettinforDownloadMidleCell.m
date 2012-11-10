//
//  SettinforDownloadMidleCell.m
//  Ezine
//
//  Created by Admin on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettinforDownloadMidleCell.h"

@implementation SettinforDownloadMidleCell

@synthesize btnChooseAll;
@synthesize btnDisableAll;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor =[UIColor clearColor];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    [btnDisableAll release];
    btnDisableAll =nil;
    
    [btnChooseAll release];
    btnChooseAll  = nil;
        
    [super dealloc];
}
#pragma mark--- action handle
-(void)btnChooseAllClick:(id)sender{
   // NSLog(@"chooseAll click");
    if (self.delegate&&[self.delegate respondsToSelector:@selector(chooseAllSite:)]) {
        [self.delegate chooseAllSite:sender];
    }
}

-(void)btnDisableAllClick:(id)sender{
    NSLog(@"disable all click");
    if (self.delegate&&[self.delegate respondsToSelector:@selector(disableAllsite:)]) {
        [self.delegate disableAllsite:sender];
    }

}

@end
