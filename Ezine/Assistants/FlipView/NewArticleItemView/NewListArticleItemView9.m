//
//  NewListArticleItemView9.m
//  Ezine
//
//  Created by Hieu  on 8/28/12.
//
//

#import "NewListArticleItemView9.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"

static const int bottomSpace = 10;

@implementation NewListArticleItemView9

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
        // self._idLayout=14;
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
        [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
        CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
        
        switch (self._idLayout) {
            case 9:
                [title setFrame:CGRectMake(15, 20, contentViewArea.width-10, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [imageView setFrame:CGRectMake(10, time_ago.frame.origin.y+time_ago.frame.size.height+20, contentViewArea.width-10, contentViewArea.height/2+50)];
                break;
            case 14:
                [title setFrame:CGRectMake(10, 10, contentViewArea.width-10, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
                
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
                titleFeed.numberOfLines=0;
                [titleFeed sizeToFit];
                
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, self.frame.size.width, titleFeed.frame.size.height)];
                time_ago.numberOfLines=0;
                [time_ago sizeToFit];
                
                [imageView setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+40, contentViewArea.width-10, contentViewArea.height-time_ago.frame.size.height-time_ago.frame.origin.y-10)];
                break;
                
            default:
                break;
        }
        
    }else {
        [self ChangetoLanscape];
    }
    
    
}

- (void) initializeFields {
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
    
    
    
    //[imageIconView setImage:[UIImage imageNamed:itemModel.icon]];
    [contentView addSubview:imageIconView];
    
    title = [[UILabel alloc] init];
    NSString *title1 =[itemModel._ArticlePortrait objectForKey:@"Title"];
    title.numberOfLines =0;
    [title sizeToFit];
	[title setText:[NSString stringWithFormat:@"%@",[title1 stringByConvertingHTMLToPlainText]]];
    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:21.12+XAppDelegate.appFontSize];
	[title setTextColor:[UIColor blackColor]];;
	[title setBackgroundColor:[UIColor clearColor]];
	[contentView addSubview:title];
	
    titleFeed =[[UILabel alloc]init];
    titleFeed.font =[UIFont fontWithName:@"UVNHongHaHep" size:13.36+XAppDelegate.appFontSize];
    [titleFeed setBackgroundColor:[UIColor clearColor]];
	[titleFeed setTextColor:RGBCOLOR(95,95,95)];
    [contentView addSubview:titleFeed];
	
	time_ago = [[UILabel alloc] init];
    titleFeed.numberOfLines =0;
    [titleFeed sizeToFit];
    [titleFeed setText:[NSString stringWithFormat:@"chia sẻ bởi %@",itemModel.nameSite]];
    NSString *timecreate=[Utils dateStringFromTimestamp:itemModel.time_ago];
    
    time_ago.numberOfLines =0;
    [time_ago sizeToFit];
    
    [time_ago setText:[NSString stringWithFormat:@"%@ - %d bình luận",timecreate,itemModel._numberComment]];
    time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:13.36+XAppDelegate.appFontSize];
	[time_ago setTextColor:RGBCOLOR(95,95,95)];
	[time_ago setBackgroundColor:[UIColor clearColor]];
	[contentView addSubview:time_ago];
    
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
#pragma mark--- ChangetoLanscape
-(void)ChangetoLanscape{
    [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
    CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
    if (self._idLayout==14) {
        [imageView setFrame:CGRectMake(10, 10, contentViewArea.width-10,200)];
        
        [title setFrame:CGRectMake(10, 220, contentViewArea.width-10, 40)];
        
        title.numberOfLines =0;
        [title sizeToFit];
        [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+5, 30, 30)];
        
        [titleFeed sizeToFit];
        [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
        
        [time_ago sizeToFit];
        [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
        
    }else if (self._idLayout==9){
        [title setFrame:CGRectMake(170, 20, contentViewArea.width-10, 40)];
        title.numberOfLines =0;
        [title sizeToFit];
        [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
        
        [titleFeed sizeToFit];
        [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width, 20)];
        
        [time_ago sizeToFit];
        [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
        
        [imageView setFrame:CGRectMake(170, time_ago.frame.origin.y+time_ago.frame.size.height+20, contentViewArea.width-330, contentViewArea.height-time_ago.frame.size.height-time_ago.frame.origin.y-80)];
        
    }
}
@end
