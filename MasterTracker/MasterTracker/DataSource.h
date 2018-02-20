//
//  DataSource.h
//  MasterTracker
//
//  Created by Luke Paulo on 9/4/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@class MyItems;

typedef void (^NewItemCompletionBlock)(NSError *error, NSDictionary *returnDict);
typedef void (^NewItemCompletionBlockPTR)(NSError *error);

@interface DataSource : NSObject

+(instancetype) sharedInstance;

//Create array to store our array of my procurement items for the my items table VC. Read only disallows other classes from modifying these property
@property (nonatomic, strong, readonly) NSArray *myItems;

//create property to store the access token
@property (nonatomic, strong, readonly) NSString *accessToken;

//method for table view to call when user executes a pull-to-refresh gesture. Asynchronous so require the caller pass a version of our completion handler
- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlockPTR)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlockPTR)completionHandler;
- (void) deleteMyItem:(MyItems *)item;


@end
