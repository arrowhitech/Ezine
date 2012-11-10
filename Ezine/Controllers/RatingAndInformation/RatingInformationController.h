//
//  RatingInformationController.h
//  Ezine
//
//  Created by Admin on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingItemCell.h"
#import "DYRateView.h"
#import "MyLauncherItem.h"
#import "MKNetworkKit.h"
#import "RateCommentController.h"
#import "SignInViewcontroller.h"
#import <QuartzCore/QuartzCore.h>

@interface GetRatingSite :MKNetworkEngine{
}

typedef void (^RatingSite)(NSDictionary* array);
-(void) listRaringSite:(int )SiteID onCompletion:(RatingSite) categoryBlock onError:(MKNKErrorBlock) errorBlock;

@end


@interface RatingInformationController : UIViewController<UITableViewDelegate,UITableViewDataSource,RateCommentDelegate,SignInViewcontrollerDelegate>{
    
    IBOutlet DYRateView  *ratingView;
    IBOutlet UITableView *tableview;
    RatingItemCell *cell;
    NSMutableArray *arrayRating;
    MyLauncherItem *_laucherItemSelect;
    GetRatingSite   *_getRatingSite;
    NSDictionary    *_dataRatingSite;
    IBOutlet UIImageView* igmwebIcon;
    
   
    
}

@property(nonatomic,retain)  IBOutlet DYRateView *ratingView;
@property(nonatomic,retain)  IBOutlet UITableView *tableview;
@property(nonatomic,retain)  NSMutableArray *arrayRating;
@property(nonatomic,retain)  MyLauncherItem *_laucherItemSelect;
@property (retain, nonatomic) IBOutlet UILabel *_nameSite;
@property (retain, nonatomic) IBOutlet UILabel *_numberRating;
@property (retain, nonatomic) IBOutlet UILabel *_numberComment;

@property(nonatomic,retain)  IBOutlet UIImageView* igmwebIcon;

@property (retain, nonatomic) IBOutlet UITextView *_comment;
@property (retain, nonatomic) IBOutlet UIButton *btnSent;
@property (retain, nonatomic) IBOutlet UIImageView *logoSite;


@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;


- (IBAction)btnSentCommentClick:(id)sender;

-(IBAction)btnCommentButtonClick:(id)sender;
-(BOOL)checkUserLogin;
-(NSString*)convertTime:(int)timecreate;
@end
