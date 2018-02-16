//
//  AppDelegate.h
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/11/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FateChangerModel.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) FateChangerModel *model;
@end

