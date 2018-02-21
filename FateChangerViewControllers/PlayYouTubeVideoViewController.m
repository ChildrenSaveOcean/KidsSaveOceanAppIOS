//
//  PlayYouTubeVideoViewController.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 2/19/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//
#import <YTPlayerView.h>
#import "PlayYouTubeVideoViewController.h"

@interface PlayYouTubeVideoViewController ()
@property (weak, nonatomic) IBOutlet YTPlayerView *playerViewer;

@end

@implementation PlayYouTubeVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.playerViewer loadWithVideoId:@"XWS40EQ3fj8"];
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

@end
