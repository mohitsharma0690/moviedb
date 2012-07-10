//
//  RateMovieViewController.m
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RateMovieViewController.h"

@interface RateMovieViewController ()

@end

@implementation RateMovieViewController
@synthesize movieNameTextField = _movieNameTextField;
@synthesize movieDataTableView = _movieDataTableView;
@synthesize movieData = _movieData;
@synthesize movieName = _movieName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setMovieNameTextField:nil];
    [self setMovieDataTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if(textField == _movieNameTextField) {
        [textField resignFirstResponder];
        self.movieName = [textField text];
        self.movieData = [self getDataFromJSON];
        // reload table
        [_movieDataTableView reloadData];
    }
    return YES;
}

- (IBAction)getRatingMessage:(id)sender {
    UIAlertView *msg = [[UIAlertView alloc] initWithTitle:@"Rate the movie" 
                                            message:nil 
                                            delegate:self 
                                            cancelButtonTitle:@"cancel" 
                                            otherButtonTitles:@"Good",@"Ok",@"Bad", nil];
    [msg show];
    [msg autorelease];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Good"]) {
        NSLog(@"User Rating : Good Movie");
    } else if([title isEqualToString:@"Ok"]) {
        NSLog(@"User Rating : Ok Movie");
    } else if([title isEqualToString:@"Bad"]) {
        NSLog(@"User Rating : Bad Movie");
    } else {
        NSLog(@"No user rating");
    }
}

- (NSArray *) getDataFromJSON {
    // modify the movie name to match the url required
    NSString *address = [NSString stringWithFormat:@"%@",_movieName];
    address = [address stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSLog(@"modified string is %@",address);
    
    // add the requisite URL-prefix
    address = [NSString stringWithFormat:@"%@%@",@"http://www.deanclatworthy.com/imdb/?q=",address];
    
    NSURL *url = [[NSURL alloc] initWithString:address];
    NSData *jsonData = [NSData dataWithContentsOfURL: url];
    
    if(jsonData != nil) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:jsonData options:
                     NSJSONReadingMutableContainers error:&error];
        if(error == nil) {
            NSLog(@"%@", result);
            NSArray *arr = [[NSArray alloc] initWithObjects:[result objectForKey:@"rating"],
                            [result objectForKey:@"year"], [result objectForKey:@"languages"], 
                            [result objectForKey:@"country"], nil]; 
            [url release];
            return [arr autorelease];
        }
    }
    [url release];
    return [[[NSArray alloc] initWithObjects:@"n/a", @"n/a", @"n/a", @"n/a", nil] autorelease];    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"in MovieTableViewController.m - tableView");
    static NSString *CellIdentifier = @"MoviedbCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...    
    if(indexPath.row == 0) {
        cell.textLabel.text = @"Rating";
    } else if(indexPath.row == 1) {
        cell.textLabel.text = @"Year";
    } else if(indexPath.row == 2) {
        cell.textLabel.text = @"Language";
    } else {
        cell.textLabel.text = @"Country";
    }
    
    if([_movieData count] > indexPath.row) {
        cell.detailTextLabel.text = [_movieData objectAtIndex: indexPath.row];
    } else {
        cell.detailTextLabel.text = @"n/a";
    }
    return cell;
}

// Table View data source ends

- (void)dealloc {
    [_movieNameTextField release];
    [_movieDataTableView release];
    [_movieName release];
    [_movieData release];
    [super dealloc];
}
@end
