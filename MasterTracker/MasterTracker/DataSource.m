//
//  DataSource.m
//  MasterTracker
//
//  Created by Luke Paulo on 9/4/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "MyItems.h"
#import "MyProjects.h"
#import "EmailSetupViewController.h"
#import <UICKeyChainStore.h>

@interface DataSource () {
    NSMutableArray *_myItems;
}

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSArray *myItems;

//track whether refresh is already in progress. don't want to fetch multiple times while waiting for a result from the server
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isLoadingOlderItems;

@end


@implementation DataSource

+(instancetype) sharedInstance {
    static dispatch_once_t once;     //dispatch_once ensures we only create a single instance of this class
    static id sharedInstance;        //holds our shared instance
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
    
}


#pragma mark - Add required KVC accessor methods

//for MyItems Table VC
//The myItems array must be accessible
- (NSUInteger) countOfItems {
    return self.myItems.count;
}

- (id) objectInItemsAtIndex:(NSUInteger)index {
    return [self.myItems objectAtIndex:index];
}

- (NSArray *) itemsAtIndexes:(NSIndexSet *)indexes {
    return [self.myItems objectsAtIndexes:indexes];
}

//add mutable accessor methods. These are KVC methods that allow insertion and deletion of elements from MyItems. Need to be _myItems not self.myItems because in header file myItems is declared as readonly
- (void) insertObject:(MyItems *)object inMyItemsAtIndex:(NSUInteger)index {
    [_myItems insertObject:object atIndex:index];
}

- (void) removeObjectFromMyItemsAtIndex:(NSUInteger)index {
    [_myItems removeObjectAtIndex:index];
}

- (void) replaceObjectInMyItemsAtIndex:(NSUInteger)index withObject:(id)object {
    [_myItems replaceObjectAtIndex:index withObject:object];
}

//DO I need to register for access token notification?






//This is going to create random values for the my items. can reconfigure once you have the data drawing from it

- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self addRandomData];
    }
    return self;
}

- (void) addRandomData {
    NSMutableArray *randomItems = [NSMutableArray array];
    
    for (int i = 1; i <= 10; i++) {
        
            MyItems *item = [[MyItems alloc] init];
            item.equipTag = [self randomSentence];
            item.equipDesc = [self randomSentence];
            item.released = [self randomSentence];
            item.releaseBy = [self randomValue];
            item.workingDaysTilRelease = [self randomValue];
        
            [randomItems addObject:item];
    }
    
    self.myItems = randomItems;

}


- (NSString *) randomSentence {
    NSUInteger wordCount = arc4random_uniform(20) + 2;
    
    NSMutableString *randomSentence = [[NSMutableString alloc] init];
    
    for (int i = 0; i <= wordCount; i++) {
        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12) + 2];
        [randomSentence appendFormat:@"Item Description: %@ ", randomWord];
    }
    
    return randomSentence;
}

- (NSString *) randomValue {
    
    NSMutableString *randomValue = [[NSMutableString alloc] init];
    
    for (int i = 0; i < 1; i++) {
        NSString *randomNumber = [self randomNumOfLength:arc4random_uniform(10)];
        [randomValue appendFormat:@"Loan Desired: $%@ ", randomNumber];
    }
    
    return randomValue;
}

- (NSString *) randomNumOfLength:(NSUInteger) len {
    NSString *numbers = @"0123456789";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[numbers length]);
        unichar c = [numbers characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return [NSString stringWithString:s];
}

- (NSString *) randomStringOfLength:(NSUInteger) len {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return [NSString stringWithString:s];
}


# pragma mark - Pull to Refresh and Infinite Scroll Completion Handlers

//for My Items Table VC
//implement the pull to refresh completion handler
- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlockPTR)completionHandler {
    
    // #1 check if request for recovering new item is already in progress. If so, return immedidately, otherwise set to YES.
    if (self.isRefreshing == NO) {
        self.isRefreshing = YES;
        
        // #2 create a new random media object and append it to the front of the KVC array. Place at top-most table cell.
        MyItems *item = [[MyItems alloc] init];
        item.equipTag = [self randomSentence];
        item.equipDesc = [self randomSentence];
        item.released = [self randomSentence];
        item.releaseBy = [self randomValue];
        item.workingDaysTilRelease = [self randomValue];
        
        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"myItems"];
        [mutableArrayWithKVO insertObject:item atIndex:0];
        
        self.isRefreshing = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
}

//implement the infinite scroll method/completion handler
- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlockPTR)completionHandler {
    if (self.isLoadingOlderItems == NO) {
        self.isLoadingOlderItems = YES;
        MyItems *item = [[MyItems alloc] init];
        item.equipTag = [self randomSentence];
        item.equipDesc = [self randomSentence];
        item.released = [self randomSentence];
        item.releaseBy = [self randomValue];
        item.workingDaysTilRelease = [self randomValue];
        
        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"myItems"];
        [mutableArrayWithKVO addObject:item];
        
        self.isLoadingOlderItems = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
}


#pragma mark Login Stuff


@end


//THIS WILL UPDATE SOMETHING AT THE PATH SPECIFIED. THE PATH MATCHES MY OLD JSON SETUP FROM 10/10 FOR REF
//NSDictionary *projUpdates = @{[NSString stringWithFormat:@"/users/%@/projectLocation/", self.projectUser]: newProjData};

//NSLog(@"Weird looking projUpdates with path/key: %@", projUpdates);

//[self.rootRef updateChildValues:projUpdates];
