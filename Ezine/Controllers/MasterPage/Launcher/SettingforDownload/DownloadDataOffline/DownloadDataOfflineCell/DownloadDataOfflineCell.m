//
//  DownloadDataOfflineCell.m
//  Ezine
//
//  Created by MrKien on 11/1/12.
//
//

#import "DownloadDataOfflineCell.h"
#import "SiteDownloadModel.h"

@implementation DownloadDataOfflineCell

@synthesize sliderpercentCell;
@synthesize titleName;
@synthesize imageLoadingOperation;
@synthesize siteDownloadID;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
     //  }

    
    
}

-(void)download{
    NSLog(@"aaaaaaaaaaaaHieueheheieheie");
    self.sliderpercentCell.progress =0.0;
    
    //  for (int i = 0; i<[arrayListIDforDownload count] ;i++) {
    //        SiteDownloadModel* site =[arrayListIDforDownload objectAtIndex:i];
    //        NSLog(@"siteOBJ===%d",site.siteID);
    [XAppDelegate.serviceEngine downloadDataOfflineSite:self.siteDownloadID reload:NO onCompletion:^(NSDictionary *responseDict) {
       // NSLog(@"siteDownloadID==%d",siteDownloadID);
        // NSLog(@"data%@",responseDict);
        
        [self  loaddatadidfinish:responseDict];
        
    } onError:^(NSError *error) {
        
        
    }];
    

}

-(void)dealloc{
    
    [titleName release];
    [sliderpercentCell release];
    [super dealloc];
}

-(void)loaddatadidfinish:(NSDictionary*)dict{
    if (dict ==NULL) {
        return;
    }
    NSLog(@"load data difinish");
    NSMutableArray* urlImageArr =[[NSMutableArray alloc]init];
    
    // Nsmutablarr  *listpage = data objectforkey : ListPage
    NSMutableArray* listpage =[NSMutableArray array];
    listpage = [dict objectForKey:@"ListPage"];
    for (int i =0; i< [listpage count]; i++) {
        
        NSDictionary*  dict1 = [listpage objectAtIndex:i];
        
        NSMutableArray* listArticle =[[NSMutableArray alloc]init];
        
        listArticle = [dict1 objectForKey:@"ListArticle"];
        if (listArticle==nil||[listArticle count]==0) {
            return;
        }
        for (int j =0; j<[listArticle count]; j++) {
            
            //NSDict dict2 = ListArticle objectatindex
            
            NSDictionary* dict2 = [listArticle objectAtIndex:j];
            
            NSString* siteLogoUrl = [dict2 objectForKey:@"SiteLogoUrl"];
            
            //do Load siteLogoUrl
            [urlImageArr addObject:siteLogoUrl];
            
            NSDictionary* dictForArticlePortrait = [dict2 objectForKey:@"ArticlePortrait"];
            
            NSString* headImageUrlForArticlePortrait =[dictForArticlePortrait objectForKey:@"HeadImageUrl"];
            
            //video
            
            //do Load HeadImageUrl with Mode ArticlePortrait/
            ////////========================
            [urlImageArr addObject:headImageUrlForArticlePortrait];
            
            NSDictionary* dictForArticleLandscape =[dict2 objectForKey:@"ArticleLandscape"];
            NSString* headImageUrlForArticleLandscape =[dictForArticleLandscape objectForKey:@"HeadImageUrl"];
            //video
            
            [urlImageArr addObject:headImageUrlForArticleLandscape];
            
            //doloadHeadImageUrl with Mode ArticleLandscape
            //=============================================
            
            NSDictionary* dictForArticleDetail =[dict2 objectForKey:@"ArticleDetail"];
            
            NSDictionary* dictForArticleDetailPortrait = [dictForArticleDetail objectForKey:@"ArticlePortrait"];
            
            NSString* imageUrlForArticleDetailPortrait = [dictForArticleDetailPortrait objectForKey:@"ImageUrl"];
            
            //do load imageUrlForArticleDetailPortrait
            ////=========================================
            [urlImageArr addObject:imageUrlForArticleDetailPortrait];
            
            NSMutableArray* listImageForArticleDetailPortrait =[NSMutableArray array];
            
            listImageForArticleDetailPortrait= [dictForArticleDetailPortrait objectForKey:@"ListImage"];
            if (listImageForArticleDetailPortrait==nil||[listImageForArticleDetailPortrait count]==0) {
                return;
            }
            
            for (int i =0; i<[listImageForArticleDetailPortrait count]; i++) {
                
                NSDictionary* dictarrurl1 =[listImageForArticleDetailPortrait objectAtIndex:i];
                
                NSString* url1 = [dictarrurl1 objectForKey:@"ImageUrl"];
                
                [urlImageArr addObject:url1];
                //do load listImageForArticleDetailPortrait
                //=======================================================
            }
            
            NSDictionary* dictForArticleDetailLandscape =[dictForArticleDetail objectForKey:@"ArticleLandscape"];
            NSString* imageUrlForArticleDetailLandscape =[dictForArticleDetailLandscape objectForKey:@"ImageUrl"];
            
            [urlImageArr addObject:imageUrlForArticleDetailLandscape];
            //do load imageUrlForArticleDetailLandscape
            ////=========================================
            
            NSMutableArray* listImageForArticleDetailLandscape =[NSMutableArray array];
            listImageForArticleDetailLandscape = [dictForArticleDetailLandscape objectForKey:@"ListImage"];
            if (listImageForArticleDetailLandscape ==nil ||[listImageForArticleDetailLandscape count]==0) {
                
            }
            
            for (int i =0; i<[listImageForArticleDetailLandscape count]; i++) {
                
                //NSString* url2 =[listImageForArticleDetailLandscape objectAtIndex:i];
                
                NSDictionary* dictarrurl2 =[listImageForArticleDetailLandscape objectAtIndex:i];
                
                NSString* url2 = [dictarrurl2 objectForKey:@"ImageUrl"];
                
                [urlImageArr addObject:url2];
                //do load listImageForArticleDetailPortrait
                //=======================================================
                
            }
            
            
            
        }
        
        
    }
    temb=0;
    for (int i =0; i<[urlImageArr count];i++ ) {
        NSString* url = [urlImageArr objectAtIndex:i];
        if ((NSNull *)url==[NSNull null]) {
            url =@"";
            //return;
        }
       // NSLog(@"i==== %d",i);
        
        self.imageLoadingOperation =[XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:url] onCompletion:^(UIImage *fetchedImage, NSURL *url1, BOOL isInCache) {
            if([url isEqualToString:[url1 absoluteString]]) {
                
                if (isInCache) {
                    [self updateProgessbar];
                    
                    
                } else {
                    [self updateProgessbar];
                }
            }
        }];
    }
  //  NSLog(@"urlImageArr==%@",urlImageArr);
    totalImage =[urlImageArr count];
    //
    //    [urlImageArr removeAllObjects];
    //    [urlImageArr release];
    
}

-(void)updateProgessbar{
    temb++;
   // NSLog(@"temb====%f",temb);
    self.sliderpercentCell.progress =temb/totalImage;
}

@end
