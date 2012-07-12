//
//  WebViewController.h
//  Moviedb
//
//  Created by mohit sharma on 12/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (retain, nonatomic) NSString *imdbId;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) NSString *name;

@end
