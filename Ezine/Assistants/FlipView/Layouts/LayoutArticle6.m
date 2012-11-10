//
//  LayoutArticle6.m
//  Ezine
//
//  Created by Admin on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.

// Description:2 trên 2 dưới(trên/dưới =2/1). Trên trái ko có ảnh ,phải có ảnh(trái/phải =1/1),Dưới có ảnh(dưới trái/dưới phải =1/1)
//tất cả đều ko có image icon và titleFeed

#import "LayoutArticle6.h"
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

@implementation LayoutArticle6
@synthesize view1;
@synthesize view2;
@synthesize view3;


-(void)initalizeViews:(NSArray*)viewCollectionDictonary{
    
    for (int i=0; i<[viewCollectionDictonary count]; i++) {
        ArticleModel *articalmode=[viewCollectionDictonary objectAtIndex:i];
        if ([articalmode._Zone isEqualToString:@"Zone1"]) {
            view1 =[[[NewListArticleItemView10 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:i]andViewoder:1] retain];
            
        }else if ([articalmode._Zone isEqualToString:@"Zone2"]){
            view2 =[[[NewListArticleItemView1 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:i]andViewoder:2] retain];
            
        }else if ([articalmode._Zone isEqualToString:@"Zone3"]){
            view3 =[[[NewListArticleItemView7 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:i]andViewoder:3] retain];
            
        }
    }
// test layout
    
//    view1 =[[[NewListArticleItemView10 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:0]andViewoder:1] retain];
//    
//    view2 =[[[NewListArticleItemView1 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:1]andViewoder:2] retain];
//    view3 =[[[NewListArticleItemView7 alloc] initWithMessageModel: (ArticleModel*)[viewCollectionDictonary objectAtIndex:2]andViewoder:3] retain];
//     
    
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
            
            [view1 setFrame:CGRectMake(-1, spaceHeder-1,384+2,573)];
            [view2 setFrame:CGRectMake(384,spaceHeder-1,384,573)];
            [view3 setFrame:CGRectMake(-1,572+spaceHeder,768+2,326)];
            
            [view1 reAdjustLayout:orientation];
            [view2 reAdjustLayout:orientation];
            [view3 reAdjustLayout:orientation];

            
        }
	}else {
		if (view1 != nil) {		
            
            [view1 setFrame:CGRectMake(-0.5, spaceHeder-1,379,643)];
            [view2 setFrame:CGRectMake(379+0.5,spaceHeder-1,381,643)];
            [view3 setFrame:CGRectMake(760,spaceHeder-1,264,643)];
            
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
