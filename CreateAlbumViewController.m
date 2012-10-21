//
//  CreateAlbumViewController.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/14/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "CreateAlbumViewController.h"

@interface CreateAlbumViewController ()

@end

@implementation CreateAlbumViewController
@synthesize albumCover, albumNameField;

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
    
    //Lets add some customization for the input text fields
   // albumNameField.placeholder = @"album name";
    
    //Register the go btton of the text field to perform the action
    [albumNameField addTarget:self
                  action:@selector(createAlbumAction:)
        forControlEvents:UIControlEventEditingDidEndOnExit];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * This method should receive the info from the image, name and description and create the new album
 */

- (IBAction)createAlbumAction:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    
    PFObject *newAlbum = [PFObject objectWithClassName:@"Album"];
    [newAlbum setObject:albumNameField.text forKey:@"name"];
    [newAlbum setObject:currentUser forKey:@"user"];
    
    
    
    UIImage *fullCover = albumCover.image;
    
    NSData *coverImageData = UIImagePNGRepresentation(fullCover);
    PFFile *coverImageFile = [PFFile fileWithName:@"cover.png" data:coverImageData];
    [coverImageFile saveInBackground];
    
    [newAlbum setObject:coverImageFile forKey:@"coverImage"];
    
    // Creating the thumbnail...    
    CGSize newSize = CGSizeMake(fullCover.size.width*0.25, fullCover.size.width*0.25);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [fullCover drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *coverThumbnailImageData = UIImagePNGRepresentation(thumbnail);
    PFFile *coverThumbnailImageFile = [PFFile fileWithName:@"cover.png" data:coverThumbnailImageData];
    [coverThumbnailImageFile saveInBackground];
    
    [newAlbum setObject:coverImageFile forKey:@"cover"];
    [newAlbum setObject:coverThumbnailImageFile forKey:@"thumbnail"];
    
    //create the albumcode
    
    
    
    // save the new album
    [newAlbum saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            NSLog(@"New Album succesfully saved");
        PFObject *userinalbum = [PFObject objectWithClassName:@"UserInAlbum"];
        [userinalbum setObject:newAlbum forKey:@"album"];
        [userinalbum setObject:currentUser forKey:@"user"];
        [userinalbum setObject:@YES forKey:@"allowToRead"];
        [userinalbum setObject:@YES forKey:@"allowToWrite"];
        [userinalbum saveInBackground];
        } else {
            NSLog(@"Error Saving the new album");
        }
        
    }];
    
    //Show an alert to the user so he knows the new album code
    UIAlertView *albumCreated = [[UIAlertView alloc] initWithTitle:@"Album Created!!" message:@"Congratulations, you have created a new album, tap ok to go back to \"My Albums\" and update the view to see your new album code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [albumCreated show];
    
    
}

/*
 * Control the action when the alert view is closed
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        //delete it
        NSLog(@"User taped OK once the album was created");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        NSLog(@"Error, this should never happen");

        
    }
}

/*
 * The next method will hide the keyboard and end edditing when any part of the view is touched
 */

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewDidUnload {
    [self setAlbumCover:nil];
    [self setAlbumNameField:nil];
    [super viewDidUnload];
}

@end
