//
//  MyItems.m
//  MasterTracker
//
//  Created by Luke Paulo on 10/24/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "MyItems.h"
#import "User.h"
#import "DataSource.h"

@implementation MyItems


- (instancetype) initWithDictionary:(NSDictionary *)itemDictionary {
    self = [super init];
    
    if (self) {
        self.equipTag = itemDictionary[@"equipmentTag"];
        self.equipDesc = itemDictionary[@"equipmentDescription"];
        self.released = itemDictionary[@"releasedBool"];
        self.releaseBy = itemDictionary[@"releaseByDate"];
        self.workingDaysTilRelease = itemDictionary[@"numWorkingDaysTilRelease"];
    }
    
    return self;
    
}



# pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        self.equipTag = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(equipTag))];
        self.equipDesc = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(equipDesc))];
        self.released = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(released))];
        self.releaseBy = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(releaseBy))];
        self.workingDaysTilRelease = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(workingDaysTilRelease))];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.equipTag forKey:NSStringFromSelector(@selector(equipTag))];
    [aCoder encodeObject:self.equipDesc forKey:NSStringFromSelector(@selector(equipDesc))];
    [aCoder encodeObject:self.released forKey:NSStringFromSelector(@selector(released))];
    [aCoder encodeObject:self.releaseBy forKey:NSStringFromSelector(@selector(releaseBy))];
    [aCoder encodeObject:self.workingDaysTilRelease forKey:NSStringFromSelector(@selector(workingDaysTilRelease))];
}

@end
