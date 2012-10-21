//
//  MyAccountViewController.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/9/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "MyAccountViewController.h"

@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Lozalized title
    self.title = NSLocalizedString(@"myAccount", @"");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Loggin Out..." message:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        //delete it
        NSLog(@"User taped No on log out");
    } else {
        NSLog(@"User taped Yes on log out");
        [PFUser logOut];
//        PFUser *currentUser = [PFUser currentUser]; // this will now be nil
        [self performSegueWithIdentifier: @"backToLogIn" sender: self];
        
    }
}

@end
