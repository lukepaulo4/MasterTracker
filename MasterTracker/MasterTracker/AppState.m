//
//  AppState.m
//  MasterTracker
//
//  Created by Luke Paulo on 9/18/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "AppState.h"

@implementation AppState

#pragma mark Singleton Methods

+ (AppState *)sharedInstance {
    static AppState *sharedMyInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyInstance = [[self alloc] init];
    });
    return sharedMyInstance;
}

@end
