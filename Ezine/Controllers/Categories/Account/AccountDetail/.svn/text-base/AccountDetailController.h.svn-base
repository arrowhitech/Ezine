//
//  AccountDetailController.h
//  Ezine
//
//  Created by MAC on 9/4/12.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MKNetworkKit.h"

@protocol AccountDetailControllerDelegate <NSObject>
-(void)logout;
@end

@interface AccountDetailController : UIViewController{
    id<AccountDetailControllerDelegate>delegate;
    
}
- (IBAction)btn_detailClick:(id)sender;
- (IBAction)btn_exitClick:(id)sender;
- (IBAction)btnSettingClick:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *_SuaTaiKhoan;
@property (retain, nonatomic) IBOutlet UILabel *_chiaSe1;
@property (retain, nonatomic) IBOutlet UILabel *_tatcasukien;
@property (retain, nonatomic) IBOutlet UILabel *_tatcaanh;
@property (retain, nonatomic) IBOutlet UILabel *_chiase2;
@property (retain, nonatomic) IBOutlet UILabel *_nameUser;
@property (retain, nonatomic) IBOutlet UILabel *_detailUser;
@property (retain, nonatomic) IBOutlet UILabel *_TrangBia;
@property (retain, nonatomic) IBOutlet UIImageView *_avatar;
@property (nonatomic, assign) id delegate;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;
@end
