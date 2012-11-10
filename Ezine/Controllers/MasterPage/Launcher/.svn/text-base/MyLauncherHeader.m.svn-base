//
//  MyLauncherHeader.m
//  Ezine
//
//  Created by PDG2 on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyLauncherHeader.h"
#import "CategoriesController.h"
#import "UIViewController+MJPopupViewController.h"
#import "EzineAppDelegate.h"

@implementation MyLauncherHeader
@synthesize currrentInterfaceOrientation,wallTitleText,delegate;
@synthesize imageLoadingOperation,_avatarUser;


-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
}

-(void) setWallTitleText:(NSString *)wallTitle {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector: @selector(didLogoutEzine:) name:KDidLogoutEzineNotification object: nil];
    [center addObserver:self selector: @selector(didLoginEzine:) name:KDidLoginEzineNotification object: nil];

	wallTitleText = wallTitle;
	UIImageView* userImageView = [[UIImageView alloc] init];
    UIImage *_image=[UIImage imageNamed:@"enzine_logo_header_n.png"];
	userImageView.image = _image;
	[userImageView setFrame:CGRectMake(13,(75-55)/2,188,60)];
	[self addSubview:userImageView];
	[userImageView release];
    
    plusButton = [[UIButton alloc] init];
    UIImage *downloadIcon=[UIImage imageNamed:@"masterpage_button_plus_n.png"];
    [plusButton setSelected:YES];
	[plusButton setImage:downloadIcon forState:UIControlStateSelected];
    [plusButton setHidden:NO];
    plusButton.backgroundColor = [UIColor clearColor];
    plusButton.showsTouchWhenHighlighted=YES;
    [plusButton setFrame:CGRectMake(768-70,-5,65,75)];
    //===== check user login
    NSNumber *useID= [[NSUserDefaults standardUserDefaults] objectForKey:@"EzineAccountID"];
    NSInteger userID=[useID integerValue];
    if (userID>0) {
        NSLog(@"logginn Ezine");
        NSString    *urlImage=[[NSUserDefaults standardUserDefaults]objectForKey:@"EzineAccountAvatar"];
        NSString    *name=[[NSUserDefaults standardUserDefaults]objectForKey:@"EzineAccountName"];
        _nameUser=[[UILabel alloc] init];
        [_nameUser setText:name];
        [_nameUser setFont:[UIFont fontWithName:@"Arial" size:20]];
        
        [_nameUser setTextColor:[UIColor blackColor]];
        [self addSubview:_nameUser];
        _avatarUser =[[UIImageView alloc] init];
        [_avatarUser setFrame:CGRectMake(self.frame.size.width-400, 20, 45, 45)];
        [_nameUser setFrame:CGRectMake(_avatarUser.frame.size.width+_avatarUser.frame.origin.x+15,30, 150, 20)];

        [_avatarUser setImage:[UIImage imageNamed:@"prolifeImage_createEzineAccount.png"]];
        EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
        if ((NSNull *)urlImage==[NSNull null]) {
            urlImage =@"";
        }
        self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlImage]
                                                              onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                  if([urlImage isEqualToString:[url absoluteString]]) {
                                                                      
                                                                      if (isInCache) {
                                                                         _avatarUser.image = fetchedImage;
                                                                      } else {
                                                                          UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                          loadedImageView.frame = _avatarUser.frame;
                                                                          loadedImageView.alpha = 0;
                                                                          [loadedImageView removeFromSuperview];
                                                                          
                                                                          self._avatarUser.image = fetchedImage;
                                                                          self._avatarUser.alpha= 1;
                                                                      }
                                                                  }
                                                              }];
        [self addSubview:_avatarUser];
    }else{
        NSLog(@"nottt  logginn Ezine");

    }
    //====end
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight){
        [plusButton setFrame:CGRectMake(1004-55,-5,65,75)];
    }else if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        [plusButton setFrame:CGRectMake(768-70,-5,65,75)];
    }
    [plusButton addTarget:self action:@selector(plusClick:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:plusButton];
    [[UIDevice currentDevice] orientation] ;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}
#pragma mark--- rotate
-(void)orientationChanged{
    NSLog(@"orientationChange header");
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        CGRect frame= self.frame;
        frame.size.width=1024;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.frame=frame;
        [plusButton setFrame:CGRectMake(1004-55,-5,65,75)];
        [_avatarUser setFrame:CGRectMake(self.frame.size.width-400, 20, 45, 45)];
        [_nameUser setFrame:CGRectMake(_avatarUser.frame.size.width+_avatarUser.frame.origin.x+15, 30, 150, 20)]     ;
        [UIView commitAnimations];
    }else if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        CGRect frame= self.frame;
        frame.size.width=768;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        self.frame=frame;
        [_avatarUser setFrame:CGRectMake(self.frame.size.width-400, 20, 45, 45)];
        [_nameUser setFrame:CGRectMake(_avatarUser.frame.size.width+_avatarUser.frame.origin.x+15, 30, 150, 20)] ;
        [plusButton setFrame:CGRectMake(768-70,-5,65,75)];
        [UIView commitAnimations];
    }
    
    
    
}

#pragma mark-----

-(void)plusClick:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(plusButtonClick)]) {
        [self.delegate plusButtonClick];
    }
    
}

-(void) dealloc {
	[wallTitleText release];
	[super dealloc];
}
#pragma mark-- logout
-(void) didLogoutEzine:(NSNotification*)notification{
    [_nameUser setText:@""];
    [_avatarUser setImage:nil];
}
#pragma mark-- logIn
-(void) didLoginEzine:(NSNotification*)notification{
    NSString    *urlImage=[[NSUserDefaults standardUserDefaults]objectForKey:@"EzineAccountAvatar"];
    NSString    *name=[[NSUserDefaults standardUserDefaults]objectForKey:@"EzineAccountName"];
    if (_nameUser) {
        _nameUser=nil;
        [_nameUser removeFromSuperview];
        [_avatarUser removeFromSuperview];
    }
    _nameUser=[[UILabel alloc] initWithFrame:CGRectMake(400, 30, 150, 20)];
    [_nameUser setText:name];
    [_nameUser setFont:[UIFont fontWithName:@"Arial" size:20]];
    [_nameUser setTextColor:[UIColor blackColor]];
    _nameUser.textAlignment=UITextAlignmentLeft;
    [self addSubview:_nameUser];
    _avatarUser =[[UIImageView alloc] init];
    [self addSubview:_avatarUser];
    [_avatarUser setFrame:CGRectMake(self.frame.size.width-400, 20, 45, 45)];
    [_nameUser setFrame:CGRectMake(_avatarUser.frame.size.width+_avatarUser.frame.origin.x+15, 30, 150, 20)];
    _nameUser.numberOfLines=0;
    [_nameUser sizeToFit];
    [_avatarUser setImage:[UIImage imageNamed:@"prolifeImage_createEzineAccount.png"]];
    
    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    if ((NSNull *)urlImage==[NSNull null]) {
        urlImage =@"";
    }
    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlImage]
                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                              if([urlImage isEqualToString:[url absoluteString]]) {
                                                                  
                                                                  if (isInCache) {
                                                                      _avatarUser.image = fetchedImage;
                                                                  } else {
                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                      loadedImageView.frame = _avatarUser.frame;
                                                                      loadedImageView.alpha = 0;
                                                                      [loadedImageView removeFromSuperview];
                                                                      
                                                                      self._avatarUser.image = fetchedImage;
                                                                      self._avatarUser.alpha= 1;
                                                                  }
                                                              }
                                                          }];

}

@end
