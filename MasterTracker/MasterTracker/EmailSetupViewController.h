//
//  EmailSetupViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@import Firebase;

@interface EmailSetupViewController : UIViewController <UITextFieldDelegate>


@property (strong, nonatomic) FIRDatabaseReference *rootRef;
@property (strong, nonatomic) FIRAuth *handle;


- (void)nextButtonPressed:(UIButton *)sender;
- (void)haveAccButtonPressed:(UIButton *)sender;

@end
