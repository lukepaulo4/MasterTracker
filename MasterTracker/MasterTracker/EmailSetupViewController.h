//
//  EmailSetupViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailSetupViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *enterEmailTextField;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *recLabel;

- (void)nextButtonPressed:(UIButton *)sender;
- (void)haveAccButtonPressed:(UIButton *)sender;

@end
