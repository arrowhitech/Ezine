//
//  MenuTableViewCell.m
//  PSStackedViewExample
//
//  Created by Peter Steinberger on 7/14/11.
//  Copyright 2011 Peter Steinberger. All rights reserved.
//

#import "CategoriesCell.h"

@implementation CategoriesCell

@synthesize glowView;
@synthesize disabledView;
@synthesize enabled;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]);
    if (self) {
        savedImage = nil;
        enabled = YES;
        
        self.clipsToBounds = YES;
        
        self.textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        self.textLabel.contentMode=UIViewContentModeLeft;
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        
//        glowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 43)];
//        glowView.image = [UIImage imageNamed:@"NewGlow"];
//        glowView.hidden = YES;
        self.textLabel.frame = CGRectMake(40, 0, 125, 43);
        self.imageView.frame = CGRectMake(0, 0, 40, 43);
        //[self addSubview:glowView];
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(10.0f , 15.0f, 21.0f, 16.0f);
    if (self.imageView.image) {
        self.textLabel.frame = CGRectMake(40, 0, 125, 43);
        
    }
}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//
//   }

- (void)setSelected:(BOOL)sel animated:(BOOL)animated {
    [super setSelected:sel animated:animated];
    
    if (sel) {
       // self.glowView.hidden = NO;
        self.textLabel.textColor = [UIColor whiteColor];
    }
    else {
        //self.glowView.hidden = YES;
        self.textLabel.textColor = [UIColor colorWithRed:(50.f/255.f)
                                                   green:(50.f/255.f)
                                                    blue:(50.f/255.f)
                                                   alpha:1.f];
    }
}

//- (void)setEnabled:(BOOL)newValue {
//    enabled = newValue;
//
//    if (self.enabled) {
//        if (self.disabledView) {
//            // Remove the "dimmed" view, if there is one. (see below)
//            [self.disabledView removeFromSuperview];
//            self.disabledView = nil;
//        }
//
//        if (savedImage) {
//            self.imageView.image = savedImage;
//            savedImage = nil;
//        }
//
//        // Reenable user interaction and selection ability
//        self.selectionStyle = UITableViewCellSelectionStyleBlue;
//        self.userInteractionEnabled = YES;
//    }
//    else {
//        /* Create the appearance of a "dimmed" table cell, with a standard error icon */
//        UIView *newView = [[UIView alloc] initWithFrame:self.bounds];
//        newView.backgroundColor = [UIColor colorWithWhite:.5f alpha:.5f];
//
//        if (self.imageView.image) {
//            savedImage = self.imageView.image;
//            self.imageView.image = [UIImage imageNamed:@"error"];
//        }
//        else {
//            UIImageView *error = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error"]];
//            CGFloat imgDim = 24.f;
//            // set the error image's frame origin to be on the far right side of the table view cell
//            CGRect frm = CGRectMake(195.f - imgDim , roundf((self.bounds.size.height/2) - (imgDim/2)), imgDim, imgDim);
//            error.frame = frm;
//            [newView addSubview:error];
//        }
//        [self addSubview:newView];
//        [self bringSubviewToFront:newView];
//        self.disabledView = newView;
//
//        // Disable future user interaction and selections
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.userInteractionEnabled = NO;
//
//        // Turn off any current selections/highlights
//        if (self.selected) {
//            self.selected = NO;
//        }
//        if (self.highlighted) {
//            self.highlighted = NO;
//        }
//    }
//    [self setNeedsDisplay];
//}
//

@end
