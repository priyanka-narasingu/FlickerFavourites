//
//  FavouritesViewController.m
//  GoogleSearchJSON
//
//  Created by Priyanka Narasingu on 7/8/14.
//  Copyright (c) 2014 Ouh Eng LIeh. All rights reserved.
//

#import "FavouritesViewController.h"
#import "EditFavouriteViewController.h"


@interface FavouritesViewController ()

@end

@implementation FavouritesViewController

@synthesize database,commentsarray,urlBig,urlSmall,title,commentString, bigImageUrlString,resultView;

NSString * sqlString;
const char *sql_stmt;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *docsDir;
    
    
    
    docsDir=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];

    
    databasepath=[[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"contacts.sqlite"]];
    
    const char *dbPath=[databasepath UTF8String];
    if (sqlite3_open(dbPath, &contactDB)==SQLITE_OK)
    {
        [self getPicture];
    }
    else
    {
        NSLog(@"Failed to create/Open database");
    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)prepareStatment
{
   }

-(void)getPicture{
   
    sqlString=[NSString stringWithFormat:@"SELECT URLSMALL, URLLARGE, COMMENT, TITLE FROM FLICKERPIC"];
    
    sql_stmt=[sqlString UTF8String];
    
    sqlite3_prepare_v2(contactDB, sql_stmt, -1, &selectStmt, NULL);
    [urlSmall removeAllObjects];
    [urlBig removeAllObjects];
    [commentsarray removeAllObjects];
    [title removeAllObjects];

        while (sqlite3_step(selectStmt) == SQLITE_ROW) {
           
            [self.urlSmall addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 0)]];
            
            [self.urlBig addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 1)]];
            
            [self.commentsarray addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 2)]];
            
            [self.title addObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStmt, 3)]];
        }
    sqlite3_reset(selectStmt);
    sqlite3_clear_bindings(selectStmt);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    commentsarray=[[NSMutableArray alloc]init];
    urlBig=[[NSMutableArray alloc]init];
    urlSmall=[[NSMutableArray alloc]init];
    title=[[NSMutableArray alloc]init];
    [self getPicture];
    [resultView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.title.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSUInteger row = indexPath.row;
//    NSLog([self.title objectAtIndex:row]);
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.title objectAtIndex:row]];
    
    NSString *image = [self.urlSmall objectAtIndex:indexPath.row];
    [[cell imageView]setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self getPicture];

    self.bigImageUrlString=[self.urlBig objectAtIndex:indexPath.row];
    self.commentString=[self.commentsarray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"FavPush" sender:self];
    
    

    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        sqlString=[NSString stringWithFormat:@"DELETE FROM FLICKERPIC WHERE URLLARGE=?"];
        
        sql_stmt=[sqlString UTF8String];
        
        sqlite3_prepare_v2(contactDB, sql_stmt, -1, &deleteStmt, NULL);
        
        sqlite3_bind_text(deleteStmt, 1, [[self.urlBig objectAtIndex:indexPath.row] UTF8String], -1, SQLITE_TRANSIENT);

        [tableView reloadData];
        if(sqlite3_step(deleteStmt)==SQLITE_DONE)
        {

           [self viewWillAppear:YES];
            
        }
        else
        {
            NSLog(@"%s",sqlite3_errmsg(contactDB));
            
        }
        sqlite3_reset(deleteStmt);
        sqlite3_clear_bindings(deleteStmt);
    }
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FavPush"]) {
       
        EditFavouriteViewController  * ef = (EditFavouriteViewController*) segue.destinationViewController;
        [ef setValue:commentString forKey:@"comment"];
        [ef setValue:bigImageUrlString forKey:@"imageUrl"];
        
    }
}


@end
