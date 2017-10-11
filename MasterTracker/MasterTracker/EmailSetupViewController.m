//
//  EmailSetupViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/13/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "EmailSetupViewController.h"
#import "AppDelegate.h"
#import <UICKeyChainStore.h>

@interface EmailSetupViewController ()

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *recLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *retypePassLabel;
@property (weak, nonatomic) IBOutlet UITextField *enterEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordTextField;


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


@implementation EmailSetupViewController

@synthesize rootRef;
@synthesize handle;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.enterEmailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.retypePasswordTextField.delegate = self;
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
    if ([self.enterEmailTextField.text length] > 0) {
    }
}

- (IBAction)passwordTextFieldDidChange:(UITextField *)sender {
    if ([self.passwordTextField.text length] > 0) {
    }
}

- (IBAction)retypePasswordTextFieldDidChange:(UITextField *)sender {
    if ([self.retypePasswordTextField.text length] > 0) {
    }
}

- (IBAction)nextButtonPressed:(id)sender {
    
    NSString *emailString = self.enterEmailTextField.text;
    NSString *passwordString = self.passwordTextField.text;
    NSString *retypePasswordString = self.retypePasswordTextField.text;
    
    if ([emailString isEqualToString:@""]) {
    
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message2 = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:message2 message:@"Email address is required." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
            
            [alert2 addAction:defaultAction2];
            [self presentViewController:alert2 animated:YES completion:nil];
            
        });
        
    //adds that email is valid
    } else if (![emailString isValidEmail]) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message3 = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Email address entered isn't valid. Try again." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
            
            [alert3 addAction:defaultAction3];
            [self presentViewController:alert3 animated:YES completion:nil];
            
        });
        
    
    } else if ([passwordString isEqualToString:@""] || [retypePasswordString isEqualToString:@""]) {
        
        NSLog(@"no password inputted");
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message1 = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:message1 message:@"Looks like one of the password fields is blank." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
            
            [alert1 addAction:defaultAction1];
            [self presentViewController:alert1 animated:YES completion:nil];
            
        });
        
    
    } else if (!(passwordString == retypePasswordString)) {
        
        NSLog(@"passwords don't match");
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"Looks like your passwords don't match. Try again." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        });
    
        
        
    } else if (passwordString == retypePasswordString) {
        
        //Create a new account by passing the new user's email address and password
        [[FIRAuth auth] createUserWithEmail:emailString password:passwordString completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
            
            NSString *projectUser = user.uid;
            
            NSLog(@"pre-handle change: the user: %@", user);
            NSLog(@"user id :%@", projectUser);
            
            if (!error) {
                
                NSLog(@"No error. Successful login");
                [UICKeyChainStore setString:projectUser forKey:@"userID"];
                NSString *kcUserID = [UICKeyChainStore stringForKey:@"userID"];
                
                NSLog(@"userID per the keychain is: %@", kcUserID);
                
                self.handle = [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                                   
                               
                    NSLog(@"post-handle change: the user: %@", user);
                    NSLog(@"user id: %@", user.uid);

                    
                    //create a root ref
                    rootRef = [[FIRDatabase database] reference];
                    
                    //create a child of the rootRef
                    FIRDatabaseReference *usersRef = [rootRef child:@"users"];
                    
                    //Create a child under the users ref
                    FIRDatabaseReference *newUserRef = [usersRef child:user.uid];
                    
                    //set a value of the dictionary for which UID is the key
                    [newUserRef setValue:@{@"userEmail":emailString}];
                    
                    
                    dispatch_async(dispatch_get_main_queue(),   ^{
                        
                        [self performSegueWithIdentifier:@"newAccCreatedSegue" sender:self];
                        
                    });
                    
                    
            
        }];
                
            } else {
                
                NSLog(@"error description %@", error.localizedDescription);
            }
        
        
    }
         
         ];
    }
         

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
