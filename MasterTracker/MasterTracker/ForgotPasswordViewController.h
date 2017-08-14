//
//  ForgotPasswordViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *forgotPassLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

- (void)enterButtonPressed:(UIButton *)sender;
- (void)backButtonPressed:(UIButton *)sender;

@end
