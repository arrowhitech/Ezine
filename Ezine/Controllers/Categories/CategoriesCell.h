//
//  CategoriesCell.h
//  Ezine
//
//  Created by MAC on 8/20/12.
//
//

#import <UIKit/UIKit.h>


@interface CategoriesCell : UITableViewCell {
	UIImageView *glowView;
    UIImage *savedImage;
}

@property(nonatomic,strong) UIImageView *glowView;
@property(nonatomic,strong) UIView *disabledView;
@property(nonatomic) BOOL enabled;

@end