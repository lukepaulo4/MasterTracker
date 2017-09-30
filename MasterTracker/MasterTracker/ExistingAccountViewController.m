//
//  ExistingAccountViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "ExistingAccountViewController.h"
#import "AppDelegate.h"
#import "AppState.h"
#import <UICKeyChainStore.h>


static NSString *const kFirebaseTermsOfService = @"https://firebase.google.com/terms/";


@interface ExistingAccountViewController ()

@end

//add category for email validation
@interface NSString (emailValidation)
- (BOOL)isValidEmail;
@end

//implement code that determines if email is valid
@implementation NSString (emailValidation)
- (BOOL)isValidEmail {
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
    
}
@end


@implementation ExistingAccountViewController

@synthesize handle;

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

//Implement the UITextFieldDelegate protocol method.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; //dismisses the keyboard
    return YES;
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

    } else if (![emailString isValidEmail]) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message3 = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Email address entered isn't valid. Try again." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
            
            [alert3 addAction:defaultAction3];
            [self presentViewController:alert3 animated:YES completion:nil];
            
        });
        
        
    } else {
            
        
    [[FIRAuth auth] signInWithEmail:emailString password:passwordString completion:^(FIRUser *user, NSError *error) {
        
        NSString *errorCode = [error localizedDescription];
        
        NSString *projectUser = user.uid;
        NSLog(@"userID per the sign in is: %@", projectUser);
        
        if (!error) {
            
        NSLog(@"No error. Successful login");
            [UICKeyChainStore setString:projectUser forKey:@"userID"];
            NSString *kcUserID = [UICKeyChainStore stringForKey:@"userID"];
            
            NSLog(@"userID per the keychain is: %@", kcUserID);
            
            
            
            
            //need to add a handle that tells this to stop listening at viewDidDissappear
            self.handle = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                
                
            }];
            
            
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            [self performSegueWithIdentifier:@"existingAccSignInSegue" sender:self];
            
        });
        
        } else if ([errorCode isEqualToString:@"Indicates the email address is malformed."]) {
            
            NSLog(@"Error %@", error);
            NSLog(@"Error Message said %@", errorCode);
            
            //For some reason the error message isn't popping up. blah.
            dispatch_async(dispatch_get_main_queue(),   ^{
                
                NSString *message2 = [[NSString alloc] initWithFormat:@"Hmm"];
                UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:message2 message:@"Looks like you entered an invalid email address. Try again." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                
                [alert2 addAction:defaultAction2];
                [self presentViewController:alert2 animated:YES completion:nil];
                
            });
            
        } else if ([errorCode isEqualToString:@"Indicates the user's account is disabled."]) {
            
            NSLog(@"Error %@", error);
            NSLog(@"Error Message said %@", errorCode);
            
            dispatch_async(dispatch_get_main_queue(),   ^{
                
                NSString *message3 = [[NSString alloc] initWithFormat:@"Hmm"];
                UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Looks like this email address was disabled. Please contact us if you think this is in error." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                
                [alert3 addAction:defaultAction3];
                [self presentViewController:alert3 animated:YES completion:nil];
                
            });
            
            //For some reason the error message isn't popping up. blah.
        } else if ([errorCode isEqualToString:@"Indicates the user attempted sign in with a wrong password."]) {
            
            NSLog(@"Error %@", error);
            NSLog(@"Error Message said %@", errorCode);
            
            dispatch_async(dispatch_get_main_queue(),   ^{
                
                NSString *message4 = [[NSString alloc] initWithFormat:@"Hmm"];
                UIAlertController *alert4 = [UIAlertController alertControllerWithTitle:message4 message:@"Looks like you entered an incorrect password." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction4 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                
                [alert4 addAction:defaultAction4];
                [self presentViewController:alert4 animated:YES completion:nil];
                
            });
            
        } else if ([errorCode isEqualToString:@"There is no user record corresponding to this identifier. The user may have been deleted."]) {
            
            NSLog(@"Error %@", error);
            NSLog(@"Error Message said %@", errorCode);
            
            dispatch_async(dispatch_get_main_queue(),   ^{
                
                NSString *message5 = [[NSString alloc] initWithFormat:@"Hmm"];
                UIAlertController *alert5 = [UIAlertController alertControllerWithTitle:message5 message:@"This email address is not registered or may have been deleted. Contact us if you think this message is an error." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction5 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                
                [alert5 addAction:defaultAction5];
                [self presentViewController:alert5 animated:YES completion:nil];
                
            });
            
        } else {
            NSLog(@"Error %@", error);
            NSLog(@"Error Message said %@", errorCode);
        
        }
        
    }];

        
    }

    
}


//ok let's try and ref some databasing!



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
