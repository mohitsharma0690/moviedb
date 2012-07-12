//
//  CustomSearchViewController.m
//  Moviedb
//
//  Created by mohit sharma on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomSearchViewController.h"
#import "WebViewController.h"

@interface CustomSearchViewController ()

@end

@implementation CustomSearchViewController
@synthesize pickerView = _pickerView;
@synthesize tableView = _tableView;
@synthesize movieData = _movieData;
@synthesize selectedRow = _selectedRow;

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
    self.title = @"Custom Search";
    MoviedbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.movieData = appDelegate.movieArray;
    [self performSortBasedOnRow:0];
    [self.tableView reloadData];
    self.selectedRow = 0;
}

- (void)viewDidUnload
{
    [self setPickerView:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
// picker view data source
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 4;
}

// picker view delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *rowName; 
    switch (row) {
        case 0:
            rowName = [[NSString alloc] initWithString:@"Genre"];
            break;
        case 1:
            rowName = [[NSString alloc] initWithString:@"Country"];
            break;
        case 2:
            rowName = [[NSString alloc] initWithString:@"Language"];
            break;
        case 3:
            rowName = [[NSString alloc] initWithString:@"Year"];
            break;
        default:
            return nil;
            break;
    }
    return [rowName autorelease];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self performSortBasedOnRow: row];
    self.selectedRow = row;
}

- (void) performSortBasedOnRow:(NSInteger) row {

    NSSortDescriptor *sortDesc;
    switch (row) {
        case 0:
            sortDesc = [[NSSortDescriptor alloc] initWithKey:@"genre" ascending:YES];
            break;
        case 1:
            sortDesc = [[NSSortDescriptor alloc] initWithKey:@"country" ascending:YES];
            break;
        case 2:
            sortDesc = [[NSSortDescriptor alloc] initWithKey:@"language" ascending:YES];
            break;
        case 3:
            sortDesc = [[NSSortDescriptor alloc] initWithKey:@"year" ascending:YES];
            break;
        default:
            return;
            break;
    }
    
    MoviedbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSArray *sortDescs = [NSArray arrayWithObject:sortDesc];
    self.movieData = [NSMutableArray arrayWithArray:[appDelegate.movieArray sortedArrayUsingDescriptors:sortDescs]];
    [self.tableView reloadData];
    [sortDesc release];
}

// table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movieData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomSearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [[self.movieData objectAtIndex:indexPath.row] name];
    switch (self.selectedRow) {
        case 0:
            cell.detailTextLabel.text = [[[[self.movieData objectAtIndex:indexPath.row] genre] componentsSeparatedByString:@","] objectAtIndex:0];
            break;
        case 1:
            cell.detailTextLabel.text = [[[[self.movieData objectAtIndex: indexPath.row] country] componentsSeparatedByString:@","] objectAtIndex:0];
            break;
        case 2:
            cell.detailTextLabel.text = [[[[self.movieData objectAtIndex: indexPath.row] language] componentsSeparatedByString:@","] objectAtIndex:0];
            break;
        case 3:
            cell.detailTextLabel.text = [[[self.movieData objectAtIndex: indexPath.row] year] stringValue];
    }
    return cell;  
}

- (void)  prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"CustomSearchSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WebViewController *destViewController = segue.destinationViewController;
        destViewController.imdbId = [[self.movieData objectAtIndex:indexPath.row] imdbId];
        destViewController.name = [[self.movieData objectAtIndex:indexPath.row] name];
    }
}

- (void) showMessage:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Inconvenience Regretted" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView autorelease];
}

- (void)dealloc {
    [_pickerView release];
    [_tableView release];
    [_movieData release];
    [super dealloc];
}
@end
