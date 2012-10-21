//
//  ShowImageViewController.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/20/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "ShowImageViewController.h"

@interface ShowImageViewController ()

@end

@implementation ShowImageViewController
@synthesize image;
@synthesize pfimage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setImage:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
 
    image.image = pfimage.image;
}
@end
