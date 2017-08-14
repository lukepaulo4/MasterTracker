//
//  EmailSetupViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "EmailSetupViewController.h"

@interface EmailSetupViewController ()

@end

@implementation EmailSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emailTextFieldDidChange:(UITextField *)sender {
    if ([self.enterEmailTextField.text length] > 0) {
    }
}

- (IBAction)nextButtonPressed:(id)sender {
}

- (IBAction)haveAccButtonPressed:(id)sender {
}


- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
