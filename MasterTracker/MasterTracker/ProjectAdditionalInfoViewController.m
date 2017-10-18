//
//  ProjectAdditionalInfoViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/16/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "ProjectAdditionalInfoViewController.h"
#import "User.h"
#import "AppState.h"
#import <UICKeyChainStore.h>

@interface ProjectAdditionalInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *wordsLabel;
@property (weak, nonatomic) IBOutlet UITextField *ownerTextField;
@property (weak, nonatomic) IBOutlet UITextField *architectTextField;
@property (weak, nonatomic) IBOutlet UITextField *eorTextField;
@property (weak, nonatomic) IBOutlet UITextField *gcTextField;
@property (weak, nonatomic) IBOutlet UITextField *projectStartTextField;
@property (weak, nonatomic) IBOutlet UITextField *projectEndTextField;
@property (weak, nonatomic) IBOutlet UITextField *contractAmountTextField;


@end

@implementation ProjectAdditionalInfoViewController

@synthesize rootRef;
@synthesize handle;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ownerTextField.delegate = self;
    self.architectTextField.delegate = self;
    self.eorTextField.delegate = self;
    self.gcTextField.delegate = self;
    self.projectStartTextField.delegate = self;
    self.projectEndTextField.delegate = self;
    self.contractAmountTextField.delegate = self;
    
    self.projectUser = [UICKeyChainStore stringForKey:@"userID"];
    
    NSLog(@"user ID per the keychain after additional proj info: %@", _projectUser);
    
    self.rootRef = [[FIRDatabase database] reference];
    
    [[[self.rootRef child:@"projects"] child:_projectUser] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSDictionary *snapDict = snapshot.value;
        NSLog(@"Snap Dic = %@", snapDict);
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"error is = %@", error.localizedDescription);
    }];
    
    
    
    NSLog(@"Snapshot done");
    
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

- (IBAction)ownerTextFieldDidChange:(UITextField *)sender {
    if ([self.ownerTextField.text length] > 0) {
    }
    
}

- (IBAction)archTextFieldDidChange:(UITextField *)sender {
    if ([self.architectTextField.text length] > 0) {
    }
}

- (IBAction)eorTextFieldDidChange:(UITextField *)sender {
    if ([self.eorTextField.text length] > 0) {
    }
}

- (IBAction)gcTextFieldDidChange:(UITextField *)sender {
    if ([self.gcTextField.text length] > 0) {
    }
}

- (IBAction)projectStartTextFieldDidChange:(UITextField *)sender {
    if ([self.projectStartTextField.text length] > 0) {
    }
}

- (IBAction)projectEndTextFieldDidChange:(UITextField *)sender {
    if ([self.projectEndTextField.text length] > 0) {
    }
}

- (IBAction)contractAmountTextFieldDidChange:(UITextField *)sender {
    if ([self.contractAmountTextField.text length] > 0) {
    }
}

- (IBAction)saveButtonPressed:(id)sender {
    
    NSString *ownerString = self.ownerTextField.text;
    NSString *archString = self.architectTextField.text;
    NSString *eorString = self.eorTextField.text;
    NSString *gcString = self.gcTextField.text;
    NSString *projStartString = self.projectStartTextField.text;
    NSString *projEndString = self.projectEndTextField.text;
    NSString *contractAmtString = self.contractAmountTextField.text;
    
    if ([self.ownerTextField.text isEqualToString:@""] || [self.architectTextField.text isEqualToString:@""] || [self.eorTextField.text isEqualToString:@""] || [self.gcTextField.text isEqualToString:@""] || [self.projectStartTextField.text isEqualToString:@""] || [self.projectEndTextField.text isEqualToString:@""] || [self.contractAmountTextField.text isEqualToString:@""]) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            NSString *message1 = [[NSString alloc] initWithFormat:@"Oops"];
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:message1 message:@"All fields required to save data." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {}];
            
            [alert1 addAction:defaultAction1];
            [self presentViewController:alert1 animated:YES completion:nil];
            
        });
        
    } else {
    
        NSDictionary *newContractData = @{@"projectOwner": ownerString,
                                          @"projectArch": archString,
                                          @"projectEOR": eorString,
                                          @"projectGC": gcString,
                                          @"projectStart": projStartString,
                                          @"projectEnd": projEndString,
                                          @"contractAmount": contractAmtString};
        
        NSDictionary *projUpdates = @{[NSString stringWithFormat:@"/projects/%@/project1/contractData/", self.projectUser]: newContractData};
        
        NSLog(@"Weird looking projUpdates with path/key: %@", projUpdates);
        
        [self.rootRef updateChildValues:projUpdates];
        
        
        
        
        
        
        //dispatch_async(dispatch_get_main_queue(),   ^{
            
            //this is going to give you an error
            //[self performSegueWithIdentifier:@"somethingSegue" sender:self];
            
        //});
        
        
        
        self.rootRef = [[FIRDatabase database] reference];
        
        [[[self.rootRef child:@"projects"] child:_projectUser] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            
            NSDictionary *snapDict = snapshot.value;
            NSLog(@"Snap Dic of added saved data is = %@", snapDict);
        } withCancelBlock:^(NSError * _Nonnull error) {
            NSLog(@"error is = %@", error.localizedDescription);
        }];
        
    }

    
}
    
//CREATE A SKIP BUTTON IN CASE THEY DON'T WANT TO INPUT THIS SHIT

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
