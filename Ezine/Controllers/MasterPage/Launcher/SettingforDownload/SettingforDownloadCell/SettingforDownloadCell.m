//
//  SettingforDownloadCell.m
//  Ezine
//
//  Created by Admin on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingforDownloadCell.h"

@implementation SettingforDownloadCell

@synthesize titleName;
@synthesize Swcell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

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
    
    
    [titleName release];
    titleName =nil;
    
    [Swcell release];
    Swcell =nil;
    
    [super dealloc];
}

@end
