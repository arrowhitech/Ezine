//
//  NewListArticleItemView5.m
//  Ezine
//
//  Created by Hieu  on 8/29/12.
//
//

#import "NewListArticleItemView5.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"
#import "CTView.h"
#import "MarkupParser.h"
#import "NewListArticleItemView4.h"

static const int bottomSpace = 10;


@implementation NewListArticleItemView5

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
        
        //self._idLayout=5;
        
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
    if ((NSNull*)imageUrl==[NSNull null]) {
        imageUrl=@"";
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
        
        switch (self._idLayout) {
            case 3:
                
                    for (UIView *view in contentView.subviews) {
                        if ([view isKindOfClass:[NewListArticleItemView4 class]]) {
                            [view removeFromSuperview];
                        }
                    }
                    if (self._idLayout==3&&self.Viewoder==1) {
//                        for (UIView *view in self.subviews) {
//                            if (view ==contentView) {
//                                [view removeFromSuperview];
//                            }
//                        }
                        
                        
                        NewListArticleItemView4 *article4=[[NewListArticleItemView4 alloc] initWithMessageModel:self.itemModel andViewoder:self.Viewoder];
                        [article4 setBackgroundColor:[UIColor whiteColor]];
                        article4.frame=CGRectMake(0, time_ago.frame.origin.y+time_ago.frame.size.height, contentView.frame.size.width, contentView.frame.size.height-time_ago.frame.origin.y-time_ago.frame.size.height);
                        [article4 reAdjustLayout:UIInterfaceOrientationPortrait];
                        [contentView addSubview:article4];
                        return;
                    }
                
                
             case 4:
            case 5:                    
                [title setFrame:CGRectMake(10, 10, contentViewArea.width-30, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
            
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width-20, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-bottomSpace)];
                
                 NSString *content =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content stringByConvertingHTMLToPlainText]];
                text_content= [self resetAlighLabel:text_content];

                break;
            case 13:
                [title setFrame:CGRectMake(10, 10, contentViewArea.width-40, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width-15, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-bottomSpace)];
                if (self.Viewoder==2) {
                     [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width-25, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-bottomSpace)];
                }

                NSString *content1 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content1 stringByConvertingHTMLToPlainText]];
                
                text_content= [self resetAlighLabel:text_content];
                return;
                break;

                break;
            case 11:
            case 15:   
                NSLog(@"IdLayout In article 5== %d",self._idLayout);
                [title setFrame:CGRectMake(10, 10, contentViewArea.width-40, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
           
                [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+10, contentViewArea.width-10-imageView.frame.size.width, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
                
                NSString *content2 =[itemModel._ArticlePortrait objectForKey:@"Content"];
                [text_content setText:[content2 stringByConvertingHTMLToPlainText]];

                text_content= [self resetAlighLabel:text_content];
                return;
                break;

            default:
                break;
        }
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation== UIInterfaceOrientationLandscapeRight){
        
        [self ChangetoLanscape];
    }
	
    
    
}

- (void) initializeFields {
    NSLog(@"initialize item 5");
	contentView = [[UIView alloc] init];
	[contentView setBackgroundColor:[UIColor whiteColor]];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
      
    imageIconView =[[UIImageView alloc]init];
    
    NSString* urlicon = itemModel.icon;
    if ((NSNull *)urlicon==[NSNull null]) {
        urlicon =@"";
    }
    self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlicon]
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
    

    
    //[imageIconView setImage:[UIImage imageNamed:itemModel.icon]];
    [contentView addSubview:imageIconView];
    
    title = [[UILabel alloc] init];
    NSString *title1 = [itemModel._ArticlePortrait objectForKey:@"Title"];

	[title setText:[NSString stringWithFormat:@"%@",[title1 stringByConvertingHTMLToPlainText]]];
    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:21.12+XAppDelegate.appFontSize];
	[title setTextColor:RGBCOLOR(55,55,55)];;
	[title setBackgroundColor:[UIColor clearColor]];
	[contentView addSubview:title];
	
    titleFeed =[[UILabel alloc]init];
    titleFeed.font =[UIFont fontWithName:@"UVNHongHaHep" size:15.36+XAppDelegate.appFontSize];
    [titleFeed setBackgroundColor:[UIColor clearColor]];
	[titleFeed setTextColor:RGBCOLOR(95,95,95)];
    [contentView addSubview:titleFeed];
	
	time_ago = [[UILabel alloc] init];
    [titleFeed setText:[NSString stringWithFormat:@"chia sẻ bởi %@",itemModel.nameSite]];
    NSString *timecreate=[Utils dateStringFromTimestamp:itemModel.time_ago];
    [time_ago setText:[NSString stringWithFormat:@"%@ - %d bình luận",timecreate,itemModel._numberComment]];
    time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:15.36+XAppDelegate.appFontSize];
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

-(void) ChangetoLanscape{
    [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
    CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
    switch (self._idLayout) {
        case 3:
            if (self.Viewoder==1) {
                for (UIView *view in contentView.subviews) {
                    if ([view isKindOfClass:[NewListArticleItemView4 class]]) {
                        [view removeFromSuperview];
                    }
                }
                //[self addSubview:contentView];
            }
            
            [title setFrame:CGRectMake(10, 10, contentViewArea.width-20, 40)];
            title.numberOfLines =0;
            [title sizeToFit];
            
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
            
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
            
            
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace+5, contentViewArea.width-10-imageView.frame.size.width-5, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
            
            NSString *content =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            

            return;
        case 4:
        case 5:
        case 11:
        case 15:
            NSLog(@"idlayout==4 in article 5");
            [title setFrame:CGRectMake(10, 10, contentViewArea.width-20, 40)];
            title.numberOfLines =0;
            [title sizeToFit];
            
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
            
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
            
           
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width-10-imageView.frame.size.width, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
            
            NSString *content1 =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content1 stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
            return;
        case 13:
            
            
            [title setFrame:CGRectMake(10, 10, contentViewArea.width-20, 40)];
            title.numberOfLines =0;
            [title sizeToFit];
            
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+5, 30, 30)];
            
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
            
         
            [text_content setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+10, contentViewArea.width-10-imageView.frame.size.width, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-20)];
            
            NSString *content2 =[itemModel._ArticleLandscape objectForKey:@"Content"];
            [text_content setText:[content2 stringByConvertingHTMLToPlainText]];
            text_content= [self resetAlighLabel:text_content];
            
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
