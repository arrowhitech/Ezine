//
//  ReadBaseOnWeb.h
//  Ezine
//
//  Created by Hieu  on 9/19/12.
//
//

#import <UIKit/UIKit.h>

@interface ReadBaseOnWeb : UIViewController<UIWebViewDelegate>{
     
    IBOutlet UIWebView *webView;
    UIActivityIndicatorView* activityindicator;
    
}
@property (nonatomic, retain) NSString *urlWeb;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
//@property (retain, nonatomic) IBOutlet UIButton *dismissButton;

@property (nonatomic,retain) UIActivityIndicatorView* activityindicator;

-(void)showActivityindicator;
-(void)hideActivityindicator;

@end
