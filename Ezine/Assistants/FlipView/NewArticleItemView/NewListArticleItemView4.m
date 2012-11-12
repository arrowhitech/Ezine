//
//  NewListArticleItemView4.m
//  Ezine
//
//  Created by Hieu  on 8/29/12.
//
//

#import "NewListArticleItemView4.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"
#import "CTView.h"
#import "MarkupParser.h"
#import "ContentViewforAc4.h"
static const int bottomSpace = 10;


@implementation NewListArticleItemView4

@synthesize itemModel;
@synthesize imageLoadingOperation;
@synthesize _idLayout;

@synthesize contentView;

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
        
         // self._idLayout=3;
        
		[self initializeFields];
		
		UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[self addGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
        
        
	}
	return self;
}
#pragma mark--- load image rotate
//-(void)LoadImage:(UIInterfaceOrientation)interfaceOrientation{
//    NSString *imageUrl;
//    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
//    
//    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
//        imageUrl = [itemModel._ArticlePortrait objectForKey:@"HeadImageUrl"];
//        
//        
//    }else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight) {
//        imageUrl = [itemModel._ArticleLandscape objectForKey:@"HeadImageUrl"];
//        
//    }
////    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:imageUrl]
////                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
////                                                              if([imageUrl isEqualToString:[url absoluteString]]) {
////                                                                  
////                                                                  if (isInCache) {
////                                                                      imageView.image = fetchedImage;
////                                                                      //     [self hideActivityIndicator];
////                                                                      
////                                                                  } else {
////                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
////                                                                      loadedImageView.frame = imageView.frame;
////                                                                      loadedImageView.alpha = 0;
////                                                                      [loadedImageView removeFromSuperview];
////                                                                      
////                                                                      imageView.image = fetchedImage;
////                                                                      imageView.alpha = 1;
////                                                                      // [self hideActivityIndicator];
////                                                                      
////                                                                  }
////                                                              }
////                                                          }];
////    
//    
//    NSString* urlicon = itemModel.icon;
//    if ((NSNull *)urlicon==[NSNull null]) {
//        urlicon =@"";
//    }
//    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlicon]
//                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
//                                                              if([urlicon isEqualToString:[url absoluteString]]) {
//                                                                  
//                                                                  if (isInCache) {
//                                                                      imageIconView.image = fetchedImage;
//                                                                      //     [self hideActivityIndicator];
//                                                                      
//                                                                  } else {
//                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
//                                                                      loadedImageView.frame = imageIconView.frame;
//                                                                      loadedImageView.alpha = 0;
//                                                                      [loadedImageView removeFromSuperview];
//                                                                      
//                                                                      imageIconView.image = fetchedImage;
//                                                                      imageIconView.alpha = 1;
//                                                                      // [self hideActivityIndicator];
//                                                                      
//                                                                  }
//                                                              }
//                                                          }];
//    
//
//    
//    
//}
#pragma mark-------

- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation{    
    [self LoadImage:interfaceOrientation];
	[contentView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  //  CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
    
//    [title setFrame:CGRectMake(13, 10, contentViewArea.width-20, 40)];
//    title.numberOfLines =0;
//    [title sizeToFit];
//    
//    [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+5, 30, 30)];
//    titleFeed.numberOfLines=0;
//    [titleFeed sizeToFit];
//    [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, titleFeed.frame.size.width, titleFeed.frame.size.height)];
//    
//    [time_ago sizeToFit];
//    [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height, titleFeed.frame.size.width, titleFeed.frame.size.height)];
//    
//   
//    [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width-16-imageView.frame.size.width, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
//    
//    
//   // [text_content setText:itemModel.text_content];
//    text_content.contentMode =UIViewContentModeLeft;
//     [text_content sizeToFit];
//    text_content.numberOfLines =0;
    NSString *content =[itemModel._ArticleLandscape objectForKey:@"Content"];
    MarkupParser* p = [[[MarkupParser alloc] init] autorelease];
    [p setFont:@"TimesNewRomanPSMT"];
    NSAttributedString* attString = [p attrStringFromMarkup:[content stringByConvertingHTMLToPlainText]];
    //
    //    [ (CTView *)[self contentView] setAttString:attString withImages:nil];
    //
    //    [(CTView *)[self contentView] buildFrames];
    //    [contentView setAttString:attString];
    //    [contentView buildFrames];
    
    contentView.scrollEnabled=NO;
    [contentView setAttString:attString withImages:Nil];
    [contentView buildFrames];

    
    
}

- (void) initializeFields {
//    NSLog(@"initialize item 3");
	contentView = [[CTView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	[contentView setBackgroundColor:[UIColor whiteColor]];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//
//    
//    imageIconView =[[UIImageView alloc]init];
//    
//    NSString* urlicon = itemModel.icon;
//    if ((NSNull *)urlicon==[NSNull null]) {
//        urlicon =@"";
//    }
//    self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlicon]
//                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
//                                                              if([urlicon isEqualToString:[url absoluteString]]) {
//                                                                  
//                                                                  if (isInCache) {
//                                                                      imageIconView.image = fetchedImage;
//                                                                      //     [self hideActivityIndicator];
//                                                                      
//                                                                  } else {
//                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
//                                                                      loadedImageView.frame = imageIconView.frame;
//                                                                      loadedImageView.alpha = 0;
//                                                                      [loadedImageView removeFromSuperview];
//                                                                      
//                                                                      imageIconView.image = fetchedImage;
//                                                                      imageIconView.alpha = 1;
//                                                                      // [self hideActivityIndicator];
//                                                                      
//                                                                  }
//                                                              }
//                                                          }];
//    
//
//    
//    
//   // [imageIconView setImage:[UIImage imageNamed:itemModel.icon]];
//    [contentView addSubview:imageIconView];
//    
//    title = [[UILabel alloc] init];
//    NSString *title1 = [itemModel._ArticlePortrait objectForKey:@"Title"];
//
//	[title setText:[NSString stringWithFormat:@"%@",[title1 stringByConvertingHTMLToPlainText]]];
//    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:21.12+XAppDelegate.appFontSize];
//	[title setTextColor:RGBCOLOR(55,55,55)];;
//	[title setBackgroundColor:[UIColor clearColor]];
//	[contentView addSubview:title];
//	
//    titleFeed =[[UILabel alloc]init];
//    titleFeed.font =[UIFont fontWithName:@"UVNHongHaHep" size:13.36+XAppDelegate.appFontSize];
//    [titleFeed setBackgroundColor:[UIColor clearColor]];
//    [titleFeed setTextColor:RGBCOLOR(101, 101, 101)];
//    [contentView addSubview:titleFeed];
//	
//	time_ago = [[UILabel alloc] init];
//    [titleFeed setText:[NSString stringWithFormat:@"chia sẻ bởi %@",itemModel.nameSite]];
//    NSString *timecreate=[Utils dateStringFromTimestamp:itemModel.time_ago];
//    [time_ago setText:[NSString stringWithFormat:@"%@ - %d bình luận",timecreate,itemModel._numberComment]];
//    time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:13.36+XAppDelegate.appFontSize];
//	[time_ago setTextColor:RGBCOLOR(179,179,179)];
//	[time_ago setBackgroundColor:[UIColor clearColor]];
//	[contentView addSubview:time_ago];
//    
//    text_content = [[UILabel alloc] init];
//	text_content.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:17+XAppDelegate.appFontSize];
//	text_content.textColor =  RGBCOLOR(33,33,33);
//	text_content.highlightedTextColor = RGBCOLOR(33,33,33);
//	text_content.contentMode = UIViewContentModeCenter;
//	text_content.textAlignment = UITextAlignmentLeft;
//	[text_content setBackgroundColor:[UIColor clearColor]];
//	text_content.numberOfLines = 0;
//	//[contentView addSubview:text_content];
//    
//	
////    NSString* text = itemModel.text_content;
////    MarkupParser* p = [[[MarkupParser alloc] init] autorelease];
////    NSAttributedString* attString = [p attrStringFromMarkup: text];
//////
//////    [ (CTView *)[self contentView] setAttString:attString withImages:nil];
//////    
//////    [(CTView *)[self contentView] buildFrames];
//////    [contentView setAttString:attString];
//////    [contentView buildFrames];
////    [contentView setAttString:attString withImages:Nil];
////    [contentView buildFrames];
    [self addSubview:contentView];
//    
	//[self reAdjustLayout];

}

-(void) drawRect:(CGRect)rect{
    
    NSLog(@"DrawRect=============");
    
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




@end
