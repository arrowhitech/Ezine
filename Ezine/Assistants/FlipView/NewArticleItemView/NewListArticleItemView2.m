//
//  NewListArticleItemView2.m
//  Ezine
//
//  Created by MAC on 8/28/12.
//
//

#import "NewListArticleItemView2.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"
#import "NewListArticleItemView3.h"
#import "NSAttributedString+Attributes.h"
#import "Utils.h"

static const int bottomSpace = 10;

@implementation NewListArticleItemView2

@synthesize itemModel;
@synthesize imageLoadingOperation;
@synthesize _idLayout;

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview{
	if (self = [super init]) {
        
		self.itemModel =_itemModel;
        self.Viewoder = oderview;
        self._idLayout =_itemModel._idLayout;
        //test
        
        //====
		[self initializeFields];
		
		UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[self addGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
        
        
	}
	return self;
}
#pragma mark--- load image rotate
-(void)LoadImage:(UIInterfaceOrientation)interfaceOrientation{
    NSString *imageUrl;
    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        imageUrl = [itemModel._ArticlePortrait objectForKey:@"HeadImageUrl"];
        
        
    }else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        imageUrl = [itemModel._ArticleLandscape objectForKey:@"HeadImageUrl"];
        
    }
    
    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:imageUrl]
                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                              if([imageUrl isEqualToString:[url absoluteString]]) {
                                                                  
                                                                  if (isInCache) {
                                                                      imageView.image = fetchedImage;
                                                                      //     [self hideActivityIndicator];
                                                                      
                                                                  } else {
                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                      loadedImageView.frame = imageView.frame;
                                                                      loadedImageView.alpha = 0;
                                                                      [loadedImageView removeFromSuperview];
                                                                      
                                                                      imageView.image = fetchedImage;
                                                                      imageView.alpha = 1;
                                                                      // [self hideActivityIndicator];
                                                                      
                                                                  }
                                                              }
                                                          }];
    NSString* urlicon = itemModel.icon;
    if ((NSNull *)urlicon==[NSNull null]) {
        urlicon =@"";
    }
    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlicon]
                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                              if([urlicon isEqualToString:[url absoluteString]]) {
                                                                  
                                                                  if (isInCache) {
                                                                      imageIconView.image = fetchedImage;
                                                                      //     [self hideActivityIndicator];
                                                                      
                                                                  } else {
                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                      loadedImageView.frame = imageIconView.frame;
                                                                      loadedImageView.alpha = 0;
                                                                      [loadedImageView removeFromSuperview];
                                                                      
                                                                      imageIconView.image = fetchedImage;
                                                                      imageIconView.alpha = 1;
                                                                      // [self hideActivityIndicator];
                                                                      
                                                                  }
                                                              }
                                                          }];
    
    
    
    
}
#pragma mark-------

- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation{
    NSLog(@"reAdjustLayout 2");
    // [self LoadImage:interfaceOrientation];
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown){
        NSLog(@"poit trait   ");
        
        for (UIView *view in contentView.subviews) {
            if ([view isKindOfClass:[NewListArticleItemView3 class]]||view.tag==100) {
                [view removeFromSuperview];
            }
        }
        
        [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
        CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 14), (contentView.frame.size.height-10));
        [self addSubview:contentView];
        
        [title setFrame:CGRectMake(13,10, contentViewArea.width-10,40)];
        //title.text=@"Bổ sung quyền của Chủ tịch nước trong Hiến phápBổ sung quyền của Chủ tịch nước trong Hiến phápBổ sung quyền của Chủ tịch nước trong Hiến phápBổ sung quyền của Chủ tịch nước trong Hiến pháp";
        [title sizeToFit];
        title.numberOfLines=0;
        
        [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace/2, 30, 30)];
        titleFeed.numberOfLines=0;
        [titleFeed sizeToFit];
        [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, titleFeed.frame.size.width, titleFeed.frame.size.height)];
        
        time_ago.numberOfLines=0;
        [time_ago sizeToFit];
        [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height,contentViewArea.width-10 , time_ago.frame.size.height)];
        
        if (self._idLayout==2&&self.Viewoder==1) {
//            for (UIView *view in self.subviews) {
//                if (view ==contentView) {
//                    [view removeFromSuperview];
//                }
//            }
            
            NewListArticleItemView3 *article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
            article3.frame =CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height, self.frame.size.width-10, self.frame.size.height-time_ago.frame.origin.y+time_ago.frame.size.height);
            [article3 setBackgroundColor:[UIColor whiteColor]];
            [article3 reAdjustLayout:UIInterfaceOrientationPortrait];
            [contentView addSubview:article3];
            //[self addSubview:contentView];
            [imageView removeFromSuperview];
            [contentView addSubview:imageView];
            [imageView setFrame:CGRectMake(self.frame.size.width/2+40, article3.frame.origin.y+5, self.frame.size.width/2-60, article3.frame.size.height-185)];
            return;
            
        }
        
        
        switch (self._idLayout) {
            case 1:
                [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+35, contentViewArea.width-16,413/2)];
                [text_content setFrame:CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y+imageView.frame.size.height+14, contentViewArea.width-16, contentViewArea.height-imageView.frame.origin.y-imageView.frame.size.height-20)];
                NSString *content =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content stringByConvertingHTMLToPlainText]];
                
                text_content= [self resetAlighLabel:text_content];
                return;
                break;
            case 2:
                [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+35, contentViewArea.width-16,413/2)];
                [text_content setFrame:CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y+imageView.frame.size.height+14, contentViewArea.width-16, contentViewArea.height-imageView.frame.origin.y-imageView.frame.size.height-20)];
                NSString *contents =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[contents stringByConvertingHTMLToPlainText]];
                
                text_content= [self resetAlighLabel:text_content];
                
                
                return;
            case 4:
                [imageView setFrame:CGRectMake(imageIconView.frame.origin.x,time_ago.frame.origin.y+40, contentViewArea.width-10,320)];
                
                break;
            case 8:
                [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+40, contentViewArea.width-10,170)];
                [text_content setFrame:CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y+imageView.frame.size.height+10, contentViewArea.width-10, contentViewArea.height-imageView.frame.origin.y-imageView.frame.size.height-10)];
                if (self.Viewoder==4) {
                    [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+40, contentViewArea.width-20,170)];
                    [text_content setFrame:CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y+imageView.frame.size.height+10, contentViewArea.width-20, contentViewArea.height-imageView.frame.origin.y-imageView.frame.size.height-10)];
                }
                NSString *contentss =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[contentss stringByConvertingHTMLToPlainText]];
                
                text_content= [self resetAlighLabel:text_content];
                return;
                break;
            case 14:
                [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+30, contentViewArea.width-10,170)];
                break;
            case 10:
                [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+40, contentViewArea.width-10,335)];
                break;
                
            default:
                break;
        }
        
        
        // [text_content sizeToFit];
        [text_content setFrame:CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y+imageView.frame.size.height+10, contentViewArea.width-20, contentViewArea.height-imageView.frame.origin.y-imageView.frame.size.height-10)];
        NSString *content =[itemModel._ArticlePortrait objectForKey:@"Content"];
        [text_content setText:[content stringByConvertingHTMLToPlainText]];
        
        text_content= [self resetAlighLabel:text_content];
        //        text_content.contentMode =UIViewContentModeLeft|UIViewContentModeTop|UIViewContentModeRight;
        //        text_content.numberOfLines =0;
        //        [text_content sizeToFit];
        
        
        
        
    }else {
        [self changeLandScape];
    }
}

- (void) initializeFields {
    NSLog(@"initialize item 2");
	contentView = [[UIView alloc] init];
	[contentView setBackgroundColor:[UIColor whiteColor]];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    extraTitle =[[UILabel alloc]init];
    [extraTitle setText:itemModel.extraTitle];
    extraTitle.font =[UIFont fontWithName:@"UVNHongHaHep" size:18+XAppDelegate.appFontSize];
    extraTitle.textAlignment = UITextAlignmentCenter;
    [extraTitle setTextColor:RGBCOLOR(111, 111, 111)];
    [extraTitle setBackgroundColor:[UIColor redColor]];
    [contentView addSubview:extraTitle];
    
	imageView = [[UIImageView alloc] init];
    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    
	
    
    //   NSString *imageUrl = [itemModel._ArticlePortrait objectForKey:@"HeadImageUrl"];
    //    if ((NSNull *)imageUrl==[NSNull null]) {
    //        imageUrl =@"";
    //    }
    //    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:imageUrl]
    //                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
    //                                                              if([imageUrl isEqualToString:[url absoluteString]]) {
    //
    //                                                                  if (isInCache) {
    //                                                                      imageView.image = fetchedImage;
    //                                                                      //     [self hideActivityIndicator];
    //
    //                                                                  } else {
    //                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
    //                                                                      loadedImageView.frame = imageView.frame;
    //                                                                      loadedImageView.alpha = 0;
    //                                                                      [loadedImageView removeFromSuperview];
    //
    //                                                                      imageView.image = fetchedImage;
    //                                                                      imageView.alpha = 1;
    //                                                                      // [self hideActivityIndicator];
    //
    //                                                                  }
    //                                                              }
    //                                                          }];
    
    NSString* urlicon = itemModel.icon;
    if ((NSNull *)urlicon==[NSNull null]) {
        urlicon =@"";
    }
    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlicon]
                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                              if([urlicon isEqualToString:[url absoluteString]]) {
                                                                  
                                                                  if (isInCache) {
                                                                      imageIconView.image = fetchedImage;
                                                                      //     [self hideActivityIndicator];
                                                                      
                                                                  } else {
                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                      loadedImageView.frame = imageIconView.frame;
                                                                      loadedImageView.alpha = 0;
                                                                      [loadedImageView removeFromSuperview];
                                                                      
                                                                      imageIconView.image = fetchedImage;
                                                                      imageIconView.alpha = 1;
                                                                      // [self hideActivityIndicator];
                                                                      
                                                                  }
                                                              }
                                                          }];
    
    
    
    
    [contentView addSubview:imageView];
    
    imageIconView =[[UIImageView alloc]init];
    // [imageIconView setImage:[UIImage imageNamed:itemModel.icon]];
    [contentView addSubview:imageIconView];
    title = [[UILabel alloc] init];
    NSString *title1 = [itemModel._ArticlePortrait objectForKey:@"Title"];
    
	[title setText:[NSString stringWithFormat:@"%@",[title1 stringByConvertingHTMLToPlainText]]];
    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:21.12+XAppDelegate.appFontSize];
	[title setTextColor:RGBCOLOR(55,55,55)];
	[title setBackgroundColor:[UIColor clearColor]];
    title.numberOfLines=0;
    [title sizeToFit];
    //    title.shadowColor = RGBCOLOR(55,55,55);
    //    title.shadowOffset = CGSizeMake(0, 1);
	[contentView addSubview:title];
    
    titleFeed =[[UILabel alloc]init];
    [titleFeed setText:[NSString stringWithFormat:@"chia sẻ bởi %@",itemModel.nameSite]];
    titleFeed.font =[UIFont fontWithName:@"UVNHongHaHep" size:13.36+XAppDelegate.appFontSize];
    [titleFeed setBackgroundColor:[UIColor clearColor]];
    titleFeed.textColor =  RGBCOLOR(95,95,95);
	titleFeed.highlightedTextColor = RGBCOLOR(33,33,33);
    
    [contentView addSubview:titleFeed];
    //	titleFeed.shadowColor = [UIColor blackColor];
    //    titleFeed.shadowOffset = CGSizeMake(0, 1);
    
	
	time_ago = [[UILabel alloc] init];
    NSString *timecreate=[Utils dateStringFromTimestamp:itemModel.time_ago];
    [time_ago setText:[NSString stringWithFormat:@"%@ - %d bình luận",timecreate,itemModel._numberComment]];
	time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:13.36+XAppDelegate.appFontSize];
	[time_ago setTextColor:RGBCOLOR(95,95,95)];
	[time_ago setBackgroundColor:[UIColor clearColor]];
    //    time_ago.shadowColor = [UIColor blackColor];
    //    time_ago.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:time_ago];
    
    text_content = [[OHAttributedLabel alloc] init];
    [text_content setBackgroundColor:[UIColor clearColor]];
	text_content.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:17+XAppDelegate.appFontSize];
	text_content.textColor =  RGBCOLOR(33,33,33);
	//text_content.highlightedTextColor = RGBCOLOR(33,33,33);
	//text_content.contentMode = UIViewContentModeTop;
    //	text_content.textAlignment = UITextAlignmentLeft;
    //    [text_content setNumberOfLines:0];
    //    [text_content sizeToFit];
    
    
	[contentView addSubview:text_content];
    
	[self addSubview:contentView];
	//[self reAdjustLayout];
}

-(void)tapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@" Item thu:%d",self.Viewoder);
    //    NSLog(@" Item thu:%d",itemModel.oder);
    //    NSLog(@" Item ID:%d",itemModel.itemID);
	[[EzineAppDelegate instance] showViewInFullScreen:self withModel:self.itemModel];
}


-(void) setFrame:(CGRect)rect {
    self.originalRect = rect;
    [super setFrame:rect];
}

- (void) dealloc{
    
	[contentView release];
    contentView =nil;
    
    [imageView release];
    imageView =nil;
    
    [title release];
    title =nil;
    
    [titleFeed release];
    titleFeed =nil;
    
    [time_ago release];
    time_ago =nil;
    
    [text_content release];
    text_content =nil;
    
    [imageIconView release ];
    imageIconView =nil;
    
	[super dealloc];
}

#pragma mark-- change landcape
-(void)changeLandScape{
    [contentView setFrame:CGRectMake(1,1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
    CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
    
    [title setFrame:CGRectMake(10,10, contentViewArea.width-30, 40)];
    title.numberOfLines=0;
    [title sizeToFit];
    [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+5, 30, 30)];
    titleFeed.numberOfLines=0;
    [titleFeed sizeToFit];
    [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width, titleFeed.frame.size.height)];
    
    [time_ago sizeToFit];
    [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height,titleFeed.frame.size.width , titleFeed.frame.size.height)];
    //=========== layout
    NSString *content;
    NewListArticleItemView3 *article3;
    switch (self._idLayout) {
        case 1:
            if (self.Viewoder==1) {
                for (UIView *view in contentView.subviews) {
                    if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                        [view removeFromSuperview];
                    }
                }
                //[self addSubview:contentView];
            }
            title.numberOfLines=0;
            [title sizeToFit];
            [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+30, 310,160)];
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+10, imageView.frame.size.width, contentViewArea.height-imageView.frame.size.height-imageView.frame.origin.y-15)];
            content =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            //[text_content sizeToFit];
            return;
            break;
        case 2:
            if (self.Viewoder==1) {
                for (UIView *view in contentView.subviews) {
                    if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                        [view removeFromSuperview];
                    }
                }
                //[self addSubview:contentView];
            }
            title.numberOfLines=0;
            [title sizeToFit];
            [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+20, 306+14,160)];
            if (self.Viewoder==3) {
                [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+20, 310,160)];
                
            }
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+10, imageView.frame.size.width, contentViewArea.height-imageView.frame.size.height-imageView.frame.origin.y-bottomSpace)];
            content =[itemModel._ArticleLandscape objectForKey:@"Content"];
            NSLog(@"text content landscape===%@  %f",content,text_content.frame.size.height);
            [text_content setText:[content stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
            break;
        case 4:
            title.numberOfLines =0;
            [title sizeToFit];
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+15, contentViewArea.width-15-230,172 )];
            
            [imageView setFrame:CGRectMake(contentViewArea.width/2.0+20,text_content.frame.origin.y+5, 225, 180)];
            
            content =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
            
            break;
        case 8:
            title.numberOfLines =0;
            [title sizeToFit];
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width/2-10, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
            content =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
            [imageView setFrame:CGRectMake(contentViewArea.width/2+10,text_content.frame.origin.y,230+10, 170)];
            
            
            break;
        case 10:
            [contentView setFrame:CGRectMake(1,1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
            CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
            
            [title setFrame:CGRectMake(10,10, self.frame.size.width/2, 40)];
            title.numberOfLines=0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+5, 30, 30)];
            titleFeed.numberOfLines=0;
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width, titleFeed.frame.size.height)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height,titleFeed.frame.size.width , titleFeed.frame.size.height)];

            
            for (UIView *view in self.subviews) {
                if ([view isKindOfClass:[NewListArticleItemView3 class]]||view.tag==100) {
                    [view removeFromSuperview];
                }
            }
            article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
            [article3 setBackgroundColor:[UIColor whiteColor]];
            article3.frame=CGRectMake(0, time_ago.frame.size.height+time_ago.frame.origin.y+8, contentViewArea.width+20, contentViewArea.height-(time_ago.frame.size.height+time_ago.frame.origin.y+10));
            ///==== don't know why have black boder line add new view to hiden it
            
            UIView *whiteview=[[UIView alloc] initWithFrame:CGRectMake(0, time_ago.frame.size.height+time_ago.frame.origin.y+6, self.frame.size.width, 4)];
            [whiteview setBackgroundColor:[UIColor whiteColor]];
            [whiteview setTag:100];
            [contentView addSubview:article3];
            [contentView addSubview:whiteview];

            [imageView setFrame:CGRectMake(self.frame.size.width/2+40, title.frame.origin.y+10, self.frame.size.width/2-60, 210)];
            [contentView bringSubviewToFront:imageView];
            return;
            
            break;
        case 14:
            [contentView setFrame:CGRectMake(1,1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
             contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
            
            [title setFrame:CGRectMake(10,10, self.frame.size.width-20, 40)];
            title.numberOfLines=0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+5, 30, 30)];
            titleFeed.numberOfLines=0;
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width, titleFeed.frame.size.height)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            
            [text_content setText:@""];
            text_content= [self resetAlighLabel:text_content];
            for (UIView *view in contentView.subviews) {
                if ([view isKindOfClass:[NewListArticleItemView3 class]]||view.tag==100) {
                    [view removeFromSuperview];
                }
            }
            article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
            [article3 setBackgroundColor:[UIColor whiteColor]];
            article3.frame=CGRectMake(0, time_ago.frame.size.height+time_ago.frame.origin.y+8, contentViewArea.width+20, contentViewArea.height-(time_ago.frame.size.height+time_ago.frame.origin.y+30));
            ///==== don't know why have black boder line add new view to hiden it
            
            UIView *whiteviews=[[UIView alloc] initWithFrame:CGRectMake(0, time_ago.frame.size.height+time_ago.frame.origin.y+6, self.frame.size.width, 4)];
            [whiteviews setBackgroundColor:[UIColor whiteColor]];
            [whiteviews setTag:100];
            [contentView addSubview:article3];
            [contentView addSubview:whiteviews];
            
            [imageView setFrame:CGRectMake(self.frame.size.width/2, article3.frame.origin.y+10, self.frame.size.width/2-25, contentViewArea.height-time_ago.frame.size.height-time_ago.frame.origin.y-160)];
            [contentView bringSubviewToFront:imageView];
            return;
            
            break;
            
        default:
            break;
    }
    
    
    
    return;
    
}

@end
