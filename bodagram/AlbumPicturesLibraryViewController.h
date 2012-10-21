//
//  AlbumPicturesLibraryViewController.h
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/13/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "CameraViewController.h"

@interface AlbumPicturesLibraryViewController : PFQueryTableViewController

@property (nonatomic, strong) PFObject *objectLeft;
@property (nonatomic, strong) PFObject *objectCenter;
@property (nonatomic, strong) PFObject *objectRight;

@property (nonatomic, strong) PFObject *selectedAlbum;

@property (nonatomic, weak) CameraViewController *parentTabController;


@end
