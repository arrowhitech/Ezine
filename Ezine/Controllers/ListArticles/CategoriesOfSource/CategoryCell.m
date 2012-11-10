//
//  FlickrCell.m
//  MKNetworkKit-iOS-Demo
//
//  Created by Mugunth Kumar on 22/1/12.
//  Copyright (c) 2012 Steinlogic. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
@synthesize titleLabel = titleLabel_;
@synthesize thumbnailImage = thumbnailImage_;
@synthesize loadingImageURLString = loadingImageURLString_;
@synthesize imageLoadingOperation = imageLoadingOperation_;

//=========================================================== 
// + (BOOL)automaticallyNotifiesObserversForKey:
//
//=========================================================== 
+ (BOOL)automaticallyNotifiesObserversForKey: (NSString *)theKey 
{
    BOOL automatic;
    
    if ([theKey isEqualToString:@"thumbnailImage"]) {
        automatic = NO;
    } else {
        automatic = [super automaticallyNotifiesObserversForKey:theKey];
    }
    
    return automatic;
}

-(void) prepareForReuse {
    
    self.thumbnailImage.image = nil;
    [self.imageLoadingOperation cancel];
}

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

-(void)setData:(NSDictionary *)data {
    self.titleLabel.text = [data objectForKey:@"Name"];
    self.loadingImageURLString =[data objectForKey:@"LogoUrl"];
    [self setTag:[[data objectForKey:@"ChannelID"] intValue]];
    
//    if ([self.loadingImageURLString length]>2) {
//        self.imageLoadingOperation = [XAppDelegate.serviceEngine imageAtURL:[NSURL URLWithString:self.loadingImageURLString]
//                                                               onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
//                                                                   if([self.loadingImageURLString isEqualToString:[url absoluteString]]) {
//                                                                       if (isInCache) {
//                                                                           self.thumbnailImage.image = fetchedImage;
//                                                                           NSLog(@"load image from cache");
//                                                                       } else {
//                                                                           NSLog(@"load image from internet");
//                                                                           UIImageView *loadedImageView = [[UIImageView alloc] initWithImage:fetchedImage];
//                                                                           loadedImageView.frame = self.thumbnailImage.frame;
//                                                                           loadedImageView.alpha = 0;
//                                                                           [self.contentView addSubview:loadedImageView];
//                                                                           [UIView animateWithDuration:0.4 animations:^{
//                                                                               loadedImageView.alpha = 1;
//                                                                               self.thumbnailImage.alpha = 0;
//                                                                           }completion:^(BOOL finished){
//                                                                               self.thumbnailImage.image = fetchedImage;
//                                                                               self.thumbnailImage.alpha = 1;
//                                                                               [loadedImageView removeFromSuperview];}];
//                                                                       }
//                                                                   }
//                                                               }];
//
//    }else {
        
   // }
    }

@end
