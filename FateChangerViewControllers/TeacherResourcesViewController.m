//
//  TeacherResourcesViewController.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/12/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//

#import "TeacherResourcesViewController.h"

@interface TeacherResourcesViewController ()
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet UITextField *teacherEmail;

@end

@implementation TeacherResourcesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.teacherEmail.delegate = self;
    [self tapForKeyboardDismissal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark control keyboard actions
- (UITapGestureRecognizer *) tapRecognizer
{
    if (!_tapRecognizer) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        _tapRecognizer.cancelsTouchesInView = NO;
    }
    return _tapRecognizer;
}

- (void) tapForKeyboardDismissal
{
    [self.view addGestureRecognizer:self.tapRecognizer];
}

- (void) removeTapForKeyboardDismissal
{
    [self.view removeGestureRecognizer:self.tapRecognizer];
}
- (void) tap:(UIGestureRecognizer *) gr
{
    [self.view endEditing:YES];
}


#pragma decimal input checks
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self skipNonnumericTextField:textField]) {
        return YES;
    }
    NSString *validRegEx = @"^[0-9.]*$";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEx];
    BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:string];
    if (myStringMatchesRegEx) {
        if ([string isEqualToString:@"."]) {
            if ([textField.text rangeOfString:@"."].location == NSNotFound) {
                return YES;
            } else {
                return NO;
            }
        } else {
            return YES;
        }
    } else {
        return NO;
    }
    
}

-(BOOL) skipNonnumericTextField:(UITextField *) textField
{
    if (self.teacherEmail == textField) {
        return YES;
    } else {
        return NO;
    }
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - actions
- (IBAction)cancelAction:(id)sender {
    [self exitExpertOffer];
}


- (IBAction)doneButton:(id)sender {
    NSLog(@"Call model to save email: %@",self.teacherEmail);
    [self exitExpertOffer];
}

- (IBAction)sendTeacherEmail:(id)sender {
    // edit email
    NSLog(@"email: %@",self.teacherEmail);
}

-(void) exitExpertOffer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
