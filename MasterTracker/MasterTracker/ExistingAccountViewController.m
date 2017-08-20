//
//  ExistingAccountViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "ExistingAccountViewController.h"
#import "AppDelegate.h"

@interface ExistingAccountViewController ()

@end

@implementation ExistingAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emailTextFieldDidChange:(UITextField *)sender {
    if ([self.emailTextField.text length] > 0) {
    }
}

- (IBAction)passwordTextFieldDidChange:(UITextField *)sender {
    if ([self.passwordTextField.text length] > 0) {
    }
}

- (IBAction)enterButtonPressed:(id)sender {
    
    NSString *emailString = self.emailTextField.text;
    NSString *passwordString = self.passwordTextField.text;
    
    if ([emailString isEqualToString:@""] || [passwordString isEqualToString:@""]) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message1 = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:message1 message:@"Looks like one of the required fields is blank." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
            
            [alert1 addAction:defaultAction1];
            [self presentViewController:alert1 animated:YES completion:nil];
            
        });
        
    } else {
            
        
    [[FIRAuth auth] signInWithEmail:emailString password:passwordString completion:^(FIRUser *user, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            [self performSegueWithIdentifier:@"existingAccSignInSegue" sender:self];
            
        });
        
    }];

        
    }

    
}

- (IBAction)forgotPassButtonPressed:(id)sender {
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
