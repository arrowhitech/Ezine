//
//  SearchKeyWordViewController.m
//  Ezine
//
//  Created by MAC on 10/3/12.
//
//

#import "SearchKeyWordViewController.h"

@interface SearchKeyWordViewController ()

@end

@implementation SearchKeyWordViewController
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
	// Do any additional setup after loading the view.
    self.
    self.contentSizeForViewInPopover = CGSizeMake(300,180);
    [self.view setBackgroundColor:[UIColor colorWithRed:213 green:216 blue:221 alpha:0.8]];
    self.title=@"Tìm Kiếm";
    _keyword=[[UITextField alloc] initWithFrame:CGRectMake(5, 5,290, 120)];
    [_keyword setBackgroundColor:[UIColor whiteColor]];
    [_keyword setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_keyword];
    UIButton *searcButton=[[UIButton alloc] initWithFrame:CGRectMake(5, 130, 290, 43)];
    [searcButton addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [searcButton setBackgroundImage:[UIImage imageNamed:@"btn_searchKeyword.png"] forState:UIControlStateNormal];
    [self.view addSubview:searcButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchClick:(id)sender{
    if (_keyword.text.length>1) {
        [self dismissModalViewControllerAnimated:YES];
        [_keyword resignFirstResponder];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(searchKeywordClick:)]) {
            XAppDelegate.isAddKeyword=NO;
            [self.delegate searchKeywordClick:_keyword.text];
        }
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Tìm kiếm" message:@"Hãy nhập vào từ khoá để tìm kiếm" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}
@end
