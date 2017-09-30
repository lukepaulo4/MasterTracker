//
//  ProjectSetupViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/16/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "ProjectSetupViewController.h"
#import "User.h"
#import "AppState.h"

@interface ProjectSetupViewController ()

@end

@implementation ProjectSetupViewController

@synthesize handle;

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

//Implement the UITextFieldDelegate protocol method.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; //dismisses the keyboard
    return YES;
}

- (IBAction)projectNameTextFieldDidChange:(UITextField *)sender {
    if ([self.projectNameTextField.text length] > 0) {
    }
}

- (IBAction)projectAddressTextFieldDidChange:(UITextField *)sender {
    if ([self.projectAddressTextField.text length] > 0) {
    }
}

- (IBAction)projectCityTextFieldDidChange:(UITextField *)sender {
    if ([self.projectCityTextField.text length] > 0) {
    }
}

- (IBAction)projectStateTextFieldDidChange:(UITextField *)sender {
    if ([self.projectStateTextField.text length] > 0) {
    }
}

- (IBAction)projectZipTextFieldDidChange:(UITextField *)sender {
    if ([self.projectZipTextField.text length] > 0) {
    }
}

- (IBAction)submitButtonPressed:(id)sender {
    
    NSString *projectNameString = self.projectNameTextField.text;
    NSString *projectAddressString = self.projectAddressTextField.text;
    NSString *projectCityString = self.projectCityTextField.text;
    NSString *projectStateString = self.projectStateTextField.text;
    NSString *projectZipString = self.projectZipTextField.text;
    NSString *projectUser = [[AppState sharedInstance].currentUser userID];

    
    //seems like the only one we really need is the project name. All the other info is optional.
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
        
        NSDictionary *projectData = @{ @"projectUser": projectUser,
                                       @"projectName": projectNameString,
                                       @"projectAddress": projectAddressString,
                                       @"projectCity": projectCityString,
                                       @"projectState": projectStateString,
                                       @"projectZip": projectZipString
                                       };
                                                        
        NSLog(@"project user name is: %@", projectUser);
        
        //create an if statement that goes if projectUser is not equal to the current user of the data we about to rearrange, then it's all bad.
        
        
        
        
        
        
        
        
    
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
