//
//  MyAlbumsViewController.h
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/8/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface MyAlbumsViewController : PFQueryTableViewController 

@property (nonatomic, retain) NSString *detailTextKey;

@property (weak, nonatomic) IBOutlet UITextField *albumCodeField;

- (IBAction)findAlbum:(id)sender;

@end
