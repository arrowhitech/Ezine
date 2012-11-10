//
//  FBPostCommentController.h
//  Ezine
//
//  Created by MAC on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBFeedObject.h"
#import "FBFeedPost.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"

@interface FBPostCommentController : UIViewController<FBSessionDelegate,FBRequestDelegate>{
    FBFeedObject      *jsonFbFeed;
 
}
@property (nonatomic,retain)    FBFeedObject      *jsonFbFeed;
@property (nonatomic, retain)   HJObjManager* imgMan;
@property (retain, nonatomic) IBOutlet UITextField *comment;
@property (retain, nonatomic) IBOutlet UILabel *name;

- (IBAction)btnSendClick:(id)sender;
-(void)showIn;
-(void)showOut;
@end
