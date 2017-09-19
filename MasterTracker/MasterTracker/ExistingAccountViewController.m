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
@import Firebase;
@import FirebaseAuth;

static NSString *const kFirebaseTermsOfService = @"https://firebase.google.com/terms/";


@interface ExistingAccountViewController ()

@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;

@end


@implementation ExistingAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [START auth_listener]
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                       // [START_EXCLUDE]
                       
                       //Not sure if these are needed now. Leave here in case want to play with later.
                       //[self setTitleDisplay:user];
                       //[self.tableView reloadData];
                       
                       // [END_EXCLUDE]
                   }];
    // [END auth_listener]
}

//commented out the above exclusions. In case come back and play with this can use this for reference
//- (void)setTitleDisplay: (FIRUser *)user {
//    if (user.displayName) {
//        self.navigationItem.title = [NSString stringWithFormat:@"Welcome %@", user.email];
//    } else {
//        self.navigationItem.title = @"Authentication Example";
//    }
//}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // [START remove_auth_listener]
    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
    // [END remove_auth_listener]
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
        
        NSString *errorCode = [error localizedDescription];
        
        if (!error) {
            
        NSLog(@"No error. Successful login");
        
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
            //Below list the possible errors and their respective error messages/codes so you know how to handle each. Cuh.
            // FIRAuthErrorCodeOperationNotAllowed - Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
            // FIRAuthErrorCodeInvalidEmail - Indicates the email address is malformed.
            // FIRAuthErrorCodeUserDisabled - Indicates the user's account is disabled.
            // FIRAuthErrorCodeWrongPassword - Indicates the user attempted sign in with a wrong password.
            // FIRAuthErrorDomain - There is no user record corresponding to this identifier. The user may have been deleted.
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
