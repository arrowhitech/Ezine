//
//  FooterDetaiArticleView.m
//  Ezine
//
//  Created by MAC on 9/19/12.
//
//

#import "FooterDetaiArticleView.h"
#import "SHK.h"
#import "SHKItem.h"
#import "SHKSharer.h"
#import "SHKTwitter.h"
#import "SHKReadItLater.h"
#import "ReadBaseOnWeb.h"
#import "MessageUI/MessageUI.h"
#import "Utils.h"


@implementation FooterDetaiArticleView
@synthesize _allpage,_curentPage,_articleID;
@synthesize imageLoadingOperation;
@synthesize activityIndicator;
@synthesize delegate;
@synthesize share;
@synthesize sitename,urlLogo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _pageNumber=[[UILabel alloc] init];
        _pageNumber.font =[UIFont fontWithName:@"ArialHebrew" size:15.36];
        [_pageNumber setBackgroundColor:[UIColor clearColor]];
        [_pageNumber setTextColor:[UIColor grayColor]];
        [self addSubview:_pageNumber];
        
        _titleFeed=[[UILabel alloc] init];
        _titleFeed.font =[UIFont fontWithName:@"UVNHongHaHepBold" size:15.36];
        [_titleFeed setBackgroundColor:[UIColor clearColor]];
        [_titleFeed setTextColor:[UIColor blackColor]];
        [self addSubview:_titleFeed];
        
        _time_ago=[[UILabel alloc] init];
        _time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:13];
        [_time_ago setBackgroundColor:[UIColor clearColor]];
        [_time_ago setTextColor:[UIColor grayColor]];
        [self addSubview:_time_ago];
        _logoSite=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self addSubview:_logoSite];
        
        _comment=[[UIButton alloc] init];
        UIImage *commentIceon=[UIImage imageNamed:@"btn_detailArticle_comment"];
        [_comment setImage:commentIceon forState:UIControlStateNormal];
        [_comment addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_comment];
        
        _like=[[UIButton alloc] init];
        UIImage *likeIcon=[UIImage imageNamed:@"btn_detailArticle_like"];
        [_like setImage:likeIcon forState:UIControlStateNormal];
        [_like addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_like];
        
        _reload=[[UIButton alloc] init];
        UIImage *reloadIcon=[UIImage imageNamed:@"btn_bookmarkDetailArticle"];
        [_reload setImage:reloadIcon forState:UIControlStateNormal];
        [_reload addTarget:self action:@selector(boomarkClick:) forControlEvents:UIControlEventTouchUpInside];
        [_reload setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_reload];
        
        _move=[[UIButton alloc] init];
        UIImage *moveIcon=[UIImage imageNamed:@"btn_detailArticle_move"];
        [_move setImage:moveIcon forState:UIControlStateNormal];
        [_move addTarget:self action:@selector(moveClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_move];
        
        _line1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line-vertical"]];
        _line2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line-vertical"]];
        [self addSubview:_line1];
        [self addSubview:_line2];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void) setdataWithModel:(ArticleDetailModel *)articleDetailModerl{
    if (_curentPage>=2) {
        [_logoSite setHidden:YES];
        [_time_ago setHidden:YES];
        [_titleFeed setHidden:YES];
    }
    NSString *timeago=[Utils dateStringFromTimestamp:articleDetailModerl._publishTime];
    [_time_ago setText:timeago];
    
    if (![self connected]) {
        
        NSString *urlLogoSite=[[NSUserDefaults standardUserDefaults] objectForKey:@"SiteLogoUrlofLine"];
        NSString  *titleSite=[[NSUserDefaults standardUserDefaults] objectForKey:@"SiteNameOfLine"];
        
        [_titleFeed setText:titleSite];
        if ((NSNull *)urlLogoSite==[NSNull null]) {
            urlLogoSite =@"";
        }
        self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlLogoSite]
                                                               onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                   if([urlLogoSite isEqualToString:[url absoluteString]]) {
                                                                       
                                                                       if (isInCache) {
                                                                           _logoSite.image = fetchedImage;
                                                                           //     [self hideActivityIndicator];
                                                                           
                                                                       } else {
                                                                           
                                                                           
                                                                           
                                                                           _logoSite.image = fetchedImage;
                                                                           _logoSite.alpha = 1;
                                                                           // [self hideActivityIndicator];
                                                                           
                                                                       }
                                                                   }
                                                               }];

        
    }else{
        [XAppDelegate.serviceEngine getDetailAsite:articleDetailModerl._SiteID onCompletion:^(NSDictionary* data) {
            [self fetchedData:data];
            
        } onError:^(NSError* error) {
            //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not connect to service" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
            //        [alert show];
            //        [alert release];
        }];
    }
   
    
}
-(void) fetchedData:(NSDictionary*)data{
    NSLog(@"site detail=== %@",data);
    NSString *urlLogoSite=[data objectForKey:@"LogoUrl"];
    NSString  *titleSite=[data objectForKey:@"Name"];
    
    [_titleFeed setText:titleSite];
    if ((NSNull *)urlLogoSite==[NSNull null]) {
        urlLogoSite =@"";
    }
    self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlLogoSite]
                                                           onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                               if([urlLogoSite isEqualToString:[url absoluteString]]) {
                                                                   
                                                                   if (isInCache) {
                                                                       _logoSite.image = fetchedImage;
                                                                       //     [self hideActivityIndicator];
                                                                       
                                                                   } else {
                                                                       
                                                                       
                                                                       
                                                                       _logoSite.image = fetchedImage;
                                                                       _logoSite.alpha = 1;
                                                                       // [self hideActivityIndicator];
                                                                       
                                                                   }
                                                               }
                                                           }];

}
#pragma mark-------- action handle
-(void)commentClick:(id) sender{

}

-(void)boomarkClick:(id) sender{
    NSString   *sessionID=[[NSUserDefaults standardUserDefaults] objectForKey:@"EzineAccountSessionId"];

    if (!sessionID) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"bookmark" message:@"ban phai dang nhap de bookmark bai viet" delegate:self cancelButtonTitle:@"thoat" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        if (isbookmark) {
            UIImage *reloadIcon=[UIImage imageNamed:@"btn_bookmarkDetailArticle"];
            [_reload setImage:reloadIcon forState:UIControlStateNormal];
        }
        [XAppDelegate.serviceEngine userAddBookMarkArticleID:self._articleID onCompletion:^(NSDictionary* data) {
            NSLog(@"return==== %@",data);
            if (data) {
                BOOL isSuccess=[[data objectForKey:@"Success"] boolValue];
                if (isSuccess) {
                    UIImage *reloadIcon=[UIImage imageNamed:@"btn_bookmarkChoose"];
                    [_reload setImage:reloadIcon forState:UIControlStateNormal];
                    isbookmark=YES;
                }else{
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Bookmark" message:@"khong the bookmark bai viet, " delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
                    [alert show];
                    [alert release];
                }
                
            }
            
            
        } onError:^(NSError* error) {
        }];

    }
    
    
}

-(void)likeClick:(id) sender{
    
}

-(void)moveClick:(id) sender{
    
    actioncover=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Chia sẻ qua Facebook",@"Chia sẻ qua Google +",@"Chia sẻ qua Email",@"Chia sẻ qua tin nhắn",@"Đánh dấu yêu thích",@"Trang tin nổi bật",nil ];
    // actionsheet.tag=10;
       
    [actioncover showFromRect:_move.frame inView:self animated:YES];
    
    
}

#pragma mark--- 
-(void) reAdjustLayout:(UIInterfaceOrientation) interfaceOrientation{
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        if (_curentPage==1) {
            [self setFrame:CGRectMake(0, 1004-100, 768, 100)];
            [_logoSite setFrame:CGRectMake(20, 50, 40, 40)];
            [_titleFeed setFrame:CGRectMake(_logoSite.frame.origin.x+_logoSite.frame.size.width+10, _logoSite.frame.origin.y, 200, 25)];
            [_time_ago setFrame:CGRectMake(_titleFeed.frame.origin.x+10, _logoSite.frame.origin.y+20, 150, 25)];
            [_pageNumber setFrame:CGRectMake(self.frame.size.width-155, 10, 130, 25)];
            _pageNumber.textAlignment=UITextAlignmentRight;
            [_pageNumber setText:[NSString stringWithFormat:@"Trang %d của %d",_curentPage,_allpage]];
            [_line1 setFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
            [_line2 setFrame:CGRectMake(0, 40, self.frame.size.width,0.5 )];
            
            [_move setFrame:CGRectMake(self.frame.size.width-50, 60, 30, 30)];
            [_like setFrame:CGRectMake(_move.frame.origin.x-45, _move.frame.origin.y, _move.frame.size.width, _move.frame.size.height)];
            [_reload setFrame:CGRectMake(_move.frame.origin.x-45*2, _move.frame.origin.y, _move.frame.size.width-5, _move.frame.size.height-5)];
            [_comment setFrame:CGRectMake(_move.frame.origin.x-45*3, _move.frame.origin.y, _move.frame.size.width, _move.frame.size.height)];
            
        }else{
            [self setFrame:CGRectMake(0, 1004-60, 768, 60)];
            [_logoSite setFrame:CGRectMake(20, 10, 40, 40)];
            [_titleFeed setFrame:CGRectMake(_logoSite.frame.origin.x+_logoSite.frame.size.width+10, _logoSite.frame.origin.y, 100, 25)];
            [_time_ago setFrame:CGRectMake(_titleFeed.frame.origin.x+10, _logoSite.frame.origin.y+20, 150, 25)];
            [_pageNumber setFrame:CGRectMake(self.frame.size.width/2-130/2, 20, 130, 25)];
            _pageNumber.textAlignment=UITextAlignmentCenter;
            [_pageNumber setText:[NSString stringWithFormat:@"Trang %d của %d",_curentPage,_allpage]];
            [_line1 setFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
            [_line2 setFrame:CGRectMake(0, 0, self.frame.size.width,1 )];
            
            [_move setFrame:CGRectMake(self.frame.size.width-50, 20, 30, 30)];
            [_like setFrame:CGRectMake(_move.frame.origin.x-45, _move.frame.origin.y, _move.frame.size.width, _move.frame.size.height)];
           [_reload setFrame:CGRectMake(_move.frame.origin.x-45*2, _move.frame.origin.y, _move.frame.size.width-5, _move.frame.size.height-5)];
            [_comment setFrame:CGRectMake(_move.frame.origin.x-45*3, _move.frame.origin.y, _move.frame.size.width, _move.frame.size.height)];

        }

        
    }else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        if (_curentPage==1) {
            [self setFrame:CGRectMake(0, 748-100,1024, 100)];
            [_logoSite setFrame:CGRectMake(20, 50, 40, 40)];
            [_titleFeed setFrame:CGRectMake(_logoSite.frame.origin.x+_logoSite.frame.size.width+10, _logoSite.frame.origin.y, 200, 25)];
            [_time_ago setFrame:CGRectMake(_titleFeed.frame.origin.x+10, _logoSite.frame.origin.y+20, 150, 25)];
            [_pageNumber setFrame:CGRectMake(self.frame.size.width-155, 10, 130, 25)];
            _pageNumber.textAlignment=UITextAlignmentRight;
            [_pageNumber setText:[NSString stringWithFormat:@"Trang %d của %d",_curentPage,_allpage]];
            [_line1 setFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
            [_line2 setFrame:CGRectMake(0, 40, self.frame.size.width,0.5 )];
            
            [_move setFrame:CGRectMake(self.frame.size.width-50, 60, 30, 30)];
            [_like setFrame:CGRectMake(_move.frame.origin.x-45, _move.frame.origin.y, _move.frame.size.width, _move.frame.size.height)];
            [_reload setFrame:CGRectMake(_move.frame.origin.x-45*2, _move.frame.origin.y, _move.frame.size.width-5, _move.frame.size.height-5)];
            [_comment setFrame:CGRectMake(_move.frame.origin.x-45*3, _move.frame.origin.y, _move.frame.size.width, _move.frame.size.height)];

        }else{
            [self setFrame:CGRectMake(0, 748-60,1024, 60)];
            [_logoSite setFrame:CGRectMake(20, 10, 40, 40)];
            [_titleFeed setFrame:CGRectMake(_logoSite.frame.origin.x+_logoSite.frame.size.width+10, _logoSite.frame.origin.y, 100, 25)];
            [_time_ago setFrame:CGRectMake(_titleFeed.frame.origin.x+10, _logoSite.frame.origin.y+20, 100, 25)];
            [_pageNumber setFrame:CGRectMake(self.frame.size.width/2-130/2, 20, 130, 25)];
            _pageNumber.textAlignment=UITextAlignmentCenter;
            [_pageNumber setText:[NSString stringWithFormat:@"Trang %d của %d",_curentPage,_allpage]];
            [_line1 setFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
            [_line2 setFrame:CGRectMake(0, 0, self.frame.size.width,1 )];
            
            [_move setFrame:CGRectMake(self.frame.size.width-50, 20, 30, 30)];
            [_like setFrame:CGRectMake(_move.frame.origin.x-45, _move.frame.origin.y, _move.frame.size.width, _move.frame.size.height)];
            [_reload setFrame:CGRectMake(_move.frame.origin.x-45*2, _move.frame.origin.y, _move.frame.size.width-5, _move.frame.size.height-5)];
            [_comment setFrame:CGRectMake(_move.frame.origin.x-45*3, _move.frame.origin.y, _move.frame.size.width, _move.frame.size.height)];

        }
       
    }
}

#pragma mark========OK==========UIActionSheetDelagate==============
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   // int _currentCover=_curentPage;
    
        switch (buttonIndex) {
            case 0:
                [self shareFacebook];
                break;
            case 1:
                NSLog(@"Chia Google +");
                [self ShareViaGooglePlus];
                break;
            case 2:
                NSLog(@"Doc sau");
                if (self.delegate) {
                    [self.delegate shareEmail];
                }
                break;
            case 3:
                NSLog(@"Doc tren web");
                if (self.delegate) {
                    [self.delegate ReadBaseOnWeb];
                }
                break;
            case 4:
                NSLog(@"Danh dau khong phu hop");
                break;
            default:
                break;
        }
    
    
    
}


#pragma mark=====Share FaceBook======================

-(void)shareFacebook{
    
    // [self showActivityIndicator];
    [[SHKActivityIndicator currentIndicator] displayActivity:@"Bắt đầu share facebook"];
    FBFeedPost *post = [[FBFeedPost alloc] initWithLinkPath:@"http://pdg-technologies.com/" caption:@"Ipad apps"];
    [post publishPostWithDelegate:self];
    
}

-(void)ShareViaGooglePlus{
    
    share =[[[GooglePlusShare alloc] initWithClientID:kClientId] autorelease];
    share.delegate = self;
    
    [[[[share shareDialog]
       setURLToShare:[NSURL URLWithString:@""]]
      setPrefillText:@"Ezine"] open];
    
    // Or, without a URL or prefill text:
    // [[share shareDialog] open];
    
}

//-(void)shareTwitter{
//    
//    NSURL *url = [NSURL URLWithString:@"http://pdg-technologies.com"];
//	SHKItem *item = [SHKItem URL:url title:@"Follow Ezine to get the hotest news hahahahahahahahaha"];
//
//    [SHKTwitter shareItem:item];
//}

//-(void)ReadItLater{
//    
//    NSURL *url = [NSURL URLWithString:@"http://ezine.com.vm"];
//    SHKItem *item = [SHKItem URL:url title:@"Read it later"];
//    
//    // Share the item
//    [SHKReadItLater shareItem:item];
//}

#pragma mark -
#pragma mark FBFeedPostDelegate

- (void) failedToPublishPost:(FBFeedPost*) _post {
    NSLog(@"failedToPublishPost failedToPublishPost failedToPublishPost");
    //[self hideActivityIndicator];
	[_post release];
    // type=kUploadNone;
}

- (void) finishedPublishingPost:(FBFeedPost*) _post {
    //[self showNotificationOn:self.view withText:@"Successfully posted to facebook!"];
	[_post release];
    
}
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    // [self hideActivityIndicator];
    
    [[SHKActivityIndicator currentIndicator]displayCompleted:@"Lỗi share lên facebook"];
    
	NSLog(@"ResponseFailed: %@", error);
	
}

- (void)request:(FBRequest *)request didLoad:(id)result{
    // [self hideActivityIndicator];
    [[SHKActivityIndicator currentIndicator]displayCompleted:@"Đã share lên facebook"];
    NSLog(@"finishedPublishingPost 22222 22222");
}
- (void)request:(FBRequest *)request didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
}
#pragma mark facebook cancel
- (void)cancelFacebook{
    NSLog(@"cancel facebook");
    //[self hideActivityIndicator];
    [[SHKActivityIndicator currentIndicator]displayCompleted:@"Thoát"];

}

#pragma mark---ActivityIndicator

/*
 * This method shows the activity indicator and
 * deactivates the table to avoid user input.
 */
- (void)showActivityIndicator {
    if (![activityIndicator isAnimating]) {
        [activityIndicator startAnimating];
    }
}

/*
 * This method hides the activity indicator
 * and enables user interaction once more.
 */
- (void)hideActivityIndicator {
    
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    
}

-(BOOL)connected{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return !(networkStatus == NotReachable);
    
}

@end
