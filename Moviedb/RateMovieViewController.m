//
//  RateMovieViewController.m
//  Moviedb
//
//  Created by mohit sharma on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RateMovieViewController.h"
#import "MovieInfo.h"
#import "MoviedbAppDelegate.h"
#import <Foundation/Foundation.h>

@interface RateMovieViewController ()

@end

@implementation RateMovieViewController
@synthesize tapGesture = _tapGesture;
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
    [self setTapGesture:nil];
    [self setTapGesture:nil];
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
    MoviedbAppDelegate *appDelegate = (MoviedbAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setDictionary:self.movieData];
    bool check=false;	
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Good"]) {
        NSLog(@"User Rating : Good Movie");
        [data setValue:[NSNumber numberWithInt:3] forKey:@"userRating"];
        check = true;
    } else if([title isEqualToString:@"Ok"]) {
        NSLog(@"User Rating : Ok Movie");
        [data setValue:[NSNumber numberWithInt:2] forKey:@"userRating"];
        check = true;
    } else if([title isEqualToString:@"Bad"]) {
        NSLog(@"User Rating : Bad Movie");
        [data setValue:[NSNumber numberWithInt:1] forKey:@"userRating"];
        check = true;
    } else {
        NSLog(@"No user rating");
    }
    if(check) {
        MovieInfo *movieObj = [[MovieInfo alloc] initMovieWithDict:data];
        [appDelegate addMovie:movieObj];
        [movieObj autorelease];
    }
    [data autorelease];
}

- (id) getDataFromJSON {
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
            [url release];
            return result;
//            NSLog(@"%@", result);
//            if([[result objectForKey:@"code"] intValue]== 1) {
//                [url autorelease];
//                return [[[NSArray alloc] 
//                         initWithObjects:@"n/a", @"n/a", @"n/a", @"n/a", @"n/a", @"n/a", @"n/a", nil] autorelease];
//            
//            } else {
//                NSArray *arr = [[NSArray alloc] initWithObjects:[result objectForKey:@"imdbid"], 
//                                [result objectForKey:@"title"],
//                                [result objectForKey:@"rating"],
//                                [result objectForKey:@"year"], 
//                                [result objectForKey:@"languages"], 
//                                [result objectForKey:@"country"],
//                                [result objectForKey:@"genre"], nil]; 
//                [url release];
//                return [arr autorelease];
//            } 
        }
    }
    [url release];
    return nil;
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
        if([self.movieData objectForKey:@"rating"] == nil) {
            cell.detailTextLabel.text = @"n/a";
        } else {
            cell.detailTextLabel.text = [self.movieData objectForKey:@"rating"];
        }
    } else if(indexPath.row == 1) {
        cell.textLabel.text = @"Year";
        if([self.movieData objectForKey:@"year"] == nil) {
            cell.detailTextLabel.text = @"n/a";
        } else {
            cell.detailTextLabel.text = [self.movieData objectForKey:@"year"];
        }
    } else if(indexPath.row == 2) {
        cell.textLabel.text = @"Language";
        if([self.movieData objectForKey:@"languages"] == nil) {
            cell.detailTextLabel.text = @"n/a";
        } else {
            cell.detailTextLabel.text = [self.movieData objectForKey:@"languages"];
        }
    } else {
        cell.textLabel.text = @"Country";
        if([self.movieData objectForKey:@"country"] == nil) {
            cell.detailTextLabel.text = @"n/a";
        } else {
            cell.detailTextLabel.text = [self.movieData objectForKey:@"country"];
        }
    }
    return cell;
}

// Table View data source ends

- (IBAction)hideKeyboard:(id)sender {
    [self.movieNameTextField resignFirstResponder];
}

- (void)dealloc {
    [_movieNameTextField release];
    [_movieDataTableView release];
    [_movieName release];
    [_movieData release];
    [_tapGesture release];
    [_tapGesture release];
    [super dealloc];
}

@end
