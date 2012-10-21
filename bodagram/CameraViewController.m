//
//  CameraViewController.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/10/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

@synthesize selectedAlbum;

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
    
    self.navigationItem.title = @"Despedida Maria Parra";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

// Action Of the camera button, setting the UIImagePickerController

- (IBAction)setPicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType: UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    
    [imagePicker setDelegate:self];

    [self presentModalViewController:imagePicker animated:YES];
    
}

// the Next method is call when the picture is taken

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    [self dismissModalViewControllerAnimated:YES];
    
    //load filters
    
   // [self loadFiltersForImage:image];
    
    //Save the image file in Parse
    
    // Resize image
  /*  UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIGraphicsEndImageContext();*/
    
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(image, 0.05f);
    
    //Set the image for uploading
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.center = CGPointMake(160, 240);
//    spinner.hidesWhenStopped = YES;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
//            [spinner stopAnimating];
        }
    }];
    
    PFObject *photo = [PFObject objectWithClassName:@"Photo"];
    [photo setObject:imageFile forKey:@"picture"];
    
    // Creating the thumbnail...
    CGSize newSize = CGSizeMake(image.size.width*0.25, image.size.width*0.25);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *thumbnailData = UIImagePNGRepresentation(thumbnail);
    PFFile *thumbnailFile = [PFFile fileWithName:@"cover.png" data:thumbnailData];
    [thumbnailFile saveInBackground];
    
    [photo setObject:thumbnailFile forKey:@"thumbnail"];

    //Setting the album and user propietaries of the picture
    [photo setObject:self.selectedAlbum forKey:@"album"];
    [photo setObject:[PFUser currentUser] forKey:@"user"];
    [photo saveInBackground];
    
        
 /*   [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            // Save PFFile
            // Create a Photo object
            PFObject *photo = [PFObject objectWithClassName:@"Photo"];
         //   [photo setObject:[PFUser currentUser] forKey:@"user"];
            [photo setObject:imageFile forKey:@"picture"];
            
            
            // Photos are public, but may only be modified by the user who uploaded them
        //    PFACL *photoACL = [PFACL ACLWithUser:[PFUser currentUser]];
        //    [photoACL setPublicReadAccess:YES];
        //    photo.ACL = photoACL;
            
            [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(!error){
                    
                }
                else {
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
            

        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];*/

}

//Method loading the filters to apply to the image
/*
- (void) loadFiltersForImage: (UIImage *)image
{
    CIImage *filterPreviewImage = [[CIImage alloc] initWithImage:image];
    
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, filterPreviewImage, @"inputIntensity",[NSNumber numberWithFloat:0.8], nil];
    
    CIFilter *colorMonochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey, filterPreviewImage,@"inputColor",[CIColor colorWithString:@"Red"], @"inputIntensity",[NSNumber numberWithFloat:0.8], nil];
    
    filters = [[NSMutableArray alloc] init];
    
    [filters addObjectsFromArray:[NSArray arrayWithObjects:[[Filter alloc] initWithNameAndFilter: @"Sepia" filter:sepiaFilter],[[Filter alloc] initWithNameAndFilter: @"Mono" filter:colorMonochrome], nil]];
    
    [self createPreviewViewsForFilters];
}*/




@end