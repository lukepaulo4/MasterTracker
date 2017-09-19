//
//  PasswordSetupViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>


//NOTE THIS VC WAS ELIMINATED AND BOTH EMAIL AND PASSWORD ARE INPUTTED INTO THE EMAIL SETUP VC. CAN DISREGARD THIS VC FOR NOW UNLESS YOU DECIDE TO GO BACK LATER.

@interface PasswordSetupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *niceLabel;
@property (weak, nonatomic) IBOutlet UILabel *retypeLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *retypePasswordTextField;

- (void)finishButtonPressed:(UIButton *)sender;

@end
