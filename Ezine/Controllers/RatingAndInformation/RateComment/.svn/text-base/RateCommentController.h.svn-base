//
//  RateCommentController.h
//  Ezine
//
//  Created by MAC on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "ServiceEngine.h"

@protocol RateCommentDelegate <NSObject>

-(void) commentdidFinished;


@end

@interface RateCommentController : UIViewController<DYRateViewDelegate,UITextViewDelegate>{
    IBOutlet UINavigationBar *navibar;
    IBOutlet UILabel *judge;
    IBOutlet UITextView *comment;
    NSString*  textCommented;
    
    UIActivityIndicatorView *activityIndicator;
    
    NSInteger siteID;
    
    int userID;
    
    id<RateCommentDelegate> delegate;
}
-(IBAction)CancelButtonClick:(id)sender;
-(IBAction)SendButtonCLick:(id)sender;


@property(nonatomic,retain) IBOutlet UINavigationBar *navibar;
@property(nonatomic,retain) IBOutlet UILabel *judge;
@property(nonatomic,retain) IBOutlet UITextView *comment;
@property(nonatomic,retain) NSString* textCommented;

@property(nonatomic,assign) NSInteger siteID;
 
@property (nonatomic,retain) id<RateCommentDelegate> delegate;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

-(void)fetchedDataSendComment:(NSDictionary*)data;

-(void)fetchedDataRatetingStar:(NSDictionary*)data;

@end
