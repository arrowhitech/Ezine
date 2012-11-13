
#import "FullScreenView.h"
#import "EzineAppDelegate.h"
#import "NSString+HTML.h"
#import "GTMNSString+HTML.h"
#import "DetailArticleViewController.h"

#import "LTTextView.h"
#import "NSAttributedString+HTML.h"
#import "LTTextImageView.h"
#import "DTTextAttachment.h"
#import "DTAttributedTextView.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DTHTMLElement.h"
#import "DTCoreTextFontDescriptor.h"
#import "DTCoreTextConstants.h"
#import "DTLinkButton.h"

static const int spaceTop = 10;
static const int spaceBottom= 10;
static const int bottomSpace = 5;

@implementation FullScreenView

@synthesize articleModel,viewToOverLap,fullScreenBG;
@synthesize _imageMain,imageLoadingOperation;
@synthesize flipViewController;
@synthesize deletate,cachedDataDetailArtcile;
@synthesize siteNameforFullScr,urlLogoforFullSrc;
@synthesize _arrayDataAllDetailArticle,_arrayIdAllDetailArticle;
@synthesize mediaPlayers,popovercontroller;


#pragma mark---  check derailArticleID to know load next article
-(void)checkDetailArticleID{
    NSLog(@"numberArticleInAll===%d",[self._arrayDataAllDetailArticle count]);
    for (int i=0; i<[self._arrayIdAllDetailArticle count]; i++) {
        NSNumber *idDetailArticle=[self._arrayIdAllDetailArticle objectAtIndex:i];
       

        if ([idDetailArticle integerValue]==articleModel._ArticleID) {
            numberArticleInAll=i;
            NSLog(@"numberArticleInAll===%d",numberArticleInAll);
            break;
        }
    }
}

#pragma mark---- init with model
-(id)initWithModel:(ArticleModel*)model {
	if (self = [super init]) {
        NSLog(@"model===%d",model._ArticleID);
        _arrayViewDetailArticle=[[NSMutableArray alloc] init];
        _arrayViewDetailArticleLandScape=[[NSMutableArray alloc] init];
        _currentOrientation=[UIApplication sharedApplication].statusBarOrientation;
        cachedDataDetailArtcile=nil;
        _arrayIdAllDetailArticle=[[NSMutableArray alloc] init];
        _arrayDataAllDetailArticle=[[NSMutableArray alloc] init];
        
        imgFakeGifAnimation=[[UIImageView alloc] initWithFrame:self.frame];
        imgFakeGifAnimation.animationDuration = 1;
        imgFakeGifAnimation.animationRepeatCount = 0;
        
        if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationLandscapeLeft||[[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationLandscapeRight) {
            NSLog(@"HHHAHAHAHAHAHAHAHAHAHHA111");
            imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-V1.png"],[UIImage imageNamed:@"Ezine-loading-V2.png"],[UIImage imageNamed:@"Ezine-loading-V3.png"],[UIImage imageNamed:@"Ezine-loading-V4.png"],[UIImage imageNamed:@"Ezine-loading-V5.png"],[UIImage imageNamed:@"Ezine-loading-V6.png"],nil];
            [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 1024, 748)];
            [imgFakeGifAnimation startAnimating];
            
        }else if ([[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortrait||[[UIApplication sharedApplication] statusBarOrientation]==UIInterfaceOrientationPortraitUpsideDown){
            NSLog(@"HHHAHAHAHAHAHAHAHAHAHHA222");
            imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-H1.png"],[UIImage imageNamed:@"Ezine-loading-H2.png"],[UIImage imageNamed:@"Ezine-loading-H3.png"],[UIImage imageNamed:@"Ezine-loading-H4.png"],[UIImage imageNamed:@"Ezine-loading-H5.png"],[UIImage imageNamed:@"Ezine-loading-H1.png"],nil];
            [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 768, 1004)];
            [imgFakeGifAnimation startAnimating];
            
        }
        

        [[UIDevice currentDevice] orientation] ;
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
        
		articleModel = model;
        
        //self.dicForArticleDetail =model.DictForArticleDetail;
        NSLog(@"DictForArticleDetail==%@",model.DictForArticleDetail);
		[self setBackgroundColor:RGBCOLOR(243,243,243)];
                        
        
		contentView = [[DetailArticleView alloc] init];
        [contentView setBackgroundColor:RGBCOLOR(243,243,243)];
        
        
        title = [[UILabel alloc] init];
        title.font =[UIFont boldSystemFontOfSize:30+XAppDelegate.appFontSize];
        [title setTextColor:[UIColor whiteColor]];
        [title setBackgroundColor:[UIColor clearColor]];
        [self addSubview:title];
        //[contentView addSubview:title];
        
        
        time_ago = [[UILabel alloc] init];
        [time_ago setText:articleModel.time_ago];
        time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:18+XAppDelegate.appFontSize];
        [time_ago setTextColor:[UIColor whiteColor]];
        [time_ago setBackgroundColor:[UIColor clearColor]];
        [self addSubview:time_ago];
        
		closeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        closeButton.showsTouchWhenHighlighted=YES;
        
		[self addSubview:contentView];
        
        /*
         Init FlipviewController
         */
        activeIndex=0;
        numberPageInArticle=0;

        self.flipViewController = [[MPFlipViewController alloc] initWithOrientation:[self flipViewController:nil orientationForInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation]];
        self.flipViewController.delegate = self;
        self.flipViewController.dataSource = self;
        CGRect pageViewRect = self.bounds;
        self.flipViewController.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.flipViewController.view.frame = pageViewRect;
        //   [self addChildViewController:self.flipViewController];
        [self addSubview:self.flipViewController.view];
        // [self.flipViewController didMoveToParentViewController:self];
        self.gestureRecognizers = self.flipViewController.gestureRecognizers;
        
        [self addSubview:imgFakeGifAnimation];
        
       
	}
	return self;
}

#pragma mark--- start load Article
- (void)startLoadArticle{
    if(![self connected]){
        
        NSLog(@"Not connect to internet");
        [self fetchedData:articleModel.DictForArticleDetail];
        
        
    }else{
        
        NSLog(@"InternetConnected");
        [self checkDetailArticleID];
        [XAppDelegate.serviceEngine GetArticleDetail:articleModel._ArticleID onCompletion:^(NSDictionary* data) {
            [self fetchedData:data];
            
        } onError:^(NSError* error) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not connect to service" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
            [alert show];
            [alert release];
            [self closeFullScreenView];
        }];
        
    }

}

//============
- (void)reAdjustLayout{
    [self buildLayoutDetailArticle];
    //
    //    [contentView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //    CGSize contentViewArea = CGSizeMake(contentView.frame.size.width, contentView.frame.size.height);
    //
    //
    //            [title setFrame:CGRectMake(10, 350, contentViewArea.width-50, 50)];
    //            title.numberOfLines=0;
    //            [title sizeToFit];
    //            [time_ago sizeToFit];
    //            [time_ago setFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height+bottomSpace, title.frame.size.width, 28)];
    //
    //            [imageView setFrame:CGRectMake(title.frame.origin.x, time_ago.frame.origin.y+time_ago.frame.size.height+bottomSpace, contentViewArea.width/2.0-40, contentViewArea.height-time_ago.frame.origin.y-time_ago.frame.size.height-bottomSpace)];
    //
    //            [closeButton setFrame:CGRectMake(contentViewArea.width - 30, 0, 30, 30)];
    //
    //            [text_content sizeToFit];
    //            [text_content setFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+5, imageView.frame.origin.y , contentViewArea.width-imageView.frame.origin.x-imageView.frame.size.width-5, imageView.frame.size.height)];
    //        //    [text_content setText:articleModel.text_content];
    //            text_content.contentMode =UIViewContentModeLeft;
    //
    //        NSString* text = [articledetailModel._content stringByConvertingHTMLToPlainText];
    //        MarkupParser* p = [[[MarkupParser alloc] init] autorelease];
    //        [p setFont:@"TimesNewRomanPSMT"];
    //        NSAttributedString* attString = [p attrStringFromMarkup: text];
    //
    //        [contentView setAttString:attString withImages:Nil];
    //        contentView._textPost=0;
    //        [contentView builtPagePoitrait];
    //    NSLog(@"_TextPost==%d",contentView._textPost);
}


-(void)closeFullScreenView {
    NSLog(@"Close Buttonn==============");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    viewToOverLap.alpha = 1;
    [self setBackgroundColor:[UIColor whiteColor]];
    //[sender removeFromSuperview];
    [UIView beginAnimations:@"CLOSEFULLSCREEN" context:NULL];
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:YES];
    [self setFrame:viewToOverLap.originalRect];
	fullScreenBG.alpha = 0;
    for (UIView* subview in [self subviews]) {
        subview.alpha = 0;
    }
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationEnd:finished:context:)];
    [UIView commitAnimations];
}

- (void)animationEnd:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context {
    if ([animationID isEqualToString:@"CLOSEFULLSCREEN"]) {
        self.alpha = 0;
        [self removeFromSuperview];
        [[EzineAppDelegate instance] closeFullScreen];
    }
}

-(void)showFields {
	[self reAdjustLayout];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.20];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:nil cache:NO];
	time_ago.alpha = 1;
	closeButton.alpha = 1;
	text_content.alpha = 1;
	[UIView commitAnimations];
}


-(void) dealloc {
	[closeButton release];
	closeButton=nil;
	[imageIconView release];
	imageIconView=nil;
	[titleFeed release];
	titleFeed=nil;
	[time_ago release];
	time_ago=nil;
	[text_content release];
	text_content=nil;
	[scrollView release];
    scrollView=nil;
	[contentView release];
	contentView=nil;
	[super dealloc];
}

#pragma mark--- fetched data
-(void)fetchedData:(NSDictionary *)data{
    NSLog(@"data article load==%@",data);

    if (data==NULL) {
        [self closeFullScreenView];
        return;
    }
    
    if ([data isEqualToDictionary:cachedDataDetailArtcile]) {
        NSLog(@"cached articleDetail");
        return;
    }
    if (_iscache) {
        return;
    }else{
        _iscache=YES;
    }
    [cachedDataDetailArtcile release];
    cachedDataDetailArtcile=[[NSDictionary alloc] initWithDictionary:data copyItems:YES];
    if (!articledetailModel) {
        articledetailModel=[[ArticleDetailModel alloc] init];
    }
    articledetailModel._ArticleID=[[data objectForKey:@"ArticleID"] integerValue];
    articledetailModel._SiteID=[[data objectForKey:@"SiteID"] integerValue];
    articledetailModel._commnetCount=[[data objectForKey:@"CommentCount"] integerValue];
    articledetailModel._publishTime=[data objectForKey:@"PublishTime"];
    articledetailModel._caption=[data objectForKey:@"Caption"];
    articledetailModel._title=[data objectForKey:@"Title"];
    articledetailModel._title=[articledetailModel._title stringByConvertingHTMLToPlainText];
    articledetailModel.urlreadWed =[data objectForKey:@"UrlWeb"];
    articledetailModel._content=[data objectForKey:@"Content"];

    articledetailModel._ArticleLandscape=[data objectForKey:@"ArticleLandscape"];
    articledetailModel._articlePortrait=[data objectForKey:@"ArticlePortrait"];
    //    HeaderDetailArticle *header=[[HeaderDetailArticle alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 56)];
    //    [header setWallTitleText:articledetailModel._SiteID];
    //    header.delegate=self;
    [self showFields];
    //
    //    //===
    //    [self addSubview:header];
    if (imgFakeGifAnimation) {
        [imgFakeGifAnimation removeFromSuperview];
    }

    
}
#pragma mark-- footer delegate
- (void) ezineButtonClicked:(id)sender{
    [self closeFullScreenView];
}

-(void) listButtonClicked:(UIButton *)sender{
    ListArticleRelative *listArticle=[[ListArticleRelative alloc] init];
    listArticle._siteId=sender.tag;
    [listArticle getLastestSource];
    listArticle.delegate=self;
    NSLog(@"list source: %d",[sender tag]);
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:listArticle];
    
    UIPopoverController* listPopover = [[UIPopoverController alloc]
                                        initWithContentViewController:navController];
    listPopover.delegate =self;
    [navController release];
    self.popovercontroller =listPopover;
    [listPopover release];
    [self.popovercontroller presentPopoverFromRect:sender.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
#pragma mark--- built layout for detail article
-(void) buildLayoutDetailArticle{
    NSString* text = [articledetailModel._content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"text===== %@",text);
    
    MarkupParser* p = [[[MarkupParser alloc] init] autorelease];
    [p setFont:@"TimesNewRomanPSMT"];
    
    _textLenght=0;
    int i=1;
      
    NSData *htmlData = [articledetailModel._content dataUsingEncoding:NSUTF8StringEncoding];
    
    // NSData* htmlData = [NSData dataWithContentsOfFile:path];
    
    CGSize maxImageSize = CGSizeMake(0, 0);
    
    // example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
	
	// example for setting a willFlushCallback, that gets called before elements are written to the generated attributed string
	void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
		// if an element is larger than twice the font size put it in it's own block
		if (element.displayStyle == DTHTMLElementDisplayStyleInline && element.textAttachment.displaySize.height > 2.0 * element.fontDescriptor.pointSize)
		{
			element.displayStyle = DTHTMLElementDisplayStyleBlock;
		}
	};
	float sizeText=1.3+XAppDelegate.appFontSize/10.0;
	NSDictionary *options1 = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:sizeText], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                             @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, callBackBlock, DTWillFlushBlockCallBack, nil];
    
    
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] init];
   

    [attString appendAttributedString:[[NSAttributedString alloc] initWithHTMLData:htmlData
                                                                            options:options1
                                                                 documentAttributes:NULL]];
    
    int currentPage=[_arrayViewDetailArticle count];
    
    while (_textLenght<[attString length]) {
        DetailArticleView *detailArticle=[[DetailArticleView alloc] init];
        detailArticle.articleModel=articledetailModel;
        [detailArticle setFrame:CGRectMake(0, 50, 768, 1004)];
        [detailArticle setAttString:attString withImages:Nil];
        detailArticle._textPost=_textLenght;
        detailArticle._numberPage=i;
        [detailArticle buildFramesArticle:UIInterfaceOrientationPortrait];
        _textLenght=detailArticle._textPost;
        NSLog(@"textPost== %d  %d",_textLenght,attString.length);
        DetailArticleViewController *detailViecontroller=[[DetailArticleViewController alloc] init];
        [detailViecontroller.view setFrame:CGRectMake(0, 0, 768, 1004)];
        [detailViecontroller.view setBackgroundColor:[UIColor whiteColor]];
        [detailViecontroller.view addSubview:detailArticle];
        
        [_arrayViewDetailArticle addObject:detailViecontroller];
        i++;
    }
    for (int j=currentPage; j<[_arrayViewDetailArticle count]; j++) {
        DetailArticleViewController *detailViecontroller=[_arrayViewDetailArticle objectAtIndex:j];
        HeaderDetailArticle *header=[[HeaderDetailArticle alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 56)];
        [header setWallTitleText:articledetailModel._SiteID];
        header.delegate=self;
        [header reAdjustLayout:UIInterfaceOrientationPortrait];
        [detailViecontroller.view addSubview:header];
        
        FooterDetaiArticleView *footerview=[[FooterDetaiArticleView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-100, self.frame.size.width, 100)];
        [footerview setBackgroundColor:[UIColor whiteColor]];
        footerview.delegate =self;
        footerview._curentPage=j+1-currentPage;
        footerview._articleID=articleModel._ArticleID;
        footerview._allpage=[_arrayViewDetailArticle count]-currentPage;
        [footerview setdataWithModel:articledetailModel];
        [footerview reAdjustLayout:UIInterfaceOrientationPortrait];
        [detailViecontroller.view addSubview:footerview];
        
    }
    NSLog(@"_ArrayDetailview count==%d",_arrayViewDetailArticle.count);
    // make array View controller article landScape
    i=1;
    _textLenght=0;
    int currentPageLandScape=[_arrayViewDetailArticleLandScape count];

    while (_textLenght<[attString length]) {
        DetailArticleView *detailArticle=[[DetailArticleView alloc] init];
        detailArticle.articleModel=articledetailModel;
        [detailArticle setFrame:CGRectMake(0, 50, 1024, 748)];
        [detailArticle setAttString:attString withImages:Nil];
        detailArticle._textPost=_textLenght;
        detailArticle._numberPage=i;
        [detailArticle buildFramesArticle:UIInterfaceOrientationLandscapeLeft];
        _textLenght=detailArticle._textPost;
        NSLog(@"textPost== %d  %d",_textLenght,attString.length);
        DetailArticleViewController *detailViecontroller=[[DetailArticleViewController alloc] init];
        [detailViecontroller.view setFrame:CGRectMake(0, 0, 1024, 748)];
        [detailViecontroller.view setBackgroundColor:[UIColor whiteColor]];
        [detailViecontroller.view addSubview:detailArticle];
        [_arrayViewDetailArticleLandScape addObject:detailViecontroller];
        i++;
    }
    NSLog(@"_ArrayDetailview count==%d",_arrayViewDetailArticleLandScape.count);
    
    for (int j=currentPageLandScape; j<[_arrayViewDetailArticleLandScape count]; j++) {
        DetailArticleViewController *detailViecontroller=[_arrayViewDetailArticleLandScape objectAtIndex:j];
        HeaderDetailArticle *header=[[HeaderDetailArticle alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 56)];
         header.urlLogo =self.urlLogoforFullSrc;
        [header setWallTitleText:articledetailModel._SiteID];
        
       
        
        header.delegate=self;
        [header reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
        [detailViecontroller.view addSubview:header];
        
        FooterDetaiArticleView *footerview=[[FooterDetaiArticleView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-100, self.frame.size.width, 100)];
        [footerview setBackgroundColor:[UIColor whiteColor]];
        footerview._curentPage=j+1-currentPageLandScape;
        footerview._articleID=articleModel._ArticleID;
        footerview.sitename =self.siteNameforFullScr;
        footerview.urlLogo =self.urlLogoforFullSrc;
        NSLog(@"  footerview.sitename%@",  footerview.sitename);
        
        footerview._allpage=[_arrayViewDetailArticleLandScape count]-currentPageLandScape;
        [footerview setdataWithModel:articledetailModel];
        [footerview reAdjustLayout:UIInterfaceOrientationLandscapeLeft];
        [detailViecontroller.view addSubview:footerview];
    }
    
    ///==================
       ///=========================
    if (activeIndex>0||numberPageInArticle>0) {
        return;
    }
    
    [self.flipViewController.view setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"_currentOrientation  ===  %d",_currentOrientation);
        DetailArticleViewController *firstView=[_arrayViewDetailArticle objectAtIndex:0];
        [self.flipViewController setViewController:firstView direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
        [self setFrame:CGRectMake(0, 0, 768, 1004)];
        [self.flipViewController.view setFrame:CGRectMake(0, 0,768, 1004)];

    }else if (_currentOrientation==UIInterfaceOrientationLandscapeLeft||_currentOrientation==UIInterfaceOrientationLandscapeRight){
        NSLog(@"_currentOrientation  ===  %d",_currentOrientation);

        DetailArticleViewController *firstView=[_arrayViewDetailArticleLandScape objectAtIndex:0];
        [self.flipViewController setViewController:firstView direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
        [self setFrame:CGRectMake(0, 0, 1024, 748)];
        [self.flipViewController.view setFrame:CGRectMake(0, 0, 1024, 748 )];

    }
    if (_arrayViewDetailArticle.count==1||_arrayViewDetailArticleLandScape.count==1) {
        numberPageInArticle=10;
        [self loadNewArticleDetail];
    }
       // [self orientationChanged];
    
}

#pragma mark - MPFlipViewControllerDelegate protocol

- (void)flipViewController:(MPFlipViewController *)flipViewController didFinishAnimating:(BOOL)finished previousViewController:(UIViewController*)previousViewController transitionCompleted:(BOOL)completed{
	if (completed){
		
	}
}

- (MPFlipViewControllerOrientation)flipViewController:(MPFlipViewController *)flipViewController orientationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
		return UIInterfaceOrientationIsPortrait(orientation)? MPFlipViewControllerOrientationVertical : MPFlipViewControllerOrientationHorizontal;
	else
		return MPFlipViewControllerOrientationHorizontal;
}

#pragma mark - MPFlipViewControllerDataSource protocol

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        activeIndex--;
        if (activeIndex>=0) {
            return [_arrayViewDetailArticle objectAtIndex:activeIndex];
        }else{
            activeIndex++;
            return nil;
        }
        
    }else if (_currentOrientation==UIInterfaceOrientationLandscapeLeft||_currentOrientation==UIInterfaceOrientationLandscapeRight){
        activeIndex--;
        if (activeIndex>=0) {
            return [_arrayViewDetailArticleLandScape objectAtIndex:activeIndex];
        }else{
            activeIndex++;
            return nil;
        }
        
    }
    return nil;
}

- (UIViewController *)flipViewController:(MPFlipViewController *)flipViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (_currentOrientation==UIInterfaceOrientationPortrait||_currentOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        if ([_arrayViewDetailArticle count]>0) {
            activeIndex++;
            
            if (activeIndex<=[_arrayViewDetailArticle count]-1) {
                if (activeIndex==[_arrayViewDetailArticle count]-1) {
                    [self loadNewArticleDetail];
                }
                return [_arrayViewDetailArticle objectAtIndex:activeIndex];
            }else{
                [self loadNewArticleDetail];

                activeIndex--;
                return nil;
            }
            
        }
        
    }else if (_currentOrientation==UIInterfaceOrientationLandscapeLeft||_currentOrientation==UIInterfaceOrientationLandscapeRight){
        if ([_arrayViewDetailArticleLandScape count]>0) {
            activeIndex++;
            if (activeIndex<=[_arrayViewDetailArticleLandScape count]-1) {
                if (activeIndex==[_arrayViewDetailArticleLandScape count]-1) {
                    [self loadNewArticleDetail];
                }
                return [_arrayViewDetailArticleLandScape objectAtIndex:activeIndex];
            }else{
                [self loadNewArticleDetail];

                activeIndex--;
                return nil;
            }
            
        }
        
    }
    
    return nil;
}

#pragma mark - OrientationChanged

-(void)orientationChanged{
    if (_arrayViewDetailArticle.count==0||_arrayViewDetailArticleLandScape.count==0) {
        return;
    }
    UIInterfaceOrientation orientationK =[UIDevice currentDevice].orientation;
    NSLog(@"orientationChanged fullscreen : %d  %d",currrentInterfaceOrientation,orientationK);

    if (_currentOrientation==orientationK)
        return;
    
    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight) {
        _currentOrientation=UIInterfaceOrientationLandscapeLeft;
        [self setFrame:CGRectMake(0, 0, 1024, 748)];
        [self.flipViewController.view setFrame:CGRectMake(0, 0, 1024, 748 )];
        NSLog(@" rotate UIInterfaceOrientationLandscapeLeft  %d",activeIndex);
        if (activeIndex>_arrayViewDetailArticleLandScape.count-1) {
            DetailArticleViewController *firstView=[_arrayViewDetailArticleLandScape lastObject];
            [self.flipViewController setViewController:firstView direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
            activeIndex=_arrayViewDetailArticleLandScape.count-1;
            
        }else{
            DetailArticleViewController *firstView=[_arrayViewDetailArticleLandScape objectAtIndex:activeIndex];
            [self.flipViewController setViewController:firstView direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
            
        }
        
        if (!imgFakeGifAnimation) {
            return;
        }
        [imgFakeGifAnimation stopAnimating];
        imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-V1.png"],[UIImage imageNamed:@"Ezine-loading-V2.png"],[UIImage imageNamed:@"Ezine-loading-V3.png"],[UIImage imageNamed:@"Ezine-loading-V4.png"],[UIImage imageNamed:@"Ezine-loading-V5.png"],[UIImage imageNamed:@"Ezine-loading-V6.png"],nil];
        [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 1024, 748)];
        [imgFakeGifAnimation startAnimating];
        
        [UIView commitAnimations];

        
    }else if([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait||[[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown){
        _currentOrientation=UIInterfaceOrientationPortrait;
        [self setFrame:CGRectMake(0, 0, 768, 1004)];
        [self.flipViewController.view setFrame:CGRectMake(0, 0,768, 1004)];
        NSLog(@"will rotate UIInterfaceOrientationPortrait %d",activeIndex);
        if (activeIndex>_arrayViewDetailArticle.count-1) {
            DetailArticleViewController *firstView=[_arrayViewDetailArticle lastObject];
            [self.flipViewController setViewController:firstView direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
            activeIndex=_arrayViewDetailArticle.count-1;
            
        }else{
            DetailArticleViewController *firstView=[_arrayViewDetailArticle objectAtIndex:activeIndex];
            [self.flipViewController setViewController:firstView direction:MPFlipViewControllerDirectionForward animated:NO completion:nil];
            
        }
        
        if (!imgFakeGifAnimation) {
            return;
        }
        [imgFakeGifAnimation stopAnimating];
        
        imgFakeGifAnimation.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"Ezine-loading-H1.png"],[UIImage imageNamed:@"Ezine-loading-H2.png"],[UIImage imageNamed:@"Ezine-loading-H3.png"],[UIImage imageNamed:@"Ezine-loading-H4.png"],[UIImage imageNamed:@"Ezine-loading-H5.png"],[UIImage imageNamed:@"Ezine-loading-H1.png"],nil];
        [imgFakeGifAnimation setFrame:CGRectMake(0, 0, 768, 1004)];
        [imgFakeGifAnimation startAnimating];
        
        [UIView commitAnimations];

        
    }
}


#pragma mark==========FooterDetailArticeViewDelegate

-(void)shareEmail{
    
    if (self.deletate) {
        [self.deletate shareEmail];
    }
}
-(void)ReadBaseOnWeb{
    if (self.deletate ) {
        [self.deletate ReadBaseOnWeb:articledetailModel.urlreadWed];
    }
    
}
#pragma mark Custom Views on Text

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame
{
	NSDictionary *attributes = [string attributesAtIndex:0 effectiveRange:NULL];
	
	NSURL *URL = [attributes objectForKey:DTLinkAttribute];
	NSString *identifier = [attributes objectForKey:DTGUIDAttribute];
	
	
	DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:frame];
	button.URL = URL;
	button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
	button.GUID = identifier;
	
	// we draw the contents ourselves
	button.attributedString = string;
	
	// make a version with different text color
	NSMutableAttributedString *highlightedString = [string mutableCopy];
	
	NSRange range = NSMakeRange(0, highlightedString.length);
	
	NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:( id)[UIColor greenColor].CGColor forKey:(id)kCTForegroundColorAttributeName];
	
	
	[highlightedString addAttributes:highlightedAttributes range:range];
	
	button.highlightedAttributedString = highlightedString;
	
	// use normal push action for opening URL
	[button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
	
	// demonstrate combination with long press
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
	[button addGestureRecognizer:longPress];
	
	return button;
}

- (void)linkPushed:(DTLinkButton *)button
{
    NSURL *URL = button.URL;
	NSLog(@"link plushed  %@",URL);
	
	if ([[UIApplication sharedApplication] canOpenURL:[URL absoluteURL]])
	{
		[[UIApplication sharedApplication] openURL:[URL absoluteURL]];
	}
	else
	{
		if (![URL host] && ![URL path])
		{
            
			// possibly a local anchor link
			NSString *fragment = [URL fragment];
			
			if (fragment)
			{
				[_textView scrollToAnchorNamed:fragment animated:NO];
			}
		}
	}
}

#pragma mark CHeck Internet Avalable=============

-(BOOL)connected{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];

    return !(networkStatus == NotReachable);
   
}
#pragma mark--- update article detail
-(void)loadNewArticleDetail{
    
    numberArticleInAll=numberArticleInAll+1;
    if (numberArticleInAll>=[self._arrayDataAllDetailArticle count]) {
        return;
    }
    articleModel=nil;
    articleModel=[self._arrayDataAllDetailArticle objectAtIndex:numberArticleInAll];
    NSLog(@"load new Article : id=== %d",articleModel._ArticleID);

    [XAppDelegate.serviceEngine GetArticleDetail:articleModel._ArticleID onCompletion:^(NSDictionary* data) {
        _iscache=NO;
        [self fetchedData:data];
        
    } onError:^(NSError* error) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not connect to service" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }];

}

#pragma mark--- ListArticleRelativedelegate

-(void)didSelectArticle:(int)arcticleId andArrayDataListArticle:(NSMutableArray *)arrayDataListArticle{
    NSLog(@"arrayDataListArticle ==%@",arrayDataListArticle);
    [self.flipViewController.left setEnabled:NO];
    [self.flipViewController.right setEnabled:NO];
    [self.popovercontroller dismissPopoverAnimated:YES];
    if (!arrayDataListArticle||arrayDataListArticle.count<1) {
        return;
    }
    if (self._arrayDataAllDetailArticle) {
        [self._arrayDataAllDetailArticle removeAllObjects];
        [self._arrayIdAllDetailArticle removeAllObjects];
    }
    numberArticleInAll=-1;
    
    for (int i=0; i<[arrayDataListArticle count]; i++) {
        NSDictionary *dataArticle=[arrayDataListArticle objectAtIndex:i];
        ArticleDetailModel *model=[[ArticleDetailModel alloc] init];
        model._ArticleID=[[dataArticle objectForKey:@"ArticleID"] integerValue];
        model._publishTime=[dataArticle objectForKey:@"PublishTime"];
        model._SiteID=articledetailModel._SiteID;
        [self._arrayDataAllDetailArticle addObject:model];
        [self._arrayIdAllDetailArticle addObject:[NSNumber numberWithInteger:model._ArticleID]];
        if (arcticleId== model._ArticleID) {
            numberArticleInAll=i-1;
        }

    }
    [_arrayViewDetailArticle removeAllObjects];
    [_arrayViewDetailArticleLandScape removeAllObjects];
    activeIndex=0;
    [self loadNewArticleDetail];
    [self.flipViewController.left setEnabled:YES];
    [self.flipViewController.right setEnabled:YES];

}
@end
