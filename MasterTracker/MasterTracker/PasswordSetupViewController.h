//
//  PasswordSetupViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordSetupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *niceLabel;
@property (weak, nonatomic) IBOutlet UILabel *retypeLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *retypePasswordTextField;

- (void)finishButtonPressed:(UIButton *)sender;

@end
