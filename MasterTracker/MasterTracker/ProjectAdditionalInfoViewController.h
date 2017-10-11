//
//  ProjectAdditionalInfoViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/16/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "EmailSetupViewController.h"

@import Firebase;

@interface ProjectAdditionalInfoViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) FIRDatabaseReference *rootRef;
@property (strong, nonatomic) FIRAuth *handle;
@property (strong, nonatomic) NSString *projectUser;


- (void)saveButtonPressed:(UIButton *)sender;

@end
