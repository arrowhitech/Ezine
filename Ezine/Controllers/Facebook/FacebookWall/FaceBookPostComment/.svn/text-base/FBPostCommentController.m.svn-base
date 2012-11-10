//
//  FBPostCommentController.m
//  Ezine
//
//  Created by MAC on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBPostCommentController.h"
#import "VariableStore.h"

@interface FBPostCommentController ()

@end

@implementation FBPostCommentController
@synthesize jsonFbFeed;
@synthesize comment;
@synthesize name;
@synthesize imgMan;

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
    // Do any additional setup after loading the view from its nib.
    self.imgMan = [[[HJObjManager alloc] init] autorelease];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/imgtable/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] retain];
	self.imgMan.fileCache = fileCache;
    
    NSString    *urlImage=[[NSUserDefaults standardUserDefaults]objectForKey:@"urlProfile"];
    NSString    *nameUSer=[[NSUserDefaults standardUserDefaults]objectForKey:@"nameProfile"];
    name.text=nameUSer;
    HJManagedImageV *ImagePark2=[[HJManagedImageV alloc]initWithFrame:CGRectMake(100, 342, 40, 40)];
    ImagePark2.imageView.contentMode=UIViewContentModeScaleToFill;
    NSURL *url = [NSURL URLWithString:urlImage];
    ImagePark2.url = url;
    ImagePark2.oid =nil;
    [self.imgMan manage:ImagePark2];
    [self.view addSubview:ImagePark2];
    
}

- (void)viewDidUnload
{
    [self setComment:nil];
    [self setName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark--- show in show out

-(void)showIn{
    CGRect menuFrame = self.view.frame;
    menuFrame.origin.y = 0;
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.view.frame = menuFrame;
                     } 
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
}

-(void)showOut{
    [comment resignFirstResponder];
    CGRect menuFrame = self.view.frame;
    menuFrame.origin.y =1024;
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.view.frame = menuFrame;
                     } 
                     completion:^(BOOL finished){
                           [self.view removeFromSuperview];
                         //                             if (self.delegate) {
                         //                                 [self.delegate backMenuClick];
                         //                             }
                         
                         
                     }];
    
}


- (IBAction)btnSendClick:(id)sender {
    if ([comment.text length]>=1) {
        NSString *idObject=[[NSString alloc] initWithFormat:@"%@",[jsonFbFeed.from objectForKey:@"id"]];
        NSLog(@"object id= %@",idObject);
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:comment.text, @"text",jsonFbFeed.object_id, @"object_id",nil];
        [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"comments.add" andParams:params andHttpMethod:@"POST" andDelegate:self];      
    }
         
        [self showOut];
}
   
- (void)dealloc {
    [comment release];
    [name release];
    [super dealloc];
}
#pragma mark---- 
#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    
	NSLog(@"ResponseFailed: %@", error);
	
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"request finish :%@",result);
}
@end
