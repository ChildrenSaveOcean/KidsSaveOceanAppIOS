//
//  IntroVideoViewController.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/15/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//

#import "IntroVideoViewController.h"
#import "HomeViewController.h"
@interface IntroVideoViewController ()

@end

@implementation IntroVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
//    [self.navigationController popToRootViewControllerAnimated:NO];
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
