//
//  User.m
//  MasterTracker
//
//  Created by Luke Paulo on 9/4/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user) {
        // The user's ID, unique to the Firebase project.
        // Do NOT use this value to authenticate with your backend server,
        // if you have one. Use getTokenWithCompletion:completion: instead.
        self.uid = user.uid;
        self.email = user.email;

    }
    
    return self;
}


@end
