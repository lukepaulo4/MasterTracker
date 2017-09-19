//
//  User.m
//  MasterTracker
//
//  Created by Luke Paulo on 9/4/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "User.h"

@implementation User


#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_userID forKey:@"userID"];
    [encoder encodeObject:_email forKey:@"email"];

}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _userID = [decoder decodeObjectForKey:@"userID"];
        _email = [decoder decodeObjectForKey:@"email"];
        
    }
    
    return self;
}

//so we can use copies doooooeeee (I think)
- (instancetype)copyWithZone:(NSZone *)zone {
    User *theCopy = [[[self class] allocWithZone:zone] init];
    theCopy.userID = [_userID copy];
    theCopy.email = [_email copy];
    
    return theCopy;
}


- (instancetype) initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if (user) {
        // The user's ID, unique to the Firebase project.
        // Do NOT use this value to authenticate with your backend server,
        // if you have one. Use getTokenWithCompletion:completion: instead.
        self.userID = user.uid;
        self.email = user.email;

    }
    
    return self;
}


- (instancetype)initWithSnapshot:(FIRDataSnapshot *)snapshot {
    User *user = [self initWithDictionary:snapshot.value];
    user.userID = snapshot.key;
    return user;
}


- (NSUInteger)hash {
    return _userID.hash;
}

- (BOOL)isEqualToUser:(User *)user {
    return [user.userID isEqualToString:_userID];
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[User class]]) {
        return NO;
    }
    
    return [self isEqualToUser:(User *)object];
}

- (NSString *)description {
    NSDictionary *dictionary = @{ @"userID": self.userID ? : @"",
                                  @"email": self.email ? : @"" };
    return [NSString stringWithFormat:@"<%@: %p> %@", NSStringFromClass([self class]), self, dictionary];
}

- (NSString *)username {
    return _email;
}

- (NSDictionary *)author {
    return @{ @"uid": self.userID ? : @"",
              @"email": self.email ? : @"",
            };
}


@end
