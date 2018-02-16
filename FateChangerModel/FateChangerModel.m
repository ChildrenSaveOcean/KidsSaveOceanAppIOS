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
