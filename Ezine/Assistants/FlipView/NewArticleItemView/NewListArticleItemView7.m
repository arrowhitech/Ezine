//
//  NewListArticleItemView7.m
//  Ezine
//
//  Created by Hieu  on 8/28/12.
//
//

#import "NewListArticleItemView7.h"
#import "NewListArticleItemView3.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"
#import "FXLabel.h"

static const int bottomSpace = 10;

@implementation NewListArticleItemView7

@synthesize itemModel;
@synthesize imageLoadingOperation;
@synthesize _idLayout;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview{
	if (self = [super init]) {
		self.itemModel =_itemModel;
        self.Viewoder = oderview;
        self._idLayout=_itemModel._idLayout;
        //test
        
        
        
        
        //===
		[self initializeFields];
		
		UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[self addGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
        
        
	}
	return self;
}
-(void)layoutLandscape{
    
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
    
    NSLog(@"reAdjustLayout 7");
    // [self LoadImage:interfaceOrientation];
    //    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight) {
    //        [self layoutLandscape];
    //        return;
    //    }
    for (UIView *view in contentView.subviews) {
        if ([view isKindOfClass:[NewListArticleItemView3 class]]||view.tag==100) {
            [view removeFromSuperview];
        }
    }
    
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        
        if (self._idLayout==3&&self.Viewoder==2) {
            for (UIView *view in contentView.subviews) {
                if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                    [view removeFromSuperview];
                }
            }
            
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
            
            NewListArticleItemView3 *article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
            article3.frame =CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height, self.frame.size.width-10, self.frame.size.height-time_ago.frame.origin.y-time_ago.frame.size.height);
            [article3 setBackgroundColor:[UIColor whiteColor]];
            [article3 reAdjustLayout:UIInterfaceOrientationPortrait];
            [contentView addSubview:article3];
            //[self addSubview:contentView];
            [imageView removeFromSuperview];
            [contentView addSubview:imageView];
            [imageView setFrame:CGRectMake(self.frame.size.width/2+30, article3.frame.origin.y+10, self.frame.size.width/2-50, article3.frame.size.height-145)];
            return;
            
        }else if (self._idLayout==5 &&self.Viewoder==5){
            for (UIView *view in contentView.subviews) {
                if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                    [view removeFromSuperview];
                }else if (view.tag==100) {
                    [view removeFromSuperview];
                }
            }
            
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
            
            //                for (UIView *view in self.subviews) {
            //                    if (view ==contentView) {
            //                        [view removeFromSuperview];
            //                    }
            //                }
            
            
            NewListArticleItemView3 *article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
            [article3 setBackgroundColor:[UIColor whiteColor]];
            article3.layer.backgroundColor=[UIColor whiteColor].CGColor;
            article3.frame =CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height, self.frame.size.width-10, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-10);
            // [article3 reAdjustLayout:UIInterfaceOrientationPortrait];
            ///==== don't know why have black boder line add new view to hiden it
            
            UIView *whiteview=[[UIView alloc] initWithFrame:CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height-2, self.frame.size.width, 4)];
            [whiteview setBackgroundColor:[UIColor whiteColor]];
            [whiteview setTag:100];
            [contentView addSubview:article3];
            [contentView addSubview:whiteview];
            //[self addSubview:contentView];
            [imageView removeFromSuperview];
            [contentView addSubview:imageView];
            [imageView setFrame:CGRectMake(self.frame.size.width/2+30, article3.frame.origin.y+10, self.frame.size.width/2-50, article3.frame.size.height-85)];
            
            
            return;
        } else if (self._idLayout==11&&self.Viewoder==1){
            for (UIView *view in contentView.subviews) {
                if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                    [view removeFromSuperview];
                }else if (view.tag==100) {
                    [view removeFromSuperview];
                }
            }
            
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
            
            
            NewListArticleItemView3 *article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
            [article3 setBackgroundColor:[UIColor whiteColor]];
            article3.layer.backgroundColor=[UIColor whiteColor].CGColor;
            article3.frame =CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height, self.frame.size.width-10, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height);
            // [article3 reAdjustLayout:UIInterfaceOrientationPortrait];
            ///==== don't know why have black boder line add new view to hiden it
            
            UIView *whiteview=[[UIView alloc] initWithFrame:CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height-2, self.frame.size.width, 4)];
            [whiteview setBackgroundColor:[UIColor whiteColor]];
            [whiteview setTag:100];
            [contentView addSubview:article3];
            [contentView addSubview:whiteview];
            //[self addSubview:contentView];
            [imageView removeFromSuperview];
            [contentView addSubview:imageView];
            [imageView setFrame:CGRectMake(self.frame.size.width/2+30, title.frame.origin.y+10, self.frame.size.width/2-50, 200)];
            
            
            return;
            
        }
        
        for (UIView *view in contentView.subviews) {
            if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                [view removeFromSuperview];
            }
        }
        
        //[self addSubview:contentView];
        [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
        CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
        
        [title setFrame:CGRectMake(13, 10, contentViewArea.width-10, 40)];
        //title.numberOfLines=0;
        //[title sizeToFit];
        title.textAlignment=UITextAlignmentLeft;
        title.contentMode=UIViewContentModeCenter;
        titleFeed.numberOfLines=0;
        [titleFeed sizeToFit];
        [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, titleFeed.frame.size.width, titleFeed.frame.size.height)];
        
        [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+5, 30, 30)];
        
        [titleFeed sizeToFit];
        [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
        
        [time_ago sizeToFit];
        [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height, titleFeed.frame.size.width, titleFeed.frame.size.height)];
        
        switch (self._idLayout) {
                
            case 4:
            case 5:
                [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
                [contentView setBackgroundColor:[UIColor whiteColor]];
                contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+5, contentViewArea.width-258-10,contentViewArea.height-20-titleFeed.frame.size.height-titleFeed.frame.origin.y)];
                [imageView setFrame:CGRectMake(text_content.frame.size.width+25,text_content.frame.origin.y+10, 507/2-15, contentViewArea.height-text_content.frame.origin.y-17)];
                
                NSString *content =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                //                text_content.numberOfLines =0;
                //                 [text_content sizeToFit];
                
                break;
                
            case 6:
                
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width/2-10,contentViewArea.height-(time_ago.frame.origin.y+time_ago.frame.size.height+20))];
                
                
                [imageView setFrame:CGRectMake(text_content.frame.size.width+30,text_content.frame.origin.y+5, 344+10, 206)];
                
                NSString *content1 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content1 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
                break;
            case 7:
                
                
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width/2-10,contentViewArea.height-(time_ago.frame.origin.y+time_ago.frame.size.height+10))];
                
                NSString *content2 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content2 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
                [imageView setFrame:CGRectMake(contentViewArea.width/2.0+15,text_content.frame.origin.y+5,contentViewArea.width/2-20, contentViewArea.height-(time_ago.frame.origin.y+time_ago.frame.size.height+20))];
                
                break;
            case 8:
                
                
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width/1.4-20, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-10)];
                NSString *content3 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content3 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
                [imageView setFrame:CGRectMake(contentViewArea.width/1.4+10,text_content.frame.origin.y+5,200, text_content.frame.size.height-10)];
                
                
                break;
            case 10:
                for (UIView *view in contentView.subviews) {
                    if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                        [view removeFromSuperview];
                    }
                }
                
                [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
                contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
                
                [title setFrame:CGRectMake(10, 10, contentViewArea.width/2.5-10, 40)];
                title.numberOfLines=0;
                [title sizeToFit];
                title.textAlignment=UITextAlignmentLeft;
                title.contentMode=UIViewContentModeCenter;
                titleFeed.numberOfLines=0;
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+5, 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width/2.5-10, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-10)];
                NSString *content4 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content4 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
                
                [imageView setFrame:CGRectMake(contentViewArea.width/2.5+20, title.frame.origin.y+10, contentViewArea.width-contentViewArea.width/2.5-25,contentViewArea.height-title.frame.origin.y-20)];
                
                
                break;
            case 11:
                
                [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
                contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
                
                [title setFrame:CGRectMake(10, 10, contentViewArea.width-30, 40)];
                title.numberOfLines=0;
                [title sizeToFit];
                title.textAlignment=UITextAlignmentLeft;
                title.contentMode=UIViewContentModeCenter;
                titleFeed.numberOfLines=0;
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+5, 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width/2+10, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-10)];
                NSString *content11 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content11 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
                
                [imageView setFrame:CGRectMake(contentViewArea.width/2+30, imageIconView.frame.origin.y+10, contentViewArea.width/2-40,contentViewArea.height-title.frame.origin.y-20)];
                
                
                break;
            case 14:
                
                [title setFrame:CGRectMake(10, 10, contentViewArea.width-10-imageView.frame.size.width, 40)];
                
                [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width/1.5, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
                NSString *content6 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content6 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
                
                
                [imageView setFrame:CGRectMake(contentViewArea.width/1.5+20,title.frame.origin.y, contentViewArea.width-contentViewArea.width/1.5-20, contentViewArea.height-10)];
                break;
                
                
            default:
                break;
        }
        
        
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        [self ChangetoLanscape];
    }
    
    
    
}

- (void) initializeFields {
    NSLog(@"initialize item 7");
	contentView = [[UIView alloc] init];
	[contentView setBackgroundColor:[UIColor whiteColor]];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //    extraTitle =[[UILabel alloc]init];
    //    [extraTitle setText:itemModel.extraTitle];
    //    extraTitle.font =[UIFont fontWithName:@"UVNHongHaHep" size:18];
    //    extraTitle.textAlignment = UITextAlignmentCenter;
    //    [extraTitle setTextColor:RGBCOLOR(111, 111, 111)];
    //    [extraTitle setBackgroundColor:[UIColor redColor]];
    //    [contentView addSubview:extraTitle];
    
	imageView = [[UIImageView alloc] init];
    imageView.layer.borderColor= [UIColor colorWithRed:196.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1].CGColor;
    imageView.layer.borderWidth =2.0f;

    
    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    
	
    
    //    NSString *imageUrl = [itemModel._ArticlePortrait objectForKey:@"HeadImageUrl"];
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
    //
    [contentView addSubview:imageView];
    
    imageIconView =[[UIImageView alloc]init];
    
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
    
    
    // [imageIconView setImage:[UIImage imageNamed:itemModel.icon]];
    [contentView addSubview:imageIconView];
    
    title = [[FXLabel alloc] init];
    NSString *title1 = [itemModel._ArticlePortrait objectForKey:@"Title"];
    
	[title setText:[NSString stringWithFormat:@"%@",[title1 stringByConvertingHTMLToPlainText]]];
    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:21.12+XAppDelegate.appFontSize];
	[title setTextColor:RGBCOLOR(55,55,55)];;
	[title setBackgroundColor:[UIColor clearColor]];
	[contentView addSubview:title];
	
    titleFeed =[[UILabel alloc]init];
    titleFeed.font =[UIFont fontWithName:@"UVNHongHaHep" size:13.36+XAppDelegate.appFontSize];
    [titleFeed setBackgroundColor:[UIColor clearColor]];
	[titleFeed setTextColor:RGBCOLOR(95,95,95)];
    [contentView addSubview:titleFeed];
	
	time_ago = [[UILabel alloc] init];
    [titleFeed setText:[NSString stringWithFormat:@"chia sẻ bởi %@",itemModel.nameSite]];
    NSString *timecreate=[Utils dateStringFromTimestamp:itemModel.time_ago];
    [time_ago setText:[NSString stringWithFormat:@"%@ - %d bình luận",timecreate,itemModel._numberComment]];
	time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:13.36+XAppDelegate.appFontSize];
	[time_ago setTextColor:RGBCOLOR(95,95,95)];
	[time_ago setBackgroundColor:[UIColor clearColor]];
	[contentView addSubview:time_ago];
    
    text_content = [[OHAttributedLabel alloc] init];
	[text_content setBackgroundColor:[UIColor clearColor]];
	text_content.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:17+XAppDelegate.appFontSize];
	text_content.textColor =  RGBCOLOR(33,33,33);
	[contentView addSubview:text_content];
    
	[self addSubview:contentView];
    //	[self reAdjustLayout];
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

-(void)ChangetoLanscape{
    NSLog(@"change LandScape artucle 7 : viewoder===%d",self.Viewoder);
    [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
    CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
    
    
    [title setFrame:CGRectMake(10, 10, contentViewArea.width-10, 40)];
    title.numberOfLines =0;
    [title sizeToFit];
    [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
    titleFeed.numberOfLines=0;
    [titleFeed sizeToFit];
    [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width, titleFeed.frame.size.height)];
    
    
    
    [time_ago sizeToFit];
    [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
    NSString *content =[itemModel._ArticleLandscape objectForKey:@"Content"];
    [text_content setText:[content stringByConvertingHTMLToPlainText]];
    
    switch (self._idLayout) {
            
        case 3:
            for (UIView *view in contentView.subviews) {
                if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                    [view removeFromSuperview];
                }
            }
            title.numberOfLines =0;
            [title sizeToFit];
            //[self addSubview:contentView];
            [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+5, contentViewArea.width/2,contentViewArea.height -time_ago.frame.origin.y-time_ago.frame.size.height-10)];
            
            [imageView setFrame:CGRectMake(contentViewArea.width/2.0+30,text_content.frame.origin.y+10, contentViewArea.width/2.0-40, text_content.frame.size.height-20)];
            
            NSString *content =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
            return;
        case 4:
            title.numberOfLines =0;
            [title sizeToFit];
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+15, contentViewArea.width-15-230,contentViewArea.height-time_ago.frame.size.height-time_ago.frame.origin.y-10 )];
            
            [imageView setFrame:CGRectMake(contentViewArea.width/2.0+20+8,text_content.frame.origin.y+10, 215, text_content.frame.size.height-10)];
            
            NSString *content1 =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content1 stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            break;
            
        case 5:
            if (self.Viewoder==5) {
                for (UIView *view in contentView.subviews) {
                    if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                        [view removeFromSuperview];
                    }else if (view.tag==100){
                        [view removeFromSuperview];
                    }
                }
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
                
                //                for (UIView *view in self.subviews) {
                //                    if (view ==contentView) {
                //                        [view removeFromSuperview];
                //                    }
                //                }
                
                
                NewListArticleItemView3 *article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:10];
                [article3 setBackgroundColor:[UIColor whiteColor]];
                article3.layer.backgroundColor=[UIColor whiteColor].CGColor;
                article3.frame =CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height, self.frame.size.width-10, self.frame.size.height-time_ago.frame.origin.y-time_ago.frame.size.height);
                // [article3 reAdjustLayout:UIInterfaceOrientationPortrait];
                [contentView addSubview:article3];
                //[self addSubview:contentView];
                [imageView removeFromSuperview];
                [contentView addSubview:imageView];
                [imageView setFrame:CGRectMake(self.frame.size.width/2+20, article3.frame.origin.y+10, self.frame.size.width/2-40, article3.frame.size.height-140)];
                
            }else{
                
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width/2-10,contentViewArea.height-time_ago.frame.size.height-time_ago.frame.origin.y-20 )];
                
                [imageView setFrame:CGRectMake(contentViewArea.width/2.0+25,text_content.frame.origin.y+10, 225, contentViewArea.height-time_ago.frame.size.height-time_ago.frame.origin.y-30)];
                
                NSString *content2 =[itemModel._ArticleLandscape objectForKey:@"Content"];
                [text_content setText:[content2 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
            }
            
            break;
            
        case 6:
            title.numberOfLines =0;
            [title sizeToFit];
            [imageView setFrame:CGRectMake(title.frame.origin.x,time_ago.frame.size.height+time_ago.frame.origin.y+10, 223+20, 125)];
            
            [text_content setFrame:CGRectMake(title.frame.origin.x,imageView.frame.origin.y+imageView.frame.size.height+6 ,imageView.frame.size.width , contentViewArea.height-imageView.frame.size.height-imageView.frame.origin.y-10)];
            
            
            NSString *content3 =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content3 stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
            break;
        case 7:
            
            [title setFrame:CGRectMake(10, 0, contentViewArea.width-10, 40)];
            title.numberOfLines =0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
            
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
            
            
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
            
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width-20, contentViewArea.height-time_ago.frame.size.height-time_ago.frame.origin.y-180)];
            NSString *content5 =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content5 stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            //            [text_content sizeToFit];
            //            text_content.numberOfLines =0;
            
            [imageView setFrame:CGRectMake(title.frame.origin.x,text_content.frame.origin.y+text_content.frame.size.height+7, contentViewArea.width-10, 178)];
            
            break;
        case 8:
            title.numberOfLines =0;
            [title sizeToFit];
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width/1.5-10, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
            NSString *content6 =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content6 stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
            [imageView setFrame:CGRectMake(contentViewArea.width/1.5+10,text_content.frame.origin.y+2,150+10, text_content.frame.size.height)];
            
            break;
        case 10:
            //[contentView setBackgroundColor:[UIColor clearColor]];
            //[text_content setText:@""];
            for (UIView *view in self.subviews) {
                if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                    [view removeFromSuperview];
                }
            }
            [imageView setFrame:CGRectMake(title.frame.origin.x,contentViewArea.height-310,contentViewArea.width-10, 300)];
            
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width-10, imageView.frame.origin.y-time_ago.frame.size.height-time_ago.frame.origin.y-20)];
            
            NSString *content10 =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content10 stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
            
            break;
        case 11:
            if (self.Viewoder==1) {
                for (UIView *view in contentView.subviews) {
                    if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                        [view removeFromSuperview];
                    }else if (view.tag==100) {
                        [view removeFromSuperview];
                    }
                }
                
                [contentView setFrame:CGRectMake(1,1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
                CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
                
                [title setFrame:CGRectMake(10,10, contentViewArea.width-10, 40)];
                title.numberOfLines=0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+5, 30, 30)];
                titleFeed.numberOfLines=0;
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width, titleFeed.frame.size.height)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                
                
                NewListArticleItemView3 *article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:10];
                [article3 setBackgroundColor:[UIColor whiteColor]];
                article3.layer.backgroundColor=[UIColor whiteColor].CGColor;
                article3.frame =CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height, self.frame.size.width-10, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height);
                // [article3 reAdjustLayout:UIInterfaceOrientationPortrait];
                ///==== don't know why have black boder line add new view to hiden it
                
                UIView *whiteview=[[UIView alloc] initWithFrame:CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height-2, self.frame.size.width, 4)];
                [whiteview setBackgroundColor:[UIColor whiteColor]];
                [whiteview setTag:100];
                [contentView addSubview:article3];
                [contentView addSubview:whiteview];
                //[self addSubview:contentView];
                [imageView removeFromSuperview];
                [contentView addSubview:imageView];
                [imageView setFrame:CGRectMake(10, 350, contentViewArea.width-20, 190)];
                
                
                return;
                
            }
            title.numberOfLines =0;
            [title sizeToFit];
            [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width/2+50, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-20)];
            NSString *content7 =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content7 stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
            [imageView setFrame:CGRectMake(contentViewArea.width/2.0+80,imageIconView.frame.origin.y, contentViewArea.width/2-100, contentViewArea.height-imageIconView.frame.origin.y-10)];
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
            NewListArticleItemView3 *article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
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




@end
