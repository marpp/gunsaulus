//
//  TimeLineImageCell.h
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/12/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

@class PFImageView;
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

@interface TimeLineImageCell : PFTableViewCell {
    UIImage *myImage;
}

@property (nonatomic, retain) UIImage *myImage;
@property (nonatomic, retain) UIButton *photoButton;


@end
