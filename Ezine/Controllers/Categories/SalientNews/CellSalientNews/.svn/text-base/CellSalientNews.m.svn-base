//
//  CellSalientNews.m
//  Ezine
//
//  Created by MAC on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellSalientNews.h"

@implementation CellSalientNews
@synthesize imageNews;
@synthesize detailNews;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.detailNews.font=[UIFont fontWithName:@"UVNHongHaHep" size:30];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (self.detailNews.tag<3) {
        return;
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:13.0f/255.0f green:154.0f/255.0f blue:251.0f/255.0f alpha:1.0f]];
    [self setSelectedBackgroundView:bgColorView];
    [bgColorView release];

}

- (void)dealloc {
    [imageNews release];
    [detailNews release];
    [super dealloc];
}
@end
