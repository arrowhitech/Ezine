//
//  NewListArticleItemView10.m
//  Ezine
//
//  Created by Hieu  on 8/30/12.
//
//

#import "NewListArticleItemView10.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"
#import "NewListArticleItemView3.h"
static const int bottomSpace = 10;


@implementation NewListArticleItemView10

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
        self._idLayout =_itemModel._idLayout;
        //test




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
    //[self LoadImage:interfaceOrientation];
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        for (UIView *view in contentView.subviews) {
            if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                [view removeFromSuperview];
            }else if (view.tag==100) {
                [view removeFromSuperview];
            }
        }
        
        [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
        CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
        title.numberOfLines =0;
        [title sizeToFit];
        switch (self._idLayout) {
            case 5:
                for (UIView *view in self.subviews) {
                    if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                        [view removeFromSuperview];
                    }
                }
                [self addSubview:contentView];
                
                
                //                if (self.Viewoder==2) {
                //                    [imageView setFrame:CGRectMake(10, 10, contentViewArea.width-20, contentViewArea.height/2.2)];
                //
                //                }
                
                [imageView setFrame:CGRectMake(10, 10, 262, 196)];
                
                [title setFrame:CGRectMake(10,imageView.frame.origin.y+imageView.frame.size.height+5, contentViewArea.width-30, 20)];
                title.numberOfLines =0;
                [title sizeToFit];
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+bottomSpace, imageView.frame.size.width, contentViewArea.height-imageIconView.frame.size.height-imageIconView.frame.origin.y)];
                
                NSString *content =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];

                break;

            case 10:    
                for (UIView *view in self.subviews) {
                    if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                        [view removeFromSuperview];
                    }
                }
                [self addSubview:contentView];      
               
                
//                if (self.Viewoder==2) {
//                    [imageView setFrame:CGRectMake(10, 10, contentViewArea.width-20, contentViewArea.height/2.2)];
//                    
//                }

                [imageView setFrame:CGRectMake(10, 10, 250, 196)];
                               
                [title setFrame:CGRectMake(10,imageView.frame.origin.y+imageView.frame.size.height+5, contentViewArea.width-20, 20)];
                title.numberOfLines =0;
                 [title sizeToFit];
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [text_content sizeToFit];
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+bottomSpace, imageView.frame.size.width, contentViewArea.height-imageIconView.frame.size.height-imageIconView.frame.origin.y)];
                
                NSString *content1 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content1 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                break;
            case 6:
                
                [imageView setFrame:CGRectMake(15, 10, 353, 199)];
                
                [title setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+4, imageView.frame.size.width, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(imageView.frame.origin.x, title.frame.origin.y+title.frame.size.height+2, 30, 30)];
                
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y, imageView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [text_content setFrame:CGRectMake(imageView.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10,imageView.frame.size.width, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-20)];
                
                NSString *content3 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content3 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
                break;
            case 7:
                if (self.Viewoder==1) {
                    [imageView setFrame:CGRectMake(15, 10, 358, 201)];
                    
                    [title setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+4, imageView.frame.size.width, 40)];
                    title.numberOfLines =0;
                    [title sizeToFit];
                    
                    [imageIconView setFrame:CGRectMake(imageView.frame.origin.x, title.frame.origin.y+title.frame.size.height+2, 30, 30)];
                    
                    [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y, imageView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                    
                    [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                    
                    [text_content setFrame:CGRectMake(imageView.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10,imageView.frame.size.width, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-30)];
                    
                    NSString *content4 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                    [text_content setText:[content4 stringByConvertingHTMLToPlainText]];
                    text_content= [self resetAlighLabel:text_content];

                }
                if (self.Viewoder==2) {
                    
                    [imageView setFrame:CGRectMake(15, 10, 352, 264)];
                    
                    [title setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+4, imageView.frame.size.width, 40)];
                    title.numberOfLines =0;
                    [title sizeToFit];
                    [imageIconView setFrame:CGRectMake(imageView.frame.origin.x, title.frame.origin.y+title.frame.size.height+2, 30, 30)];
                    
                    [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y, imageView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                    
                    [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                    
                    [text_content setFrame:CGRectMake(imageView.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+15,imageView.frame.size.width, 185)];
                    
                    NSString *content5 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                    [text_content setText:[content5 stringByConvertingHTMLToPlainText]];
                    text_content= [self resetAlighLabel:text_content];

                    
                }
                                
                break;
            default:
                break;
        }
       
        
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
       
        [self ChangetoLandscape];
    }
    
	
    
    
}

- (void) initializeFields {
    NSLog(@"initialize item 8");
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
//                                                                        onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
//                                                                            if([imageUrl isEqualToString:[url absoluteString]]) {
//                                                                                
//                                                                                if (isInCache) {
//                                                                                    imageView.image = fetchedImage;
//                                                                                    //     [self hideActivityIndicator];
//                                                                                    
//                                                                                } else {
//                                                                                    UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
//                                                                                    loadedImageView.frame = imageView.frame;
//                                                                                    loadedImageView.alpha = 0;
//                                                                                    [loadedImageView removeFromSuperview];
//                                                                                    
//                                                                                    imageView.image = fetchedImage;
//                                                                                    imageView.alpha = 1;
//                                                                                    // [self hideActivityIndicator];
//                                                                                    
//                                                                                }
//                                                                            }
//                                                                        }];
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
    
    title = [[UILabel alloc] init];
    NSString *title1 =[itemModel._ArticlePortrait objectForKey:@"Title"];

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

-(void)ChangetoLandscape{
    for (UIView *view in contentView.subviews) {
        if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
            [view removeFromSuperview];
        }else if (view.tag==100) {
            [view removeFromSuperview];
        }
    }

    [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
    CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));

    switch (self._idLayout) {
            case 6:
            case 7:
            [imageView setFrame:CGRectMake(10, 10, contentViewArea.width-10, 266)];
            
            [title setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+4, imageView.frame.size.width, 40)];
            title.numberOfLines=0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(imageView.frame.origin.x, title.frame.origin.y+title.frame.size.height+2, 30, 30)];
            
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y, imageView.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
            
            [text_content setFrame:CGRectMake(imageView.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+10,imageView.frame.size.width, contentViewArea.height-time_ago.frame.origin.y+time_ago.frame.size.height-10)];
            
            NSString *content =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
                break;

     
            

        case 5:
            [title setFrame:CGRectMake(10, 10, contentViewArea.width-10, 40)];
            title.numberOfLines =0;
            [title sizeToFit];
            
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
            
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];

            [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width/2-10,contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-10 )];
            
            [imageView setFrame:CGRectMake(contentViewArea.width/2.0+26,text_content.frame.origin.y+10, 210, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-30)];
            
            NSString *content1 =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content1 stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];

            return;
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
                if ([view isKindOfClass:[NewListArticleItemView3 class]]) {
                    [view removeFromSuperview];
                }
            }
            NewListArticleItemView3* article3=[[NewListArticleItemView3 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
            [article3 setBackgroundColor:[UIColor whiteColor]];
            article3.frame=CGRectMake(0, time_ago.frame.size.height+time_ago.frame.origin.y+10, contentViewArea.width+20, contentViewArea.height-(time_ago.frame.size.height+time_ago.frame.origin.y+10));
            
            ///==== don't know why have black boder line add new view to hiden it
            
            UIView *whiteview=[[UIView alloc] initWithFrame:CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height+8, self.frame.size.width, 4)];
            [whiteview setBackgroundColor:[UIColor whiteColor]];
            [whiteview setTag:100];
            [contentView addSubview:article3];
            [contentView addSubview:whiteview];
            
            [imageView setFrame:CGRectMake(self.frame.size.width/2+40, title.frame.origin.y+10, self.frame.size.width/2-60, 210)];
            [contentView bringSubviewToFront:imageView];
            return;
            break;

            

            if (self.Viewoder==1) {
                [imageView setFrame:CGRectMake(15, 10, 306, 232)];
                
                [title setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+4, imageView.frame.size.width, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(imageView.frame.origin.x, title.frame.origin.y+title.frame.size.height+2, 30, 30)];
                
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y, imageView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [text_content setFrame:CGRectMake(imageView.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+2,imageView.frame.size.width, 300)];
                
                NSString *content2 =[itemModel._ArticleLandscape objectForKey:@"Content"];
                [text_content setText:[content2 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
            }
            if (self.Viewoder==2) {
                
                [imageView setFrame:CGRectMake(15, 10, 306, 232)];
                
                [title setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+4, imageView.frame.size.width, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(imageView.frame.origin.x, title.frame.origin.y+title.frame.size.height+2, 30, 30)];
                
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y, imageView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [text_content setFrame:CGRectMake(imageView.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+2,imageView.frame.size.width, 300)];
                
                NSString *content3 =[itemModel._ArticleLandscape objectForKey:@"Content"];
                [text_content setText:[content3 stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];
                
                
            }
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
