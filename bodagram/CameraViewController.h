//
//  CameraViewController.h
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/10/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface CameraViewController : UITabBarController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    CIContext *context;
    NSMutableArray *filters;
    CIImage *beginImage;
}

@property (nonatomic,weak) IBOutlet UIScrollView *filtersScrollView;

@property (nonatomic,weak) PFObject *selectedAlbum;

- (void)uploadImage:(NSData *)imageData;
- (void)setUpImages:(NSArray *)images;

- (IBAction)setPicture:(id)sender;

@end
