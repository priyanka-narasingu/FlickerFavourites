//
//  FirstViewController.m
//  GoogleSearchJSON
//
//  Created by Priyanka Narasingu on 29/7/14.
//  Copyright (c) 2014 iss. All rights reserved.

#import "PhotoSearchViewController.h"
#import "SearchResults.h"
#import "Reachability.h"

@implementation PhotoSearchViewController
NSString *const FlickrAPIKey = @"2f4a83741d73a4b390fca0cd22a866ee";

@synthesize searchString, activityIndicatorView, buffer;

- (IBAction) search {
        [activityIndicatorView startAnimating];
    
    Reachability * reachability=[Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus remoteHostStatus=[reachability currentReachabilityStatus];
    
    if (remoteHostStatus==NotReachable) {
        NSLog(@"Not Reachable");
        UIAlertView *alertPopUp=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Not Connected to Network"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertPopUp show];
    }
    else if (remoteHostStatus==ReachableViaWWAN)
    {
        NSLog(@"Reachable via WWAN");
    }
    else if (remoteHostStatus==ReachableViaWiFi)
    {
        NSLog(@"Reachable via WIFI");
    }
    
    
    self.buffer = [NSMutableData data];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:
                             defaultConfigObject delegate:
                             self delegateQueue:
                             [NSOperationQueue mainQueue]];
    [[session dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey,searchString.text]]] resume];

   
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [buffer appendData:data];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
        NSLog(@"Done with bytes %d", [buffer length]);
        
        [self processResponse:buffer];
    }
    else
        NSLog(@"Error %@",[error userInfo]);
    [activityIndicatorView stopAnimating];

}

- (void) processResponse:(NSMutableData *)data {
	NSError *e = nil;
    
    [self.searchResults.photoTitles removeAllObjects];
    [self.searchResults.photoSmallImageData removeAllObjects];
    [self.searchResults.photoURLsLargeImage removeAllObjects];
    
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data
                        options:NSJSONReadingMutableContainers error:&e];
    
   
    NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    for (NSDictionary *photo in photos) {
        
       		NSString *title = [photo objectForKey:@"title"];
        
        [self.searchResults.photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
		
       
		NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        [self.searchResults.photoSmallImageData addObject:photoURLString];
       
		photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
		[self.searchResults.photoURLsLargeImage addObject:photoURLString];
        
       // NSLog(photoURLString);
        
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchResultView" object:nil];
    
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void)viewDidLoad{
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"3.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    searchString.delegate=self;
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchString resignFirstResponder];
    return YES;
}


@end
