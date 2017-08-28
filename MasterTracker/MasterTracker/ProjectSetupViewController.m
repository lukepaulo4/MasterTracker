//
//  ProjectSetupViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/16/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "ProjectSetupViewController.h"

@interface ProjectSetupViewController ()

@end

@implementation ProjectSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.projectNameTextField.delegate = self;
    self.projectAddressTextField.delegate = self;
    self.projectCityTextField.delegate = self;
    self.projectStateTextField.delegate = self;
    self.projectZipTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)projectNameTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)projectAddressTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)projectCityTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)projectStateTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)projectZipTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)submitButtonPressed:(id)sender {
    
    if ([self.projectNameTextField.text isEqualToString:@""]) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message1 = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:message1 message:@"Project name required." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
            
            [alert1 addAction:defaultAction1];
            [self presentViewController:alert1 animated:YES completion:nil];
            
        });
        
    } else {
    
    dispatch_async(dispatch_get_main_queue(),   ^{
        
        [self performSegueWithIdentifier:@"addProjectInfoSegue" sender:self];
        
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
