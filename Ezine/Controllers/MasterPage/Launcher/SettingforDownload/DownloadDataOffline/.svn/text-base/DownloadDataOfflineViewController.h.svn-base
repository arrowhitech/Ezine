//
//  DownloadDataOfflineViewController.h
//  Ezine
//
//  Created by MAC on 11/1/12.
//
//

#import <UIKit/UIKit.h>
#import "DownloadDataOfflineCell.h"
#import "MKNetworkKit.h"

@interface DownloadDataOfflineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *tableviewDownload;
    DownloadDataOfflineCell* cellDownloadOffline;
    
    NSMutableArray* arrayListIDforDownload;
    float temb;
    float totalImage;
  //  NSTimer* timer;
}

@property (nonatomic, retain) IBOutlet UITableView *tableviewDownload;
@property(nonatomic,assign) NSMutableArray* arrayListIDforDownload;

@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;

//@property(nonatomic,retain) NSTimer* timer;

//-(void)loaddatadidfinish:(NSDictionary *)dict;

@end
