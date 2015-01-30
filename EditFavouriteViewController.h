//
//  EditFavouriteViewController.h
//  GoogleSearchJSON
//
//  Created by Priyanka Narasingu on 7/8/14.
//  Copyright (c) 2014 Ouh Eng LIeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface EditFavouriteViewController : UIViewController<UITextFieldDelegate>
{
    NSString *comment;
    NSString *imageUrl;
    UITextField *textFieldComment;
    UIImageView *imageView;
    sqlite3 *contactDB;
    NSString *databasepath;
    sqlite3_stmt *updateStmt;
    sqlite3_stmt *deleteStmt;

}
@property(strong, nonatomic)NSString *comment;
@property(strong, nonatomic)NSString *imageUrl;

@property(strong, nonatomic)IBOutlet UITextField *textFieldComment;
@property(strong, nonatomic)IBOutlet UIImageView *imageView;

-(IBAction)update;
-(IBAction)deleteFromFav;

@end
