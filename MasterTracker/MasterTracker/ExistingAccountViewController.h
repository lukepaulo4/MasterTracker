//
//  ExistingAccountViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@import FirebaseAuth;

@import Firebase;

@interface ExistingAccountViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *accLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) FIRAuth *handle;

- (void)enterButtonPressed:(UIButton *)sender;
- (void)forgotPassButtonPressed:(UIButton *)sender;

@end
