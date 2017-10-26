//
//  LogSelectTableViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 10/20/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "LogSelectTableViewController.h"
#import <UICKeyChainStore.h>

@interface LogSelectTableViewController ()

@end

@implementation LogSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //WHAT ABOUT A TITLE?!?!?!?! NEED TO CREATE A TITLE OBJECT THEN CAN SHOOT ONTO EACH PAGE
    NSString *p1Name = [UICKeyChainStore stringForKey:@"project1Name"];
    self.navigationItem.title = p1Name;
    
    
    //set the array items here. To start we can have the procurement and submittal log. Eventually we can get to billing/projections/etc.
    self.logOptions = [NSArray arrayWithObjects:@"Procuremnt Log",
                       @"Submittal Log",
                       nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.logOptions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Log Cell Identifier" forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Log Cell Identifier"];
    }
    
    //here set the text words and style, bold. can edit later if wanted
    cell.textLabel.text = self.logOptions[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    
    
    return cell;
}


//Use this method to indent title/info if needed
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Sets indent for all rows less than count to 0. So none will be indented, but can easibly come back and play with numbers to edit.
    if (indexPath.row < self.logOptions.count) {
        return 0;
    } else {
        return 2;
    }
}


//Set the cell height here... it will only ever be 2 or eventually 3. can't have it as the full screen though.. fuck with this until it looks cool.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    CGFloat navControllerHeight = self.navigationController.toolbar.frame.size.height;
    
    CGFloat correctHeight = screenHeight - navBarHeight - navControllerHeight - 25;
    
    //CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat numSettings = self.logOptions.count;
    
    CGFloat cellHeight;
    
    if (numSettings > 4) {
        
        cellHeight = correctHeight / numSettings;
        
    } else {
        
        cellHeight = screenHeight / 5;
    }
    
    //fuck this line. prints too many.
    //NSLog(@"Settings cell height is equal to %f", cellHeight);
    
    return cellHeight;
}



//Segues for each row
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *rowValue = self.logOptions[indexPath.row];
    
    if ([rowValue isEqualToString:@"Procurement Log"]) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            //This segue is not setup. Create one that goes to the log
            [self performSegueWithIdentifier:@"procurementLogSegue" sender:self];
            
        });
        
    } else if ([rowValue isEqualToString:@"Submittal Log"]) {
        
        //once you get this feature working, segue to it, til then just have a pop up so the app doesn't crash
        //        dispatch_async(dispatch_get_main_queue(),   ^{
        //
        //            //still need to create this segue
        //            [self performSegueWithIdentifier:@"faqSegue" sender:self];
        
        //        });
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message1 = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:message1 message:@"This feature isn't working yet!." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
            
            [alert1 addAction:defaultAction1];
            [self presentViewController:alert1 animated:YES completion:nil];
            
        });
        
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
