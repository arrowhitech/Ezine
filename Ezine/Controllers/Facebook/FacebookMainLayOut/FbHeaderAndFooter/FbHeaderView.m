
//
//  HeaderView.m
//  FlipView
//
//  Created by Reefaq Mohammed on 16/07/11.

//

#import "FbHeaderView.h"
#import "EzineAppDelegate.h"

@implementation FbHeaderView
@synthesize delegate;
@synthesize currrentInterfaceOrientation,wallTitleText;
@synthesize imgViewWedIcon;
@synthesize btnArticleType;
@synthesize _idSite;
@synthesize imageLoadingOperation,_islayout1,_isSearchAllSite;
@synthesize _namesite,numberArticle;

-(void)setAlpha:(CGFloat)alpha{
    self.alpha=alpha;
}

-(void)changeStyleHeader:(int) layoutId{
    if (layoutId==1) {
        _islayout1=YES;
        [self setBackgroundColor:[UIColor clearColor]];
        [self.btnArticleType setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        NSLog(@"olala");
        [ezineBtn setImage:[UIImage imageNamed:@"btn_EzineGray.png"] forState:UIControlStateNormal];
        //[themBtn setImage:[UIImage imageNamed:@"btn_addsiteGray.png"] forState:UIControlStateNormal];
        //[listBtn setImage:[UIImage imageNamed:@"btn_listDetailGray.png"] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.btnArticleType setTitleColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:0.3] forState:UIControlStateNormal];
        
    }
//    if (_idSite==-2) {
//        [themBtn setHidden:YES];
//        [listBtn setHidden:YES];
//    }
}
-(void)rotate:(UIInterfaceOrientation)interfaceOrientation animation:(BOOL)animation{
    currrentInterfaceOrientation = interfaceOrientation;
    if (currrentInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||currrentInterfaceOrientation==UIInterfaceOrientationLandscapeRight) {
        [self.btnArticleType setTitleColor:[UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:0.3] forState:UIControlStateNormal];
        [_lineImage setFrame:CGRectMake(10, 54, 1024-20, 1)];
        [self setBackgroundColor:[UIColor whiteColor]];
        //  [imgViewWedIcon setFrame:CGRectMake(listBtn.frame.origin.x+listBtn.frame.size.width+120, listBtn.frame.origin.y,45, 45)] ;
        
    }else if (currrentInterfaceOrientation==UIInterfaceOrientationPortrait||currrentInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown){
        if (_islayout1) {
            [self setBackgroundColor:[UIColor clearColor]];
            
        }
        //  [imgViewWedIcon setFrame:CGRectMake(listBtn.frame.origin.x+listBtn.frame.size.width+60, listBtn.frame.origin.y,45, 45)] ;
        [_lineImage setFrame:CGRectMake(10, 54, 768-20, 1)];
        
    }
    
}

-(void) setWallTitleText:(NSString *)wallTitle {
    [self setBackgroundColor:[UIColor whiteColor]];
	wallTitleText = wallTitle;
	
    _lineImage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 54, self.frame.size.width-20, 1)];
    [_lineImage setImage:[UIImage imageNamed:@"line-vertical.png"]];
    [self addSubview:_lineImage];
    
    // button controll
    ezineBtn = [[UIButton alloc] init];
    UIImage *ezineIcon=[UIImage imageNamed:@"btn_ezineClear"];
	[ezineBtn setImage:ezineIcon forState:UIControlStateNormal];
	[ezineBtn setFrame:CGRectMake(10,(56-ezineIcon.size.height)/2,ezineIcon.size.width,ezineIcon.size.height)];
    [ezineBtn addTarget:self action:@selector(ezineTouched:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:ezineBtn];
    
    //themBtn = [[UIButton alloc] init];
    //UIImage *themIcon=[UIImage imageNamed:@"btn_them"];
	//[themBtn setImage:themIcon forState:UIControlStateNormal];
	//[themBtn setFrame:CGRectMake(ezineBtn.frame.origin.x+ezineBtn.frame.size.width+5,(56-themIcon.size.height)/2,themIcon.size.width,themIcon.size.height)];
   // [themBtn addTarget:self action:@selector(themTouched:) forControlEvents:UIControlEventTouchUpInside];
	//[self addSubview:themBtn];
    
//    for (NSNumber * siteID in XAppDelegate.arrayIdSite){
//        if (self._idSite==[siteID integerValue]) {
//            [themBtn setHidden:YES];
//            break;
//        }
//    }
   // NSString    *keyword=[[NSUserDefaults standardUserDefaults] objectForKey:@"KEYWORDSEARCHALLSITE"];
//    if (keyword) {
//        [themBtn setHidden:NO];
//        isaddSiteFromKeyWord=YES;
//        _isSearchAllSite=YES;
//        
//        searchKeyword=[[UISearchBar alloc] init];
//        [searchKeyword setFrame:CGRectMake(125,17, 347,40)];
//        [searchKeyword setTintColor:[UIColor whiteColor]];
//        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0,searchKeyword.frame.size.height-1,searchKeyword.frame.size.width, 1)];
//        [bottomBorder setBackgroundColor:[UIColor whiteColor]];
//        [bottomBorder setOpaque:YES];
//        [bottomBorder setTag:SEARCHBAR_BORDER_TAG];
//        [searchKeyword addSubview:bottomBorder];
//        //[searchInformation setContentInset:UIEdgeInsetsMake(5, 0, 5, 35)];
//        UITextField* searchField = nil;
//        
//        for (UIView *searchBarSubview in [searchKeyword subviews]) {
//            if ([searchBarSubview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
//                [(UITextField *)searchBarSubview setBackground:[UIImage imageNamed:@"img_searchSite.png"]];
//                [(UITextField *)searchBarSubview setBackgroundColor:[UIColor clearColor]];
//                searchField = (UITextField*)searchBarSubview;
//                [searchField setTextAlignment:UITextAlignmentLeft];
//                searchField.textColor = [UIColor colorWithRed:63.0/255 green:177.0/255 blue:227.0/255 alpha:1.0];
//                [searchField setFont:[UIFont fontWithName:@"ArialMT" size:14]];
//                
//            }
//            
//        }
//        [bottomBorder release];
//        
//        [self addSubview:searchKeyword];
//        [searchKeyword setFrame:CGRectMake(themBtn.frame.origin.x+themBtn.frame.size.width+5,themBtn.frame.origin.y-2,327,42)];
//        searchKeyword.userInteractionEnabled=NO;
//        [searchKeyword setText:keyword];
//        for (UIView *subview in searchKeyword.subviews)
//        {
//            if ([subview conformsToProtocol:@protocol(UITextInputTraits)])
//            {
//                [(UITextField *)subview setClearButtonMode:UITextFieldViewModeWhileEditing];
//            }
//        }
//        numberArticle=[[UILabel alloc] init];
//        [numberArticle setBackgroundColor:[UIColor clearColor]];
//        [self addSubview:numberArticle];
//        numberArticle.font=[UIFont fontWithName:@"UVNHongHaHepBold" size:14];
//        numberArticle.textAlignment=UITextAlignmentLeft;
//        [numberArticle setFrame:CGRectMake(searchKeyword.frame.origin.x+searchKeyword.frame.size.width+10, themBtn.frame.origin.y+10, 60, 20)];
//        [numberArticle setTextColor:RGBCOLOR(175, 175, 175)];
//        
//        [numberArticle setText:[NSString stringWithFormat:@"Có %@ kết quả",wallTitle]];
//        NSLog(@"keyword===%@   total===%@",keyword,numberArticle.text);
//        [numberArticle sizeToFit];
//        numberArticle.numberOfLines=0;
//        
//    }else{
        //listBtn = [[UIButton alloc] init];
        //UIImage *listIcon=[UIImage imageNamed:@"btn_listClear"];
        //[listBtn setImage:listIcon forState:UIControlStateNormal];
       // [listBtn setFrame:CGRectMake(themBtn.frame.origin.x+themBtn.frame.size.width+5,(56-listIcon.size.height)/2,listIcon.size.width,listIcon.size.height)];
       // [listBtn setTag:_idSite];
       // [listBtn addTarget:self action:@selector(listTouched:) forControlEvents:UIControlEventTouchUpInside];
       // [self addSubview:listBtn];
   // }
    
    _namesite=[[UILabel alloc] init];
    [_namesite setBackgroundColor:[UIColor clearColor]];
    _namesite.font=[UIFont fontWithName:@"UVNHongHaHep" size:30];
    _namesite.textAlignment=UITextAlignmentLeft;
    _namesite.userInteractionEnabled=YES;
    [_namesite setTextColor:RGBCOLOR(99, 99, 99)];
    UITapGestureRecognizer *tapGesture1 = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap1:)] autorelease];
    [_namesite addGestureRecognizer:tapGesture1];
    [self addSubview:_namesite];
    
    
    btnArticleType =[[UIButton alloc]init];
    [btnArticleType setImage:[UIImage imageNamed:@"btn_showListArticleInHeader.png"] forState:UIControlStateNormal];
    [btnArticleType addTarget:self action:@selector(articleListType:) forControlEvents:UIControlEventTouchUpInside];
    [btnArticleType setTag:_idSite];
    //[self addSubview:btnArticleType];
    [self fetchedData:nil];
    
}

-(void)ezineTouched:(id) sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ezineButtonClicked:)]) {
        [self.delegate ezineButtonClicked:sender];
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"KEYWORDSEARCHALLSITE"];
    }
}

//-(void)themTouched:(id) sender{
//    if (isaddSiteFromKeyWord) {
//        [XAppDelegate.serviceEngine UserAddKeyWord:searchKeyword.text inSite:self._idSite onCompletion:^(NSDictionary* data) {
//            NSLog(@" data search==== %@",data);
//            XAppDelegate.isAddKeyword=YES;
//           // [themBtn setHidden:YES];
//            
//            
//        } onError:^(NSError* error) {
//            //            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"add keyword" message:@"service loi hoac server loi" delegate:self cancelButtonTitle:@"done" otherButtonTitles: nil];
//            //            [alert show];
//            //            [alert release];
//        }];
//    }else{
//        SourceModel *sourceToAdd = [[SourceModel alloc] initWithId:self._idSite image:@"addSite" title:_namesite.text isAddButton:NO isTop:NO articleList:nil];
//        [XAppDelegate._arrayAllSite insertObject:sourceToAdd atIndex:XAppDelegate._arrayAllSite.count-1];
//        [XAppDelegate.arrayIdSite addObject:[NSNumber numberWithInt:sourceToAdd.sourceId]];
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:XAppDelegate.arrayIdSite];
//        [defaults setObject:data forKey:@"IdAllSite"];
//        [defaults synchronize];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"KDidAddSiteNotification" object:self userInfo:nil];
//       // [themBtn setHidden:YES];
//        
//    }
//    
//}

-(void)listTouched:(id)sender{
//    NSLog(@"list touched");
//    if (self.delegate && [self.delegate respondsToSelector:@selector(listButtonClicked:)]) {
//        [self.delegate listButtonClicked:listBtn];
//    }
    
}

-(IBAction)articleListType:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showCategoryOfSource: inRect:)]) {
        [self.delegate showCategoryOfSource:btnArticleType inRect:_namesite.frame];
    }
    
    
}

-(void) dealloc {
	[wallTitleText release];
	[super dealloc];
}
#pragma mark-----
-(void)fetchedData:(NSDictionary *)data{
    
    NSString *nameSite=[[NSUserDefaults standardUserDefaults]objectForKey:@"nameProfile"];
    NSString *urlImage=[[NSUserDefaults standardUserDefaults] objectForKey:@"urlProfile"];
    imgViewWedIcon =[[UIImageView alloc]init];
    [imgViewWedIcon setFrame:CGRectMake(ezineBtn.frame.origin.x+ezineBtn.frame.size.width+250,(56-40)/2,46, 40)] ;
    EzineAppDelegate *appdelegate=(EzineAppDelegate*)[[UIApplication sharedApplication]delegate];
    if ((NSNull *)urlImage ==[NSNull null]) {
        urlImage =@"";
    }
    self.imageLoadingOperation = [appdelegate.serviceEngine imageAtURL:[NSURL URLWithString:urlImage]
                                                          onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                                                  
                                                                  if (isInCache) {
                                                                      imgViewWedIcon.image = fetchedImage;
                                                                  } else {
                                                                      UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
                                                                      loadedImageView.frame = imgViewWedIcon.frame;
                                                                      loadedImageView.alpha = 0;
                                                                      [loadedImageView removeFromSuperview];
                                                                      
                                                                      self.imgViewWedIcon.image = fetchedImage;
                                                                      self.imgViewWedIcon.alpha= 1;
                                                                  }
                                                              
                                                          }];
    
    imgViewWedIcon.contentMode=UIViewContentModeScaleToFill;
    [self addSubview:imgViewWedIcon];
    
    [_namesite setFrame:CGRectMake(imgViewWedIcon.frame.origin.x+imgViewWedIcon.frame.size.width+10,7,70,40)];
    [_namesite setText:nameSite];
    [_namesite sizeToFit];
    _namesite.numberOfLines=0;
    
    [self addSubview:btnArticleType];
    [btnArticleType setFrame:CGRectMake(_namesite.frame.origin.x+_namesite.frame.size.width+10, imgViewWedIcon.frame.origin.y+20, 14, 7)];
    nameSite =nil;
    
}

//-(void)checkSite{
//    if ([themBtn isHidden]) {
//        return;
//    }else{
//        if (isaddSiteFromKeyWord) {
//            if (XAppDelegate.isAddKeyword) {
//                [themBtn setHidden:YES];
//            }
//        }else{
//            for (NSNumber * siteID in XAppDelegate.arrayIdSite){
//                if (self._idSite==[siteID integerValue]) {
//                    [themBtn setHidden:YES];
//                    break;
//                }
//            }
//            
//        }
//    }
//}

-(void)labelTap1:(id)sender{
    NSLog(@"tap to name site");
    if (self.delegate && [self.delegate respondsToSelector:@selector(showCategoryOfSource: inRect:)]) {
        [self.delegate showCategoryOfSource:btnArticleType inRect:_namesite.frame];
    }
}
@end
