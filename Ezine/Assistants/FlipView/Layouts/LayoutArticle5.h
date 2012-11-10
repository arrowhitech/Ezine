//
//  LayoutArticle5.h
//  Ezine
//
//  Created by Admin on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.

// Description:2 trái 2 phải(trái/phải =1/1). Trái gồm trái trên trái dưới(trên/dưới=2/1), đều đầy đủ ảnh và text. Phải gồm trên và dưới, trên có ảnh và text , dưới có text ko có ảnh (trên/dưới =2/3). tất cả đều ko có image icon và titleFeed

#import "LayoutViewExtention.h"
#import "ArticleModel.h"

@class UIViewExtention;
@interface LayoutArticle5 : LayoutViewExtention{
 
    UIViewExtention* view1;
	UIViewExtention* view2;
	UIViewExtention* view3;
    UIViewExtention* view4;
    UIViewExtention* view5;
    
}

@property (nonatomic,retain) UIViewExtention* view1;
@property (nonatomic,retain) UIViewExtention* view2;
@property (nonatomic,retain) UIViewExtention* view3;
@property (nonatomic,retain) UIViewExtention* view4;
@property (nonatomic,retain) UIViewExtention* view5;

@end
