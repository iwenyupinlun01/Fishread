//
//  AppDelegate.m
//  Fishread
//
//  Created by 王俊钢 on 2017/5/31.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "AppDelegate.h"
#import "TopViewController.h"
#import "WXApi.h"
#import "AFNetworking.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//友盟统计
#import "UMMobClick/MobClick.h"
//bugly
#import <Bugly/Bugly.h>

//runime防止崩溃系统
#import "AvoidCrash.h"
#import "NSArray+AvoidCrash.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    TopViewController *top = [[TopViewController alloc]init];
    [self.window setRootViewController:top];
    //向微信注册应用。
    [WXApi registerApp:WXPatient_App_ID];
    //Bugly
    [Bugly startWithAppId:@"fb07b04cce"];
    //友盟	
    UMConfigInstance.appKey = @"592f7ad68630f5691a001e3c";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    [ShareSDK registerApp:@"1d0c68ab95d2c"
     //第二个参数（分享平台集合）
          activePlatforms:@[
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
                 //微信
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
                 
             default:
                 break;
         }
         
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              switch (platformType)
              {
                      //腾讯微信权限类型authType:SSO + Web授权
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:WXPatient_App_ID
                                            appSecret:WXPatient_App_Secret];
                      break;
                  default:
                      break;
              }
          }];
    
    //启动防止崩溃功能
    [AvoidCrash becomeEffective];
    
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    
    return YES;
}

-(void)onReq:(BaseReq *)req{
    
    NSLog(@"huidiao");
    
}

//微信代理方法
- (void)onResp:(BaseResp *)resp
{
    
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if(aresp.errCode== 0 ||aresp.errCode==nil)
    {
        NSString *code = aresp.code;
        [self getWeiXinOpenId:code];
    }
}

//通过code获取access_token，openid，unionid

- (void)getWeiXinOpenId:(NSString *)code{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXPatient_App_ID,WXPatient_App_Secret,code];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        if (data){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *openID = dic[@"openid"];
            NSString *unionid = dic[@"unionid"];
            NSLog(@"openid---------%@",openID);
            NSLog(@"unid===========%@",unionid);
            NSString *access_token = dic[@"access_token"];
            NSLog(@"token---------------%@",access_token);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:access_token forKey:@"access_token"];
            [defaults setObject:openID forKey:@"openid"];
            [defaults synchronize];
            NSLog(@"%@",[defaults objectForKey:@"access_token"]);
            AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
            manage.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manage GET:@"https://api.weixin.qq.com/sns/userinfo" parameters:@{@"openid":openID, @"access_token":access_token} progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"%@",dict);
                //        {
                //            city = "xxx";
                //            country = xxx;
                //            headimgurl = “http://wx.qlogo.cn/mmopen/xxxxxxx/0”;
                //            language = "zh_CN";
                //            nickname = xxx;
                //            openid = xxxxxxxxxxxxxxxxxxx; //授权用户唯一标识
                //            privilege =     (
                //            );
                //            province = "xxx";
                //            sex = 0;
                //            unionid = xxxxxxxxxxxxxxxxxx;
                //        }
                
                NSString *namestr = [dict objectForKey:@"nickname"];
                NSString *pathurlstr = [dict objectForKey:@"headimgurl"];
                [defaults setObject:dict forKey:@"userinfo"];
                [defaults setObject:namestr forKey:@"namestr"];
                [defaults setObject:pathurlstr forKey:@"pathurlstr"];
                [defaults synchronize];

                
                [[NSNotificationCenter defaultCenter] postNotificationName:WXLoginSuccess object:@"dengluchenggong"];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"userinfo error-->%@", error.localizedDescription);
            }];
        }
    });
    
}




- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options{
    
    [WXApi handleOpenURL:url delegate:self];
    return true;
}
// 这个方法是用于从微信返回第三方App
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [WXApi handleOpenURL:url delegate:self];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"home");
    [PPNetworkHelper GET:[NSString stringWithFormat:yemianbukejian,[tokenstr tokenstrfrom],@"1"] parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)dealwithCrashMessage:(NSNotification *)note {
    //不论在哪个线程中导致的crash，这里都是在主线程
    
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    NSLog(@"\n\n在AppDelegate中 方法:dealwithCrashMessage打印\n\n\n\n\n%@\n\n\n\n",note.userInfo);
}

@end
