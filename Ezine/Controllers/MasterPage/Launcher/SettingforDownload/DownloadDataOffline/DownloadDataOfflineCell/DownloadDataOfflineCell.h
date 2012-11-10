//
//  DownloadDataOfflineCell.h
//  Ezine
//
//  Created by MrKien on 11/1/12.
//
//

#import <UIKit/UIKit.h>

@interface DownloadDataOfflineCell : UITableViewCell{
 
    IBOutlet UILabel  *titleName;
    IBOutlet UIProgressView *sliderpercentCell;
    
    float temb;
    float totalImage;
    
    int siteDownloadID;
    
}

@property(nonatomic,retain) IBOutlet UILabel   *titleName;
@property(nonatomic,retain)   IBOutlet UIProgressView *sliderpercentCell;

@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property(nonatomic,assign) int siteDownloadID;


-(void)loaddatadidfinish:(NSDictionary *)dict;
-(void)download;

@end
