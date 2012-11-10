//
//  LayoutArticle4.h
//  Ezine
//
//  Created by Admin on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
// Description:2 trên 3 dưới(trên/dưới=1/1). Trên bên trái có ảnh bên phải ko có ảnh(trái/phải=2/1). Dưới trái gồm 2 layout trên và dưới(trên/dưới =1/1),cả hai đều có ảnh ko có text, bên phải có ảnh và text wrap around ảnh, ảnh căn trái view. (trái/phải=1/2). 

#import "LayoutViewExtention.h"
#import "ArticleModel.h"

@class UIViewExtention;
@interface LayoutArticle4 : LayoutViewExtention{
    
    UIViewExtention* view1;
	UIViewExtention* view2;
	UIViewExtention* view3;
    UIViewExtention* view4;
	UIViewExtention* view5;
    UIInterfaceOrientation currentOriention;
}

@property (nonatomic,retain) UIViewExtention* view1;
@property (nonatomic,retain) UIViewExtention* view2;
@property (nonatomic,retain) UIViewExtention* view3;
@property (nonatomic,retain) UIViewExtention* view4;
@property (nonatomic,retain) UIViewExtention* view5;

@end
