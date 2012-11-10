//
//  MyLauncherView.m
//  Ezine
//
//  Created by PDG2 on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "MyLauncherView.h"
#import "VariableStore.h"

struct NItemLocation {
	NSInteger page;
	NSInteger sindex;
};
typedef struct NItemLocation NItemLocation;

static const int pControllHeight = 30;
static const int maxItemsPageCount = 12;
static const int maxPageCount = 12;

static const int portraitItemWidth = 240;
static const int portraitItemHeight = 210;
static const int portraitColumnCount = 3;
static const int portraitRowCount = 3;

static const int landscapeItemWidth = 240;
static const int landscapeItemHeight = 200;
static const int landscapeColumnCount = 4;
static const int landscapeRowCount = 3;

@interface MyLauncherView(Private)
-(void)layoutItems;
-(void)beginEditing;
-(void)animateItems;
-(void)organizePages;
-(NItemLocation)itemLocation;
-(void)endEditing;
@end

@implementation MyLauncherView
@synthesize delegate, pages,_currentPage,_numberPage,isLastpage;
@synthesize draggingItem,dragging;
@synthesize itemsAdded;
@synthesize editing;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
        _ezineDelegate=(EzineAppDelegate *)[[UIApplication sharedApplication] delegate];
        arraydataSite=[[NSMutableArray alloc] init];
        arraydataSite=_ezineDelegate._arrayAllSite;
        isLastpage=YES;
		dragging = NO;
		editing = NO;
		itemsAdded = NO;
		columnCount = portraitColumnCount;
		rowCount = portraitRowCount;
		itemWidth = portraitItemWidth;
		itemHeight = portraitItemHeight;
        [[UIDevice currentDevice] orientation] ;
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
        
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
        panGestureRecognizer.delegate=self;
    }
    return self;
}

- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer{
    if (recognizer.state==UIGestureRecognizerStateEnded) {
        if(editing)
        {
            dragging = NO;
            [draggingItem setDragging:NO];
            draggingItem = nil;
            [self endEditing];
            
        }
        else
        {
            for (MyLauncherItem *item in [pages objectAtIndex:0]) {
                if (item.logoSite==recognizer.view) {
                    [[self delegate] launcherViewItemSelected:item];
                }
            }
        }
    }
}

- (void) handlePanFrom: (UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self];
    CGPoint location = CGPointMake(recognizer.view.center.x + translation.x,
                                   recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    
    
    if(dragging)
	{
        draggingItem.center = location;
			NItemLocation sItemLocation = [self itemLocation];
			NSInteger page = sItemLocation.page;
			NSInteger sindex = sItemLocation.sindex;
			CGFloat dragItemX = draggingItem.center.x;
			CGFloat dragItemY = draggingItem.center.y;
			NSInteger dragItemColumn = floor(dragItemX/itemWidth);
            if (_currentPage==1) {
                dragItemColumn-=1;
            }
            NSInteger dragItemRow = floor(dragItemY/itemHeight);
			NSInteger dragIndex = (dragItemRow * columnCount) + dragItemColumn;
			if(sindex != dragIndex)
			{
				[[draggingItem retain] autorelease];
				NSMutableArray *itemPage = [pages objectAtIndex:page];
				[itemPage removeObjectAtIndex:sindex];
				NSMutableArray *currentPage = [pages objectAtIndex:0];
				if(dragIndex > currentPage.count)
				{
					dragIndex = currentPage.count;
					[currentPage insertObject:draggingItem atIndex:dragIndex];
					[self organizePages];
				}
				else
				{
                    NSLog(@"sindex==%d   dragIndex=  %d",sindex,dragIndex);
                    if (self.delegate) {
                        [delegate didchangePlaceItem:sindex toItem:dragIndex];
                    }
					[currentPage insertObject:draggingItem atIndex:dragIndex];
					[self organizePages];
					[UIView beginAnimations:nil context:nil];
					[UIView setAnimationDuration:0.3];
					[self layoutItems];
					[UIView commitAnimations];
				}
			}
	}

    
    
    if (UIGestureRecognizerStateEnded == recognizer.state) {
        [draggingItem removeGestureRecognizer:panGestureRecognizer];
        dragging = NO;
		[draggingItem setDragging:NO];
		draggingItem = nil;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3];
		[self layoutItems];
		[UIView commitAnimations];
    }
}

- (void) handleLongPressFrom: (UISwipeGestureRecognizer *)recognizer
{
    if(UIGestureRecognizerStateBegan == recognizer.state)
    {
        
        if(editing)
        {
            if(!draggingItem)
            {
                draggingItem = (MyLauncherItem*)recognizer.view;
                recognizer.enabled=NO;
                recognizer.enabled=YES;
               // [draggingItem addGestureRecognizer:panGestureRecognizer];
                
                [self addSubview:draggingItem];
                dragging = YES;
            }
        }else{
            
            [self beginEditing];
            draggingItem = (MyLauncherItem*)recognizer.view;
            recognizer.enabled=NO;
            recognizer.enabled=YES;
           // [draggingItem addGestureRecognizer:panGestureRecognizer];
            draggingItem.selected = NO;
            draggingItem.highlighted = NO;
            [draggingItem setDragging:YES];
            
            [self addSubview:draggingItem];
            dragging = YES;
            
        }

    }
}

-(void)dealloc{
    longPressGestureRecognizer.delegate = nil;
    [longPressGestureRecognizer release];
    tapGestureRecognizer.delegate = nil;
    [tapGestureRecognizer release];
    panGestureRecognizer.delegate = nil;
    [panGestureRecognizer release];
    [pages release];
    [super dealloc];
}

#pragma mark----- orientationChanged
-(void)layoutItems1
{
	CGFloat pageWidth = self.frame.size.width;
	
	CGFloat padding = 10;
	CGFloat x = 0;
	CGFloat minX = 0;
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        NSLog(@"Portrait");
        columnCount = portraitColumnCount;
        rowCount = portraitRowCount;
        itemWidth = portraitItemWidth;
        itemHeight = portraitItemHeight;
    }else  if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        
        columnCount = landscapeColumnCount;
		rowCount = landscapeRowCount;
		itemWidth = landscapeItemWidth;
		itemHeight = landscapeItemHeight;
        pageWidth=self.frame.size.height;
    }
	if (_currentPage==1) {
        for (NSMutableArray *page in pages)
        {
            CGFloat y = 0;
            int itemsCount = 1;
            for (int i=0;i<page.count;i++)
            {
                MyLauncherItem *item=[page objectAtIndex:i];
                if(itemsAdded)
                {
                    CGRect prevFrame;
                    if (i==0&& !item.isAddButton) {
                        NSLog(@"site in place 0:%@",item.title);
                        prevFrame = CGRectMake(x, y, itemWidth*2+padding, itemHeight);
                        itemsCount=2;
                        x=itemWidth + padding;
                    }else{
                        prevFrame = CGRectMake(x, y, itemWidth, itemHeight);
                    }
                    
                    if(!item.dragging)
                    {
                        item.transform = CGAffineTransformIdentity;
                        [item setFrame:prevFrame];
                        [item resetFrameItem];
                    }
                }
                else
                {
                    
                    item.frame = CGRectMake(x, y, itemWidth, itemHeight);
                    if (_currentPage==1&&i==0&& !item.isAddButton) {
                        itemsCount=2;
                        item.frame = CGRectMake(x, y, itemWidth*2+10, itemHeight);
                        x=itemWidth + padding;
                    }
                    item.delegate = self;
                    [item layoutItem];
//                    [item addTarget:self action:@selector(itemTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];
//                    [item addTarget:self action:@selector(itemTouchedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
//                    [item addTarget:self action:@selector(itemTouchedDown:) forControlEvents:UIControlEventTouchDown];
                    longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
                    longPressGestureRecognizer.delegate = self;
                    [item addGestureRecognizer:longPressGestureRecognizer];
                    [self addSubview:item];
                }
                item.closeButton.hidden = editing ? NO : YES;
                
                x += itemWidth + padding;
                
                if ( itemsCount % columnCount == 0)
                {
                    y += itemHeight + padding;
                    x = minX;
                }
                
                itemsCount++;
            }
            
            minX += pageWidth;
            x = minX;
        }
        
    }else{
        for (NSMutableArray *page in pages)
        {
            CGFloat y = 0;
            int itemsCount = 1;
            for (int i=0;i<page.count;i++)
            {
                MyLauncherItem *item=[page objectAtIndex:i];
                if(itemsAdded)
                {
                    CGRect    prevFrame = CGRectMake(x, y, itemWidth, itemHeight);
                    item.transform = CGAffineTransformIdentity;
                    item.frame = prevFrame;
                    [item resetFrameItem];
                    
                }
                else
                {
                    
                    item.frame = CGRectMake(x, y, itemWidth, itemHeight);
                    //                    if (_currentPage==1&&i==0) {
                    //                        itemsCount=2;
                    //                        item.frame = CGRectMake(x, y, itemWidth*2+10, itemHeight);
                    //                        x=itemWidth + padding;
                    //                    }
                    item.delegate = self;
                    [item layoutItem];
//                    [item addTarget:self action:@selector(itemTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];
//                    [item addTarget:self action:@selector(itemTouchedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
//                    [item addTarget:self action:@selector(itemTouchedDown:) forControlEvents:UIControlEventTouchDown];
                    longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
                    longPressGestureRecognizer.delegate = self;
                    [item addGestureRecognizer:longPressGestureRecognizer];
                    [self addSubview:item];
                }
                item.closeButton.hidden = editing ? NO : YES;
                
                x += itemWidth + padding;
                
                if ( itemsCount % columnCount == 0)
                {
                    y += itemHeight + padding;
                    x = minX;
                }
                
                itemsCount++;
            }
            
            minX += pageWidth;
            x = minX;
        }
        
    }
    itemsAdded = YES;
}

-(void)orientationChanged{
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        self.frame= CGRectMake(10+5,75,768-10*2+256,1024-20-75-50-256);
        
    }else if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        self.frame=       CGRectMake(10+5,75,768-10*2,1024-20-75-50);
        
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self layoutItems1];
    [UIView commitAnimations];
    
}

#pragma mark-------------

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    
    if(dragging)
	{
		for (UITouch* touch in touches)
		{
			CGPoint location = [touch locationInView:self];
			draggingItem.center = CGPointMake(location.x, location.y);
            
			NItemLocation sItemLocation = [self itemLocation];
			NSInteger page = sItemLocation.page;
			NSInteger sindex = sItemLocation.sindex;
			CGFloat dragItemX = draggingItem.center.x;
			CGFloat dragItemY = draggingItem.center.y;
			NSInteger dragItemColumn = floor(dragItemX/itemWidth);
            if (_currentPage==1) {
                dragItemColumn-=1;
            }
            
            NSInteger dragItemRow = floor(dragItemY/itemHeight);
			NSInteger dragIndex = (dragItemRow * columnCount) + dragItemColumn;
            NSLog(@"drag index===%d",dragIndex);
            if (_currentPage==1&&dragIndex==0) {
                break;
            }
            
            if (draggingItem._isSiteTop) {
                return;
            }
            if(sindex != dragIndex)
			{
				[[draggingItem retain] autorelease];
				NSMutableArray *itemPage = [pages objectAtIndex:page];
				[itemPage removeObjectAtIndex:sindex];
				NSMutableArray *currentPage = [pages objectAtIndex:0];
				if(dragIndex > currentPage.count)
				{
					dragIndex = currentPage.count;
					[currentPage insertObject:draggingItem atIndex:dragIndex];
					[self organizePages];
				}
				else
				{
                    
					[currentPage insertObject:draggingItem atIndex:dragIndex];
					[self organizePages];
					[UIView beginAnimations:nil context:nil];
					[UIView setAnimationDuration:0.3];
					[self layoutItems];
					[UIView commitAnimations];
                    
                    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:sindex],@"from",[NSNumber numberWithInt:dragIndex],@"to",[NSNumber numberWithInt:_currentPage],@"Page", nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:KDidChangeOrderSiteNotification object:self userInfo:info];
				}
			}
            //moving page
//            if (location.x>690) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:KNeedNextPageNotification object:self userInfo:nil];
//            }
		}
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (dragging) {
        dragging = NO;
		[draggingItem setDragging:NO];
		draggingItem = nil;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3];
		[self layoutItems];
		[UIView commitAnimations];
    }
}

-(void)itemTouchedUpInside:(MyLauncherItem *)item
{
    NSLog(@"touch up inside : %d",_currentPage);
	if(editing)
	{
        [itemHoldTimer invalidate];
        itemHoldTimer = nil;
		dragging = NO;
		[draggingItem setDragging:NO];
		draggingItem = nil;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3];
		[self layoutItems];
		[UIView commitAnimations];
        
	}
	else
	{
		[movePagesTimer invalidate];
		movePagesTimer = nil;
		[itemHoldTimer invalidate];
		itemHoldTimer = nil;
		[[self delegate] launcherViewItemSelected:item];
	}
}

-(void)itemTouchedUpOutside:(MyLauncherItem *)item
{
    NSLog(@"touch up outside ");
	[movePagesTimer invalidate];
	movePagesTimer = nil;
	[itemHoldTimer invalidate];
	itemHoldTimer = nil;
	dragging = NO;
	[draggingItem setDragging:NO];
	draggingItem = nil;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3];
	[self layoutItems];
	[UIView commitAnimations];
}

-(void)itemTouchedDown:(MyLauncherItem *)item
{ 
    [itemHoldTimer invalidate];
    itemHoldTimer = nil;
    CGFloat timeInterval=1.0;
    if (editing) {
        timeInterval=1.0;
    }
    itemHoldTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(itemHoldTimer:) userInfo:item repeats:NO];
}

-(void)itemHoldTimer:(NSTimer *)timer
{
    canEnEditing=NO;
    itemHoldTimer = nil;
    if(editing)
	{
		if(!draggingItem)
		{
			draggingItem = (MyLauncherItem*)timer.userInfo;
			[draggingItem setDragging:YES];
            [self addSubview:draggingItem];
			dragging = YES;
		}
	}else{
        
        [self beginEditing];
        draggingItem = (MyLauncherItem*)timer.userInfo;
        draggingItem.selected = NO;
        draggingItem.highlighted = NO;
        [draggingItem setDragging:YES];
        [self addSubview:draggingItem];
        dragging = YES;
        
    }
}

-(void)organizePages
{
	int currentPageIndex = 0;
	for(NSMutableArray *page in pages)
	{
		if(page.count > maxItemsPageCount)
		{
			NSInteger nextPageIndex = currentPageIndex+1;
			NSMutableArray *nextPage = [pages objectAtIndex:nextPageIndex];
			if(nextPage)
			{
				MyLauncherItem *moveItem = [[page lastObject] retain];
				[page removeObject:moveItem];
				[nextPage insertObject:moveItem atIndex:0];
			}
			else
			{
				[pages addObject:[NSMutableArray array]];
				nextPage = [pages lastObject];
				MyLauncherItem *moveItem = [[page lastObject] retain];
				[page removeObject:moveItem];
				[nextPage addObject:moveItem];
			}
		}
		currentPageIndex++;
	}
}

//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//	[super touchesMoved:touches withEvent:event];
//	if(dragging)
//	{
//		for (UITouch* touch in touches)
//		{
//			CGPoint location = [touch locationInView:self];
//			draggingItem.center = CGPointMake(location.x, location.y);
//            if (location.x>690&&_currentPage<_numberPage) {
//                if (self.delegate) {
//                    [delegate didMoveItemTonextPage:draggingItem inPage:_currentPage];
//                }
//                dragging=NO;
//                break;
//            }
//            NSLog(@"center: x= %f y= %f",location.x,location.y);
//			NItemLocation sItemLocation = [self itemLocation];
//			NSInteger page = sItemLocation.page;
//			NSInteger sindex = sItemLocation.sindex;
//			CGFloat dragItemX = draggingItem.center.x;
//			CGFloat dragItemY = draggingItem.center.y;
//			NSInteger dragItemColumn = floor(dragItemX/itemWidth);
//            if (_currentPage==1) {
//                dragItemColumn-=1;
//            }
//            NSInteger dragItemRow = floor(dragItemY/itemHeight);
//			NSInteger dragIndex = (dragItemRow * columnCount) + dragItemColumn;
//            if (dragIndex==0&&_currentPage==1) {
//                break;
//            }
//			if(sindex != dragIndex)
//			{
//				[[draggingItem retain] autorelease];
//				NSMutableArray *itemPage = [pages objectAtIndex:page];
//				[itemPage removeObjectAtIndex:sindex];
//				NSMutableArray *currentPage = [pages objectAtIndex:0];
//				if(dragIndex > currentPage.count)
//				{
//					dragIndex = currentPage.count;
//					[currentPage insertObject:draggingItem atIndex:dragIndex];
//					[self organizePages];
//				}
//				else
//				{
//                    NSLog(@"sindex==%d   dragIndex=  %d",sindex,dragIndex);
//                    if (self.delegate) {
//                        [delegate didchangePlaceItem:sindex toItem:dragIndex];
//                    }
//					[currentPage insertObject:draggingItem atIndex:dragIndex];
//					[self organizePages];
//					[UIView beginAnimations:nil context:nil];
//					[UIView setAnimationDuration:0.3];
//					[self layoutItems];
//					[UIView commitAnimations];
//				}
//			}
//		}
//	}
//}
-(void)beginEditing
{
	if(editing)
		return;
	countSiteDelete=0;
	editing = YES;
    
	[self animateItems];
	[[NSNotificationCenter defaultCenter] postNotificationName:KDidBeginEdittingSiteNotification object:self userInfo:nil];
}

-(void)endEditing
{
	editing = NO;
    
	for (int i = 0; i < pages.count; ++i)
	{
		NSArray* itemPage = [pages objectAtIndex:i];
		if(itemPage.count == 0)
		{
			[pages removeObjectAtIndex:i];
			--i;
		}
		else
		{
			for (MyLauncherItem* item in itemPage)
				item.transform = CGAffineTransformIdentity;
		}
	}
	[self layoutItems];
    [[NSNotificationCenter defaultCenter] postNotificationName:KDidEndEdittingSiteNotification object:self userInfo:nil];
}

-(void)animateItems
{
	static BOOL animatesLeft = NO;
	if (editing)
	{
        
		CGAffineTransform animateUp = CGAffineTransformMakeScale(1.0, 1.0);
		CGAffineTransform animateDown = CGAffineTransformMakeScale(0.99, 0.99);
		[UIView beginAnimations:nil context:nil];
		
		NSInteger i = 0;
		NSInteger animatingItems = 0;
		for (NSArray* itemPage in pages)
		{
			for (MyLauncherItem* item in itemPage)
			{
				if (!item.isAddButton) {
                    item.closeButton.hidden = !editing;
                
                    if (item != draggingItem)
                    {
                        ++animatingItems;
                        if (i % 2)
                            item.transform = animatesLeft ? animateDown : animateUp;
                        else
                            item.transform = animatesLeft ? animateUp : animateDown;
                        
                    }
                    ++i;
                }
			}
		}
		
		if (animatingItems >= 1)
		{
			[UIView setAnimationDuration:0.05];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(animateItems)];
			animatesLeft = !animatesLeft;
		}
		else
		{
			[NSObject cancelPreviousPerformRequestsWithTarget:self];
			[self performSelector:@selector(animateItems) withObject:nil afterDelay:0.05];
		}
		[UIView commitAnimations];
	}
}

-(void)setPages:(NSMutableArray *)newPages
{
	if (pages != newPages)
	{
        [pages release];
        pages = [newPages mutableCopy];
    }
	[self layoutItems];
}

-(void)layoutLauncher{
	[self layoutItems];
}

-(void)layoutItems
{
   
    
	CGFloat pageWidth = self.frame.size.width;
	
	CGFloat padding = 10;
	CGFloat x = 0;
	CGFloat minX = 0;
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight){
        columnCount = landscapeColumnCount;
		rowCount = landscapeRowCount;
		itemWidth = landscapeItemWidth;
		itemHeight = landscapeItemHeight;
        pageWidth=self.frame.size.height;
    }else if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        columnCount = portraitColumnCount;
        rowCount = portraitRowCount;
        itemWidth = portraitItemWidth;
        itemHeight = portraitItemHeight;
    }
	if (_currentPage==1) {
        for (NSMutableArray *page in pages)
        {
            CGFloat y = 0;
            int itemsCount = 1;
            for (int i=0;i<page.count;i++)
            {
                MyLauncherItem *item=[page objectAtIndex:i];
                if(itemsAdded)
                {
                    CGRect prevFrame;
                    if (i==0 && !item.isAddButton) {
                        prevFrame = CGRectMake(x, y, itemWidth*2+padding, itemHeight);
                        itemsCount=2;
                        x=itemWidth + padding;
                    }else{
                        prevFrame = CGRectMake(x, y, itemWidth, itemHeight);
                    }
                    
                    if(!item.dragging)
                    {
                        item.transform = CGAffineTransformIdentity;
                        if(item.frame.origin.x != x || item.frame.origin.y != y)
                            [item setFrame:prevFrame];
                        [item resetFrameItem];
                    }
                }
                else
                {
                    
                    item.frame = CGRectMake(x, y, itemWidth, itemHeight);
                    if (_currentPage==1&&i==0&& !item.isAddButton) {
                        itemsCount=2;
                        item.frame = CGRectMake(x, y, itemWidth*2+10, itemHeight);
                        x=itemWidth + padding;
                    }
                    item.delegate = self;
                    [item layoutItem];
//                    [item addTarget:self action:@selector(itemTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];
//                    [item addTarget:self action:@selector(itemTouchedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
//                    [item addTarget:self action:@selector(itemTouchedDown:) forControlEvents:UIControlEventTouchDown];
                    longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
                    longPressGestureRecognizer.delegate = self;
                    [item addGestureRecognizer:longPressGestureRecognizer];
                    
                    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
                    //The number of taps for the gesture to be recognized.
                    tapGestureRecognizer.numberOfTapsRequired = 1;
                    
                    //The number of fingers required to tap for the gesture to be recognized.
                    tapGestureRecognizer.numberOfTouchesRequired = 1;
                    
                    //Add the tapGestureRecognizer to the imageView
                    [item.logoSite addGestureRecognizer:tapGestureRecognizer];
                    tapGestureRecognizer.delegate = self;
                    
                    [self addSubview:item];
                }
                item.closeButton.hidden = editing ? NO : YES;
                
                x += itemWidth + padding;
                
                if ( itemsCount % columnCount == 0)
                {
                    y += itemHeight + padding;
                    x = minX;
                }
                
                itemsCount++;
            }
            
            minX += pageWidth;
            x = minX;
        }
        
    }else{
        for (NSMutableArray *page in pages)
        {
            CGFloat y = 0;
            int itemsCount = 1;
            for (int i=0;i<page.count;i++)
            {
                MyLauncherItem *item=[page objectAtIndex:i];
                if(itemsAdded)
                {
                    CGRect    prevFrame = CGRectMake(x, y, itemWidth, itemHeight);
                    
                    
                    if(!item.dragging)
                    {
                        item.transform = CGAffineTransformIdentity;
                        if(item.frame.origin.x != x || item.frame.origin.y != y)
                            item.frame = prevFrame;
                    }
                }
                else
                {
                    
                    item.frame = CGRectMake(x, y, itemWidth, itemHeight);
                    if (_currentPage==1&&i==0&& !item.isAddButton) {
                        itemsCount=2;
                        item.frame = CGRectMake(x, y, itemWidth*2+10, itemHeight);
                        x=itemWidth + padding;
                    }
                    item.delegate = self;
                    [item layoutItem];
//                    [item addTarget:self action:@selector(itemTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];
//                    [item addTarget:self action:@selector(itemTouchedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
//                    [item addTarget:self action:@selector(itemTouchedDown:) forControlEvents:UIControlEventTouchDown];
                    longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
                    longPressGestureRecognizer.delegate = self;
                    [item addGestureRecognizer:longPressGestureRecognizer];
                    
                    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
                    //The number of taps for the gesture to be recognized.
                    tapGestureRecognizer.numberOfTapsRequired = 1;
                    
                    //The number of fingers required to tap for the gesture to be recognized.
                    tapGestureRecognizer.numberOfTouchesRequired = 1;
                    
                    //Add the tapGestureRecognizer to the imageView
                    [item.logoSite addGestureRecognizer:tapGestureRecognizer];
                    tapGestureRecognizer.delegate = self;
                    [self addSubview:item];
                }
                item.closeButton.hidden = editing ? NO : YES;
               
                x += itemWidth + padding;
                
                if ( itemsCount % columnCount == 0)
                {
                    y += itemHeight + padding;
                    x = minX;
                }
                
                itemsCount++;
            }
            
            minX += pageWidth;
            x = minX;
        }
        
    }
    itemsAdded = YES;
}

-(NItemLocation)itemLocation
{
	NItemLocation i;
	
	int itemPage = 0;
	for (NSMutableArray *page in pages)
	{
		int itemOrder = 0;
		for (MyLauncherItem *item in page)
		{
			if(item == draggingItem)
			{
				i.page = itemPage;
				i.sindex = itemOrder;
				return i;
			}
			itemOrder++;
		}
        
		itemPage++;
	}
	i.page = 0;
	i.sindex = 0;
	
	return i;
}

-(void)didDeleteItem:(id)item
{
    
	MyLauncherItem *ditem = (MyLauncherItem*)item;
    
	for (NSMutableArray *page in pages)
	{
		int i = 0;
		for (MyLauncherItem *aitem in page)
		{
			if(aitem == ditem)
			{
                [page removeObject:aitem];
                NSDictionary *info = [NSDictionary dictionaryWithObject:item forKey:@"item"];
                [[NSNotificationCenter defaultCenter] postNotificationName:KDidDeleteSiteNotification object:self userInfo:info];
//                [UIView beginAnimations:nil context:nil];
//                [UIView setAnimationDuration:0.3];
//                [self layoutItems];
//                [UIView commitAnimations];
				return;
			}
            
            i++;
		}
	}
}

-(void)didInforClick:(id)item{
    if (self.delegate) {
        [self.delegate itemInforClick:item];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark----- reload font size

-(void) reloadFontSize{
     for (NSMutableArray *page in pages)
         for ( MyLauncherItem *item in page) {
             [item reloadFontSize];
         }
}


-(void)reloadAllsite{
    for (NSArray* itemPage in pages)
    {
        for (MyLauncherItem* item in itemPage)
        {
            [item reloadImage];
        
        }
    }
}

-(void)checkReloadAllsite{
    for (NSArray* itemPage in pages)
    {
        for (MyLauncherItem* item in itemPage)
        {
            [item checkReload];
            
        }
    }

}
@end
