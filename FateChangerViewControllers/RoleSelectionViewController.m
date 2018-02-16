//
//  ViewController.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/11/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//

#import "RoleSelectionViewController.h"
#import "TabsViewController.h"

@interface RoleSelectionViewController ()

@end

@implementation RoleSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectedStudentRole:(id)sender {
}
    
- (IBAction)selectedTeacherRole:(id)sender {
}
    
- (IBAction)selectedSomeoneRole:(id)sender {
}
#pragma mark - navigation
-(void) presentTabsViewController
{
//UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//TabsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TabsViewControllerID"];
//[vc setModalPresentationStyle:UIModalPresentationFullScreen];
//[self.navigationController presentViewController:vc animated:NO completion:nil];
    [self performSegueWithIdentifier:@"segueFromRolesToTabs" sender:self];
}
@end
