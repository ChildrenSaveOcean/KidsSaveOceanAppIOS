//
//  DearStudentViewController.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/15/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//
#import "AppDelegate.h"
#import "DearStudentViewController.h"
#import "FateChangerModel.h"

@interface DearStudentViewController ()
@property (nonatomic, strong) FateChangerModel *model;
@end

@implementation DearStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.model = [(AppDelegate *)[[UIApplication sharedApplication] delegate] model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - actions

- (IBAction)shareFateChanger:(id)sender {
    [super viewDidLoad];
    self.model = [(AppDelegate *)[[UIApplication sharedApplication] delegate] model];
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
