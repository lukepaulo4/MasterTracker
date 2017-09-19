//
//  AppState.h
//  MasterTracker
//
//  Created by Luke Paulo on 9/18/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@import FirebaseDatabase;

@interface AppState : NSObject

@property (nonatomic, retain) User *currentUser;

+ (AppState *)sharedInstance;

@end
