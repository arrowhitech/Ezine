//
//  FacebookViewArticle1.m
//  Ezine
//
//  Created by MAC on 10/15/12.
//
//

#import "FacebookViewArticle1.h"

@implementation FacebookViewArticle1
@synthesize itemModel;
@synthesize imageLoadingOperation;
@synthesize _idLayout;
@synthesize _type,idActorPost;

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
        self._type=itemModel.type;
        self.idActorPost=itemModel.actor_id;
        urlImage=@"";
        //test
        
        //====
		[self initializeFields];
		
		UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[self addGestureRecognizer:tapRecognizer];
		[tapRecognizer release];
        
        
	}
	return self;
    
}

#pragma mark--- create view
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

- (void) initializeFields {
    NSLog(@"initialize item 2");
    
	contentView = [[UIView alloc] init];
	[contentView setBackgroundColor:[UIColor whiteColor]];
	contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView = [[UIImageView alloc] init];
    
    [contentView addSubview:imageView];
    
    extraTitle =[[UILabel alloc]init];
    [extraTitle setText:@""];
    extraTitle.font =[UIFont fontWithName:@"UVNHongHaHep" size:18+XAppDelegate.appFontSize];
    extraTitle.textAlignment = UITextAlignmentCenter;
    [extraTitle setTextColor:RGBCOLOR(111, 111, 111)];
    [extraTitle setBackgroundColor:[UIColor redColor]];
    [contentView addSubview:extraTitle];
    //=== name actor
    nameActor=[[UILabel alloc] init];
    nameActor.font =[UIFont fontWithName:@"UVNHongHaHepBold" size:14];
    nameActor.textAlignment = UITextAlignmentLeft;
    [nameActor setTextColor:[UIColor whiteColor]];
    [nameActor setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:nameActor];
    
    
    imageIconView =[[UIImageView alloc]init];
    
    NSString *urlicon=[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",idActorPost];
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
    
    // [imageIconView setImage:[UIImage imageNamed:itemModel.icon]];
    [contentView addSubview:imageIconView];
    title = [[UILabel alloc] init];
    //    NSString *title1 = @"";
    //
    //	[title setText:[NSString stringWithFormat:@"%@",[title1 stringByConvertingHTMLToPlainText]]];
    title.font =[UIFont fontWithName:@"UVNHongHaHep" size:21.12];
	[title setTextColor:[UIColor whiteColor]];
	[title setBackgroundColor:[UIColor clearColor]];
    title.numberOfLines=0;
    [title sizeToFit];
    title.shadowColor = [UIColor whiteColor];
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
    int commentcount=[[itemModel.comments objectForKey:@"count"] integerValue];
    [time_ago setText:[NSString stringWithFormat:@"%@ - %d bình luận",time_ago.text,commentcount]];
	time_ago.font =[UIFont fontWithName:@"UVNHongHaHep" size:14];
	[time_ago setTextColor:[UIColor whiteColor]];
	[time_ago setBackgroundColor:[UIColor clearColor]];
    time_ago.textAlignment=UITextAlignmentLeft;
    [contentView addSubview:time_ago];
    
    // comment
    [contentView addSubview:time_ago];
    
    text_content = [[OHAttributedLabel alloc] init];
    [text_content setBackgroundColor:[UIColor clearColor]];
	text_content.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:17+XAppDelegate.appFontSize];
	text_content.textColor =  RGBCOLOR(33,33,33);
    NSArray *media=[self.itemModel.attachment objectForKey:@"media"];
    if (media&&media.count>=1) {
        NSDictionary *dataImage=[media objectAtIndex:0];
        NSString *src=[dataImage objectForKey:@"src"];
        urlImage=[src stringByReplacingOccurrencesOfString:@"_s" withString:@"_n"];
        
        NSLog(@"url image===%@",urlImage);
        self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlImage]
                                                               onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                   
                                                                   
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
                                                                   
                                                               }];
        
    }
    
    text_content.text=itemModel.message;
	[contentView addSubview:text_content];
    
	[self addSubview:contentView];
	[self getdetailActorId];
}


#pragma mark-------
- (void)reAdjustLayout:(UIInterfaceOrientation)interfaceOrientation{
    if (interfaceOrientation ==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"idlayout ======%d",self._idLayout);
        
        [contentView setFrame:CGRectMake(1, 1, self.frame.size.width-0.5, self.frame.size.height-0.5)];
        
        CGSize contentViewArea = CGSizeMake((contentView.frame.size.width - 10), (contentView.frame.size.height-10));
        
        
        switch (self._type) {
            case 247:
            case 80:
            case 127:
                NSLog(@"attact ment===%@",itemModel.attachment);
                [imageView setFrame:CGRectMake(20,20,contentViewArea.width-30,336)];
                [title setText:[itemModel.attachment objectForKey:@"name"] ];
                [title setFrame:CGRectMake(15,contentView.frame.size.height/2, contentViewArea.width-10, 40)];
                title.numberOfLines=0;
                [title sizeToFit];
                [title setFrame:CGRectMake(40,imageView.frame.size.height+imageView.frame.origin.y-title.frame.size.height-80, title.frame.size.width,title.frame.size.height)];
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+10 , 30, 30)];
                
                [nameActor setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, contentView.frame.size.width-imageIconView.frame.size.width-25, 20)];
                nameActor.numberOfLines=0;
                [nameActor sizeToFit];
                [time_ago setFrame:CGRectMake(nameActor.frame.origin.x,nameActor.frame.origin.y+nameActor.frame.size.height+2,contentViewArea.width , 20)];
                [text_content setFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.size.height+imageView.frame.origin.y+10, contentViewArea.width-30, contentViewArea.height-imageView.frame.size.height-imageView.frame.origin.y-20)];
                [text_content setText:text_content.text];
                text_content= [self resetAlighLabel:text_content];
                
                break;
                
            default:
                [imageView setFrame:CGRectMake(10, 10, 10, 10)];
                
                [title setFrame:CGRectMake(15,contentView.frame.size.height*5/7, contentViewArea.width-10, 40)];
                title.numberOfLines=0;
                [title sizeToFit];
                
                [imageIconView setFrame:CGRectMake(title.frame.origin.x,title.frame.origin.y+title.frame.size.height+10 , 30, 30)];
                
                [titleFeed sizeToFit];
                [titleFeed setFrame:CGRectMake(imageIconView.frame.origin.x+imageIconView.frame.size.width+5, imageIconView.frame.origin.y-5, title.frame.size.width-imageIconView.frame.size.width-5, 20)];
                
                [time_ago sizeToFit];
                [time_ago setFrame:CGRectMake(titleFeed.frame.origin.x,titleFeed.frame.origin.y+titleFeed.frame.size.height+2,titleFeed.frame.size.width , titleFeed.frame.size.height)];
                
                [text_content setFrame:CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y+imageView.frame.size.height+5, contentViewArea.width-20, contentViewArea.height-imageView.frame.origin.y-imageView.frame.size.height-30)];
                NSString *content =itemModel.message;
                [text_content setText:[content stringByConvertingHTMLToPlainText]];
                
                text_content= [self resetAlighLabel:text_content];
                break;
        }
        
        
        
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
	NSLog(@"Parsed Response FBRequest: %@", result);
    if (result) {
        // NSDictionary *dataActor=[result objectAtIndex:0];
        
        NSString *name=[result objectForKey:@"name"];
        name=[name stringByConvertingHTMLToPlainText];
        nameActor.text=[NSString stringWithFormat:@"chia sẻ bởi %@",name];
        [self reAdjustLayout:UIInterfaceOrientationPortrait];
        
    }
    
    
    
}

#pragma mark--- tapped
-(void)tapped:(id)sender{
    
}

#pragma mark--- load image rotate
-(void)LoadImage:(UIInterfaceOrientation)interfaceOrientation{
    
    if ((NSNull *)urlImage==[NSNull null]) {
        urlImage =@"";
    }
    self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlImage]
                                                           onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                               if([urlImage isEqualToString:[url absoluteString]]) {
                                                                   
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
    
    
}

@end
