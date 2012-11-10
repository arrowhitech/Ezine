//
//  SettingAccountDetailController.m
//  Ezine
//
//  Created by Hieu  on 9/5/12.
//
//

#import "SettingAccountDetailController.h"
#import "ForgetPasswordController.h"
#import "ChangePasswordControllerViewController.h"
#import "ConfirmEmailController.h"
@interface SettingAccountDetailController ()

@end

@implementation SettingAccountDetailController
@synthesize naviBar;

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
    self.navigationController.navigationBarHidden =YES;
    self.title =@"Tài khoản Ezine";
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden =YES;
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark===============OK===============================

-(void)btnCancelClick:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];

}

-(void)btnFinishedClick:(id)sender{
    
   
}

-(void)btnChangeEmailClick:(id)sender{
   
    

    
}


-(void)btnChangePasswordClick:(id)sender{
    ChangePasswordControllerViewController *forgetpass =[[ChangePasswordControllerViewController alloc]initWithNibName:@"ChangePasswordControllerViewController" bundle:nil];
    
    [self.navigationController pushViewController:forgetpass animated:YES];
    
    
    
}

-(void)btnForgetEmailClick:(id)sender{
    
       

}
-(void)btnForgetPasswordClick:(id)sender{
    
    ForgetPasswordController *forgetpass =[[ForgetPasswordController alloc]initWithNibName:@"ForgetPasswordController" bundle:nil];
    
    [self.navigationController pushViewController:forgetpass animated:YES];

    
}

-(void)btnConfirmEmail:(id)sender{
    
    ConfirmEmailController *forgetpass =[[ConfirmEmailController alloc]initWithNibName:@"ConfirmEmailController" bundle:nil];
    
    [self.navigationController pushViewController:forgetpass animated:YES];

    
}
@end
