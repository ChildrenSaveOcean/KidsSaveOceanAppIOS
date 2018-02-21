//
//  IntroVideoViewController.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/15/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//
#import "AppDelegate.h"
#import "IntroVideoViewController.h"
#import "HomeViewController.h"
@interface IntroVideoViewController ()
@property (nonatomic, strong) FateChangerModel *model;

@end

@implementation IntroVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [(AppDelegate *)[[UIApplication sharedApplication] delegate] model];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goHomeTab:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}
- (IBAction)skipVideo:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}
- (IBAction)shareFateChanger:(id)sender {
    [self.model shareActionMessage:@"Great app for saving the ocean and its whales. Try it! (Shared from Fate Changer" from:self onlyTo:nil];
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
