//
//  LaucherViewPageCell.m
//  Ezine
//
//  Created by MAC on 9/28/12.
//
//

#import "LaucherViewPageCell.h"

@implementation LaucherViewPageCell
@synthesize _info,_logoSite,_nameSite,_rateView,_numberChoose,_numberComment,_btnrRemoveSite;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:13.0f/255.0f green:154.0f/255.0f blue:251.0f/255.0f alpha:1.0f]];
    [self setSelectedBackgroundView:bgColorView];
    [bgColorView release];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_rateView release];
    [_logoSite release];
    [_nameSite release];
    [_numberChoose release];
    [_numberComment release];
    [_info release];
    [_btnrRemoveSite release];
    [super dealloc];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.editing) {
        [self._logoSite setFrame:CGRectMake(20+35, 10, 35, 40)];
        [self._nameSite setFrame:CGRectMake(70+35, 7, 295, 20)];
        [self._rateView setFrame:CGRectMake(70+35, 34, 97, 20)];
        [self._numberChoose setFrame:CGRectMake(170+35, 30, 127, 21)];
        [self._numberComment setFrame:CGRectMake(self._numberChoose.frame.origin.x+97+40, 32, 123, 21)];
        [self._info setFrame:CGRectMake(self.frame.size.width-68-35, 12, 32, 30)];

    }else{
        [self._logoSite setFrame:CGRectMake(20, 10, 35, 40)];
        [self._nameSite setFrame:CGRectMake(70, 7, 295, 20)];
        [self._rateView setFrame:CGRectMake(70, 34, 97, 20)];
        [self._numberChoose setFrame:CGRectMake(170, 32, 127, 21)];
        [self._numberComment setFrame:CGRectMake(self._numberChoose.frame.origin.x+97+40, 32, 123, 21)];
        [self._info setFrame:CGRectMake(self.frame.size.width-57, 12, 32, 30)];
    }

}
@end
