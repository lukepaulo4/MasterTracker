//
//  ExistingAccountViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExistingAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *accLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (void)enterButtonPressed:(UIButton *)sender;
- (void)forgotPassButtonPressed:(UIButton *)sender;

@end
