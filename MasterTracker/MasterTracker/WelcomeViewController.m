//
//  WelcomeViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/16/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //meh about the above to. Set your array of possible settings
    
    self.welcomePageOptions =  [NSArray arrayWithObjects:@"CREATE NEW PROJECT",
                            @"VIEW SHARED PROJECT",
                            // @"EXISTING PROJECT", (this should only pop up when already have an account)
                            nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Will have 1 section in our table view
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Make this equal to the number of array objects in the welcomPageOptions
    return [self.welcomePageOptions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Welcome Cell Identifier" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Welcome Cell Identifier"];
    }
    
    cell.textLabel.text = self.welcomePageOptions[indexPath.row];
    cell.textLabel.font =  [UIFont boldSystemFontOfSize:20];
    
    
    //Can make a NSMutableAttributedString then apply the below slayage
    //    addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Bradley Hand" size:20] range:range];
    //    [cell.textLabel addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10] range: range];
    //    [cell.textLabel addAttribute:NSKernAttributeName value:@1.3 range:range];
    //    [cell.textLabel addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1] range:range];
    
    
    
    
    //This would be to add another sub text either below or to the sides. See if you can incorporate how to get image of arrows on side for this one
    //    if (indexPath.row < self.settingsLabels.count) {
    //        cell.detailTextLabel.text = @"";
    //    } else {
    //        cell.detailTextLabel = @""
    //    }
    
    return cell;
}

//Use this method to indent title/info if needed
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Sets indent for all rows less than count to 0. So none will be indented, but can easibly come back and play with numbers to edit.
    if (indexPath.row < self.welcomePageOptions.count) {
        return 0;
    } else {
        return 2;
    }
}

//This method will allow if you can select a row. The way it is set up now won't let you select row 0 (the first one)
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return nil;
//    } else {
//        return indexPath;
//    }
//}


//Segues for each row
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *rowValue = self.welcomePageOptions[indexPath.row];
    
    if ([rowValue isEqualToString:@"CREATE NEW PROJECT"]) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            //This segue is setup
            [self performSegueWithIdentifier:@"newProjectSetupSegue" sender:self];
            
        });
        
    } else if ([rowValue isEqualToString:@"VIEW SHARED PROJECT"]) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            //still need to create this segue
            [self performSegueWithIdentifier:@"faqSegue" sender:self];
            
        });
        
        
        //focus on this after the first one is gucci. and maybe the second
    //} else if ([rowValue isEqualToString:@"EXISTING PROJECT"]) {
        
        //dispatch_async(dispatch_get_main_queue(),   ^{
            
            //[self performSegueWithIdentifier:@"assetsAcceptedSegue" sender:self];
            
        //});
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
    CGFloat numSettings = self.welcomePageOptions.count;
    
    CGFloat cellHeight = correctHeight / numSettings;
    
    //fuck this line. prints too many.
    //NSLog(@"Settings cell height is equal to %f", cellHeight);
    
    return cellHeight;
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
