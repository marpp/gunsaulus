//
//  AlbumPictures.h
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/13/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

@class PFImageView;
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface AlbumPictures : PFTableViewCell

@property (nonatomic, weak) IBOutlet PFImageView *imageLeft;
@property (nonatomic, weak) IBOutlet PFImageView *imageCenter;
@property (nonatomic, weak) IBOutlet PFImageView *imageRight;


@end
