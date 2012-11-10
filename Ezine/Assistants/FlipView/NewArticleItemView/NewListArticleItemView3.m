//
//  NewListArticleItemView3.m
//  Ezine
//
//  Created by MAC on 8/28/12.
//
//

#import "NewListArticleItemView3.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"
static const int bottomSpace = 10;

@implementation NewListArticleItemView3
@synthesize itemModel;
@synthesize imageLoadingOperation;
@synthesize _idLayout;

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview{
	if (self = [super init]) {
		self.itemModel =_itemModel;
        self.Viewoder = oderview;
        
        self._idLayout =_itemModel._idLayout;
        // test
        
        
		//[self initializeFields];
		
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

//- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation{
//    //currentOrientation=interfaceOrientation;
//    [self LoadImage:interfaceOrientation];
//    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
//        [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
//        CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
//    
//
//       //[self setFrame:CGRectMake(1, 1, self.frame.size.width, self.frame.size.height)];
//       
//        if (self._idLayout==2) {
//            
////           // [self setFrame:CGRectMake(1,-56 ,768-0.5,430-0.5)];
////            
////            [title setFrame:CGRectMake(15,55, contentViewArea.width-10, 40)];
//////            title.numberOfLines =0;
//////            [title sizeToFit];
////            [title setLineBreakMode:UILineBreakModeClip];
////            title.numberOfLines=1;
////            title.adjustsFontSizeToFitWidth=YES;
////            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
////            
////            [titleFeed sizeToFit];
////            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
////            
////            [time_ago sizeToFit];
////            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
////            //    if (self._idLayout==1||self._idLayout==14) {
////            [imageView setFrame:CGRectMake(self.frame.size.width/2+30,145,self.frame.size.width/2-45, self.frame.size.height/2+10)];
////            
////            [text_content setFrame:CGRectMake(title.frame.origin.x, imageView.frame.size.height+imageView.frame.origin.y+5, imageView.frame.size.width,334)];
////    
////            text_content.contentMode= UIViewContentModeLeft;
////            [text_content sizeToFit];
////            text_content.numberOfLines =0;
////            
//            
//            //
//            return;
//        }else if (self._idLayout==5){
//            //[self setFrame:CGRectMake(282,609+56,486,289)];
//            
//            [title setFrame:CGRectMake(15,10, contentViewArea.width-10, 40)];
//            title.numberOfLines =0;
//            [title sizeToFit];
//            
//            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+5, 30, 30)];
//            
//            [titleFeed sizeToFit];
//            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
//            
//            [time_ago sizeToFit];
//            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//            //    if (self._idLayout==1||self._idLayout==14) {
//            [imageView setFrame:CGRectMake(self.frame.size.width/2+30,114,self.frame.size.width/2-40, self.frame.size.height/2-50)];
//            return;
//        }else if (self._idLayout==11){
//            [title sizeToFit];
//            [title setFrame:CGRectMake(15,50, contentViewArea.width/2-10, 40)];
//            title.numberOfLines =0;
//            [title sizeToFit];
//            
//            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//            
//            [titleFeed sizeToFit];
//            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
//            
//            [time_ago sizeToFit];
//            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//            //    if (self._idLayout==1||self._idLayout==14) {
//            [imageView setFrame:CGRectMake(self.frame.size.width/2+30,70 ,self.frame.size.width/2-40, self.frame.size.height/2-70)];
//            return;
//        }else if (self._idLayout==3){
//            //[self setFrame:CGRectMake(0,445+50,497,460)];
//            NSLog(@"idlyaout== 3");
//            NSLog(@"title== %@",title.text);
//            [title setFrame:CGRectMake(15,10, contentViewArea.width-10, 40)];
//            title.numberOfLines =0;
//            [title sizeToFit];
//
//            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//            
//            [titleFeed sizeToFit];
//            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
//            
//            [time_ago sizeToFit];
//            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//            //    if (self._idLayout==1||self._idLayout==14) {
//            [imageView setFrame:CGRectMake(280,115,204,255)];
//            return;
//            
//        }
//
//        [title setFrame:CGRectMake(15,20, contentViewArea.width-10, 40)];
//        title.numberOfLines =0;
//        [title sizeToFit];
//
//        
//        [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//        
//        [titleFeed sizeToFit];
//        [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentViewArea.width-10, 20)];
//        
//        [time_ago sizeToFit];
//        [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//        //    if (self._idLayout==1||self._idLayout==14) {
//        [imageView setFrame:CGRectMake(self.frame.size.width*3/5+10,120,self.frame.size.width/2-20, self.frame.size.height/2)];
//        
//    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
//        
//        [self ChangertoLanscape];
//        
//        
//    }
//	    
//   
////        
////    }else if (self._idLayout==4||self._idLayout==10){
////        [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+40, contentViewArea.width,335)];
////        
////    }else if (self._idLayout==8){
////        [imageView setFrame:CGRectMake(imageIconView.frame.origin.x, time_ago.frame.origin.y+40, contentViewArea.width,170)];
////        
////    }
//    
////    [text_content sizeToFit];
////    [text_content setFrame:CGRectMake(imageIconView.frame.origin.x,imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace , contentViewArea.width-10, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height)];
////    [text_content setText:itemModel.text_content];
////    text_content.contentMode =UIViewContentModeLeft;
//    
////    switch (self.Viewoder%3) {
////        case 0:
////            
////            [title sizeToFit];
////            [title setFrame:CGRectMake(15,20, contentViewArea.width-10, title.frame.size.height)];
////            
////            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 50, 60)];
////            
////            [titleFeed sizeToFit];
////            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y, title.frame.size.width-imageIconView.frame.size.width-5, 28)];
////            
////            [time_ago sizeToFit];
////            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+4,titleFeed.frame.size.width , titleFeed.frame.size.height)];
////            
////            [text_content sizeToFit];
////            [text_content setFrame:CGRectMake(imageIconView.frame.origin.x,imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace , contentViewArea.width-10, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height)];
////            [text_content setText:itemModel.text_content];
////            text_content.contentMode =UIViewContentModeLeft;
////            
////            break;
////        case 1:
////            
////            [extraTitle sizeToFit];
////            [extraTitle setFrame:CGRectMake(10, 10,150, 30)];
////            
////            [title sizeToFit];
////            [title setFrame:CGRectMake(15, extraTitle.frame.origin.y+extraTitle.frame.size.height+bottomSpace, contentViewArea.width-20, 50)];
////            
////            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 50, 60)];
////            
////            [titleFeed sizeToFit];
////            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y, 240, 28)];
////            
////            [time_ago sizeToFit];
////            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+4, titleFeed.frame.size.width, titleFeed.frame.size.height)];
////            
////            [imageView setFrame:CGRectMake( contentViewArea.width/2+10, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width/2-10, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
////            
////            [text_content sizeToFit];
////            [text_content setFrame:CGRectMake(title.frame.origin.x, imageView.frame.origin.y, contentViewArea.width-imageView.frame.size.width, imageView.frame.size.height)];
////            [text_content setText:itemModel.text_content];
////            text_content.contentMode = UIViewContentModeLeft;
////            
////            break;
////        case 2:
////            
////            [title sizeToFit];
////            [title setFrame:CGRectMake(10, 10, contentViewArea.width-10, 50)];
////            
////            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 50, 60)];
////            
////            [titleFeed sizeToFit];
////            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y, title.frame.size.width, 28)];
////            
////            [time_ago sizeToFit];
////            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+4, titleFeed.frame.size.width, titleFeed.frame.size.height)];
////            
////            [text_content sizeToFit];
////            [text_content setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace, contentViewArea.width-10, contentViewArea.height-imageIconView.frame.origin.y-imageIconView.frame.size.height-bottomSpace)];
////            [text_content setText:itemModel.text_content];
////            text_content.contentMode =UIViewContentModeLeft;
////            break;
////            
////        default:
////            break;
////    }
//    
//}

//- (void) initializeFields {
//    NSLog(@"initialize item 3");
//	contentView = [[UIView alloc] init];
//	[contentView setBackgroundColor:[UIColor whiteColor]];
//	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    
//	imageView = [[[UIImageView alloc] init]retain];
//    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
//    
//	
//    
//    //[imageView setImage:[UIImage imageNamed:itemModel.image]];
////    NSString *imageUrl = [itemModel._ArticlePortrait objectForKey:@"HeadImageUrl"];
////    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:imageUrl]
////                                                                        onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
////                                                                            if([imageUrl isEqualToString:[url absoluteString]]) {
////                                                                                
////                                                                                if (isInCache) {
////                                                                                    imageView.image = fetchedImage;
////                                                                                    //     [self hideActivityIndicator];
////                                                                                    
////                                                                                } else {
////                                                                                    UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
////                                                                                    loadedImageView.frame = imageView.frame;
////                                                                                    loadedImageView.alpha = 0;
////                                                                                    [loadedImageView removeFromSuperview];
////                                                                                    
////                                                                                    imageView.image = fetchedImage;
////                                                                                    imageView.alpha = 1;
////                                                                                    // [self hideActivityIndicator];
////                                                                                    
////                                                                                }
////                                                                            }
////                                                                        }];
////    
//    
//    [self addSubview:imageView];
//    
//    
//    
//    [contentView addSubview:imageView];
//    
//    imageIconView =[[UIImageView alloc]init];
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
//    //[imageIconView setImage:[UIImage imageNamed:itemModel.icon]];
//    [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
//    
//    [self addSubview:imageIconView];
//    
//    [contentView addSubview:imageIconView];
//    
//    title = [[UILabel alloc] init];
//    NSString *title1 =[itemModel._ArticlePortrait objectForKey:@"Title"];
//
//	[title setText:[NSString stringWithFormat:@"%@",[title1 stringByConvertingHTMLToPlainText]]];
//    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:21.12+XAppDelegate.appFontSize];
//	[title setTextColor:RGBCOLOR(55,55,55)];
//	[title setBackgroundColor:[UIColor clearColor]];
//    [title setLineBreakMode:UILineBreakModeClip];
//    title.autoresizingMask=UIViewAutoresizingFlexibleWidth;
//    
//	[self addSubview:title];
//    
//    [contentView addSubview:title];
//    
//    titleFeed =[[UILabel alloc]init];
//    [titleFeed setText:[NSString stringWithFormat:@"chia sẻ bởi %@",itemModel.nameSite]];
//    titleFeed.font =[UIFont fontWithName:@"UVNHongHaHep" size:15.36+XAppDelegate.appFontSize];
//    [titleFeed setBackgroundColor:[UIColor clearColor]];
//    [titleFeed setTextColor:RGBCOLOR(101, 101, 101)];
//    [self addSubview:titleFeed];
//	
//    [contentView addSubview:titleFeed];
//    
//	time_ago = [[UILabel alloc] init];
//    NSString *timecreate=[Utils dateStringFromTimestamp:itemModel.time_ago];
//    [time_ago setText:[NSString stringWithFormat:@"%@ - %d bình luận",timecreate,itemModel._numberComment]];
//    time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:15.36+XAppDelegate.appFontSize];
//	[time_ago setTextColor:RGBCOLOR(179,179,179)];
//	[time_ago setBackgroundColor:[UIColor clearColor]];
//	[self addSubview:time_ago];
//    
//    [contentView addSubview:time_ago];
//    text_content = [[UILabel alloc] init];
//	text_content.font = [UIFont fontWithName:@"UVNHongHaHep" size:20+XAppDelegate.appFontSize];
//	text_content.textColor =  RGBCOLOR(33,33,33);
//	text_content.highlightedTextColor = RGBCOLOR(33,33,33);
//	text_content.contentMode = UIViewContentModeCenter;
//	text_content.textAlignment = UITextAlignmentLeft;
//	[text_content setBackgroundColor:[UIColor whiteColor]];
//	text_content.numberOfLines = 0;
//    
//	[contentView addSubview:text_content];
//    
//   // [self ChangertoLanscape];
//    
//	//[self addSubview:contentView];
//	//[self reAdjustLayout:currentOrientation];
//   
//}

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

CTFontRef CTFontCreateFromUIFont(UIFont *font)
{
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)font.fontName,
                                            font.pointSize,
                                            NULL);
    return ctFont;
}
-(void)drawRect:(CGRect)rect{
    CGRect imageRect;
    [self setBackgroundColor:[UIColor whiteColor]];
    if (self._idLayout==2) {
        rect=CGRectMake(0, 110, self.frame.size.width-20, self.frame.size.height-115);
        imageRect=CGRectMake(self.frame.size.width/2+10,180,self.frame.size.width/2, self.frame.size.height);
    }else if (self._idLayout==3){
        rect=CGRectMake(0, 20, self.frame.size.width-20, self.frame.size.height-25);
        imageRect=CGRectMake(self.frame.size.width/2+10,140,self.frame.size.width/2, self.frame.size.height);

    }else if (self._idLayout==5){
        if (self.Viewoder==10) {
            rect=CGRectMake(0, 20, self.frame.size.width-20, self.frame.size.height-25);
            imageRect=CGRectMake(self.frame.size.width/2,140,self.frame.size.width/2, self.frame.size.height);
        }else{
            rect=CGRectMake(0, 20, self.frame.size.width-20, self.frame.size.height-25);
            imageRect=CGRectMake(self.frame.size.width/2+10,80,self.frame.size.width/2, self.frame.size.height);
        }
        
    } else if (self._idLayout==10) {
        if (self.Viewoder==1) {
            rect=CGRectMake(0, -80, self.frame.size.width-20, self.frame.size.height-40);
            imageRect=CGRectMake(0,100,self.frame.size.width, self.frame.size.height/3);
        }else {
            rect=CGRectMake(0, 20, self.frame.size.width-40, self.frame.size.height-25);
            imageRect=CGRectMake(self.frame.size.width/2+10,80,self.frame.size.width/2, self.frame.size.height);

        }
       
    }else if (self._idLayout==11){
        rect=CGRectMake(0, 70, self.frame.size.width-20, self.frame.size.height-75);
        imageRect=CGRectMake(self.frame.size.width/2+10,370,self.frame.size.width/2, self.frame.size.height);

        if (self.Viewoder==10) {
            rect=CGRectMake(0, 10, self.frame.size.width-20, self.frame.size.height-15);
            imageRect=CGRectMake(0,100,self.frame.size.width, 200);
        }
    }else if (self._idLayout==14){
        rect=CGRectMake(0, 0, self.frame.size.width-40, self.frame.size.height-5);
        imageRect=CGRectMake(self.frame.size.width/2-20,120,self.frame.size.width/2+20, self.frame.size.height);
    }else{
        rect=CGRectMake(0, -150, self.frame.size.width-20, self.frame.size.height-40);
        imageRect=CGRectMake(self.frame.size.width*3/5,120,self.frame.size.width/2, self.frame.size.height/2);
    }
    [self setBackgroundColor:[UIColor whiteColor]];
    NSLog(@"drawwwwwwwwwwww======");
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 10, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Create a path to render text in
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect );
    
    // An attributed string containing the text to render
    
    
    //(UIFont *)font color:(UIColor *)color alignment:(CTTextAlignment)alignment
    UIFont *font=[UIFont fontWithName:@"TimesNewRomanPSMT" size:17+XAppDelegate.appFontSize];
    CTTextAlignment alignment=kCTJustifiedTextAlignment;
    //CTTextAlignment alignment1=kCTRightTextAlignment;
    UIColor *color=RGBCOLOR(33,33,33);
    CFMutableAttributedStringRef attrString1 = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    NSString *content =[itemModel._ArticlePortrait objectForKey:@"Content"];
    NSString *string=[content stringByConvertingHTMLToPlainText];
//    string=@"Theo tờ trình của Ủy ban dự thảo sửa đổi Hiến pháp năm 1992, có 9 nội dung cơ bản sửa đổi, như: tiếp tục khẳng định và làm rõ hơn vị trí, vai trò, trách nhiệm lãnh đạo của Đảng đối với Nhà nước và xã hội; thể hiện sâu sắc hơn quan điểm bảo vệ, tôn trọng quyền con người; tiếp tục bảo vệ vững chắc Tổ quốc Việt Nam xã hội chủ nghĩa, tạo cơ sở hiến định để Nhà nước đẩy mạnh hợp tác quốc tế, thực hiện quyền, nghĩa vụ quốc gia, góp phần giữ gìn hòa bình khu vực và thế giớiTheo tờ trình của Ủy ban dự thảo sửa đổi Hiến pháp năm 1992, có 9 nội dung cơ bản sửa đổi, như: tiếp tục khẳng định và làm rõ hơn vị trí, vai trò, trách nhiệm lãnh đạo của Đảng đối với Nhà nước và xã hội; thể hiện sâu sắc hơn quan điểm bảo vệ, tôn trọng quyền con người; tiếp tục bảo vệ vững chắc Tổ quốc Việt Nam xã hội chủ nghĩa, tạo cơ sở hiến định để Nhà nước đẩy mạnh hợp tác quốc tế, thực hiện quyền, nghĩa vụ quốc gia, góp phần giữ gìn hòa bình khu vực và thế giớiTheo tờ trình của Ủy ban dự thảo sửa đổi Hiến pháp năm 1992, có 9 nội dung cơ bản sửa đổi, như: tiếp tục khẳng định và làm rõ hơn vị trí, vai trò, trách nhiệm lãnh đạo của Đảng đối với Nhà nước và xã hội; thể hiện sâu sắc hơn quan điểm bảo vệ, tôn trọng quyền con người; tiếp tục bảo vệ vững chắc Tổ quốc Việt Nam xã hội chủ nghĩa, tạo cơ sở hiến định để Nhà nước đẩy mạnh hợp tác quốc tế, thực hiện quyền, nghĩa vụ quốc gia, góp phần giữ gìn hòa bình khu vực và thế giớiTheo tờ trình của Ủy ban dự thảo sửa đổi Hiến pháp năm 1992, có 9 nội dung cơ bản sửa đổi, như: tiếp tục khẳng định và làm rõ hơn vị trí, vai trò, trách nhiệm lãnh đạo của Đảng đối với Nhà nước và xã hội; thể hiện sâu sắc hơn quan điểm bảo vệ, tôn trọng quyền con người; tiếp tục bảo vệ vững chắc Tổ quốc Việt Nam xã hội chủ nghĩa, tạo cơ sở hiến định để Nhà nước đẩy mạnh hợp tác quốc tế, thực hiện quyền, nghĩa vụ quốc gia, góp phần giữ gìn hòa bình khu vực và thế giới";
    if (string != nil)
        CFAttributedStringReplaceString (attrString1, CFRangeMake(0, 0), (CFStringRef)string);
    
    CFAttributedStringSetAttribute(attrString1, CFRangeMake(0, CFAttributedStringGetLength(attrString1)), kCTForegroundColorAttributeName, color.CGColor);
    CTFontRef theFont = CTFontCreateFromUIFont(font);
    CFAttributedStringSetAttribute(attrString1, CFRangeMake(0, CFAttributedStringGetLength(attrString1)), kCTFontAttributeName, theFont);
    CFRelease(theFont);
    
    CTParagraphStyleSetting settings[] = {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    CFAttributedStringSetAttribute(attrString1, CFRangeMake(0, CFAttributedStringGetLength(attrString1)), kCTParagraphStyleAttributeName, paragraphStyle);
    CFRelease(paragraphStyle);
    
    
    NSMutableAttributedString *ret = (NSMutableAttributedString *)attrString1;
    
    
    NSAttributedString* attString = [[NSAttributedString alloc]
                                     initWithAttributedString:ret];
    // Create a path to wrap around
    CGMutablePathRef clipPath = CGPathCreateMutable();
    CGPathAddRect(clipPath, NULL, imageRect);
    
    // A CFDictionary containing the clipping path
    CFStringRef keys[] = { kCTFramePathClippingPathAttributeName };
    CFTypeRef values[] = { clipPath };
    CFDictionaryRef clippingPathDict = CFDictionaryCreate(NULL,
                                                          (const void **)&keys, (const void **)&values,
                                                          sizeof(keys) / sizeof(keys[0]),
                                                          &kCFTypeDictionaryKeyCallBacks,
                                                          &kCFTypeDictionaryValueCallBacks);
    
    // An array of clipping paths -- you can use more than one if needed!
    NSArray *clippingPaths = [NSArray arrayWithObject:(NSDictionary*)clippingPathDict];
    
    // Create an options dictionary, to pass in to CTFramesetter
    NSDictionary *optionsDict = [NSDictionary dictionaryWithObject:clippingPaths forKey:(NSString*)kCTFrameClippingPathsAttributeName];
    
    // Finally create the framesetter and render text
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString); //3
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, [attString length]), path, optionsDict);
    
    CTFrameDraw(frame, context);
    
    // Clean up
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
    
    
    //[self initializeFields];
//    [self addSubview:imageView];
//    [self addSubview:time_ago];
//    [self addSubview:title];
//    [self addSubview:titleFeed];
//    [self addSubview:imageIconView];

    
}

//-(void) ChangertoLanscape{
//  //   [self setFrame:CGRectMake(1, 1, self.frame.size.width-1, self.frame.size.height-1)];
//    [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
//   
//    CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
//    //[self addSubview:contentView];
//    switch (self._idLayout) {
//        case 2:
//        {
//           
//
//            [title setFrame:CGRectMake(15,50, contentViewArea.width-10, 40)];
////            title.numberOfLines =0;
////            [title sizeToFit];
//            [title setLineBreakMode:UILineBreakModeClip];
//            title.autoresizingMask=UIViewAutoresizingFlexibleWidth;
//
//            
//            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//            
//            [titleFeed sizeToFit];
//            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
//            
//            [time_ago sizeToFit];
//            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//            //    if (self._idLayout==1||self._idLayout==14) {
//            [imageView setFrame:CGRectMake(title.frame.origin.x,time_ago.frame.origin.y+time_ago.frame.size.height+8,310,170)];
//            
//            
//            return;
//            //
//        }
//            break;
//        case 5:
//            [title setFrame:CGRectMake(15,10, contentViewArea.width-10, 40)];
//            title.numberOfLines =0;
//            [title sizeToFit];
//            
//            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//            
//            [titleFeed sizeToFit];
//            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
//            
//            [time_ago sizeToFit];
//            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//            //    if (self._idLayout==1||self._idLayout==14) {
//            [imageView setFrame:CGRectMake(self.frame.size.width/2+18,112,self.frame.size.width/2-28, self.frame.size.height/2-85)];
//            return;
//            break;
//        case 3:
//        {
//            [self setFrame:CGRectMake(0,445+50,497,460)];
//            [title setFrame:CGRectMake(15,10, contentViewArea.width-10, 40)];
//            title.numberOfLines =0;
//            [title sizeToFit];
//
//            
//            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//            
//            [titleFeed sizeToFit];
//            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
//            
//            [time_ago sizeToFit];
//            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//            //    if (self._idLayout==1||self._idLayout==14) {
//            [imageView setFrame:CGRectMake(280,150,200,240)];
//            return;
//            
//        }
//            break;
//        case 10:
//            
//        {
//            if (self.Viewoder==1) {
//                [title setFrame:CGRectMake(15,20, contentViewArea.width-10, 40)];
//                title.numberOfLines =0;
//                [title sizeToFit];
//
//                
//                [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//                
//                [titleFeed sizeToFit];
//                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
//                
//                [time_ago sizeToFit];
//                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//                //    if (self._idLayout==1||self._idLayout==14) {
//                [imageView setFrame:CGRectMake(0+10,340,self.frame.size.width-20, self.frame.size.height/3.5)];
//            }else {
//                [title setFrame:CGRectMake(15,20, contentViewArea.width/2+10, 40)];
//                title.numberOfLines =0;
//                [title sizeToFit];
//
//                
//                [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//                
//                [titleFeed sizeToFit];
//                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
//                
//                [time_ago sizeToFit];
//                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//                //    if (self._idLayout==1||self._idLayout==14) {
//                [imageView setFrame:CGRectMake(self.frame.size.width/2+30,30,self.frame.size.width/2-40, self.frame.size.height/1.5+13)];
//            }
//            return;
//        }
//            break;
//         case 11:
//            [title setFrame:CGRectMake(15,20, contentViewArea.width-10, 40)];
//            title.numberOfLines =0;
//            [title sizeToFit];
//            
//            
//            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//            
//            [titleFeed sizeToFit];
//            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
//            
//            [time_ago sizeToFit];
//            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//            //    if (self._idLayout==1||self._idLayout==14) {
//            [imageView setFrame:CGRectMake(0+10,375,self.frame.size.width-20, self.frame.size.height/3.5)];
//            return;
//         case 14:
//            [title setFrame:CGRectMake(15,20, contentViewArea.width-10, 40)];
//            title.numberOfLines =0;
//            [title sizeToFit];
//
//            
//            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//            
//            [titleFeed sizeToFit];
//            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
//            
//            [time_ago sizeToFit];
//            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//            //    if (self._idLayout==1||self._idLayout==14) {
//            [imageView setFrame:CGRectMake(self.frame.size.width/2+20+6,130,self.frame.size.width/2-30-2, self.frame.size.height/3.5)];
//            return;
//            break;
//        default:
//            break;
//    }
//
//    [title setFrame:CGRectMake(15,20, contentViewArea.width-10, 40)];
//    title.numberOfLines =0;
//    [title sizeToFit];
//
//    
//    [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
//    
//    [titleFeed sizeToFit];
//    [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, self.frame.size.width-imageIconView.frame.size.width-5, 20)];
//    
//    [time_ago sizeToFit];
//    [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
//    //    if (self._idLayout==1||self._idLayout==14) {
//    [imageView setFrame:CGRectMake(self.frame.size.width*3/5+10,120,self.frame.size.width/2-20, self.frame.size.height/2)];
//    
//    
//    
//    
//}


@end
