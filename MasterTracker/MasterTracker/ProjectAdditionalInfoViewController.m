//
//  ProjectAdditionalInfoViewController.m
//  MasterTracker
//
//  Created by Luke Paulo on 8/16/17.
//  Copyright © 2017 lpinc. All rights reserved.
//

#import "ProjectAdditionalInfoViewController.h"

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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ownerTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)archTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)eorTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)gcTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)projectStartTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)projectEndTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)contractAmountTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)saveButtonPressed:(id)sender {
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
