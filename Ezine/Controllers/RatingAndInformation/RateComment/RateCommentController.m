//
//  RateCommentController.m
//  Ezine
//
//  Created by MAC on 9/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RateCommentController.h"

@interface RateCommentController ()

@end

@implementation RateCommentController
@synthesize  navibar,judge,comment;
@synthesize textCommented;
@synthesize siteID,activityIndicator;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
   DYRateView* ratingView =[[DYRateView alloc]initWithFrame:CGRectMake(196, 60, 180, 24)fullStar:[UIImage imageNamed:@"StarFullLarge.png"] emptyStar:[UIImage imageNamed:@"StarEmptyLarge.png"]];
   
    ratingView.padding = 15;
    ratingView.alignment = RateViewAlignmentCenter;
    ratingView.editable = YES;
    ratingView.delegate = self;
    [self.view addSubview:ratingView];
    textCommented =[[NSString alloc]init];
    //textCommented =comment.text;
    [ratingView release];
     
    
    
    
   // NSLog(@"textCommented======%@",comment.text);
    
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicator];
    
    NSNumber *number =  [[NSUserDefaults standardUserDefaults] objectForKey:@"EzineAccountID"];
    userID = [number intValue];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
-(IBAction)CancelButtonClick:(id)sender{
      [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)SendButtonCLick:(id)sender {
    NSLog(@"Sended=====");
    [self showActivityIndicator];
    
    NSLog(@"userID userID userID ====%d",userID);
    NSLog(@"=============================");
    NSLog(@"SiteID Site ID SIte ID====%d  %@",siteID,comment.text);
    if (userID<=0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Gửi bình luận" message:@"Đăng nhập để gửi bình luận" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
        [self hideActivityIndicator];
    }else{
        [XAppDelegate.serviceEngine SentCommentwithSiteident:siteID userident:userID withComment:comment.text onCompletion:^(NSDictionary *responseDict) {
            
            [self fetchedDataSendComment:responseDict];
            
        }onError:^(NSError *error) {
            
        }];

    }
      

}



#pragma mark - DYRateViewDelegate

- (void)rateView:(DYRateView *)rateView changedToNewRate:(NSNumber *)rate {
    
    NSLog(@"userID Rate delegate and Siteid==== :%d%d",userID,siteID);
    NSLog(@"Rate count===%d  %d   %d",[rate intValue],siteID,userID);
    if (userID<=0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Gửi bình luận" message:@"Đăng nhập để gửi đánh giá" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
        [self hideActivityIndicator];
    }else{
        [XAppDelegate.serviceEngine RatewithSiteID:userID anduserID:siteID andRateMark:[rate intValue] onCompletion:^(NSDictionary *responseDict) {
            
            [self fetchedDataRatetingStar:responseDict];
            
        } onError:^(NSError *error) {
            
        }];

    }
    }

///============FetchedDataRatingStar======================

-(void)fetchedDataRatetingStar:(NSDictionary *)data{
    
    //[self hideActivityIndicator];
        
    BOOL result=[[data objectForKey:@"Success"] boolValue];
    NSLog(@"result==%@",data);
    // NSLog(@"userid: %d",userID);
    if (result==true) {
            
             
    }else{
        NSString *message=[data objectForKey:@"Message"];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Không thể gửi đánh giá" message:message delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}




#pragma mark ====UItextViewDelegate================OK=======





-(void)dealloc{
    
    [super dealloc];
    [textCommented release];
    textCommented =nil;
    
}
-(void)fetchedDataSendComment:(NSDictionary *)data{
   
    [self hideActivityIndicator];
    NSLog(@"======%@",data);
    
    if ([comment.text length]==0) {
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Bình Luận" message:@"Chưa viết bình luận" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }

    BOOL result=[[data objectForKey:@"Success"] boolValue];
    NSLog(@"result==%d",result);
   // NSLog(@"userid: %d",userID);
    if (result==true) {
        if (self.delegate) {
            
            [self.delegate commentdidFinished];
        }
        
        [self dismissModalViewControllerAnimated:YES];
        
    }else{
        NSString *message=[data objectForKey:@"Message"];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Cannot send Comment" message:message delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}


/*
 * This method shows the activity indicator and
 * deactivates the table to avoid user input.
 */
- (void)showActivityIndicator {
    if (![activityIndicator isAnimating]) {
        [activityIndicator startAnimating];
    }
}

/*
 * This method hides the activity indicator
 * and enables user interaction once more.
 */
- (void)hideActivityIndicator {
    
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    
}


@end
