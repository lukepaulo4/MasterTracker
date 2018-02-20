//
//  ProcurementLogTVControllerTableViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 10/25/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "ProcurementLogTVControllerTableViewController.h"
#import <UICKeyChainStore.h>
#import "DataSource.h"
#import "MyItems.h"
#import "User.h"
#import "ProcurementItemTVCell.h"
#import "ProcurementItemFullScreenViewController.h"


@interface ProcurementLogTVControllerTableViewController () <ProcurementItemTVCellDelegate>


@end

@implementation ProcurementLogTVControllerTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[DataSource sharedInstance] addObserver:self forKeyPath:@"myItems" options:0 context:nil];
    
    //register the cell for this beezy
    [self.tableView registerClass:[ProcurementItemTVCell class] forCellReuseIdentifier:@"procurementCell"];

    
    
    /*
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *p1Name = [UICKeyChainStore stringForKey:@"project1Name"];
    self.navigationItem.title = p1Name;
    
    NSLog(@"array from DataSource view did load is %@", [DataSource sharedInstance].myItems);
    
    //register for KVO of myItems
    [[DataSource sharedInstance] addObserver:self forKeyPath:@"myItems" options:0 context:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidFire:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView registerClass:[ProcurementItemTVCell class] forCellReuseIdentifier:@"procurementItemIdentifier"];
     */
    
}



//method for above refreshControlDidFire
//- (void) refreshControlDidFire:(UIRefreshControl *) sender {
//    [[DataSource sharedInstance] requestNewItemsWithCompletionHandler:^(NSError *error) {
//       [sender endRefreshing];
//    }];
//}


//observers must be removed when they're no longer needed. dealloc method best place to do this
- (void) dealloc {
    [[DataSource sharedInstance] removeObserver:self forKeyPath:@"myItems"];
}


//all KVOs must be sent to precisely one method. add code to handle it
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //check if update is coming from DataSource object we registered with & is myItems the updated key?
    if (object == [DataSource sharedInstance] && [keyPath isEqualToString:@"myItems"]) {
        //We know myItems changed. Let's see what kind of change it is.
        NSKeyValueChange kindOfChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
        
        if (kindOfChange == NSKeyValueChangeSetting) {
            
            //someone set a brand new image array
            [self.tableView reloadData];
            
        } else if (kindOfChange == NSKeyValueChangeInsertion ||
                   kindOfChange == NSKeyValueChangeRemoval ||
                   kindOfChange == NSKeyValueChangeReplacement) {
            // We have an incremental change: inserted, deleted, or replaced images
            
            // Get a list of the index (or indices) that changed
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            // #1 - Convert this NSIndexSet to an NSArray of NSIndexPaths (which is what the table view animation methods require)
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
               [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            // #2 - Call `beginUpdates` to tell the table view we're about to make changes
            [self.tableView beginUpdates];
            
            // Tell the table view what the changes are
            if (kindOfChange == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeRemoval) {
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            // Tell the table view that we're done telling it about changes, and to complete the animation
            [self.tableView endUpdates];
        }
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 0;
//}


//Need to present all of our descriptions as rows in this table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //added this per 28
    return [DataSource sharedInstance].myItems.count;
    
}


//Required method and most important. Returns a prepped and ready UITableViewCell instance to the table view to display at a given location. This method is called every time a new row is about to appear on screen whether scrolling up or down.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProcurementItemTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"procurementCell" forIndexPath:indexPath];
    cell.item = [DataSource sharedInstance].myItems[indexPath.row];
    //cell.textLabel.text = item.equipDesc;
    
    return cell;

}

#pragma mark - MyItemsTableViewCellDelegate

- (void) cell:(ProcurementItemTVCell *)cell didTapImageView:(UIImageView *)imageView {
    
    //MyItemFullScreenViewController *fullScreenVC = [[MyItemFullScreenViewController alloc] initWithMyItem:cell.item];
    
    //[self presentViewController:fullScreenVC animated:YES completion:nil];
    dispatch_async(dispatch_get_main_queue(),   ^{
        
        [self performSegueWithIdentifier:@"procurementItemFullScreenSegue" sender:self];
    });
}


//height of cells when we scroll
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //note that the table heights should be based off of the machine it is on (iphone/ipad) remember to check this later
    return 100;
    
    //this is supposedly what we supposed to do per unit 29, but the cells stack weird. double check layout subview since you changed it to suit no image view or second view (tag)
    //MyItems *item = [DataSource sharedInstance].myItems[indexPath.row];
    //return [ProcurementItemTVCell heightForItem:item width:CGRectGetWidth(self.view.frame)];
    
    
}


#pragma mark - Infinite Scroll Methods

- (void) infiniteScrollIfNecessary {
    
    // #3 - Check if user has scrolled to the last photo.
    NSIndexPath *bottomIndexPath = [[self.tableView indexPathsForVisibleRows] lastObject];
    
    if (bottomIndexPath && bottomIndexPath.row == [DataSource sharedInstance].myItems.count - 1) {
        // The very last cell is on screen
        [[DataSource sharedInstance] requestOldItemsWithCompletionHandler:nil];
    }
}

#pragma mark - UIScrollViewDelegate

// #4 UITableView is a subclass of UIScrollView. When content size is larger than its frame a pan gesture moves its content. Scroll view can be scrolled horizontally or vertically. (Table view locked into vertical scrolling though)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self infiniteScrollIfNecessary];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        MyItems *item = [DataSource sharedInstance].myItems[indexPath.row];
        [[DataSource sharedInstance] deleteMyItem:item];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
