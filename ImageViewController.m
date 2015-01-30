//
//  Created by Priyanka Narasingu on 06/08/2014.
//  Copyright (c) 2014 iss. All rights reserved.
//

#import "ImageViewController.h"
#import "SearchResults.h"
#import <Social/Social.h>

@implementation ImageViewController

@synthesize imageView, searchResults, comments;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
//	NSLog(@"Loading view");
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    comments.delegate=self;
    NSString *docsDir;
    docsDir=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    databasepath=[[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"contacts.sqlite"]];
    
    const char *dbPath=[databasepath UTF8String];
    if (sqlite3_open(dbPath, &contactDB)==SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt="CREATE TABLE IF NOT EXISTS FLICKERPIC(ID INTEGER PRIMARY KEY AUTOINCREMENT, URLSMALL TEXT, URLLARGE TEXT, COMMENT TEXT, TITLE TEXT)";
        if (sqlite3_exec(contactDB,sql_stmt, NULL, NULL, &errMsg)!=SQLITE_OK) {
            NSLog(@"Failed to create table");
        }
        
    }
    else
    {
        NSLog(@"Failed to create/Open database");
    }
    [self prepareStatment];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [comments resignFirstResponder];
    return YES;
}


-(void)prepareStatment
{
    NSString * sqlString;
    const char *sql_stmt;
    
    sqlString=[NSString stringWithFormat:@"INSERT INTO FLICKERPIC(URLSMALL, URLLARGE, COMMENT, TITLE) VALUES(?,?,?,?)"];
    sql_stmt=[sqlString UTF8String];
    
    sqlite3_prepare_v2(contactDB, sql_stmt, -1, &insertStmt, NULL);
    }

-(void)addFavourites;

{
    
    sqlite3_bind_text(insertStmt, 1, [searchResults.picUrlSmall UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_bind_text(insertStmt, 2, [searchResults.picUrlBig UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_bind_text(insertStmt, 3, [comments.text UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_bind_text(insertStmt, 4, [searchResults.picTitle UTF8String], -1, SQLITE_TRANSIENT);
    
    if(sqlite3_step(insertStmt)==SQLITE_DONE)
    {
        UIAlertView *alertPopUp=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Added to favourites" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertPopUp show];
        
        NSLog(@"Added to favourites");
        comments.text=@"";
        
        
    }
    else
    {
        NSLog(@"%s",sqlite3_errmsg(contactDB));
        NSLog(@"Failed to add");
    }
    sqlite3_reset(insertStmt);
    sqlite3_clear_bindings(insertStmt);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *urlImage = searchResults.picUrlBig;
    
    
    [imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                [NSURL URLWithString:urlImage]]]];


    
}
-(IBAction)facebookbtn{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"Cancelled");
            } else
            {
                NSLog(@"Done");
            }
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        
         NSString *urlImage = searchResults.picUrlBig;
        [controller setInitialText:@"App testing Post"];
        //[controller addURL:[NSURL URLWithString:@"http://farm6.static.flickr.com/"]];
        [controller addImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                     [NSURL URLWithString:urlImage]]]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }

}
-(IBAction)favbtn{
    [self addFavourites];
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)webViewDidFinishLoad:(UIWebView *)currentWebView{
 
   // [addressbar setText:[url absoluteString]];
}

@end
