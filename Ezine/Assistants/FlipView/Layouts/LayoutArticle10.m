//
//  LayoutArticle10.m
//  Ezine
//
//  Created by MAC on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LayoutArticle10.h"
#import "UIViewExtention.h"
#import "NewListArticleItemView1.h"
#import "NewListArticleItemView2.h"
#import "NewListArticleItemView3.h"
#import "NewListArticleItemView4.h"
#import "NewListArticleItemView6.h"
#import "NewListArticleItemView7.h"
#import "NewListArticleItemView8.h"
#import "NewListArticleItemView9.h"
#import "NewListArticleItemView10.h"

static const float GAP = 10;
static const int colsInPortrait = 3;
static const int colsInLandscape = 4;
static const float animationDuration = 0.5;
static const int spaceHeder = 56;
static const int spaceBottom = 50;

@implementation LayoutArticle10
@synthesize view1;
@synthesize view2;
@synthesize view3;




-(void)initalizeViews:(NSArray*)viewCollectionDictonary{
    for (int i=0; i<[viewCollectionDictonary count]; i++) {
        ArticleModel *articalmode=[viewCollectionDictonary objectAtIndex:i];
        if ([articalmode._Zone isEqualToString:@"Zone1"]) {
            view1 =[[[NewListArticleItemView7 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:i]andViewoder:1] retain];
            
        }else if ([articalmode._Zone isEqualToString:@"Zone2"]){
            view2 =[[[NewListArticleItemView2 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:i]andViewoder:2] retain];
            
        }else if ([articalmode._Zone isEqualToString:@"Zone3"]){
            view3 =[[[NewListArticleItemView10 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:i]andViewoder:3] retain];
            
        }
    }

    
    
//    view1 =[[[NewListArticleItemView7 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:0]andViewoder:1] retain];
//    
//    view2 =[[[NewListArticleItemView2 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:1]andViewoder:2] retain];
//    view3 =[[[NewListArticleItemView10 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:2]andViewoder:3] retain];
    
    self.isFullScreen=   FALSE;
    view1.isFullScreen = FALSE;
    view2.isFullScreen = FALSE;
    view3.isFullScreen = FALSE;
    
    
	[view1 setBackgroundColor:[UIColor whiteColor]];
	[view2 setBackgroundColor:[UIColor whiteColor]];
	[view3 setBackgroundColor:[UIColor whiteColor]];
    
    
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    
    
}


-(void)rotate:(UIInterfaceOrientation)orientation animation:(BOOL)animation {
    self._interaceOrientation=orientation;

	[view1 setBackgroundColor:[UIColor whiteColor]];
	[view2 setBackgroundColor:[UIColor whiteColor]];
	[view3 setBackgroundColor:[UIColor whiteColor]];
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
            [view1 setFrame:CGRectMake(-1, spaceHeder-1,768+2,342)];
            [view2 setFrame:CGRectMake(-1,341+spaceHeder,498+2,557)];
            [view3 setFrame:CGRectMake(498,341+spaceHeder,270,557)];
            
            [view1 reAdjustLayout:orientation];
            [view2 reAdjustLayout:orientation];
            [view3 reAdjustLayout:orientation];

            
        }
	}else {
		if (view1 != nil) {		
            
            [view1 setFrame:CGRectMake(0, spaceHeder-1,342,643)];
            [view2 setFrame:CGRectMake(342,spaceHeder-1,682,322)];
            [view3 setFrame:CGRectMake(342,321+spaceHeder,682,321)];
            
            [view1 reAdjustLayout:orientation];
            [view2 reAdjustLayout:orientation];
            [view3 reAdjustLayout:orientation];

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
        
		
	}
	
	//rotate/adjust inner view
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
    
    
}
#pragma mark-- viewdidAppear
-(void)viewDidAppear:(BOOL)animated{
    [view1 LoadImage:self._interaceOrientation];
    [view2 LoadImage:self._interaceOrientation];
    [view3 LoadImage:self._interaceOrientation];
    [headerView checkSite];

    
    [super viewDidAppear:animated];
}

- (void) dealloc{
    
	[view1 release];
	[view2 release];
	[view3 release];
    
    
    [super dealloc];
}



@end



