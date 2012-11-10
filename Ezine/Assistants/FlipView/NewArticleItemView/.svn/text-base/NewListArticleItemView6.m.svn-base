//
//  NewListArticleItemView6.m
//  Ezine
//
//  Created by Hieu  on 8/28/12.
//
//

#import "NewListArticleItemView6.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"

static const int bottomSpace = 10;

@implementation NewListArticleItemView6

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
    
    if ((NSNull *) imageUrl == [NSNull null]) {
       imageUrl =@"";
    }
    self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:imageUrl]
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
	[contentView setFrame:CGRectMake(1, 1, self.frame.size.width-2, self.frame.size.height-2)];
    CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
    
               
            [title sizeToFit];
            [title setFrame:CGRectMake(10, 10, contentViewArea.width-10, 50)];
            
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 50, 60)];
            
            [titleFeed sizeToFit];
        [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
    
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+4, titleFeed.frame.size.width, titleFeed.frame.size.height)];
            
            [text_content sizeToFit];
            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width-10, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
            NSString *content =[itemModel._ArticlePortrait objectForKey:@"Content"];
            [text_content setText:[content stringByConvertingHTMLToPlainText]];
            text_content.contentMode =UIViewContentModeLeft;

    switch (self._idLayout) {
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 13:
            
            break;
        default:
            break;
    }
    
}

- (void) initializeFields {
    NSLog(@"initialize item 6");
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
    
	//imageView = [[UIImageView alloc] init];
   // EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    
	
    
    //[imageView setImage:[UIImage imageNamed:itemModel.image]];
//    self.imageLoadingOperation = [appdelegate.getListSiteMasterPageEngine imageAtURL:[NSURL URLWithString:itemModel.image]
//                                                                        onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
//                                                                            if([itemModel.image isEqualToString:[url absoluteString]]) {
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
//    [contentView addSubview:imageView];
    
    
    
    
    
    imageIconView =[[UIImageView alloc]init];
    
    
   // [imageIconView setImage:[UIImage imageNamed:itemModel.icon]];
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
    
    text_content = [[UILabel alloc] init];
	text_content.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:17+XAppDelegate.appFontSize];
	text_content.textColor =  RGBCOLOR(33,33,33);
	text_content.highlightedTextColor = RGBCOLOR(33,33,33);
	text_content.contentMode = UIViewContentModeCenter;
	text_content.textAlignment = UITextAlignmentLeft;
	[text_content setBackgroundColor:[UIColor clearColor]];
	text_content.numberOfLines = 0;
	[contentView addSubview:text_content];
    
	[self addSubview:contentView];
	//[self reAdjustLayout];
}

-(void)tapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Taped");
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




@end
