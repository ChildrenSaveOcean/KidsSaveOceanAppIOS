//
//  DonationViewController.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/12/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//
#import "AppDelegate.h"
#import "FateChangerModel.h"
#import "DonationViewController.h"

@interface DonationViewController ()
@property (nonatomic, strong) FateChangerModel *model;

@end

@implementation DonationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [(AppDelegate *)[[UIApplication sharedApplication] delegate] model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donateToFateChanger:(id)sender {
    NSURL *url = [NSURL URLWithString:@"https://www.kidssaveocean.com/donate"];
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    [[UIApplication sharedApplication] openURL:url options:dictionary completionHandler:nil];
}
#pragma mark - actions

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
