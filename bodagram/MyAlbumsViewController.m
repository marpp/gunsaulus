//
//  MyAlbumsViewController.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/8/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "MyAlbumsViewController.h"

#import "CameraViewController.h"

@interface MyAlbumsViewController ()

@end

@implementation MyAlbumsViewController

@synthesize detailTextKey;

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.className = @"Album";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // The key of the PFObject to display in the label in case of subtitle cell style
        self.detailTextKey = @"albumCode";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        self.imageKey = @"thumbnail";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 100;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Lozalized title
    self.title = NSLocalizedString(@"myAlbums", @"");
    
    //Log the user
//    PFUser *currentUser = [PFUser currentUser];
//    NSString *currentUserEmail = [NSString stringWithFormat:@"%@%@", @"The Current user is: ", currentUser.email];
//    NSLog(@"%@", currentUserEmail);
//    NSLog(@"vamos no");
}

- (void)viewDidUnload {
    [self setAlbumCodeField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}


 // Override to customize what kind of query to perform on the class. The default is to query for
 // all objects ordered by createdAt descending.
 - (PFQuery *)queryForTable {
// PFQuery *query = [PFQuery queryWithClassName:self.className];
//     [query whereKey:@"user" equalTo:[PFUser currentUser]];

    PFQuery *query = [PFQuery queryWithClassName:@"UserInAlbum"];
     [query whereKey:@"user" equalTo:[PFUser currentUser]];
     [query includeKey:@"album"];
     
//     [albums findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//         if (!error) {
//             // The find succeeded.
//             NSLog(@"Successfully retrieved %d albums.", objects.count);
//             [query whereKey:@"objectId" containedIn:objects];
//         } else {
//             // Log details of the failure
//             NSLog(@"Error: %@ %@", error, [error userInfo]);
//         }
//     }];
     
//     PFQuery *query = [PFQuery queryWithClassName:@"Album"];
//     [query whereKey:@"objectId" matchesKey:@"album" inQuery:albums];
     
     

 // If Pull To Refresh is enabled, query against the network by default.
 if (self.pullToRefreshEnabled) {
 query.cachePolicy = kPFCachePolicyNetworkOnly;
 }
 
 // If no objects are loaded in memory, we look to the cache first to fill the table
 // and then subsequently do a query against the network.
 if (self.objects.count == 0) {
 query.cachePolicy = kPFCachePolicyCacheThenNetwork;
 }
 
 [query orderByDescending:@"createdAt"];
 
 return query;
 }
 


// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
// and the imageView being the imageKey in the object.

//Overrided to show subtitle style cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    //static NSString *CellIdentifier = @"Cell";
    
    PFTableViewCell *cell = (PFTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"myAlbumsTable"];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myAlbumsTable"];
    }
    
    //Obtaing the album since we are getting just UserInAlbum class
    PFObject *album = [object objectForKey:@"album"];
    
    // Configure the cell
    cell.textLabel.text = [album objectForKey:self.textKey];
    cell.detailTextLabel.text = [album objectId];
    cell.imageView.image = [UIImage imageNamed:@"Icon@2x.png"];
    
//    if(object){
//        cell.imageView.file = [object objectForKey:self.imageKey];
//        
//        // PFQTVC will take care of asynchronously downloading files, but will only load them when the tableview is not moving. If the data is there, let's load it right away.
//        if ([cell.imageView.file isDataAvailable]) {
//            [cell.imageView loadInBackground];
//        }
//    }
    
    return cell;
}


/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [self.objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

#pragma mark - UITableViewDataSource

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the object from Parse and reload the table view
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, and save it to Parse
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Segues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([segue.identifier isEqualToString:@"showAlbum"]) {
         NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         CameraViewController *destViewController = segue.destinationViewController;
         PFObject *userinalbum = [self.objects objectAtIndex:indexPath.row];
         destViewController.selectedAlbum = [userinalbum objectForKey:@"album"]; //set the selected segue to pass for the next view
     }
 }




- (IBAction)findAlbum:(id)sender {
    
    NSString *albumCode = self.albumCodeField.text;
    PFUser *user = [PFUser currentUser];

    
    //First thing, we check that the album is not ther already:
    PFQuery *albumAlreadyAdded = [PFQuery queryWithClassName:@"UserInAlbum"];
    [albumAlreadyAdded whereKey:@"album" equalTo:albumCode];
    [albumAlreadyAdded whereKey:@"user" equalTo:user];
    
    [albumAlreadyAdded getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(!object){
            // In case there is no object, we add the album
            PFQuery *queryAlbum = [PFQuery queryWithClassName:@"Album"];
            [queryAlbum whereKey:@"objectId" equalTo:albumCode];
            [queryAlbum getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if (!object) { //This means there is no album with that code
                    NSLog(@"The getFirstObject request failed.");
                    UIAlertView *albumNotFound = [[UIAlertView alloc] initWithTitle:@"Album Not Found" message:@"Sorry, we did not found that code, please, check the code you wer given" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [albumNotFound show];
                    
                } else { //This means there is an album with that code
                    // The find succeeded.
                    NSLog(@"Successfully retrieved the object.");
                    
                    
                    
                    PFObject *userinalbum = [PFObject objectWithClassName:@"UserInAlbum"];
                    [userinalbum setObject:object forKey:@"album"];
                    [userinalbum setObject:user forKey:@"user"];
                    [userinalbum setObject:@YES forKey:@"allowToRead"];
                    [userinalbum setObject:@NO forKey:@"allowToWrite"];
                    [userinalbum saveInBackground];
                    
                    UIAlertView *albumFound = [[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"The album you requested has been added to your albums, you can start taking pictures now!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [albumFound show];
                    
                }
            }];
            
            
        }else { //This means that the user has already that album added
            UIAlertView *albumAdded = [[UIAlertView alloc] initWithTitle:@"Album already in the list" message:@"The album you requested is already on your album list" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [albumAdded show];
        }
    }];
    
    
    
}
@end

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
 
 @end*/