/*
 This module is licensed under the MIT license.
 
 Copyright (C) 2011 by raw engineering
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
//
//  FooterView.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.

//

#import "FooterView.h"

#import "AFKPageFlipper.h"

@implementation FooterView
@synthesize flipView;
@synthesize currrentInterfaceOrientation,viewArray,isLoading;
@synthesize deletegate;
@synthesize _numberAllpage;
@synthesize _timeArticle,timeCreate;


-(void)reAssignPaginationButtons {
	NSLog(@"reAssignPaginationButtons olala4");
    UILabel* prevLabel = (UILabel*)[previousView viewWithTag:1];
    UIImageView* prevImage =(UIImageView*)[previousView viewWithTag:2];
    
    UILabel* nextLabel = (UILabel*)[nextView viewWithTag:1];
    UIImageView* nextImage = (UIImageView*)[nextView viewWithTag:2];
    
    
    [buttonNext setHidden:FALSE];
    [buttonPrevious setHidden:FALSE];
    //			[prevLabel setText:[NSString stringWithFormat:@"%d - %d",1,((15*(currentScrollNumber))-15)]];
    //			[prevLabel sizeToFit];
    int pointInpage;
    if (numberTotal<=_numberAllpage-_numberAllpage%10) {
        pointInpage=((numberTotal-1)/10 +1)*10;
    }else{
        pointInpage=_numberAllpage;
    }
    [nextLabel setText:@""];
    [nextLabel sizeToFit];
    
    [buttonNext sizeToFit];
    [buttonPrevious sizeToFit];
    
    
    [prevImage setFrame:CGRectMake(0, 3, prevImage.frame.size.width, prevImage.frame.size.height)];
    [prevLabel setFrame:CGRectMake(prevImage.frame.origin.x + prevImage.frame.size.width + 5, 0, prevLabel.frame.size.width, prevLabel.frame.size.height)];
    [previousView setFrame:CGRectMake(0, 0, prevLabel.frame.size.width + prevImage.frame.size.width + 5, 20)];
    
    [nextLabel setFrame:CGRectMake(0, 0, nextLabel.frame.size.width, nextLabel.frame.size.height)];
    [nextImage setFrame:CGRectMake(nextLabel.frame.origin.x + nextLabel.frame.size.width + 5, 3, nextImage.frame.size.width, nextImage.frame.size.height)];
    [nextView setFrame:CGRectMake(0, 0, nextLabel.frame.size.width + nextImage.frame.size.width + 5, 20)];
    [self.timeCreate setFrame:CGRectMake(barButtonsView.frame.size.width+30, 0, 90, 20)];

    [previousView setUserInteractionEnabled:FALSE];
    [nextView setUserInteractionEnabled:FALSE];
    
    [buttonPrevious setUserInteractionEnabled:TRUE];
    [buttonNext setUserInteractionEnabled:TRUE];
    
    [buttonPrevious setFrame:CGRectMake((barButtonsView.frame.origin.x - previousView.frame.size.width) - 5, 17, previousView.frame.size.width, 20)];
    [buttonNext setFrame:CGRectMake(barButtonsView.frame.origin.x + barButtonsView.frame.size.width + 5, 17, nextView.frame.size.width, 20)];
    
	
	
}
#pragma mark-- convert time
-(void)convertTime:(int)timecreate{
    int minutes=timecreate/60;
    if (minutes>=60) {
        int hour=timecreate/3600;
        if (hour>=24) {
            int day=timecreate/(3600*24);
            [self.timeCreate setText:[NSString stringWithFormat:@"%d ngày trước",day]];
            
        }else {
            [self.timeCreate setText:[NSString stringWithFormat:@"%d giờ trước",hour]];
            
        }
    }else {
        [self.timeCreate setText:[NSString stringWithFormat:@"%d phút trước",minutes]];
    }
}
#pragma mark-- ----generateButtons
-(void) generateButtons {
    NSLog(@"Olala3");
	if (previousView) {
		for (UIView* view in previousView.subviews) {
			[view removeFromSuperview];
		}
		[previousView removeFromSuperview];
		[previousView release];
	}
	
	previousView = [[UIView alloc] init];
    
	UILabel* labelPrevious = [[UILabel alloc] init];
	[labelPrevious setText:@"Mới nhất"];
	[labelPrevious setTextColor:[UIColor grayColor]];
	[labelPrevious setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:14+XAppDelegate.appFontSize]];
	[labelPrevious sizeToFit];
	[labelPrevious setTag:1];
	[previousView addSubview:labelPrevious];
	[labelPrevious release];
	// convert time
    self.timeCreate = [[UILabel alloc] init];
	[self.timeCreate setText:@"time"];
	[self.timeCreate setTextColor:[UIColor grayColor]];
	[self.timeCreate setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:14]];
	[self.timeCreate sizeToFit];
	[previousView addSubview:self.timeCreate];
    
    int time=[[NSDate date] timeIntervalSince1970];
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    [df setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSDate *date = [df dateFromString:_timeArticle];
    int timecreateIs=time-[date timeIntervalSince1970];
    NSLog(@"time:%d   %@     %@",timecreateIs,_timeArticle,[NSDate date] );
    [self convertTime:timecreateIs];

	UIImageView* prevImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"previous.png"]];
	[prevImage setTag:2];
	[previousView addSubview:prevImage];
	[prevImage release];
	
	[previousView setUserInteractionEnabled:FALSE];
	
	
	buttonPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonPrevious addSubview:previousView];
	[buttonPrevious sizeToFit];
	[buttonPrevious addTarget:self action:@selector(previousClick:) forControlEvents:UIControlEventTouchUpInside];
    
	if (nextView) {
		for (UIView* view in nextView.subviews) {
			[view removeFromSuperview];
		}
		[nextView removeFromSuperview];
		[nextView release];
	}
	
	nextView = [[UIView alloc] init];
	
	UILabel* labelNext = [[UILabel alloc] init];
	[labelNext setText:@""];
	[labelNext setTextColor:[UIColor darkGrayColor]];
	[labelNext setFont:[UIFont fontWithName:@"UVNHongHaHepBold" size:14+XAppDelegate.appFontSize]];
	[labelNext sizeToFit];
	[labelNext setTag:1];
	[nextView addSubview:labelNext];
	[labelNext release];
	
	UIImageView* nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next.png"]];
	[nextImage setTag:2];
	[nextView addSubview:nextImage];
	[nextImage release];
	
	[nextView setUserInteractionEnabled:FALSE];
	
	
	buttonNext = [UIButton buttonWithType:UIButtonTypeCustom];
	[buttonNext addSubview:nextView];
	[buttonNext sizeToFit];
	[buttonNext addTarget:self action:@selector(nextClick:) forControlEvents:UIControlEventTouchUpInside];
	
	if (barButtonsView) {
		for (UIView* view in barButtonsView.subviews) {
			[view removeFromSuperview];
		}
		[barButtonsView removeFromSuperview];
		[barButtonsView release];
	}
	
	barButtonsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,15, self.frame.size.width, 20)];
	[barButtonsView setBackgroundColor:[UIColor whiteColor]];
	CGFloat left = 10;
	CGFloat width = 0;
    int numberPointLastpage=_numberAllpage%10;
    int numberPointInCurrentPage;
    if (numberTotal<=_numberAllpage-numberPointLastpage) {
        numberPointInCurrentPage=11;
    }else if (_numberAllpage<=10){
        numberPointInCurrentPage=numberPointLastpage+1;
    }else{
        numberPointInCurrentPage=numberPointLastpage;
    }
	for (int i = 1; i <= numberPointInCurrentPage; i++) {
        NSLog(@"all page===%d  %d  %d %d",numberPointLastpage,numberTotal,_numberAllpage,i);

		UIButton* boxButton = [[UIButton alloc] init];
		[boxButton setBackgroundColor:[UIColor clearColor]];
		[boxButton setTag:i];
		[boxButton setFrame:CGRectMake(left,15, 27, 27)];
		        //		[boxButton setBackgroundColor:[UIColor blueColor]];
        //        		if (flipView.currentPage == i) {
        //            selectedButtonIndex = i;
        //        			[boxButton setFrame:CGRectMake(left,17, 27, 20)];
        if (i==numberTotal%10||(i==10&&numberTotal%10==0)) {
            [boxButton setImage:[UIImage imageNamed:@"img_pageChoose.png"] forState:UIControlStateNormal];
            [boxButton setImage:[UIImage imageNamed:@"img_pageChoose.png"] forState:UIControlStateSelected];
            
        }else{
            [boxButton addTarget:self action:@selector(boxClick:) forControlEvents:UIControlEventTouchUpInside];
            width = boxButton.frame.origin.x + boxButton.frame.size.width;
            
            
            [boxButton setImage:[UIImage imageNamed:@"unselected-page.png"] forState:UIControlStateNormal];
            [boxButton setImage:[UIImage imageNamed:@"unselected-page.png"] forState:UIControlStateSelected];
            

        }
        
        
        
        //        			[boxButton setBackgroundColor:[UIColor blueColor]];
        //        		}
		[barButtonsView addSubview:boxButton];
		[boxButton release];
		left+=30;
	}
    readAndCommentButton =[[UIButton alloc]init];
    [readAndCommentButton setBackgroundColor:[UIColor clearColor]];
    [readAndCommentButton setFrame:CGRectMake(self.frame.size.width-35, self.frame.size.height-30, 20, 20)];
#pragma mark========Button Binh luan
    [readAndCommentButton addTarget:self action:@selector(btnCommentandWriteClick:) forControlEvents:UIControlEventTouchUpInside];
    [readAndCommentButton setImage:[UIImage imageNamed:@"iconWriteComment.png"] forState:UIControlStateNormal];
    
    [self addSubview:readAndCommentButton];
    [readAndCommentButton release];
    
    
//===== search button
    searchKeyword =[[UIButton alloc]init];
    [searchKeyword setBackgroundColor:[UIColor clearColor]];
    [searchKeyword setFrame:CGRectMake(self.frame.size.width-85, self.frame.size.height-30, 20, 20)];
#pragma mark========Button Binh luan
    [searchKeyword addTarget:self action:@selector(btnSearchKeyword:) forControlEvents:UIControlEventTouchUpInside];
    
    [searchKeyword setImage:[UIImage imageNamed:@"btn_searchSite@2x.png"] forState:UIControlStateNormal];
    
    [self addSubview:searchKeyword];
    [searchKeyword release];

	width +=10;
	BOOL shouldScroll = FALSE;
	int scrollCount = 0;
    //	if (width > 450) {
    //		scrollCount = floor(flipperView.currentPage/15) + 1;
    //		if (flipperView.currentPage % 15==0) {
    //			scrollCount -= 1;
    //		}
    //		shouldScroll = TRUE;
    //		width = 450;
    //	}
	[barButtonsView setFrame:CGRectMake((self.frame.size.width/2) - (width/2), barButtonsView.frame.origin.y, width, barButtonsView.frame.size.height)];
	[barButtonsView setContentSize:CGSizeMake(barButtonsView.frame.size.width/2, barButtonsView.frame.size.height)];
    
    
	if (shouldScroll) {
		if (scrollCount > 1) {
			[barButtonsView setContentOffset:CGPointMake(((scrollCount-1) * 450), barButtonsView.frame.origin.y) animated:NO];
			currentScrollNumber =scrollCount;
            
		}else {
			[barButtonsView setContentOffset:CGPointMake(0, barButtonsView.frame.origin.y) animated:NO];
			currentScrollNumber = 1;
			
			[barButtonsView setFrame:CGRectMake(barButtonsView.frame.origin.x, barButtonsView.frame.origin.y, 450, barButtonsView.frame.size.height)];
			
		}
	}
    [buttonPrevious setFrame:CGRectMake((barButtonsView.frame.origin.x - (buttonPrevious.frame.size.width-5)) - 5, 0, buttonPrevious.frame.size.width, buttonPrevious.frame.size.height-12)];
	[buttonNext setFrame:CGRectMake(barButtonsView.frame.origin.x + barButtonsView.frame.size.width + 5, 0, buttonNext.frame.size.width, buttonNext.frame.size.height-12)];
	[self addSubview:barButtonsView];
	[self addSubview:buttonPrevious];
	[self addSubview:buttonNext];
	
	totalScrollNumber = (numberTotal / 15) +1;
	if (!shouldScroll) {
		currentScrollNumber = 1;
	}
	[self reAssignPaginationButtons];
	
}

-(void) setViewArray:(NSArray *) arrayToSet {
	viewArray = arrayToSet;
	
	numberTotal = [viewArray count]+1;
	NSLog(@"page=== %d/%d",numberTotal,_numberAllpage);
	[self generateButtons];
	NSLog(@"Olala2");
}
#pragma mark==============Button adding by code handle==========
-(void)boxClick:(id)sender {
    	UIButton* button = (UIButton*)sender;
    //    //[self nextClick:nil];
    NSLog(@"Boxxxx Click: %d  %d",button.tag,numberTotal);
    //    if ([button isSelected]) {
    //        [button setImage:[UIImage imageNamed:@"unselected-page.png"] forState:UIControlStateNormal];
    //        [button setSelected:NO];
    //      //  [self nextClick:nil];
    //    }else {
    //        [button setImage:[UIImage imageNamed:@"selected-page.png"] forState:UIControlStateSelected];
    //        [button setSelected:YES];
    //
    //    }
    if (self.deletegate) {
        [self.deletegate btnbockClick:button.tag];
    }
    
}

-(void)btnCommentandWriteClick:(id)sender{
    if (self.deletegate) {
        [self.deletegate btnCommentClick:sender];
    }

    
    NSLog(@"btnCommentandWriteClick");
    
}

#pragma mark=======End =============

-(void)previousClick:(id)sender {
	if (currentScrollNumber > 1) {
		currentScrollNumber -= 1;
		[barButtonsView setContentOffset:CGPointMake(barButtonsView.contentOffset.x - 450, barButtonsView.frame.origin.y) animated:YES];
		[self reAssignPaginationButtons];
	}
}
-(void)nextClick:(id)sender {
	if (currentScrollNumber < totalScrollNumber) {
		currentScrollNumber += 1;
		[barButtonsView setContentOffset:CGPointMake(barButtonsView.contentOffset.x + 450, barButtonsView.frame.origin.y) animated:YES];
		[self reAssignPaginationButtons];
	}
}


-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
	[self reAdjustLayout];
}

-(void)reAdjustLayout {
    [barButtonsView setFrame:CGRectMake((self.frame.size.width/2) - barButtonsView.frame.size.width/2, 15, barButtonsView.frame.size.width, barButtonsView.frame.size.height)];
    [buttonPrevious setFrame:CGRectMake((barButtonsView.frame.origin.x - buttonPrevious.frame.size.width) - 5,17, buttonPrevious.frame.size.width, 20)];
    [buttonNext setFrame:CGRectMake(barButtonsView.frame.origin.x + barButtonsView.frame.size.width + 5, 17, buttonNext.frame.size.width, 20)];
    
    [barButtonsView setContentOffset:CGPointMake(450 * (currentScrollNumber-1), barButtonsView.frame.origin.y) animated:NO];
    
    [readAndCommentButton setFrame:CGRectMake(self.frame.size.width-45, self.frame.size.height-30, 20, 20)];
    [searchKeyword setFrame:CGRectMake(self.frame.size.width-85, self.frame.size.height-30, 20, 20)];
}

-(void)setAlpha:(CGFloat)alpha{
    self.alpha=alpha;
}

-(void) dealloc {
	[nextView release];
	[previousView release];
	[barButtonsView release];
    [readAndCommentButton release];
	[super dealloc];
}

#pragma mark--btnSearchKeyword
-(void)btnSearchKeyword:(id)sender{
    if (self.deletegate) {
        [self.deletegate searchKeywork:sender];
    }
}
@end
