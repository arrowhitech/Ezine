//
//  FBDetailViewController.m
//  Ezine
//
//  Created by MAC on 7/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBDetailViewController.h"
#import "FBPostCommentController.h"
#import "UIViewController+MJPopupViewController.h"
#import "FBlikeAndCommentViewcontroller.h"

@interface PhotosObject : NSObject
{
    NSString    *object_id;
    NSString    *urlPhotos;
}
@property (nonatomic, retain)    NSString    *object_id;
@property (nonatomic, retain)    NSString    *urlPhotos;

@end

@implementation PhotosObject
@synthesize object_id,urlPhotos;


@end


@interface FBDetailViewController ()

@end

@implementation FBDetailViewController
@synthesize detailTitle;
@synthesize nameUser;
@synthesize timeCreate;
@synthesize numberLike;
@synthesize titleFeed;
@synthesize shorttitleFeed;
@synthesize activityIndicator,imgMan;
@synthesize jsonFacebook,jsonFbFeed,currentApicall,fliper;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imgMan = [[[HJObjManager alloc] init] autorelease];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/imgtable/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
	self.imgMan.fileCache = fileCache;
    // add activityIndicator
    int xPosition = (self.view.bounds.size.width / 2.0) - 50;
    int yPosition = (self.view.bounds.size.height / 2.0) - 150.0;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 100, 100)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    arrayPhotos=[[NSMutableArray alloc] init];
    [self.view addSubview:activityIndicator];
    [self loaddetail];
    [self LoadDataOffFeed];
}

- (void)viewDidUnload
{
    [self setDetailTitle:nil];
    [self setNameUser:nil];
    [self setTitleFeed:nil];
    [self setTimeCreate:nil];
    [self setNumberLike:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}


-(void)convertTime:(int)timecreate{
    int minutes=timecreate/60;
    if (minutes>=60) {
        int hour=timecreate/3600;
        if (hour>=24) {
            int day=timecreate/(3600*24);
            [self.timeCreate setText:[NSString stringWithFormat:@"%d ngày trước",day]];

        }else {
            [self.timeCreate setText:[NSString stringWithFormat:@"%d giờ trước",hour]];

        }
    }else {
        [self.timeCreate setText:[NSString stringWithFormat:@"%d phút trước",minutes]];
    }
}
#pragma mark---

- (IBAction)btnEzineClick:(id)sender {
    [self.view.superview.superview removeFromSuperview];
}

#pragma mark--- load detail
-(void) loaddetail{
    NSLog(@"jsonFacebook url: %@",jsonFacebook.urlPicture);
    if (jsonFacebook.urlPicture) {
        NSString *urlImage=[[NSString alloc] initWithFormat:@"%@",jsonFacebook.urlPicture];
        urlImage=[urlImage stringByReplacingOccurrencesOfString:@"_s" withString:@"_n"];
        NSLog(@"jsonFacebook url: %@",urlImage);
        HJManagedImageV *ImagePark2=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 100, 740, 410)];
        ImagePark2.imageView.contentMode=UIViewContentModeScaleToFill;
        NSURL *url = [NSURL URLWithString:urlImage];
        ImagePark2.url = url;
        ImagePark2.oid =nil;
        [self.imgMan manage:ImagePark2];
        [self.view addSubview:ImagePark2];
        [self.detailTitle setText:jsonFacebook.title];
    }else {
        [titleFeed setFrame:CGRectMake(34, 64, 748, 200)];
        [titleFeed setNumberOfLines:20]; 
    }
       //[self.view addSubview:ImageFeed];
    
    HJManagedImageV *userFeedIcon=[[HJManagedImageV alloc]initWithFrame:CGRectMake(10, 960, 30, 30)];
    userFeedIcon.imageView.contentMode=UIViewContentModeScaleToFill;
    NSString *UrlIconFeed=[[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",jsonFacebook.idFeed];
    NSLog(@"UrlIconFeed:%@",UrlIconFeed);
    NSURL *url = [NSURL URLWithString:UrlIconFeed];
    userFeedIcon.url = url;
    userFeedIcon.oid =nil;
    [self.imgMan manage:userFeedIcon];
    [self.view addSubview:userFeedIcon];

    [self.titleFeed setText:jsonFacebook.title];
    [titleFeed removeFromSuperview];
    [self.view addSubview:titleFeed];
    [self.nameUser setText:jsonFacebook.nameProlife];
    [self.shorttitleFeed setText:jsonFacebook.title];
    if (jsonFacebook.userLike) {
        NSString *userlike1=[[NSString alloc] initWithFormat:@"%@ và %d người đã thích",jsonFacebook.userLike,jsonFacebook.numberUserLike];
        [self.numberLike setText:userlike1];

    }else {
        NSString *userlike1=[[NSString alloc] initWithFormat:@"%d người đã thích",jsonFacebook.numberUserLike];
        [self.numberLike setText:userlike1];

    }
    //like button
    NSLog(@"link like: %@",jsonFacebook.linkLikeFeed);
    FBLikeButton *likeButton = [[FBLikeButton alloc] initWithFrame:CGRectMake(400, 956, 320, 30)
                                                            andUrl:@"http://news.ezine.vn/Article/Details/12871" andStyle:FBLikeButtonStyleButtonCount andColor:FBLikeButtonColorLight];
     
    [self.view addSubview:likeButton];
    
    int time=[[NSDate date] timeIntervalSince1970];
    NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
    //2010-12-01T21:35:43+0000  
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZZ"];
    NSDate *date = [df dateFromString:[jsonFacebook.dateCreate stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
    int timecreateIs=time-[date timeIntervalSince1970];
    NSLog(@"time:%d   %@     %@",timecreateIs,date,[NSDate date] );
    [self convertTime:timecreateIs];
    
}
- (void)dealloc {
    [titleFeed release];
    [detailTitle release];
    [nameUser release];
    [titleFeed release];
    [timeCreate release];
    [numberLike release];
    [super dealloc];
}
#pragma mark---
- (void)embedYouTube:(NSString*)url frame:(CGRect)frame {  
    NSString *embedHTML = @"\
    <html><head>\
	<style type=\"text/css\">\
	body {\
	background-color: transparent;\
	color: white;\
	}\
	</style>\
	</head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
	width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    NSString* html = [NSString stringWithFormat:embedHTML, url, frame.size.width, frame.size.height];  
      
       UIWebView* videoView = [[UIWebView alloc] initWithFrame:frame];  
        [self.view addSubview:videoView];  
     
    [videoView loadHTMLString:html baseURL:nil];  
}  


-(void)DataOffNewFeed{
    if ([jsonFbFeed.type isEqualToString:@"link"]) {
        [self.detailTitle setText:jsonFbFeed.description];
        CGRect FrameVideo = CGRectMake(160, 160, 448, 350);
        [self embedYouTube:jsonFbFeed.link frame:FrameVideo];
        NSLog(@"link : %@",jsonFbFeed.link);
        
    }else if ([jsonFbFeed.type isEqual:@"status"]) {
        [self.detailTitle setText:jsonFbFeed.message];
        NSLog(@"status");
        
    }else if([jsonFbFeed.type isEqualToString:@"video"]){
        NSLog(@"VIIII DDD EEEE OOOO");
        NSString *urlImage=[[NSString alloc] initWithFormat:@"%@",jsonFbFeed.picture];
        urlImage=[urlImage stringByReplacingOccurrencesOfString:@"_s" withString:@"_n"];
        
        ImageCenter=[[HJManagedImageV alloc]initWithFrame:CGRectMake(279, 150, 210, 210)];
        //ImageCenter.imageView.contentMode=UIViewContentModeScaleToFill;
        NSURL *url = [NSURL URLWithString:urlImage];
        ImageCenter.url = url;
        ImageCenter.oid =nil;
        [self.imgMan manage:ImageCenter];
        [self.view addSubview:ImageCenter];
        [self.detailTitle setText:jsonFbFeed.description];
        [self.titleFeed setText:jsonFbFeed.story];
        [self.view bringSubviewToFront:self.titleFeed];
               
    }else{
        NSLog(@"photos");
        NSArray *arrayOFPhotos=[jsonFbFeed.link componentsSeparatedByString:@"&"];
        NSString * numberPhotos = [arrayOFPhotos lastObject];
        numberPhotos=[numberPhotos stringByReplacingOccurrencesOfString:@"relevant_count=" withString:@""];
        if ([numberPhotos intValue]>1) {
            NSString    *idAlbums=[arrayOFPhotos objectAtIndex:1];
            idAlbums=[idAlbums stringByReplacingOccurrencesOfString:@"set=a." withString:@""];
            NSArray *arrayPhoto=[idAlbums componentsSeparatedByString:@"."];
            idAlbums=[arrayPhoto objectAtIndex:0];
            NSLog(@"idAlbums");
            NSString *queryKey=[[NSString alloc] initWithFormat:@"SELECT object_id, src_big, caption FROM photo WHERE album_object_id = %@",idAlbums];
            NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            queryKey, @"query",
                                            nil];
            
            [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"fql.query"
                                                                      andParams:params1
                                                                  andHttpMethod:@"POST"
                                                                    andDelegate:self];
            

        }else {
            NSString *urlImage=[[NSString alloc] initWithFormat:@"%@",jsonFbFeed.picture];
            urlImage=[urlImage stringByReplacingOccurrencesOfString:@"_s" withString:@"_n"];
            NSLog(@"urlImage= %@",urlImage);
            ImageCenter=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 100, 740, 410)];
            ImageCenter.imageView.contentMode=UIViewContentModeBottom;
            NSURL *url = [NSURL URLWithString:urlImage];
            ImageCenter.url = url;
            ImageCenter.oid =nil;
            [ImageCenter.imageView setUserInteractionEnabled:YES];
            [self.imgMan manage:ImageCenter];
            [self.view addSubview:ImageCenter];
            [self.detailTitle setText:jsonFbFeed.message];
            [self.titleFeed setText:jsonFbFeed.message];
            [self.view bringSubviewToFront:self.titleFeed];
            
        }
       
    }
}

-(void) LoadDataOffFeed{
    if (currentApiCall==kAPIUserFriendsList) {
        
    }else {
        [self DataOffNewFeed];
        NSString    *idCreater=[[NSString alloc] initWithFormat:@"%@",[jsonFbFeed.from objectForKey:@"id"]];
        HJManagedImageV *userFeedIcon=[[HJManagedImageV alloc]initWithFrame:CGRectMake(10, 960, 30, 30)];
        userFeedIcon.imageView.contentMode=UIViewContentModeScaleToFill;
        NSString *UrlIconFeed=[[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",idCreater];
        NSLog(@"UrlIconFeed:%@",UrlIconFeed);
        NSURL *url = [NSURL URLWithString:UrlIconFeed];
        userFeedIcon.url = url;
        userFeedIcon.oid =nil;
        [self.imgMan manage:userFeedIcon];
        [self.view addSubview:userFeedIcon];
        
        [self.nameUser setText:[jsonFbFeed.from objectForKey:@"name"]];
        [self.shorttitleFeed setText:jsonFbFeed.message];
        //like and numberlike    
        int countLike=[[jsonFbFeed.likes objectForKey:@"count"] intValue];
        if (countLike>0) {
            NSArray *ArrayDataLike=[jsonFbFeed.likes objectForKey:@"data"];
            NSDictionary *likes=[ArrayDataLike objectAtIndex:0];
            NSString *userlike1=[[NSString alloc] initWithFormat:@"%@ và %d người đã thích",[likes objectForKey:@"name"],countLike];
            [self.numberLike setText:userlike1];
            
        }else {
            [self.numberLike setText:@"0 người đã thích"];
            
        }
        
        
        int time=[[NSDate date] timeIntervalSince1970];
        NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
        //2010-12-01T21:35:43+0000  
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ssZZZZ"];
        NSDate *date = [df dateFromString:[jsonFbFeed.create_time stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
        int timecreateIs=time-[date timeIntervalSince1970];
        NSLog(@"time:%d   %@     %@",timecreateIs,date,[NSDate date] );
        [self convertTime:timecreateIs];
        

    }   
        
}


#pragma mark--- action handle
- (IBAction)btnComment:(id)sender {
//    NSString *idObject=[[NSString alloc] initWithFormat:@"%@",[jsonFbFeed.from objectForKey:@"id"]];
//    NSLog(@"object id= %@",idObject);
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Test comment from ios app", @"text",jsonFbFeed.object_id, @"object_id",nil];
//    [[[FBRequestWrapper defaultManager] facebook] requestWithMethodName:@"comments.add" andParams:params andHttpMethod:@"POST" andDelegate:self];
    FBPostCommentController *postComment=[[FBPostCommentController alloc] initWithNibName:@"FBPostCommentController" bundle:nil];
    [self.view addSubview:postComment.view];
    postComment.jsonFbFeed=self.jsonFbFeed;
    [postComment.view setFrame:CGRectMake(0, 1024, 768,1024)];
    [postComment showIn];
    //[self.view setFrame: CGRectMake(0, -745, 768, 1024)];
}

- (IBAction)btnLikeClick:(id)sender {
//    FBlikeAndCommentViewcontroller *fblikeandcommnet=[[FBlikeAndCommentViewcontroller alloc] initWithNibName:@"FBlikeAndCommentViewcontroller" bundle:nil];
//    [self.view addSubview:fblikeandcommnet.view];
//    fblikeandcommnet.jsonFbFeed=self.jsonFbFeed;
//    [fblikeandcommnet.view setFrame:CGRectMake(0, 1024, 768,1024)];
//    [fblikeandcommnet showIn];

}
#pragma mark---- 
#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    
	NSLog(@"ResponseFailed: %@", error);
	
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"request finish :%@",result);
    for (int i=0; i<[result count]; i++) {
        NSDictionary *loan=[result objectAtIndex:i];
        PhotosObject *photoObject=[[PhotosObject alloc] init];
        photoObject.object_id=[loan objectForKey:@"object_id"];
        photoObject.urlPhotos=[loan objectForKey:@"src_big"];
        [arrayPhotos addObject:photoObject];
    }
    if ([arrayPhotos count]>2) {
        PhotosObject *photo1=[arrayPhotos objectAtIndex:0];
        PhotosObject *photo2=[arrayPhotos objectAtIndex:1];
        PhotosObject *photo3=[arrayPhotos objectAtIndex:2];
        
        ImageCenter=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 100, 740, 410)];
        ImageCenter.imageView.contentMode=UIViewContentModeBottom;
        NSURL *url1 = [NSURL URLWithString:photo1.urlPhotos];
        ImageCenter.url = url1;
        ImageCenter.oid =nil;
        [self.imgMan manage:ImageCenter];
        [self.view addSubview:ImageCenter];
        
        HJManagedImageV *leftImage=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 550, 300,300)];
        leftImage.imageView.contentMode=UIViewContentModeBottom;
        NSURL *url2 = [NSURL URLWithString:photo2.urlPhotos];
        leftImage.url = url2;
        leftImage.oid =nil;
        [self.imgMan manage:leftImage];
        [self.view addSubview:leftImage];
        
        HJManagedImageV *rightImage=[[HJManagedImageV alloc]initWithFrame:CGRectMake(400, 550, 300,300)];
        rightImage.imageView.contentMode=UIViewContentModeBottom;
        NSURL *url3 = [NSURL URLWithString:photo3.urlPhotos];
        rightImage.url = url3;
        rightImage.oid =nil;
        [self.imgMan manage:rightImage];
        [self.view addSubview:rightImage];


    }else {
        PhotosObject *photo1=[arrayPhotos objectAtIndex:0];
        PhotosObject *photo2=[arrayPhotos objectAtIndex:1];
        
        ImageCenter=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 100, 740, 410)];
        ImageCenter.imageView.contentMode=UIViewContentModeBottom;
        NSURL *url1 = [NSURL URLWithString:photo1.urlPhotos];
        ImageCenter.url = url1;
        ImageCenter.oid =nil;
        [self.imgMan manage:ImageCenter];
        [self.view addSubview:ImageCenter];
        
        HJManagedImageV *leftImage=[[HJManagedImageV alloc]initWithFrame:CGRectMake(15, 600, 740,410)];
        leftImage.imageView.contentMode=UIViewContentModeBottom;
        NSURL *url2 = [NSURL URLWithString:photo2.urlPhotos];
        leftImage.url = url2;
        leftImage.oid =nil;
        [self.imgMan manage:leftImage];
        [self.view addSubview:leftImage];
    }
}

@end
