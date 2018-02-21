//
//  LearnViewController.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/14/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//

#import "LearnViewController.h"

@interface LearnViewController ()

@end

@implementation LearnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - actions
- (IBAction)playIntroduction:(id)sender {
    [[self navigationController] popToRootViewControllerAnimated:NO];
}


- (IBAction)skipIntroduction:(id)sender {
    [[self navigationController] popToRootViewControllerAnimated:NO];

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
