//
//  LogInTestViewController.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/17/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "LogInTestViewController.h"

@interface LogInTestViewController ()

@end

@implementation LogInTestViewController

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
    [super viewDidUnload];
}
- (IBAction)logOut:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"Before log out %@", currentUser.username);
    [PFUser logOut];
    PFUser *currentUser2 = [PFUser currentUser];
    NSLog(@"After logut:  %@", currentUser2.username);
    
}


@end
