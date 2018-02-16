//
//  HomeViewController.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/12/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//

#import "HomeViewController.h"
#import "RoleSelectionViewController.h"

@interface HomeViewController ()
@property (nonatomic, assign,getter=isFirstTime) BOOL firstTime;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstTime = YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)selectedBackButtonOnHomeView:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RoleSelectionViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RoleSelectionViewControllerID"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self.navigationController presentViewController:vc animated:NO completion:nil];
}

@end
