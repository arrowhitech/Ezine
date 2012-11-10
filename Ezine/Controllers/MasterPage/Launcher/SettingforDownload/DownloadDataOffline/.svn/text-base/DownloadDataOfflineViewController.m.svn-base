//
//  DownloadDataOfflineViewController.m
//  Ezine
//
//  Created by MAC on 11/1/12.
//
//

#import "DownloadDataOfflineViewController.h"
#import "SiteDownloadModel.h"

@interface DownloadDataOfflineViewController ()

@end

@implementation DownloadDataOfflineViewController
@synthesize tableviewDownload;
@synthesize arrayListIDforDownload;
@synthesize imageLoadingOperation;
//@synthesize timer;

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
    [self setTitle:@"Download nguồn tin offline"];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Thoát"
                                                                    style:UIBarButtonSystemItemDone target:self action:@selector(btnCancelClicked:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
//    for (int i = 0; i<[arrayListIDforDownload count] ;i++) {
//        SiteDownloadModel* site =[arrayListIDforDownload objectAtIndex:i];
//        NSLog(@"siteOBJ===%d",site.siteID);
//        [XAppDelegate.serviceEngine downloadDataOfflineSite:site.siteID reload:NO onCompletion:^(NSDictionary *responseDict) {
//            
//            // NSLog(@"data%@",responseDict);
//            
//            [self  loaddatadidfinish:responseDict];
//            
//        } onError:^(NSError *error) {
//            
//            
//        }];
//
//    }

        
    [super viewDidLoad];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight||toInterfaceOrientation==UIInterfaceOrientationPortrait||toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ====TableViewdelegate=========OK======

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
   // int numofRow =0;
    return [arrayListIDforDownload count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
           
    
    int row = indexPath.row;
    int section = indexPath.section;
    
         NSString *CellIdentifier = [NSString stringWithFormat:@"CustomTableCellSlider%d%d",section,row];
        static NSString *CellNib = @"DownloadDataOfflineCell";
        
        cellDownloadOffline = (DownloadDataOfflineCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
           if (cellDownloadOffline==nil) {
               
               NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
               for(id currentObject in topLevelObjects){
                   if([currentObject isKindOfClass:[UITableViewCell class]]){
                       cellDownloadOffline = (DownloadDataOfflineCell *) currentObject;
                       break;
                   }
               }

//            NSArray *topLevelObject=[[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
//           
//            cellDownloadOffline = (DownloadDataOfflineCell *)[topLevelObject objectAtIndex:0];
            
            
                SiteDownloadModel *source=[arrayListIDforDownload objectAtIndex:indexPath.row];
                [cellDownloadOffline.titleName setText:source.nameSite];
               cellDownloadOffline.siteDownloadID =source.siteID;
               
               [cellDownloadOffline download];
          //  cellDownloadOffline.sliderpercentCell.progress=0.0;
           // [self performSelectorOnMainThread:@selector(makeMyProgressBarMoving) withObject:nil waitUntilDone:YES];
            }
            
            
        
        return cellDownloadOffline;
        
} 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section]==1) {
        return 50;
    }else {
        return 47;
    }
}

-(void)dealloc{
    
    [tableviewDownload release];
    [cellDownloadOffline release];
    [arrayListIDforDownload release];
    
    [super dealloc];
    
}

//-(void)updateProgessbar{
//    temb++;
//    NSLog(@"temb====%f",temb);
//      cellDownloadOffline.sliderpercentCell.progress =temb/totalImage;
//}

//-(void)loaddatadidfinish:(NSDictionary*)dict{
//    if (dict ==NULL) {
//        return;
//    }
//    NSLog(@"load data difinish");
//   NSMutableArray* urlImageArr =[[NSMutableArray alloc]init];
//    
//   // Nsmutablarr  *listpage = data objectforkey : ListPage
//    NSMutableArray* listpage =[NSMutableArray array];
//   listpage = [dict objectForKey:@"ListPage"];
//    for (int i =0; i< [listpage count]; i++) {
//        
//        NSDictionary*  dict1 = [listpage objectAtIndex:i];
//        
//        NSMutableArray* listArticle =[[NSMutableArray alloc]init];
//        
//       listArticle = [dict1 objectForKey:@"ListArticle"];
//        if (listArticle==nil||[listArticle count]==0) {
//            return;
//        }
//        for (int j =0; j<[listArticle count]; j++) {
//            
//            //NSDict dict2 = ListArticle objectatindex
//            
//            NSDictionary* dict2 = [listArticle objectAtIndex:j];
//            
//            NSString* siteLogoUrl = [dict2 objectForKey:@"SiteLogoUrl"];
//            
//            //do Load siteLogoUrl
//            [urlImageArr addObject:siteLogoUrl];
//            
//            NSDictionary* dictForArticlePortrait = [dict2 objectForKey:@"ArticlePortrait"];
//            
//            NSString* headImageUrlForArticlePortrait =[dictForArticlePortrait objectForKey:@"HeadImageUrl"];
//            
//            //video
//            
//            //do Load HeadImageUrl with Mode ArticlePortrait/
//            ////////========================
//            [urlImageArr addObject:headImageUrlForArticlePortrait];
//            
//            NSDictionary* dictForArticleLandscape =[dict2 objectForKey:@"ArticleLandscape"];
//            NSString* headImageUrlForArticleLandscape =[dictForArticleLandscape objectForKey:@"HeadImageUrl"];
//            //video
//            
//            [urlImageArr addObject:headImageUrlForArticleLandscape];
//            
//            //doloadHeadImageUrl with Mode ArticleLandscape
//            //=============================================
//            
//            NSDictionary* dictForArticleDetail =[dict2 objectForKey:@"ArticleDetail"];
//            
//            NSDictionary* dictForArticleDetailPortrait = [dictForArticleDetail objectForKey:@"ArticlePortrait"];
//            
//            NSString* imageUrlForArticleDetailPortrait = [dictForArticleDetailPortrait objectForKey:@"ImageUrl"];
//            
//            //do load imageUrlForArticleDetailPortrait
//            ////=========================================
//            [urlImageArr addObject:imageUrlForArticleDetailPortrait];
//            
//            NSMutableArray* listImageForArticleDetailPortrait =[NSMutableArray array];
//            
//           listImageForArticleDetailPortrait= [dictForArticleDetailPortrait objectForKey:@"ListImage"];
//            if (listImageForArticleDetailPortrait==nil||[listImageForArticleDetailPortrait count]==0) {
//                return;
//            }
//            
//            for (int i =0; i<[listImageForArticleDetailPortrait count]; i++) {
//                
//                NSDictionary* dictarrurl1 =[listImageForArticleDetailPortrait objectAtIndex:i];
//                
//                NSString* url1 = [dictarrurl1 objectForKey:@"ImageUrl"];
//                
//                [urlImageArr addObject:url1];
//                //do load listImageForArticleDetailPortrait
//                //=======================================================
//            }
//            
//            NSDictionary* dictForArticleDetailLandscape =[dictForArticleDetail objectForKey:@"ArticleLandscape"];
//            NSString* imageUrlForArticleDetailLandscape =[dictForArticleDetailLandscape objectForKey:@"ImageUrl"];
//            
//            [urlImageArr addObject:imageUrlForArticleDetailLandscape];
//            //do load imageUrlForArticleDetailLandscape
//            ////=========================================
//            
//            NSMutableArray* listImageForArticleDetailLandscape =[NSMutableArray array];
//            listImageForArticleDetailLandscape = [dictForArticleDetailLandscape objectForKey:@"ListImage"];
//            if (listImageForArticleDetailLandscape ==nil ||[listImageForArticleDetailLandscape count]==0) {
//                
//            }
//            
//            for (int i =0; i<[listImageForArticleDetailLandscape count]; i++) {
//                
//                //NSString* url2 =[listImageForArticleDetailLandscape objectAtIndex:i];
//                
//                NSDictionary* dictarrurl2 =[listImageForArticleDetailLandscape objectAtIndex:i];
//                
//                NSString* url2 = [dictarrurl2 objectForKey:@"ImageUrl"];
//                
//                [urlImageArr addObject:url2];
//                //do load listImageForArticleDetailPortrait
//                //=======================================================
//                
//            }
//            
//            
//            
//        }
//        
//        
//    }
//    temb=0;
//    for (int i =0; i<[urlImageArr count];i++ ) {
//        NSString* url = [urlImageArr objectAtIndex:i];
//        if ((NSNull *)url==[NSNull null]) {
//            url =@"";
//            //return;
//        }
//        NSLog(@"i==== %d",i);
//
//        self.imageLoadingOperation =[XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:url] onCompletion:^(UIImage *fetchedImage, NSURL *url1, BOOL isInCache) {
//            if([url isEqualToString:[url1 absoluteString]]) {
//                
//                                   if (isInCache) {
//                                       [self updateProgessbar];
//
//                                    
//                                    } else {
//                                        [self updateProgessbar];                                        
//                                    }
//                            }
//        }];
//    }
//      NSLog(@"urlImageArr==%@",urlImageArr);
//    totalImage =[urlImageArr count];
////    
////    [urlImageArr removeAllObjects];
////    [urlImageArr release];
//
//}

//- (void)makeMyProgressBarMoving {
//     
//        cellDownloadOffline.sliderpercentCell.progress = 0.0;
//    timer=   [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(moreProgress) userInfo:nil repeats:YES];
//    
//}
//
//-(void)moreProgress{
//    
//    cellDownloadOffline.sliderpercentCell.progress +=0.02;
//    if (cellDownloadOffline.sliderpercentCell.progress==1.0) {
//        [timer invalidate];
//        timer =nil;
//    }
//    
//    
//}

-(void)viewDidDisappear:(BOOL)animated{
    
    
    [super viewDidDisappear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

-(void)btnCancelClicked:(id)sender{
 
    [self dismissModalViewControllerAnimated:YES];
}

@end
