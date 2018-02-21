//
//  FateChangerModel.m
//  FateChangerAppIOS
//
//  Created by Bill Weatherwax on 1/29/18.
//  Copyright © 2018 waxcruz. All rights reserved.
//

#import "FateChangerModel.h"

@interface FateChangerModel()
@property (nonatomic, strong) NSString *role;
@end

@implementation FateChangerModel
-(instancetype) init
{
    [self superclass];
    if (self) {
        _role = @"Student";
    }
    return self;
}

-(void) startOfModel
{
    
    NSDictionary* defaults = @{@"Role":@"Student"
                               };
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    self.role = [[NSUserDefaults standardUserDefaults] stringForKey:@"Role"];
}

-(void) stopModel
{
    [[NSUserDefaults standardUserDefaults] setObject:self.role forKey:@"Role"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) saveUserDefaultValues
{
    [self stopModel];
}
#pragma mark - Share Action
-(void) shareActionMessage:(NSString *) message from:(UIViewController *) vcSelf onlyTo: (NSString *) toApp;
{
    
    //create a message
    NSString *theMessage = message;
    NSArray *items = @[theMessage];
    
    // build an activity view controller
    UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    if ([toApp isEqualToString:@"Facebook"]) {
        controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                             UIActivityTypeMessage,
                                             UIActivityTypeMail,
                                             UIActivityTypePrint,
                                             UIActivityTypeCopyToPasteboard,
                                             UIActivityTypeAssignToContact,
                                             UIActivityTypeSaveToCameraRoll,
                                             UIActivityTypeAddToReadingList,
                                             UIActivityTypePostToFlickr,
                                             UIActivityTypePostToVimeo,
                                             UIActivityTypePostToTencentWeibo,
                                             UIActivityTypeAirDrop,
                                             UIActivityTypePostToTwitter,
                                             @"com.apple.reminders.RemindersEditorExtension",
                                             @"com.apple.mobilenotes.SharingExtension"
                                             ];

    } else
        if ([toApp isEqualToString:@"Twitter"]) {
            controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                                 UIActivityTypeMessage,
                                                 UIActivityTypeMail,
                                                 UIActivityTypePrint,
                                                 UIActivityTypeCopyToPasteboard,
                                                 UIActivityTypeAssignToContact,
                                                 UIActivityTypeSaveToCameraRoll,
                                                 UIActivityTypeAddToReadingList,
                                                 UIActivityTypePostToFlickr,
                                                 UIActivityTypePostToVimeo,
                                                 UIActivityTypePostToTencentWeibo,
                                                 UIActivityTypeAirDrop,
                                                 UIActivityTypePostToFacebook,
                                                 @"com.apple.reminders.RemindersEditorExtension",
                                                 @"com.apple.mobilenotes.SharingExtension"
                                                 ];

        } else {
            controller.excludedActivityTypes = nil;
        }
    // and present it
    dispatch_async(dispatch_get_main_queue(), ^{
        [vcSelf presentViewController:controller animated:YES completion:nil];
    });

}

-(void) postTeacherRequestForResource: (NSString *) teacherEmail
{
    // add teacher email to Firebase noSQL database
}
-(NSString *) requestBestPersonContinent: (NSString *) continent forCountry: (NSString *) country
{
    // request contact address by continent and country from Firebase noSQL database
    return @"Prime Minister Justin Trudeau/nHouse of Commons/nOttawa, Ontario/nCanada/nK1A 0A6";
}

-(void)selectedRole: (NSString *) role
{
    self.role = role;
}
-(NSString *) whatIsRole
{
    return  self.role;
}


@end
