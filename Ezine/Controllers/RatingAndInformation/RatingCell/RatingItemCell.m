//
//  RatingItemCell.m
//  Ezine
//
//  Created by Admin on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RatingItemCell.h"

@implementation RatingItemCell

@synthesize lbltitle,lblcontent,lblusername,lbltime_ago;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [lbltitle release];
    lbltitle =nil;
    
    [lblcontent release];
    lblcontent = nil;
    
    [lbltime_ago release];
    lbltime_ago = nil;
    
    [lblusername release];
    lblusername = nil;
    
    [super dealloc];
}

@end
