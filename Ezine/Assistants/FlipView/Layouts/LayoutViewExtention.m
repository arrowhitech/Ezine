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
//  LayoutViewExtention.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.
 
//

#import "LayoutViewExtention.h"
#import "NSString+HTML.h"


@implementation LayoutViewExtention
@synthesize _interaceOrientation;

@synthesize currrentInterfaceOrientation,isFullScreen,headerView,footerView,fbheaderView,fbfooterView;

@synthesize layoutID;
@synthesize delegate;

-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
	currrentInterfaceOrientation = interfaceOrientation;
	NSLog(@"rotate in layoutViewExtention");
	[self reAdjustLayout];
}

-(void) setFooterView:(FooterView *)footerview {
	footerView = [footerview retain];
	[self.view addSubview:(UIView*)footerview];
}

-(void) setHeaderView:(HeaderView *)headerview {
	headerView = [headerview retain];
	[self.view addSubview:(UIView*)headerview];
}
-(void) setFbheaderView:(FbHeaderView *)fbheaderViews{
    fbheaderView = [fbheaderViews retain];
	[self.view addSubview:(UIView*)fbheaderViews];
}

-(void) setFbfooterView:(FbFooterView *)fbfooterViews{
    fbfooterView=[fbfooterViews retain];
    [self.view addSubview:(UIView*)fbfooterViews];

}
-(void)reAdjustLayout {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    if (currrentInterfaceOrientation == UIInterfaceOrientationPortrait || currrentInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [footerView setFrame:CGRectMake(0, 1004 - 50, 768,50)];
    }else {
        [footerView setFrame:CGRectMake(0, 748 - 50, 1024,50)];
    }
    [footerView rotate:currrentInterfaceOrientation animation:YES];
    [headerView rotate:currrentInterfaceOrientation animation:YES];
    [fbfooterView rotate:currrentInterfaceOrientation animation:YES];
    [fbheaderView rotate:currrentInterfaceOrientation animation:YES];
    [UIView commitAnimations];

	//view extending this class can overide this method
}

-(void)initalizeViews:(NSDictionary*)viewCollectionDictonary {
	//view extending this class can overide this method

}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"willRotateToInterfaceOrientation");
//    if (self.delegate) {
//        [self.delegate RotateToInterfaceOrientation:toInterfaceOrientation];
//    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.10];
    if (currrentInterfaceOrientation == UIInterfaceOrientationPortrait || currrentInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [footerView setFrame:CGRectMake(0, 1004 - 50, 768,50)];
    }else {
        [footerView setFrame:CGRectMake(0, 748 - 50, 1024,50)];
    }
    [footerView rotate:currrentInterfaceOrientation animation:YES];
    [headerView rotate:currrentInterfaceOrientation animation:YES];
    [fbfooterView rotate:currrentInterfaceOrientation animation:YES];
    [fbheaderView rotate:currrentInterfaceOrientation animation:YES];

    [UIView commitAnimations];

    [self rotate:toInterfaceOrientation animation:YES];
     
}


-(void) dealloc {
	[headerView release];
	[footerView release];
	[super dealloc];
}


@end
