//
//  ForgetPasswordController.m
//  Ezine
//
//  Created by Hieu  on 9/5/12.
//
//

#import "ForgetPasswordController.h"

@interface ForgetPasswordController ()

@end

@implementation ForgetPasswordController
@synthesize forgetpass;
@synthesize activityIndicator;

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
    self.navigationController.navigationBarHidden =NO;
    self.title=@"Cài đặt tài khoản";
    [self.forgetpass  setDelegate:self];
    [self.forgetpass  setReturnKeyType:UIReturnKeyDone];
    
    
    
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityIndicator];
    
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden=YES;
}
-(IBAction)btnSendButtonCLick:(id)sender{
    
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark == handle touch anyobject hiden virtual keyboard

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // NSLog(@"touch");
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.phase==UITouchPhaseBegan) {
        [forgetpass resignFirstResponder];
       
    }
    [super touchesBegan:touches withEvent:event];
}


#pragma mark======UITextFieldDelegate======OK============
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.forgetpass       resignFirstResponder];
 
    
    return  YES;
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
