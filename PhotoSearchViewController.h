//
//  FirstViewController.h
//  GoogleSearchJSON
//
//  Created by Priyanka Narasingu on 29/7/14.
//  Copyright (c) 2014 iss. All rights reserved.

#import <UIKit/UIKit.h>
@class  SearchResults;
@interface PhotoSearchViewController : UIViewController<UITextFieldDelegate> {
	UITextField *searchString;
	UIActivityIndicatorView *activityIndicatorView;
    NSMutableData *buffer;
	NSURLConnection *conn;
  
}
@property(strong, nonatomic) IBOutlet UITextField *searchString;
@property(strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property(strong, nonatomic) NSMutableData *buffer;
@property(weak, nonatomic) SearchResults *searchResults;
//@property(strong, nonatomic) NSMutableArray  *photoTitles;
//@property(strong, nonatomic) NSMutableArray  *photoSmallImageData;
//@property(strong, nonatomic) NSMutableArray  *photoURLsLargeImage;



- (IBAction) search;
- (void) processResponse:(NSMutableData *) data;
- (void)searchFlickrPhotos:(NSString *)text;

@end
