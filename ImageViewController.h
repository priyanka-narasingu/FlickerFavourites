//
//  Created by Priyanka Narasingu on 06/08/2014.
//  Copyright (c) 2014 iss. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <sqlite3.h>
@class SearchResults;
@interface ImageViewController : UIViewController<UITextFieldDelegate>{
	UIImageView *imageView;
    NSString *databasepath;
    UITextField *comments;
    sqlite3 *contactDB;
    sqlite3_stmt *insertStmt;
    sqlite3_stmt *updateStmt;
    sqlite3_stmt *deleteStmt;
    sqlite3_stmt *selectStmt;
    
}
@property(strong, nonatomic) IBOutlet UIImageView *imageView;
@property(strong, nonatomic) IBOutlet UITextField *comments;
@property(weak, nonatomic) SearchResults *searchResults;

-(IBAction) facebookbtn;
-(IBAction) favbtn;
@end
