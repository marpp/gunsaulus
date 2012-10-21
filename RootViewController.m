//
//  RootViewController.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/14/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "RootViewController.h"
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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

//This is the root controller, so let's programm de login and singup views just in case there is no user logged in

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"%@", currentUser.username);

    if (![PFUser currentUser]) { // No user logged in
        
        // Instantiate our custom log in view controller
        MyLogInViewController *logInViewController = [[MyLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        [logInViewController setFields:PFLogInFieldsUsernameAndPassword
         | PFLogInFieldsSignUpButton];
        
        // Create the sign up view controller
        MySignUpViewController *signUpViewController = [[MySignUpViewController alloc] init];
        
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        signUpViewController.fields = PFSignUpFieldsUsernameAndPassword
         | PFSignUpFieldsSignUpButton
         | PFSignUpFieldsAdditional
         | PFSignUpFieldsDismissButton;

    
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
    
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    
    } else {
    
    [self performSegueWithIdentifier: @"goToMyAlbums" sender: self];
    }
    
}


#pragma mark - Delegates for log in controlling

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    
   [self performSegueWithIdentifier: @"goToMyAlbums" sender: self];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
    
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Delegates for sign up in controlling

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
                    
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}



// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    
    NSString *email = signUpController.signUpView.usernameField.text;
    NSString *name = signUpController.signUpView.additionalField.text;    
    
    [user setObject:name forKey:@"name"];
    [user setEmail:email];
    [user saveInBackground];
    
    [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}



@end
