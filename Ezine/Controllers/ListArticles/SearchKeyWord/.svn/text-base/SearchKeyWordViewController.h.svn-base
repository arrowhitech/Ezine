//
//  SearchKeyWordViewController.h
//  Ezine
//
//  Created by MAC on 10/3/12.
//
//

#import <UIKit/UIKit.h>

@protocol SearchKeyWordViewControllerDelegate <NSObject>

-(void)searchKeywordClick:(NSString*)keyword;

@end

@interface SearchKeyWordViewController : UIViewController
{
    UITextField *_keyword;
}
@property (nonatomic, assign) id<SearchKeyWordViewControllerDelegate>delegate;
@end
