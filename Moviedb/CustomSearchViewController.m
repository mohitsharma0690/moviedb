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
@synthesize selectedRowFirstComp = _selectedRowFirstComp;
@synthesize selectedRowSecondComp = _selectedRowSecondComp;
@synthesize pickerItems = _pickerItems;

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
    
    // init the movieData array
    // self.movieData = appDelegate.movieArray;
    self.movieData = [NSMutableArray array];
    
    [self loadPickerViewItems:0];
    [self performSortBasedOnRows];
    [self.tableView reloadData];
    
    self.selectedRowFirstComp =  0;
    self.selectedRowSecondComp = 0;
    
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

- (void) loadPickerViewItems:(NSInteger) selRow {
    // genre
    NSMutableArray *temp;
    if(selRow == 0) {
        temp = [[NSMutableArray alloc] initWithObjects:@"Drama",@"Action",@"Fantasy",@"Romance",nil];
    } else if(selRow == 1) {
        temp = [[NSMutableArray alloc]  initWithObjects:@"US",@"India",@"Rest",nil];
    } else if(selRow == 2) {
        temp = [[NSMutableArray alloc] initWithObjects:@"English",@"Hindi",@"Rest",nil];
    } else {
        temp = [[NSMutableArray alloc] initWithObjects:@"Before 2000", @"After 2000",nil];
    }
    self.pickerItems = temp;
    [self.pickerView reloadComponent:1];
    [temp release];
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) {
        return 4;
    } else {
        return [self.pickerItems count];
    }
}

// picker view delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *rowName; 
    if(component == 0) {
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
    } else {
        rowName = [self.pickerItems objectAtIndex:row];
        return rowName;
    }
    return [rowName autorelease];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component == 0) {
        [self loadPickerViewItems:row];
        self.selectedRowFirstComp = row;
        //self.selectedRowSecondComp = 0;
    } else {
        self.selectedRowSecondComp = row;
    }
    [self performSortBasedOnRows];
}

- (void) performSortBasedOnRows {

    [self.movieData removeAllObjects];
    MoviedbAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];    
    /* genre */
    NSEnumerator *e = [appDelegate.movieArray objectEnumerator];

    MovieInfo *obj;
    if(self.selectedRowFirstComp == 0) {
        while ( obj = [e nextObject]) {
            if([[obj genre] rangeOfString:[self.pickerItems objectAtIndex:self.selectedRowSecondComp] options:NSCaseInsensitiveSearch].length != 0) {
                [self.movieData addObject:obj];
            }
        }
    } else if(self.selectedRowFirstComp == 1) {
        while(obj = [e nextObject]) {
            if([[obj country] rangeOfString:[self.pickerItems objectAtIndex:self.selectedRowSecondComp] options:NSCaseInsensitiveSearch].length != 0) {
                [self.movieData addObject:obj];
            }
        }
    } else if(self.selectedRowFirstComp == 2) {
        while(obj = [e nextObject]) {
            if([[obj language] rangeOfString:[self.pickerItems objectAtIndex:self.selectedRowSecondComp]  options:NSCaseInsensitiveSearch].length != 0) {
                [self.movieData addObject:obj];
            }
        }
    } else {
        while(obj = [e nextObject]) {
            if(self.selectedRowSecondComp == 0 && [[obj year] intValue] < 2000) {
                [self.movieData addObject:obj];
            } else if(self.selectedRowSecondComp == 1 && [[obj year] intValue] >= 2000) {
                [self.movieData addObject:obj];
            }
        }
    }

    [self.tableView reloadData];

}

// table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movieData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomSearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [[self.movieData objectAtIndex:indexPath.row] name];
    if(self.selectedRowFirstComp == 3) {
        MovieInfo *obj = [self.movieData objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [[obj year] stringValue];
    } else {
        cell.detailTextLabel.text = [self.pickerItems objectAtIndex:self.selectedRowSecondComp];
    }
//    switch (self.selectedRowFirstComp) {
//        case 0:
//            cell.detailTextLabel.text = [[[[self.movieData objectAtIndex:indexPath.row] genre] componentsSeparatedByString:@","] objectAtIndex:0];
//            break;
//        case 1:
//            cell.detailTextLabel.text = [[[[self.movieData objectAtIndex: indexPath.row] country] componentsSeparatedByString:@","] objectAtIndex:0];
//            break;
//        case 2:
//            cell.detailTextLabel.text = [[[[self.movieData objectAtIndex: indexPath.row] language] componentsSeparatedByString:@","] objectAtIndex:0];
//            break;
//        case 3:
//            cell.detailTextLabel.text = [[[self.movieData objectAtIndex: indexPath.row] year] stringValue];
//    }
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
    [_pickerItems release];
    [super dealloc];
}
@end
