//
//  SalientNewsViewController.h
//  Ezine
//
//  Created by MAC on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownView.h"
#import "EzineAppDelegate.h"
#import "MKNetworkKit.h"
#import "EzineAppDelegate.h"


@protocol SalientNewsViewControllerDelegate <NSObject>

-(void)didSelectSiteInSalentNews;

@end
@interface SalientNewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DropDownViewDelegate>{

    UILabel     *chooseLocation;
    UILabel     *nameLocation;
    UIButton    *showLocation;
     DropDownView *viewLocation;
    NSMutableArray  *_arrayDataJsonreturn;
    EzineAppDelegate    *_delegate;
}
@property (nonatomic, strong)  UITableView *menuTable;

@property (nonatomic, strong) IBOutlet UILabel     *chooseLocation;  
@property (nonatomic, strong) IBOutlet UILabel     *nameLocation;  
@property (nonatomic, strong) IBOutlet UIButton    *showLocation; 
@property (retain, nonatomic) IBOutlet UIButton *LocationStartpoint;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
@property (nonatomic, assign)id <SalientNewsViewControllerDelegate>delegate;

-(IBAction)btnshowClick:(id)sender;
-(void)orientationChanged;
- (void)fetchedData;
@end
