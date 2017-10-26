//
//  ProcurementLogTVControllerTableViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 10/25/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyItems;

@interface ProcurementLogTVControllerTableViewController : UITableViewController

@property (nonatomic, strong) MyItems *myItem;

@property (nonatomic, strong) NSArray *equipmentDescriptions;

@end
