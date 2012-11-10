//
//  FBDetailViewController.h
//  Ezine
//
//  Created by MAC on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MediaPlayer/MediaPlayer.h>

#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "FacebookDetailViewController.h"
#import "JsonFBNewFeed.h"
#import "FBlikeButton.h"
#import "FBFeedObject.h"
#import "FBFeedPost.h"
#import "AFKPageFlipper.h"

@interface FBDetailViewController : UIViewController<FBRequestDelegate,FBSessionDelegate>{
    UIActivityIndicatorView *activityIndicator;
    JsonFBNewFeed    *jsonFacebook;
    FBFeedObject      *jsonFbFeed;
    HJManagedImageV *ImageCenter;
    int currentApiCall;
    NSMutableArray  *arrayPhotos;
    
}
@property   int currentApicall;
@property   (nonatomic, retain)     JsonFBNewFeed    *jsonFacebook;
@property   (nonatomic, retain)     FBFeedObject      *jsonFbFeed;
@property   (nonatomic, retain)     AFKPageFlipper     *fliper; 

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain)    HJObjManager* imgMan;
@property (retain, nonatomic) IBOutlet UITextView *detailTitle;
@property (retain, nonatomic) IBOutlet UILabel *nameUser;
@property (retain, nonatomic) IBOutlet UILabel *shorttitleFeed;
@property (retain, nonatomic) IBOutlet UILabel *timeCreate;
@property (retain, nonatomic) IBOutlet UILabel *numberLike;
- (IBAction)btnComment:(id)sender;

@property (retain, nonatomic) IBOutlet UILabel *titleFeed;
- (IBAction)btnEzineClick:(id)sender;
-(void) loaddetail;
-(void) LoadDataOffFeed;
- (IBAction)btnLikeClick:(id)sender;
@end
