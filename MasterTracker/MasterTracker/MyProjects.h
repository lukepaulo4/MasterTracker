//
//  MyProjects.h
//  MasterTracker
//
//  Created by Luke Paulo on 1/3/18.
//  Copyright © 2018 lpinc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"

@class User;

@interface MyProjects : NSObject /*<NSCoding>*/

@property (nonatomic, strong) NSString *projectName;
@property (nonatomic, strong) NSString *projectAddress;
@property (nonatomic, strong) NSString *projectCity;
@property (nonatomic, strong) NSString *projectState;
@property (nonatomic, strong) NSString *projectZip;
@property (nonatomic, strong) NSString *projectOwner;
@property (nonatomic, strong) NSString *projectArch;
@property (nonatomic, strong) NSString *projectEOR;
@property (nonatomic, strong) NSString *projectGC;
@property (nonatomic, strong) NSString *projectStart;
@property (nonatomic, strong) NSString *projectEnd;
@property (nonatomic, strong) NSString *projectContractAmount;

@end
