//
//  LaucherViewPageCell.h
//  Ezine
//
//  Created by MAC on 9/28/12.
//
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"


@interface LaucherViewPageCell : UITableViewCell
@property (retain, nonatomic) IBOutlet DYRateView *_rateView;
@property (retain, nonatomic) IBOutlet UIImageView *_logoSite;
@property (retain, nonatomic) IBOutlet UILabel *_nameSite;
@property (retain, nonatomic) IBOutlet UILabel *_numberChoose;
@property (retain, nonatomic) IBOutlet UILabel *_numberComment;
@property (retain, nonatomic) IBOutlet UIButton *_info;
@property (retain, nonatomic) IBOutlet UIButton *_btnrRemoveSite;


//demo git =====

@end
