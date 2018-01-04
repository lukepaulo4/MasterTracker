//
//  User.h
//  MasterTracker
//
//  Created by Luke Paulo on 9/4/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

//if you ever need to recognize UIImage than import
//#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import "DataSource.h"

@import Firebase;

//Can insert <NSCoding> after object, however, doing so will require the use of the initWithCoder/enableWithCoder functions to be called in the .h implementation file
@interface User : NSObject

- (instancetype) initWithDictionary:(NSDictionary *)userDictionary;

//list all the data this class should store
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *email;


//Initialize data model from snapshot
- (instancetype)initWithSnapshot:(FIRDataSnapshot *)snapshot;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDictionary *author;


@end
