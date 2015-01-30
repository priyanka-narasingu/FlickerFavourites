//
//  EditFavouriteViewController.m
//  GoogleSearchJSON
//
//  Created by Priyanka Narasingu on 7/8/14.
//  Copyright (c) 2014 Ouh Eng LIeh. All rights reserved.
//

#import "EditFavouriteViewController.h"

@interface EditFavouriteViewController ()

@end

@implementation EditFavouriteViewController
@synthesize comment,imageUrl,textFieldComment,imageView;
NSString * sqlString;
const char *sql_stmt;
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
    textFieldComment.delegate=self;
    
    // Do any additional setup after loading the view.
    textFieldComment.text=self.comment;
    [imageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                [NSURL URLWithString:self.imageUrl]]]];
    
    NSString *docsDir;
    docsDir=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    databasepath=[[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"contacts.sqlite"]];
    
    const char *dbPath=[databasepath UTF8String];
    if (sqlite3_open(dbPath, &contactDB)==SQLITE_OK)
    {
        NSLog(@"DB Success");
    }
    else
    {
        NSLog(@"Failed to create/Open database");
    }

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textFieldComment resignFirstResponder];
    return YES;
}
-(IBAction)update
{
    [self UpdateComment];
    
}

-(void)UpdateComment
{
   
    
    sqlString=[NSString stringWithFormat:@"UPDATE FLICKERPIC SET COMMENT=? WHERE URLLARGE=?"];
    
    sql_stmt=[sqlString UTF8String];
    
    sqlite3_prepare_v2(contactDB, sql_stmt, -1, &updateStmt, NULL);
    
    sqlite3_bind_text(updateStmt, 1, [textFieldComment.text UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_bind_text(updateStmt, 2, [imageUrl UTF8String], -1, SQLITE_TRANSIENT);
    
    if(sqlite3_step(updateStmt)==SQLITE_DONE)
    {
        UIAlertView *alertPopUp=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Updated Comment" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertPopUp show];
        textFieldComment.text=@"";
    }
    else
    {
        NSLog(@"%s",sqlite3_errmsg(contactDB));
        
    }
    sqlite3_reset(updateStmt);
    sqlite3_clear_bindings(updateStmt);
    
}

-(IBAction)deleteFromFav
{
    
    [self dismissViewControllerAnimated: YES completion:nil];
    

}

-(void)viewWillAppear:(BOOL)animated
{
    textFieldComment.text=self.comment;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
