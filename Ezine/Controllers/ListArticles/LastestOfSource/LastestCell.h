//
//  LastestCell.h
//  Ezine
//
//  Created by PDG2 on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastestCell : UITableViewCell

@property (nonatomic, assign) IBOutlet UIImageView *thumbnailImage;
@property (nonatomic, assign) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeArticle;
@property (nonatomic, strong) NSString* loadingImageURLString;
@property (nonatomic, strong) MKNetworkOperation* imageLoadingOperation;
-(void) setData:(NSDictionary*) data;
@end
