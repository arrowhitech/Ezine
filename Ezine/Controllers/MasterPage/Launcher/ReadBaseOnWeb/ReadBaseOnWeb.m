//
//  ReadBaseOnWeb.m
//  Ezine
//
//  Created by Hieu  on 9/19/12.
//
//

#import "ReadBaseOnWeb.h"

@interface ReadBaseOnWeb ()

@end

@implementation ReadBaseOnWeb
@synthesize webView;
@dynamic activityindicator;
@synthesize urlWeb;

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
    self.navigationController.navigationBarHidden=NO;
    [self setTitle:@"Đọc trên Web"];
    
    // add activityIndicator
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityindicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityindicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.view addSubview:activityindicator];
    
    NSURL *url = [NSURL URLWithString:urlWeb];
    NSLog(@"urlweb=====%@",urlWeb);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.webView.delegate = nil;
    [self setWebView:nil];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc{
    
    self.webView.delegate = nil;
    [webView release];
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden =NO;
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden=YES;
    [webView release];
    webView =nil;
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webViewDidStartLoad");
    [self showActivityindicator];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
    [self hideActivityindicator];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"didFailLoadWithError %@",error);
    [self hideActivityindicator];
}

/*
 * This method shows the activity indicator and
 * deactivates the table to avoid user input.
 */
- (void)showActivityindicator {
    if (![activityindicator isAnimating]) {
        [activityindicator startAnimating];
    }
}

/*
 * This method hides the activity indicator
 * and enables user interaction once more.
 */
- (void)hideActivityindicator {
    
    if ([activityindicator isAnimating]) {
        [activityindicator stopAnimating];
    }
    
}

@end
