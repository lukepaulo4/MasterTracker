//
//  ProjectSetupViewController.h
//  MasterTracker
//
//  Created by Luke Paulo on 8/16/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectSetupViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectAddressLabel;
@property (strong, nonatomic) IBOutlet UITextField *projectNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *projectAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *projectCityTextField;
@property (strong, nonatomic) IBOutlet UITextField *projectStateTextField;
@property (strong, nonatomic) IBOutlet UITextField *projectZipTextField;

- (void)submitButtonPressed:(UIButton *)sender;

@end
