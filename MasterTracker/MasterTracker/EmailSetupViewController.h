//
//  EmailSetupViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailSetupViewController : UIViewController <UITextFieldDelegate>

- (void)nextButtonPressed:(UIButton *)sender;
- (void)haveAccButtonPressed:(UIButton *)sender;

@end
