//
//  MyItems.h
//  MasterTracker
//
//  Created by Luke Paulo on 10/24/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataSource.h"

@class User;

@interface MyItems : NSObject <NSCoding>

//Declare the initializer
- (instancetype) initWithDictionary:(NSDictionary *)itemDictionary;

//List all the data this class should store about an 'item'
@property (nonatomic, strong) NSString *equipTag;
@property (nonatomic, strong) NSString *equipDesc;
@property (nonatomic, strong) NSString *released;
@property (nonatomic, strong) NSString *releaseBy;
@property (nonatomic, strong) NSString *workingDaysTilRelease;

@property (nonatomic, strong) User *user;



@end
