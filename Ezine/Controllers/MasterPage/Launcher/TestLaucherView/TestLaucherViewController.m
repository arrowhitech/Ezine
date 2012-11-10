//
//  TestLaucherViewController.m
//  Ezine
//
//  Created by MAC on 9/25/12.
//
//

#import "TestLaucherViewController.h"

@interface TestLaucherViewController ()

@end

@implementation TestLaucherViewController
@synthesize _scrollViewSite;
@synthesize _footer,_header,_arraysites;
@synthesize _numberPage;


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
    _arraysites=[[NSMutableArray alloc]init];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
#pragma mark---- built page
-(void)builtPage{
    
    _arraysites=[[NSMutableArray alloc] init];
    for (int i=0 ;i <[XAppDelegate._arrayAllSite count];i++) {
        [_arraysites addObject:[[[MyLauncherItem alloc] initWithSourceModel:[XAppDelegate._arrayAllSite objectAtIndex:i]] autorelease]];
    }
    
}
@end
