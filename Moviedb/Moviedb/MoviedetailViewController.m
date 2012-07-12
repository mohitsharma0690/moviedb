//
//  MovieDetailViewController.m
//  Moviedb
//
//  Created by mohit sharma on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieInfo.h"
#import "WebViewController.h"

@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController
@synthesize titleLabel = _titleLabel;
@synthesize movieDetailTableView = _movieDetailTableView;
@synthesize movieData = _movieData;


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
    self.titleLabel.text = [self.movieData name];
    self.title = [self.movieData name];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setMovieDetailTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellText = @"8.00000000000";
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:17.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // movie name is declared earlier
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MovieDetailCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.textLabel.numberOfLines = 0;
    //cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    
    // configure the cell
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"IMDB id";
            cell.detailTextLabel.text = [self.movieData imdbId];
            break;
        case 1:
            cell.textLabel.text = @"Rating";
            cell.detailTextLabel.text = [[[self.movieData rating] stringValue] substringToIndex:3];
            break;
        case 2:
            cell.textLabel.text = @"Year";
            cell.detailTextLabel.text = [[self.movieData year] stringValue];
            break;
        case 3:
            cell.textLabel.text = @"Country";
            cell.detailTextLabel.text = [self.movieData country];
            break;
        case 4:
            cell.textLabel.text = @"Language";
            cell.detailTextLabel.text = [[[self.movieData language] componentsSeparatedByString:@","] objectAtIndex:0];
            break;
        case 5:
            cell.textLabel.text = @"Your Rating";
            switch ([[self.movieData userRating] intValue]) {
                case 3:
                    cell.detailTextLabel.text = @"AWESOME !!";
                    break;
                case 2:
                    cell.detailTextLabel.text = @"So So .. ";
                    break;
                case 1:
                    cell.detailTextLabel.text = @"Sucks";
                default:
                    break;
            }
            break;
        case 6:
            cell.textLabel.text = @"Genre";
            cell.detailTextLabel.text = [[[self.movieData genre] componentsSeparatedByString:@","] objectAtIndex:0];
            break;
        default:
            cell.textLabel.text = @"N/A";
            cell.detailTextLabel.text = @"N/A";
            break;
    }
    return cell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"imdbPage"]) {
        WebViewController *destViewController = segue.destinationViewController;
        destViewController.imdbId = [self.movieData imdbId];
        destViewController.name = [self.movieData name];
    }
}

- (void)dealloc {
    [_titleLabel release];
    [_movieDetailTableView release];
    [_movieData release];
    [super dealloc];
}
@end
