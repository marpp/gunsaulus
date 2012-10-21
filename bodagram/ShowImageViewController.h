//
//  ShowImageViewController.h
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/20/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ShowImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (strong, nonatomic) PFImageView *pfimage;

@end
