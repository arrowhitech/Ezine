//
//  LayoutArticle14.m
//  Ezine
//
//  Created by MAC on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LayoutArticle14.h"
#import "UIViewExtention.h"
#import "NewListArticleItemView1.h"
#import "NewListArticleItemView2.h"
#import "NewListArticleItemView3.h"
#import "NewListArticleItemView4.h"
#import "NewListArticleItemView6.h"
#import "NewListArticleItemView7.h"
#import "NewListArticleItemView8.h"
#import "NewListArticleItemView9.h"


static const float GAP = 10;
static const int colsInPortrait = 3;
static const int colsInLandscape = 4;
static const float animationDuration = 0.5;
static const int spaceHeder = 56;
static const int spaceBottom = 50;

@implementation LayoutArticle14
@synthesize view1;
@synthesize view2;
@synthesize view3;
@synthesize view4;
@synthesize view5;
@synthesize view6;



-(void)initalizeViews:(NSArray*)viewCollectionDictonary{
    for (int i=0; i<[viewCollectionDictonary count]; i++) {
        ArticleModel *articalmode=[viewCollectionDictonary objectAtIndex:i];
        if ([articalmode._Zone isEqualToString:@"Zone1"]) {
            view1 =[[[NewListArticleItemView2 alloc] initWithMessageModel:articalmode andViewoder:1] retain];
            
        }else if ([articalmode._Zone isEqualToString:@"Zone2"]){
            view2 =[[[NewListArticleItemView2 alloc] initWithMessageModel:articalmode andViewoder:2] retain];
            
        }else if ([articalmode._Zone isEqualToString:@"Zone3"]){
            view3 =[[[NewListArticleItemView7 alloc] initWithMessageModel:articalmode andViewoder:3] retain];
            
        }else if ([articalmode._Zone isEqualToString:@"Zone4"]){
            view4 =[[[NewListArticleItemView9 alloc] initWithMessageModel:articalmode andViewoder:4] retain];
            
        }else if ([articalmode._Zone isEqualToString:@"Zone5"]){
            view5 =[[[NewListArticleItemView9 alloc] initWithMessageModel:articalmode andViewoder:5] retain];
            
        }else if ([articalmode._Zone isEqualToString:@"Zone6"]){
            view6 =[[[NewListArticleItemView9 alloc] initWithMessageModel:articalmode andViewoder:6] retain];
            
        }
    }

    
//    view1 =[[[NewListArticleItemView2 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:0]andViewoder:1] retain];
//    
//    view2 =[[[NewListArticleItemView2 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:1]andViewoder:2] retain];
//    view3 =[[[NewListArticleItemView7 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:2]andViewoder:3] retain];
//    view4 =[[[NewListArticleItemView9 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:3]andViewoder:4] retain];
//    view5 =[[[NewListArticleItemView9 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:4]andViewoder:5] retain];
//    view6 = [[[NewListArticleItemView9 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:5]andViewoder:6] retain];

    
    self.isFullScreen=   FALSE;
    view1.isFullScreen = FALSE;
    view2.isFullScreen = FALSE;
    view3.isFullScreen = FALSE;
    view4.isFullScreen = FALSE;
    view5.isFullScreen = FALSE;
    view6.isFullScreen = FALSE;
    
    
	[view1 setBackgroundColor:[UIColor whiteColor]];
	[view2 setBackgroundColor:[UIColor whiteColor]];
	[view3 setBackgroundColor:[UIColor whiteColor]];
    [view4 setBackgroundColor:[UIColor whiteColor]];
    [view5 setBackgroundColor:[UIColor whiteColor]];
    [view6 setBackgroundColor:[UIColor whiteColor]];
    
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];
    [self.view addSubview:view5];
    [self.view addSubview:view6];
}


-(void)rotate:(UIInterfaceOrientation)orientation animation:(BOOL)animation {
    self._interaceOrientation=orientation;

	[view1 setBackgroundColor:[UIColor whiteColor]];
	[view2 setBackgroundColor:[UIColor whiteColor]];
    [view3 setBackgroundColor:[UIColor whiteColor]];
    [view4 setBackgroundColor:[UIColor whiteColor]];
    [view5 setBackgroundColor:[UIColor whiteColor]];
    [view6 setBackgroundColor:[UIColor whiteColor]];
   
    
	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [footerView setFrame:CGRectMake(0, 1004 - 50, 768,50)];
    }else {
        [footerView setFrame:CGRectMake(0, 748 - 50, 1024,50)];
    }
    [footerView rotate:orientation animation:YES];
    [headerView rotate:orientation animation:YES];
    
    
	
	for (UIView* myview in [self.view subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
			if (self.isFullScreen) {
				if (!((UIViewExtention*)myview).isFullScreen) {
					[((UIViewExtention*)myview) setAlpha:0];
				}
			}else {
				[((UIViewExtention*)myview) setAlpha:1];
			}
		}
	}
	
	
	
	if (animation) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.50];
	}
	
	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
		if (view1 != nil) {
            
            [view1 setFrame:CGRectMake(-1, spaceHeder-1,384+2,428)];
            [view2 setFrame:CGRectMake(384,spaceHeder-1,384,428)];
            [view3 setFrame:CGRectMake(-1,426+spaceHeder,768+2,222)];
            [view4 setFrame:CGRectMake(-1,647+spaceHeder,256+2,261)];
            [view5 setFrame:CGRectMake(256,647+spaceHeder,256,261)];
            [view6 setFrame:CGRectMake(512,647+spaceHeder,256,261)];
           
            [view1 reAdjustLayout:orientation];
            [view2 reAdjustLayout:orientation];
            [view3 reAdjustLayout:orientation];
            [view4 reAdjustLayout:orientation];
            [view5 reAdjustLayout:orientation];
            [view6 reAdjustLayout:orientation];

            
            
        }
	}else {
		if (view1 != nil) {		
            
            [view1 setFrame:CGRectMake(0, spaceHeder-1,1024/3.0,(748-spaceHeder-spaceBottom)/2.0+1)];
            [view2 setFrame:CGRectMake(1024/3.0,spaceHeder-1,view1.bounds.size.width,view1.bounds.size.height)];
            [view3 setFrame:CGRectMake(1024*2/3.0,spaceHeder-1,view1.bounds.size.width,view1.bounds.size.height)];
            [view4 setFrame:CGRectMake(0,view1.bounds.size.height+spaceHeder,view1.bounds.size.width,view1.bounds.size.height)];
            [view5 setFrame:CGRectMake(1024/3.0,view1.bounds.size.height+spaceHeder,view1.bounds.size.width,view1.bounds.size.height)];
            [view6 setFrame:CGRectMake(1024*2/3.0,view1.bounds.size.height+spaceHeder,view1.bounds.size.width,view1.bounds.size.height)];
            [view1 reAdjustLayout:orientation];
            [view2 reAdjustLayout:orientation];
            [view3 reAdjustLayout:orientation];
            [view4 reAdjustLayout:orientation];
            [view5 reAdjustLayout:orientation];
            [view6 reAdjustLayout:orientation];

        }
	}
	
	if (animation) {
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];	
		[UIView commitAnimations];
	}else {
		for (UIView* myview in [self.view subviews]) {
			if ([myview isKindOfClass:[UIViewExtention class]]) {
				[((UIViewExtention*)myview) setAlpha:1];
			}
		}
        
        [view1 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        [view2 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        [view3 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        [view4 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        [view5 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        [view6 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        
		
	}
	
//	//rotate/adjust inner view
//	for (UIView* myview in [self.view subviews]) {
//		if ([myview isKindOfClass:[UIViewExtention class]]) {
//			[((UIViewExtention*)myview) rotate:orientation animation:YES];
//		}
//	}
	
}

- (void)animationEnd:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {	
	for (UIView* myview in [self.view subviews]) {
		if ([myview isKindOfClass:[UIViewExtention class]]) {
            [((UIViewExtention*)myview) setAlpha:1];
		}
	}
    [view1 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
    [view2 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
    [view3 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
    [view4 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
    [view5 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
    [view6 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
}
#pragma mark-- viewdidAppear
-(void)viewDidAppear:(BOOL)animated{
    [view1 LoadImage:self._interaceOrientation];
    [view2 LoadImage:self._interaceOrientation];
    [view3 LoadImage:self._interaceOrientation];
    [view4 LoadImage:self._interaceOrientation];
    [view5 LoadImage:self._interaceOrientation];
    [view6 LoadImage:self._interaceOrientation];
    [headerView checkSite];

    [super viewDidAppear:animated];
}

- (void) dealloc{
    
	[view1 release];
	[view2 release];
    [view3 release];
    [view4 release];
    [view5 release];
    [view6 release];
   
	
    
    
    [super dealloc];
}



@end
