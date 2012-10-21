//
//  CreateAlbumViewController.h
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/14/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface CreateAlbumViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *albumCover;

@property (weak, nonatomic) IBOutlet UITextField *albumNameField;

- (IBAction)createAlbumAction:(id)sender;

@end
