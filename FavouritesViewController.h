//
//  FavouritesViewController.h
//  GoogleSearchJSON
//
//  Created by Priyanka Narasingu on 7/8/14.
//  Copyright (c) 2014 Ouh Eng LIeh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface FavouritesViewController : UITableViewController
{
    NSString *databasepath;
    UITextField *comments;
    sqlite3 *contactDB;
    sqlite3_stmt *insertStmt;
    sqlite3_stmt *updateStmt;
    sqlite3_stmt *deleteStmt;
    sqlite3_stmt *selectStmt;
    sqlite3 *database;
    NSMutableArray *commentsarray;
    NSMutableArray *urlSmall;
    NSMutableArray *urlBig;
    NSMutableArray *title;

    
    NSString *commentString;
    NSString *bigImageUrlString;
    UITableView *resultView;
    

}
@property(strong, nonatomic) IBOutlet UITableView *resultView;
@property(strong, nonatomic) NSMutableArray *commentsarray;
@property(strong, nonatomic) NSMutableArray *urlSmall;
@property(strong, nonatomic) NSMutableArray *urlBig;
@property(strong, nonatomic) NSMutableArray *title;

@property (nonatomic, readonly) sqlite3 *database;

@property(strong, nonatomic) NSString *commentString;
@property(strong, nonatomic) NSString *bigImageUrlString;


@end
