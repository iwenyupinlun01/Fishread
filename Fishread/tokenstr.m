//
//  tokenstr.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "tokenstr.h"

@implementation tokenstr

+(NSString *)tokenstrfrom
{
    NSString *tokenstr = [[NSString alloc] init];
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *token = [userdefat objectForKey:@"tokenuser"];
    if (token.length==0) {
        tokenstr = @"";
    }
    else
    {
        tokenstr = token;
    }
    NSLog(@"token--------%@",tokenstr);
    return tokenstr;
}

+(NSString *)nicknamestrfrom
{
    NSString *nicknamestr = [[NSString alloc] init];
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *namestr = [userdefat objectForKey:@"namestr"];
    if (namestr.length==0) {
        nicknamestr = @"";
    }
    else
    {
        nicknamestr = namestr;
    }
    NSLog(@"name--------%@",nicknamestr);
    return nicknamestr;
}

+(NSString *)userimgstrfrom
{
    NSString *userimgstr = [[NSString alloc] init];
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *imgstr = [userdefat objectForKey:@"pathurlstr"];
    if (imgstr.length==0) {
        userimgstr = @"";
    }
    else
    {
        userimgstr = imgstr;
    }
    NSLog(@"pathurlstr--------%@",userimgstr);
    return userimgstr;
}

+(NSString *)useruid
{
    NSString *useruid = [[NSString alloc] init];
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *uidstr = [userdefat objectForKey:@"useruid"];
    if (uidstr.length==0) {
        useruid = @"";
    }
    else
    {
        useruid = uidstr;
    }

    return useruid;
}
@end
