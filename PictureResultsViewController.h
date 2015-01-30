
//
//  Created by Priyanka Narasingu on 06/08/2014.
//  Copyright (c) 2014 iss. All rights reserved.
//


#import <UIKit/UIKit.h>
@class SearchResults;
@interface PictureResultsViewController : UITableViewController<NSURLSessionDataDelegate> {
	UITableView *resultView;
}
@property(strong, nonatomic) IBOutlet UITableView *resultView;

@property(weak, nonatomic) SearchResults *searchResults;
@end
