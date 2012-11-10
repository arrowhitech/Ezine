//
//  FacebookViewArticle3.m
//  Ezine
//
//  Created by MAC on 10/15/12.
//
//

#import "FacebookViewArticle3.h"

@implementation FacebookViewArticle3
@synthesize itemModel;
@synthesize imageLoadingOperation;
@synthesize _idLayout,idActorPost;


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
- (id) initWithMessageModel:(FBObjectModel*) _itemModel andViewoder:(NSInteger)oderview{
    if (self = [super init]) {
        
		self.itemModel =_itemModel;
        self.Viewoder = oderview;
        self._idLayout =1;
        self.idActorPost=itemModel.actor_id;

        //test
        
        //====
		[self initializeFields];
		
		UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[self addGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
        
        
	}
	return self;
    
}
#pragma mark--- get detail actor
-(void)getdetailActorId{
    NSString *graphPath=[NSString stringWithFormat:@"%@?fields=name",self.idActorPost];
    NSLog(@"detail Actor");
    BOOL loggedIn = [[FBRequestWrapper defaultManager] isLoggedIn];
    if (loggedIn) {
//        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                        graphPath, @"query",
//                                        nil];
        
        [[[FBRequestWrapper defaultManager] facebook] requestWithGraphPath:graphPath andDelegate:self];


    }

    
}
#pragma mark--- create view
- (void) initializeFields {
    if (self.itemModel==nil) {
        return;
    }
	contentView = [[UIView alloc] init];
	[contentView setBackgroundColor:[UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1.0]];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    extraTitle =[[UILabel alloc]init];
    [extraTitle setText:@""];
    extraTitle.font =[UIFont fontWithName:@"UVNHongHaHep" size:18+XAppDelegate.appFontSize];
    extraTitle.textAlignment = UITextAlignmentCenter;
    [extraTitle setTextColor:RGBCOLOR(111, 111, 111)];
    [extraTitle setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:extraTitle];
    //=== name actor
    nameActor=[[UILabel alloc] init];
    nameActor.font =[UIFont fontWithName:@"UVNHongHaHepBold" size:18+XAppDelegate.appFontSize];
    nameActor.textAlignment = UITextAlignmentLeft;
    [nameActor setTextColor:[UIColor blackColor]];
    [nameActor setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:nameActor];
    
    //====  
    
    
	imageView = [[UIImageView alloc] init];
  
    NSString *urlicon=[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",idActorPost];
    if ((NSNull *)urlicon==[NSNull null]) {
        urlicon =@"";
    }
  
    [contentView addSubview:imageView];
    
    imageIconView =[[UIImageView alloc]init];
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
    // [imageIconView setImage:[UIImage imageNamed:itemModel.icon]];
    [contentView addSubview:imageIconView];
    title = [[UILabel alloc] init];
    NSString *title1 = @"";
    
	[title setText:[NSString stringWithFormat:@"%@",[title1 stringByConvertingHTMLToPlainText]]];
    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:21.12+XAppDelegate.appFontSize];
	[title setTextColor:RGBCOLOR(55,55,55)];
	[title setBackgroundColor:[UIColor clearColor]];
    title.numberOfLines=0;
    [title sizeToFit];
    title.shadowColor = [UIColor blackColor];
    title.shadowOffset = CGSizeMake(0, 1);
	[contentView addSubview:title];
    
    titleFeed =[[UILabel alloc]init];
    [titleFeed setText:@""];
    titleFeed.font =[UIFont fontWithName:@"UVNHongHaHep" size:15.36+XAppDelegate.appFontSize];
    [titleFeed setBackgroundColor:[UIColor clearColor]];
    titleFeed.textColor =  RGBCOLOR(33,33,33);
	titleFeed.highlightedTextColor = RGBCOLOR(33,33,33);
    
    [contentView addSubview:titleFeed];
    //	titleFeed.shadowColor = [UIColor blackColor];
    //    titleFeed.shadowOffset = CGSizeMake(0, 1);
    
	
	time_ago = [[UILabel alloc] init];
	[time_ago setText:[Utils dateStringFromTimeNumber:itemModel.created_time]];
	time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:14];
	[time_ago setTextColor:RGBCOLOR(182, 182, 182)];
	[time_ago setBackgroundColor:[UIColor clearColor]];
    time_ago.textAlignment=UITextAlignmentRight;
    [contentView addSubview:time_ago];
    // comment
    numbercomment = [[UILabel alloc] init];
    int commentcount=[[itemModel.comments objectForKey:@"count"] integerValue];
	[numbercomment setText:[NSString stringWithFormat:@"%d Bình luận",commentcount]];
	numbercomment.font =[UIFont fontWithName:@"UVNHongHaHep" size:14];
	[numbercomment setTextColor:RGBCOLOR(182, 182, 182)];
	[numbercomment setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:numbercomment];
    // likes
    numberLike = [[UILabel alloc] init];
    int likescount=[[itemModel.likes objectForKey:@"count"] integerValue];
	[numberLike setText:[NSString stringWithFormat:@"%d Yêu thích",likescount]];
	numberLike.font =[UIFont fontWithName:@"UVNHongHaHep" size:14];
	[numberLike setTextColor:RGBCOLOR(182, 182, 182)];
	[numberLike setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:numberLike];

    

    
    
    text_content = [[OHAttributedLabel alloc] init];
    [text_content setBackgroundColor:[UIColor clearColor]];
	text_content.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:17+XAppDelegate.appFontSize];
	text_content.textColor =  RGBCOLOR(33,33,33);
	//text_content.highlightedTextColor = RGBCOLOR(33,33,33);
	//text_content.contentMode = UIViewContentModeTop;
    //	text_content.textAlignment = UITextAlignmentLeft;
    //    [text_content setNumberOfLines:0];
    //    [text_content sizeToFit];
    
    
	[contentView addSubview:text_content];
    
	[self addSubview:contentView];
	[self getdetailActorId];
}


#pragma mark-------
- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation{
    //[self LoadImage:interfaceOrientation];
    if (interfaceOrientation ==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"idlayout ======%d",self._idLayout);
        
    
        [contentView setFrame:CGRectMake(1, 0, self.frame.size.width-0.5, self.frame.size.height)];
        
        CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
        
        [imageIconView setFrame:CGRectMake(10, 10, 30, 30)];
        
        [nameActor setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+10,imageIconView.frame.origin.y, contentViewArea.width-120, 20)];
        nameActor.numberOfLines=0;
        [nameActor sizeToFit];
        [time_ago setFrame:CGRectMake(contentViewArea.width-100,nameActor.frame.origin.y,100, 20)];
        
        [numberLike setFrame:CGRectMake(imageIconView.frame.origin.x,contentViewArea.height-15,100, 20)];
        //numberLike.text=@"2 Yêu thích";
       
        [numbercomment setFrame:CGRectMake(numberLike.frame.origin.x+110,contentViewArea.height-15,100, 20)];
        //numbercomment.text=@"2 Bình luận";
        
        [text_content setFrame:CGRectMake(imageIconView.frame.origin.x,nameActor.frame.origin.y+nameActor.frame.size.height+10, contentViewArea.width-10, contentViewArea.height-nameActor.frame.origin.y-nameActor.frame.size.height-30)];
        NSString *content =itemModel.message;
        [text_content setText:[content stringByConvertingHTMLToPlainText]];
        
        text_content= [self resetAlighLabel:text_content];
        
        
    }else if(interfaceOrientation ==UIInterfaceOrientationLandscapeLeft|| interfaceOrientation== UIInterfaceOrientationLandscapeRight){
        //[self changeLandScape];
    }
}


#pragma mark FBRequestDelegate

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSLog(@"ResponseFailed: %@", error);
	}

- (void)request:(FBRequest *)request didLoad:(id)result {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	//NSLog(@"Parsed Response FBRequest: %@", result);
    if (result) {
       // NSDictionary *dataActor=[result objectAtIndex:0];
        
        NSString *name=[result objectForKey:@"name"];
        name=[name stringByConvertingHTMLToPlainText];
        nameActor.text=name;
        [self reAdjustLayout:UIInterfaceOrientationPortrait];

    }
   
    

   }

#pragma mark--- tapped
-(void)tapped:(id)sender{
    
}
@end
