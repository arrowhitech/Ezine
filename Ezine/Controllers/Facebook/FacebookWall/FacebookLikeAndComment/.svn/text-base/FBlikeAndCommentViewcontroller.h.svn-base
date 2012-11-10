//
//  FBlikeAndCommentViewcontroller.h
//  Ezine
//
//  Created by MAC on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBPostCommentController.h"
#import "FBFeedObject.h"
#import "FBFeedPost.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"


@interface FBlikeAndCommentViewcontroller : UIViewController<FBRequestDelegate,FBSessionDelegate,UITableViewDataSource,UITableViewDelegate>{
    FBFeedObject      *jsonFbFeed;
    NSMutableArray    *arrayComment;
    NSMutableArray    *arrayLike;
    BOOL               isShowComment; 

}
@property (nonatomic,retain)    FBFeedObject      *jsonFbFeed;
@property (nonatomic, retain)   HJObjManager* imgMan;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UITableView *tableCommentAndLike;

- (IBAction)btnLikesClicks:(id)sender;
- (IBAction)btnCommentClicks:(id)sender;
-(void)showIn;
-(void)showOut;
@end
