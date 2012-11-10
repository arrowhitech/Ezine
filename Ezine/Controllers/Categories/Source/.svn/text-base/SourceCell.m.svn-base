//
//  SourceCell.m
//  Ezine
//
//  Created by MAC on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SourceCell.h"

@implementation SourceCell
@synthesize btnAddSource;
@synthesize detailSource;
@synthesize NameSources;
@synthesize logoImage;
@synthesize imageView,enabled,glowView,disabledView,isSource,section;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        savedImage = nil;
        enabled = YES;
        
        self.clipsToBounds = YES;
        self.NameSources.font = [UIFont fontWithName:@"UVNHongHaHepBold" size:17];
        self.NameSources.contentMode=UIViewContentModeLeft;
        
        self.logoImage.contentMode = UIViewContentModeCenter;
        
        self.detailSource.font=[UIFont fontWithName:@"UVNHongHaHep" size:12];
        glowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 43)];
        glowView.image = [UIImage imageNamed:@"NewGlow"];
        glowView.hidden = YES;
        [self addSubview:glowView];

    }
    return self;
}



- (void)dealloc {
    [logoImage release];
    [NameSources release];
    [detailSource release];
    [btnAddSource release];
    [super dealloc];
}

- (void)setSelected:(BOOL)sel animated:(BOOL)animated {
    [super setSelected:sel animated:animated];
    if (self.btnAddSource.tag<3&&isSource) {
        return;
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor colorWithRed:13.0f/255.0f green:154.0f/255.0f blue:251.0f/255.0f alpha:1.0f]];
    [self setSelectedBackgroundView:bgColorView];
    [bgColorView release];
}

- (void)setEnabled:(BOOL)newValue {
    enabled = newValue;
    
    if (self.enabled) {
        if (self.disabledView) {
            // Remove the "dimmed" view, if there is one. (see below)
            [self.disabledView removeFromSuperview];
            self.disabledView = nil;
        }
        
        if (savedImage) {
            self.imageView.image = savedImage;
            savedImage = nil;
        }
        
        // Reenable user interaction and selection ability
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.userInteractionEnabled = YES;
    }
    else {
        /* Create the appearance of a "dimmed" table cell, with a standard error icon */
        UIView *newView = [[UIView alloc] initWithFrame:self.bounds];
        newView.backgroundColor = [UIColor colorWithWhite:.5f alpha:.5f];
        
        if (self.imageView.image) {
            savedImage = self.imageView.image;
            self.imageView.image = [UIImage imageNamed:@"error"];
        }
        else {
            UIImageView *error = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error"]];
            CGFloat imgDim = 24.f;
            // set the error image's frame origin to be on the far right side of the table view cell
            CGRect frm = CGRectMake(195.f - imgDim , roundf((self.bounds.size.height/2) - (imgDim/2)), imgDim, imgDim);
            error.frame = frm;
            [newView addSubview:error];        
        }
        [self addSubview:newView];
        [self bringSubviewToFront:newView];
        self.disabledView = newView;
        
        // Disable future user interaction and selections
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.userInteractionEnabled = NO;
        
        // Turn off any current selections/highlights
        if (self.selected) {
            self.selected = NO;
        }
        if (self.highlighted) {
            self.highlighted = NO;
        }
    }    
    [self setNeedsDisplay];
}

- (void)layoutSubviews {
	
    [super layoutSubviews];
	
	// getting the cell size
	
	// get the X pixel spot
	
	//	Work out how to diferenciate between slide delete and edit delete
	if (self.isSource) {
        
    }else{
        if (!self.editing) {
            
            self.logoImage.frame=CGRectMake( 5, 10, 40, 40);
            self.NameSources.frame=CGRectMake(70, 8, 232, 21);
            self.detailSource.frame=CGRectMake(70, 29, 232, 21);
            
        }else{
            
            self.logoImage.frame=CGRectMake( 40, 10, 40, 40);
            self.NameSources.frame=CGRectMake(105, 8, 232, 21);
            self.detailSource.frame=CGRectMake(105, 29, 232, 21);
            
        }
        if (self.section==1) {
            if (!self.editing) {
                
                self.logoImage.frame=CGRectMake( 5, 5, 50, 50);
                self.NameSources.frame=CGRectMake(70, 18, 232, 21);
                self.detailSource.frame=CGRectMake(70, 16, 232, 21);
                
            }else{
                
                self.logoImage.frame=CGRectMake( 40, 5, 40, 40);
                self.NameSources.frame=CGRectMake(105, 18, 232, 21);
                self.detailSource.frame=CGRectMake(105, 29, 232, 21);
                
            }

        }
    }
    
	
}
@end
