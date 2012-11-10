//
//  FlickrCell.h
//  MKNetworkKit-iOS-Demo
//
//  Created by Mugunth Kumar on 22/1/12.
//  Copyright (c) 2012 Steinlogic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell 

@property (nonatomic, assign) IBOutlet UIImageView *thumbnailImage;
@property (nonatomic, assign) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
-(void) setData:(NSDictionary*) data;
@end
