//
//  NewListArticleItemView1.m
//  Ezine
//
//  Created by MAC on 8/28/12.
//
//

#import "NewListArticleItemView1.h"
#import "ArticleModel.h"
#import "EzineAppDelegate.h"
#import "Utils.h"

static const int bottomSpace = 10;

@implementation NewListArticleItemView1
@synthesize itemModel;
@synthesize imageLoadingOperation;
@synthesize _idLayout;

- (id) initWithMessageModel:(ArticleModel*) _itemModel andViewoder:(NSInteger)oderview{
	if (self = [super init]) {
		self.itemModel =_itemModel;
        self.Viewoder = oderview;
        self._idLayout =_itemModel._idLayout;
        //TEST
       // self._idLayout =1;
        //======
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
    if ((NSNull *)imageUrl==[NSNull null]) {
        imageUrl =@"";
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
#pragma mark---- 

#pragma mark-------
- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation{
    //[self LoadImage:interfaceOrientation];
    if (interfaceOrientation ==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"idlayout ======%d",self._idLayout);
        CGSize contentViewArea;
        if (self._idLayout==1) {
            [title setTextColor:[UIColor whiteColor]];
            [time_ago setTextColor:[UIColor whiteColor]];
            [titleFeed setTextColor:[UIColor whiteColor]];
            [contentView setFrame:CGRectMake(0, -56, self.frame.size.width, self.frame.size.height+56)];
             contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
            
            [imageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+56)];
            
            [title setFrame:CGRectMake(15,contentView.frame.size.height*5/7, contentViewArea.width-10, 40)];
            title.numberOfLines=0;
            [title sizeToFit];
            [title setFrame:CGRectMake(15,contentView.frame.size.height-title.frame.size.height-80, title.frame.size.width,title.frame.size.height)];

            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
            
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            
        }else{
            [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
             contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
            
            [imageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+56)];
            
            [title setFrame:CGRectMake(15,contentView.frame.size.height*5/7, contentViewArea.width-10, 40)];
            title.numberOfLines=0;
            [title sizeToFit];
            
            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
            
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
        }
        
        
        //===========  layout

        switch (self._idLayout) {
            case 6:
                [title setTextColor:[UIColor whiteColor]];
                [title setBackgroundColor:[UIColor clearColor]];
                [titleFeed setBackgroundColor:[UIColor clearColor]];
                [titleFeed setTextColor:[UIColor whiteColor]];
                [time_ago setBackgroundColor:[UIColor clearColor]];
                [time_ago setTextColor:[UIColor whiteColor]];
                [title setFrame:CGRectMake(15,contentView.frame.size.height*5/7+20-XAppDelegate.appFontSize*10, contentViewArea.width-10, 40)];
                title.numberOfLines=0;
                [title sizeToFit];
                [title setFrame:CGRectMake(15,contentView.frame.size.height-title.frame.size.height-110, title.frame.size.width,title.frame.size.height)];

                [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                
                [imageView setFrame:CGRectMake(10, 14, 352+12, 524)];

                break;
            case 9:
                NSLog(@"idlayout ======9");
                title.numberOfLines=0;
                [title sizeToFit];            if (self.Viewoder==1) {
                    [title setFrame:CGRectMake(15,contentView.frame.size.height*5/7+30, contentViewArea.width-10, 40)];
                    
                }else{
                    [title setFrame:CGRectMake(15,contentView.frame.size.height*5/7, contentViewArea.width-10, 40)];
                    
                }
                [title sizeToFit];
                title.numberOfLines =0;
                [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                
                [imageView setFrame:CGRectMake(10, 10, contentViewArea.width-10, contentViewArea.height-10)];
                break;
            case 12:
                [contentView setBackgroundColor:[UIColor blackColor]];
                if (self.Viewoder==0) {
                    [imageView setFrame:CGRectMake(0, 0, contentView.frame.size.width-70, 395)];
                }else{
                    [imageView setFrame:CGRectMake(0, 0, contentView.frame.size.width-35, 200)];
                    
                }

                break;
            case 15:
                [title setTextColor:[UIColor whiteColor]];
                [time_ago setTextColor:[UIColor whiteColor]];
                [titleFeed setTextColor:[UIColor whiteColor]];
                [contentView setFrame:CGRectMake(0, -56, self.frame.size.width, self.frame.size.height+56)];
                contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
                
                [imageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+56)];
                
                [title setFrame:CGRectMake(15,contentView.frame.size.height*5/7, contentViewArea.width-10, 40)];
                title.numberOfLines=0;
                [title sizeToFit];
                if (self.Viewoder==5){
                    [title setFrame:CGRectMake(15,contentView.frame.size.height-title.frame.size.height-70, title.frame.size.width,title.frame.size.height)];

                }else{
                    [title setFrame:CGRectMake(15,contentView.frame.size.height-title.frame.size.height-130, title.frame.size.width,title.frame.size.height)];

                }
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                
                [imageView setFrame:CGRectMake(10, 20, contentViewArea.width-20, contentViewArea.height-10)];
                if (self.Viewoder==5) {
                    NSLog(@"viewoder====5 in layout 15");
                    [imageView setFrame:CGRectMake(10, 20, contentViewArea.width-20, contentViewArea.height-10)];

                }

                break;
            default:
                break;
        }

    }else if(interfaceOrientation ==UIInterfaceOrientationLandscapeLeft|| interfaceOrientation== UIInterfaceOrientationLandscapeRight){
        [self changeLandScape];
    }
}

- (void) initializeFields {
    NSLog(@"initialize item 1");
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
    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    
	
    
    //[imageView setImage:[UIImage imageNamed:itemModel.image]];
    NSString *imageUrl ;
    if ([UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortrait||[UIApplication sharedApplication].statusBarOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        imageUrl = [itemModel._ArticlePortrait objectForKey:@"HeadImageUrl"];
    }else {
        imageUrl = [itemModel._ArticleLandscape objectForKey:@"HeadImageUrl"];
    }
//    if ((NSNull *)imageUrl==[NSNull null]) {
//        imageUrl=@"";
//    }
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
    NSString *title1 =[ itemModel._ArticlePortrait objectForKey:@"Title"];
	[title setText:[NSString stringWithFormat:@"%@",[title1 stringByConvertingHTMLToPlainText]]];
    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:24];
	[title setTextColor:[UIColor whiteColor]];;
	[title setBackgroundColor:[UIColor clearColor]];
    title.shadowColor = [UIColor blackColor];
    title.shadowOffset = CGSizeMake(0, 1);

	[contentView addSubview:title];
	
    titleFeed =[[UILabel alloc]init];
    [titleFeed setText:[NSString stringWithFormat:@"chia sẻ bởi %@",itemModel.nameSite]];
    titleFeed.font =[UIFont fontWithName:@"UVNHongHaHep" size:13];
    [titleFeed setBackgroundColor:[UIColor clearColor]];
    [titleFeed setTextColor:[UIColor colorWithRed:55 green:55 blue:55 alpha:1]];
    [contentView addSubview:titleFeed];
	titleFeed.shadowColor = [UIColor blackColor];
    titleFeed.shadowOffset = CGSizeMake(0, 1);

	time_ago = [[UILabel alloc] init];
    NSString *timecreate=[Utils dateStringFromTimestamp:itemModel.time_ago];
    [time_ago setText:[NSString stringWithFormat:@"%@ - %d bình luận",timecreate,itemModel._numberComment]];

	time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:13];
	[time_ago setTextColor:[UIColor whiteColor]];
	[time_ago setBackgroundColor:[UIColor clearColor]];
    time_ago.shadowColor = [UIColor blackColor];
    time_ago.shadowOffset = CGSizeMake(0, 1);
    
	[contentView addSubview:time_ago];
        
	[self addSubview:contentView];
	//[self reAdjustLayout];
}

-(void)tapped:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Taped");
        NSLog(@" Item thu:%d",self.Viewoder);
        
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
#pragma mark--- load lay out

- (void)changeLandScape{
    [title setTextColor:RGBCOLOR(55,55,55)];
    [title setFont:[UIFont fontWithName:@"UVNHongHaHep" size:21.12]];
    [titleFeed setFont:[UIFont fontWithName:@"UVNHongHaHep" size:13.36]];
    titleFeed.textColor =  RGBCOLOR(95,95,95);
    [time_ago setFont:[UIFont fontWithName:@"UVNHongHaHep" size:13.36]];
    [time_ago setTextColor:RGBCOLOR(95,95,95)];
    
    [contentView setFrame:CGRectMake(0,1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
    CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));

    switch (self._idLayout) {
        case 1:
                      
            [title setFrame:CGRectMake(15,10, contentViewArea.width-10, 40)];
            
            title.numberOfLines =0;
            [title sizeToFit];
            [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
            
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            
            [imageView setFrame:CGRectMake(title.frame.origin.x, imageIconView.frame.origin.y+imageIconView.frame.size.height+bottomSpace+10, 650, 484)];
            
            break;
        case 6:
            
            [imageView setFrame:CGRectMake(15, 10, 351, 528)];
            [title setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.size.height+imageView.frame.origin.y, imageView.frame.size.width, 40)];
            title.numberOfLines =0; 
            [title sizeToFit];
            [title setFrame:CGRectMake(imageView.frame.origin.x,contentViewArea.height-title.frame.size.height-50, imageView.frame.size.width, title.frame.size.height)];

            [imageIconView setFrame:CGRectMake(imageView.frame.origin.x, title.frame.origin.y+title.frame.size.height+2, 30, 30)];
            
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
            [imageView setFrame:CGRectMake(15, 10, 351, contentViewArea.height-title.frame.size.height-70)];

            break;
            
        case 9:
            [title setFrame:CGRectMake(180, 10, contentViewArea.width-190, 40)];
            title.numberOfLines =0;
            [title sizeToFit];
            
            [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, 30, 30)];
            
            [titleFeed sizeToFit];
            [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
            
            [time_ago sizeToFit];
            [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
            [imageView setFrame:CGRectMake(180, time_ago.frame.origin.y+time_ago.frame.size.height+20, 1024-360,748/1.5)];
            
            break;
        case 15:
            if (self.Viewoder!=4) {
                [title sizeToFit];
                [title setFrame:CGRectMake(10, 10, contentViewArea.width-10, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+5, 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x, titleFeed.frame.origin.y+titleFeed.frame.size.height+2, titleFeed.frame.size.width, titleFeed.frame.size.height)];
                
                [imageView setFrame:CGRectMake(title.frame.origin.x,imageIconView.frame.origin.y+imageIconView.frame.size.height+10, contentViewArea.width-10, 175)];

            }else {
                [imageView setFrame:CGRectMake(10, 20, contentView.frame.size.width-20, contentView.frame.size.height-150)];
                
                [title setFrame:CGRectMake(10,contentView.frame.size.height-140, contentViewArea.width-10, 40)];
                title.numberOfLines =0;
                [title sizeToFit];
                [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+bottomSpace , 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
            }
            break;
        default:
            break;
    }
    

}

@end
