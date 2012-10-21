//
//  TimeLineViewController.h
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/10/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "ShowImageViewController.h"

@interface TimeLineViewController : PFQueryTableViewController

@property (nonatomic, strong) PFImageView *imageWillShow;

@property (nonatomic, strong) PFObject *selectedAlbum;

@property (nonatomic, weak) CameraViewController *parentTabController;

- (IBAction)showImage:(UIButton *)sender;


@end
