//
//  AlbumPictures.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/13/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "AlbumPictures.h"

@implementation AlbumPictures
@synthesize imageLeft;
@synthesize imageCenter;
@synthesize imageRight;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        CALayer *layer = self.imageLeft.layer;
//        [layer setBorderColor: [[UIColor whiteColor] CGColor]];
//        [layer setBorderWidth:8.0f];
//        [layer setShadowColor: [[UIColor blackColor] CGColor]];
//        [layer setShadowOpacity:0.9f];
//        [layer setShadowOffset: CGSizeMake(1, 3)];
//        [layer setShadowRadius:4.0];
//        
//        CALayer *layerRigth = self.imageRight.layer;
//        [layerRigth setBorderColor: [[UIColor whiteColor] CGColor]];
//        [layerRigth setBorderWidth:8.0f];
//        [layerRigth setShadowColor: [[UIColor blackColor] CGColor]];
//        [layerRigth setShadowOpacity:0.9f];
//        [layerRigth setShadowOffset: CGSizeMake(1, 3)];
//        [layerRigth setShadowRadius:4.0];
//        
//        CALayer *layerCenter = self.imageCenter.layer;
//        [layerCenter setBorderColor: [[UIColor whiteColor] CGColor]];
//        [layerCenter setBorderWidth:8.0f];
//        [layerCenter setShadowColor: [[UIColor blackColor] CGColor]];
//        [layerCenter setShadowOpacity:0.9f];
//        [layerCenter setShadowOffset: CGSizeMake(1, 3)];
//        [layerCenter setShadowRadius:4.0];

        imageLeft.contentMode = UIViewContentModeScaleToFill;
        imageCenter.contentMode = UIViewContentModeScaleToFill;
        imageRight.contentMode = UIViewContentModeScaleToFill;

        
//        [self.contentView bringSubviewToFront:self.imageLeft];
//        [self.contentView bringSubviewToFront:self.imageCenter];
//        [self.contentView bringSubviewToFront:self.imageRight];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
