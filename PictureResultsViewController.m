
//
//  Created by Priyanka Narasingu on 06/08/2014.
//  Copyright (c) 2014 iss. All rights reserved.
//


#import "PictureResultsViewController.h"
#import "SearchResults.h"
#import "AudioController.h"

@interface PictureResultsViewController()
@property (strong, nonatomic) AudioController *audioController;



@end
@implementation PictureResultsViewController


@synthesize resultView, searchResults;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Results";
    self.audioController = [[AudioController alloc] init];
    [self.audioController tryPlayMusic];
    
    
}



- (void)viewWillAppear:(BOOL)animated {
	[resultView reloadData];
    
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // return 1;
        return searchResults.photoTitles.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSUInteger row = indexPath.row;
    cell.textLabel.text = [NSString stringWithFormat:@"%d. %@", row+1,[searchResults.photoTitles objectAtIndex:row]];
    
    NSString *image = [searchResults.photoSmallImageData objectAtIndex:indexPath.row];
    [[cell imageView]setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]]];

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
	NSUInteger row = indexPath.row;
    searchResults.picUrlBig = [searchResults.photoURLsLargeImage objectAtIndex:row];
    searchResults.picUrlSmall=[searchResults.photoSmallImageData objectAtIndex:row];
    searchResults.picTitle=[searchResults.photoTitles objectAtIndex:row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchWebView" object:nil];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}



@end

