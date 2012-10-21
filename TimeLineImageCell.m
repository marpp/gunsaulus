//
//  TimeLineImageCell.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/12/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "TimeLineImageCell.h"

@implementation TimeLineImageCell

@synthesize myImage;
@synthesize photoButton;

#pragma mark - NSObject

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
//        // Initialization code
        
        self.opaque = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.clipsToBounds = NO;
        
//        self.myImage = [UIImage imageNamed:@"Icon.png"];
        
//        CGRect buttonRect = CGRectMake(30.0f, 20.0f, 260.0f, 260.0f);
//        UIButton *button = [[UIButton alloc] initWithFrame:buttonRect];
//        [button setBackgroundImage:[UIImage imageNamed:@"Icon.png"] forState:UIControlStateNormal];
//        [self.contentView addSubview:button];
        
//        UIView *dropshadowView = [[UIView alloc] init];
//        dropshadowView.backgroundColor = [UIColor whiteColor];
//        dropshadowView.frame = CGRectMake( 20.0f, -44.0f, 280.0f, 322.0f);
//        [self.contentView addSubview:dropshadowView];
    
//        CALayer *layer = self.imageView.layer;
//        [layer setBorderColor: [[UIColor whiteColor] CGColor]];
//        [layer setBorderWidth:8.0f];
//        [layer setShadowColor: [[UIColor blackColor] CGColor]];
//        [layer setShadowOpacity:0.9f];
//        [layer setShadowOffset: CGSizeMake(1, 3)];
//        [layer setShadowRadius:4.0];
//        [picture setClipsToBounds:NO];
//        layer.masksToBounds = NO;
//        layer.shadowRadius = 3.0f;
//        layer.shadowOpacity = 0.5f;
//        layer.shadowOffset = CGSizeMake( 0.0f, 1.0f);
//        layer.shouldRasterize = YES;
//  
//        self.imageView.frame = CGRectMake( 30.0f, 20.0f, 260.0f, 260.0f);
//        self.imageView.backgroundColor = [UIColor blackColor];
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    
//        [self setUserInteractionEnabled:NO];
        
//        self.photoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.photoButton.frame = CGRectMake( 30.0f, 20.0f, 260.0f, 260.0f);
//       [self.photoButton setImage:self.myImage.image forState:UIControlStateNormal];
//        
//        [self.contentView addSubview:photoButton];
        
    }
    
    return self;
}


#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.imageView.frame = CGRectMake( 30.0f, 20.0f, 260.0f, 260.0f);
//    self.photoButton.frame = CGRectMake( 30.0f, 20.0f, 260.0f, 260.0f);
}

/*- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
