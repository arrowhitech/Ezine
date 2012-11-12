//
//  HeaderDetailArticle.m
//  Ezine
//
//  Created by MAC on 9/10/12.
//
//

#import "HeaderDetailArticle.h"

@implementation HeaderDetailArticle
@synthesize imageLoadingOperation,delegate;
@synthesize urlLogo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
-(void) setWallTitleText:(int )idSite {
    [self setBackgroundColor:[UIColor clearColor]];
	
    
    // button controll
    ezineBtn = [[UIButton alloc] init];
    UIImage *ezineIcon=[UIImage imageNamed:@"btn_EzineDetailArticle.png"];
	[ezineBtn setImage:ezineIcon forState:UIControlStateNormal];
	[ezineBtn setFrame:CGRectMake(10,(56-36)/2,80,36)];
    [ezineBtn addTarget:self action:@selector(ezineTouched:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:ezineBtn];
    
    listBtn = [[UIButton alloc] init];
    UIImage *themIcon=[UIImage imageNamed:@"btn_listDetailArticle.png"];
	[listBtn setImage:themIcon forState:UIControlStateNormal];
	[listBtn setFrame:CGRectMake(ezineBtn.frame.origin.x+ezineBtn.frame.size.width+15,(56-36)/2,63,36)];
    [listBtn addTarget:self action:@selector(listbtnTouch:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:listBtn];
    [listBtn setTag:idSite];
    
    _lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 56, self.frame.size.width-20, 1)];
    [_lineImage setImage:[UIImage imageNamed:@"line-vertical.png"]];
    [self addSubview:_lineImage];
//
    _logoSite=[[UIImageView alloc] initWithFrame:CGRectMake(300, 10, 40, 40)];
    [self addSubview:_logoSite];
    
    if (![self connected]) {
        NSString *urlLogoSite=[[NSUserDefaults standardUserDefaults] objectForKey:@"SiteLogoUrlofLine"];
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
        [XAppDelegate.serviceEngine getDetailAsite:idSite onCompletion:^(NSDictionary* data) {
            [self fetchedData:data];
            
        } onError:^(NSError* error) {
            //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not connect to service" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
            //        [alert show];
            //        [alert release];
        }];
        

    }
        
}
#pragma mark----


-(void)ezineTouched:(id) sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ezineButtonClicked:)]) {
        [self.delegate ezineButtonClicked:sender];
    }
}

-(void)listbtnTouch:(id) sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(listButtonClicked:)]) {
        [self.delegate listButtonClicked:listBtn];
    }
    
}
- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation{
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        [self setFrame:CGRectMake(0, 0, 768, 56)];
        _lineImage.frame= CGRectMake(10, 56, self.frame.size.width-20, 1);
        [_logoSite setFrame:CGRectMake(self.frame.size.width-80, 10, 40, 40)];
        
    }else if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft||interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        [self setFrame:CGRectMake(0, 0, 1024, 56)];
        _lineImage.frame= CGRectMake(10, 56, self.frame.size.width-20, 1);
        [_logoSite setFrame:CGRectMake(self.frame.size.width-80, 10, 40, 40)];

    }
}
#pragma mark---
-(void) fetchedData:(NSDictionary*)data{
    //NSLog(@"site detail=== %@",data);
    NSString *urlLogoSite=[data objectForKey:@"LogoUrl"];
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

-(BOOL)connected{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    return !(networkStatus == NotReachable);
    
}
@end
