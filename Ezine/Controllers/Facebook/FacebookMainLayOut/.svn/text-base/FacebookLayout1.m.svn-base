//
//  FacebookLayout1.m
//  Ezine
//
//  Created by MAC on 10/15/12.
//
//

#import "FacebookLayout1.h"
#import "FacebookViewArticle1.h"
#import "FacebookViewArticle2.h"
#import "FacebookViewArticle3.h"

static const float GAP = 10;
static const int colsInPortrait = 3;
static const int colsInLandscape = 4;
static const float animationDuration = 0.5;
static const int spaceHeder = 56;
static const int spaceBottom = 50;

@interface FacebookLayout1 ()

@end

@implementation FacebookLayout1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)initalizeViews:(NSArray*)viewCollectionDictonary{
    NSLog(@"viewCollectionDictonary count=== %d",viewCollectionDictonary.count);
    view1 =[[[FacebookViewArticle1 alloc] initWithMessageModel: (FBObjectModel*)[viewCollectionDictonary objectAtIndex:0]andViewoder:1] retain];
    view2 =[[[FacebookViewArticle2 alloc] initWithMessageModel: (FBObjectModel*)[viewCollectionDictonary objectAtIndex:1]andViewoder:2] retain];
    view3 =[[[FacebookViewArticle2 alloc] initWithMessageModel: (FBObjectModel*)[viewCollectionDictonary objectAtIndex:2]andViewoder:3] retain];
    view4 =[[[FacebookViewArticle3 alloc] initWithMessageModel: (FBObjectModel*)[viewCollectionDictonary objectAtIndex:3]andViewoder:4] retain];
    view5 =[[[FacebookViewArticle3 alloc] initWithMessageModel: (FBObjectModel*)[viewCollectionDictonary objectAtIndex:4]andViewoder:5] retain];
    view6 =[[[FacebookViewArticle3 alloc] initWithMessageModel: (FBObjectModel*)[viewCollectionDictonary objectAtIndex:5]andViewoder:6] retain];
    view7 =[[[FacebookViewArticle3 alloc] initWithMessageModel: (FBObjectModel*)[viewCollectionDictonary objectAtIndex:6]andViewoder:7] retain];
    view8 =[[[FacebookViewArticle3 alloc] initWithMessageModel: (FBObjectModel*)[viewCollectionDictonary objectAtIndex:7]andViewoder:8] retain];
    self.isFullScreen= FALSE;
    view1.isFullScreen = FALSE;
    view2.isFullScreen = FALSE;
    view3.isFullScreen = FALSE;
    view4.isFullScreen = FALSE;
    view5.isFullScreen = FALSE;
    view6.isFullScreen = FALSE;
    view7.isFullScreen = FALSE;
    view8.isFullScreen = FALSE;

	[view1 setBackgroundColor:[UIColor whiteColor]];
	[view2 setBackgroundColor:[UIColor whiteColor]];
	[view3 setBackgroundColor:[UIColor whiteColor]];
    [view3 setBackgroundColor:[UIColor whiteColor]];
	[view4 setBackgroundColor:[UIColor whiteColor]];
	[view5 setBackgroundColor:[UIColor whiteColor]];
	[view6 setBackgroundColor:[UIColor whiteColor]];
	[view7 setBackgroundColor:[UIColor whiteColor]];

    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    [self.view addSubview:view4];
    [self.view addSubview:view5];
    [self.view addSubview:view6];
    [self.view addSubview:view7];
    [self.view addSubview:view8];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rotate:(UIInterfaceOrientation)orientation animation:(BOOL)animation {
    self._interaceOrientation=orientation;
    
	[view1 setBackgroundColor:[UIColor whiteColor]];
	[view2 setBackgroundColor:[UIColor whiteColor]];
	[view3 setBackgroundColor:[UIColor whiteColor]];
    
    
	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        [fbfooterView setFrame:CGRectMake(0, 1004 - 50, 768,50)];
       // [FbfooterView setFrame:CGRectMake(0, 1004 - 50, 768,50)];

    }else {
        [fbfooterView setFrame:CGRectMake(0, 748 - 50, 1024,50)];
    }
    [fbfooterView rotate:orientation animation:YES];
    [fbheaderView rotate:orientation animation:YES];
    
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
            
            [view1 setFrame:CGRectMake(0, spaceHeder-1,490,490+2)];
            [view2 setFrame:CGRectMake(0,490+spaceHeder,280,430)];
            [view3 setFrame:CGRectMake(280, 490+spaceHeder,210,430)];
            [view4 setFrame:CGRectMake(490, spaceHeder,278,180)];
            [view5 setFrame:CGRectMake(490, 180+spaceHeder,278,170)];
            [view6 setFrame:CGRectMake(490, 170+180+spaceHeder,278,160)];
            [view7 setFrame:CGRectMake(490, 160+170+180+spaceHeder,278,160)];
            [view8 setFrame:CGRectMake(490, 160+160+170+180+spaceHeder,278,230)];

            [view1 reAdjustLayout:orientation];
            [view2 reAdjustLayout:orientation];
            [view3 reAdjustLayout:orientation];
            [view4 reAdjustLayout:orientation];
            [view5 reAdjustLayout:orientation];
            [view6 reAdjustLayout:orientation];
            [view7 reAdjustLayout:orientation];
            [view8 reAdjustLayout:orientation];

        }
	}else {
		if (view1 != nil) {
            
            [view1 setFrame:CGRectMake(0,spaceHeder,343,642)];
            [view2 setFrame:CGRectMake(343,spaceHeder,343,642)];
            [view3 setFrame:CGRectMake(343*2,spaceHeder,344,642)];
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
        [view4 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        [view5 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        [view6 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        [view7 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];
        [view8 setBackgroundColor:[UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:0.9]];

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
-(void)viewDidAppear:(BOOL)animated{
 //   [view1 LoadImage:self._interaceOrientation];
//    [view2 LoadImage:self._interaceOrientation];
//    [view3 LoadImage:self._interaceOrientation];
//    [headerView checkSite];
    [super viewDidAppear:animated];
}
@end
