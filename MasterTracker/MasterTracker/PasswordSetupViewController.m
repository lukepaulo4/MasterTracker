//
//  PasswordSetupViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//



#import "PasswordSetupViewController.h"

@interface PasswordSetupViewController ()

//NOTE THIS VC WAS ELIMINATED AND BOTH EMAIL AND PASSWORD ARE INPUTTED INTO THE EMAIL SETUP VC. CAN DISREGARD THIS VC FOR NOW UNLESS YOU DECIDE TO GO BACK LATER.

@end

@implementation PasswordSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)passwordTextFieldDidChange:(UITextField *)sender {
    if ([self.passwordTextField.text length] > 0) {
    }
}

- (IBAction)retypePasswordTextFieldDidChange:(UITextField *)sender {
    if ([self.retypePasswordTextField.text length] > 0) {
    }
}

- (IBAction)finishButtonPressed:(id)sender {
    
    if ([[self.passwordTextField text] isEqualToString:@""] || [[self.retypePasswordTextField text] isEqualToString:@""]) {
        
        NSLog(@"no password inputted");
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message1 = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:message1 message:@"Looks like one of the password fields is blank." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert1 addAction:defaultAction1];
            [self presentViewController:alert1 animated:YES completion:nil];
            
        });
        
        
    } else if (self.passwordTextField.text == self.retypePasswordTextField.text) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            [self performSegueWithIdentifier:@"newAccCreatedSegue" sender:self];
            
        });
        
    } else {
        
        NSLog(@"passwords don't match");
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"Looks like your passwords don't match. Try again." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        });
    }

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
