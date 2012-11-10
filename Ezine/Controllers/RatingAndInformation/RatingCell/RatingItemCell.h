//
//  RatingItemCell.h
//  Ezine
//
//  Created by Admin on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
@interface RatingItemCell : UITableViewCell{
}

@property(nonatomic,retain) IBOutlet UILabel *lbltitle;
@property(nonatomic,retain) IBOutlet UILabel *lblusername;
@property(nonatomic,retain) IBOutlet UILabel *lblcontent;
@property(nonatomic,retain) IBOutlet UILabel *lbltime_ago;

@end
