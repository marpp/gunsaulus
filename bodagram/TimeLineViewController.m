//
//  TimeLineViewController.m
//  bodagram
//
//  Created by Alberto de Pablo Rodriguez on 10/10/12.
//  Copyright (c) 2012 Alberto de Pablo Rodriguez. All rights reserved.
//

#import "TimeLineImageCell.h"
#import "TimeLineViewController.h"

@interface TimeLineViewController ()

@end

@implementation TimeLineViewController
@synthesize selectedAlbum;
@synthesize parentTabController;
@synthesize imageWillShow;

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.className = @"Photo";
        
        // The key of the PFObject to display in the label of the default cell style
        //self.textKey = @"name";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        self.imageKey = @"thumbnail";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
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
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Setting the background
    
    UIView *texturedBackgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    texturedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pinkBackGround.png"]];
    self.tableView.backgroundView = texturedBackgroundView;
    
    self.tableView.tableFooterView = nil;
    
}

- (void)viewDidUnload {
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
  
     parentTabController = (CameraViewController *)self.tabBarController;
     self.selectedAlbum = parentTabController.selectedAlbum;
    
     
 PFQuery *query = [PFQuery queryWithClassName:self.className];
     
     [query whereKey:@"album" equalTo:[PFObject objectWithoutDataWithClassName:@"Album" objectId:[self.selectedAlbum objectId]]];
     
     
     
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
 
 //Overrided to show the customized cell

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
 static NSString *CellIdentifier = @"Cell";
     
     if (indexPath.section == self.objects.count) {
         // this behavior is normally handled by PFQueryTableViewController, but we are using sections for each object and we must handle this ourselves
         UITableViewCell *cell = [self tableView:tableView cellForNextPageAtIndexPath:indexPath];
         return cell;
     } else {
         
         TimeLineImageCell *cell = (TimeLineImageCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
         
         if(cell == nil){
             cell = [[TimeLineImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
         }
         
//We are going to create the cell just inside this method, the cell will be a button with the image as background. In timeline cell we will just add the properties of the cell
         
         PFImageView *imageView = [[PFImageView alloc] init];
         imageView.image = [UIImage imageNamed:@"Icon.png"];
         
         
         if(object){
             imageView.file = [object objectForKey:self.imageKey];
             
             // PFQTVC will take care of asynchronously downloading files, but will only load them when the tableview is not moving. If the data is there, let's load it right away.
             if ([imageView.file isDataAvailable]) {
                 [imageView loadInBackground];
             }
         }
         
         // reescale the image keep size x width
         UIImage *original = imageView.image;
         
         float desiredWidth = 260.0f;
         
         float scaleFactor = original.size.width / desiredWidth;
         
         
         // Creating the scaled image...
         CGSize newSize = CGSizeMake(original.size.width/scaleFactor, original.size.width/scaleFactor);
         UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
         [original drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
         UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
         UIGraphicsEndImageContext();
         
         NSLog(@"original width: %f",original.size.width);
         NSLog(@"original hegth: %f",original.size.height);

         NSLog(@"width: %f",scaledImage.size.width);
         NSLog(@"hegth: %f",scaledImage.size.height);
         
         
         CGRect buttonRect = CGRectMake(30.0f, 20.0f, scaledImage.size.width, scaledImage.size.height);
         UIButton *photoButton = [[UIButton alloc] initWithFrame:buttonRect];
         [photoButton setBackgroundImage:scaledImage forState:UIControlStateNormal];
         photoButton.tag = indexPath.section; // set the tag to the row so we now the row of the button taped in the action of the button
         [photoButton addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
         [cell.contentView addSubview:photoButton];
         
         
         
         self.imageWillShow = imageView;
//
//         
         
         return cell;
     }
 }


- (NSIndexPath *)indexPathForObject:(PFObject *)targetObject {
    for (int i = 0; i < self.objects.count; i++) {
        PFObject *object = [self.objects objectAtIndex:i];
        if ([[object objectId] isEqualToString:[targetObject objectId]]) {
            return [NSIndexPath indexPathForRow:0 inSection:i];
        }
    }
    
    return nil;
}

 // Override if you need to change the ordering of objects in the table.

//we override this object because we want to implement one section per object
 - (PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath {
    
     if (indexPath.section < self.objects.count) {
         return [self.objects objectAtIndex:indexPath.section];
     }
     
     return nil;
     
 }
 

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
 * Set the number of sections, the timeline will have one picture per section. 
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sections = self.objects.count;
    if (self.paginationEnabled && sections != 0)
        sections++;
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



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

/*
 *  UIView to show in the header
 */

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

    
/*
 * Heigh of the header
 */

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == self.objects.count) { //Load more line
        return 0.0f;
    }
    return 0.0f; // We have no header at this time
}

/*
 *  UIView to show in the footer
 */

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake( 0.0f, 0.0f, self.tableView.bounds.size.width, 16.0f)];
    /*footerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pinkBackGround.png"]];*/
    return footerView;
}

/*
 * Heigh of the footer
 */

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.objects.count) { //Load more line
        return 0.0f;
    }
    return 16.0f;
}

/*
 * Heigh for the row that the sistem is drawing
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.objects.count) {
        // Load More Section
        return 44.0f;
    }
    
    return 280.0f;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == self.objects.count && self.paginationEnabled) {
        // Load More Cell
        [self loadNextPage];
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.frame = CGRectMake(30.0f,20.0f,260.0f,260.0f);
//}

# pragma mark - segues

-(void)showImage:(UIButton *)sender{
    
    NSLog(@"tag %d", sender.tag);
    PFObject *photo = [self.objects objectAtIndex:sender.tag]; //the tag is the index row of the created button

    PFImageView *imageOfPhoto = [[PFImageView alloc] init];
//    imageOfPhoto.image = [UIImage imageNamed:@"Icon.png"];
    
    
    if(photo){
        imageOfPhoto.file = [photo objectForKey:self.imageKey];
        
        // PFQTVC will take care of asynchronously downloading files, but will only load them when the tableview is not moving. If the data is there, let's load it right away.
        if ([imageOfPhoto.file isDataAvailable]) {
            [imageOfPhoto loadInBackground];
        }
    }
    
    imageWillShow = imageOfPhoto;
    
    [self performSegueWithIdentifier: @"showImageSegue" sender: self];

    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showImageSegue"]) {
        ShowImageViewController *destViewController = segue.destinationViewController;
        
        
        destViewController.pfimage = imageWillShow; //set the selected segue to pass for the next view
    }
}


@end
