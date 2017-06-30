//
//  loginViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "loginViewController.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "WXApi.h"
#import "xieyiViewController.h"
#import "AFManager.h"
@interface loginViewController ()<YBAttributeTapActionDelegate>
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UIImageView *logoimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UIButton *loginbtn;
@property (nonatomic,strong) UIButton *zhijiebtn;
@property (nonatomic,strong) UILabel *aggrentlab;
@property (nonatomic,strong) UIButton *gobackbtn;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgimg];
    [self.view addSubview:self.logoimg];
    [self.view addSubview:self.loginbtn];
    [self.view addSubview:self.loginbtn];
    [self.view addSubview:self.zhijiebtn];
    [self.view addSubview:self.aggrentlab];
    [self.view addSubview:self.namelab];
    [self.view addSubview:self.gobackbtn];
    [self weixinLogin];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXLogin:) name:WXLoginSuccess object:@"dengluchenggong"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.logoimg.frame = CGRectMake(283/2*WIDTH_SCALE, 264/2*HEIGHT_SCALE, (DEVICE_WIDTH/2-283/2*WIDTH_SCALE)*2, (DEVICE_WIDTH/2-283/2*WIDTH_SCALE)*2);
    self.loginbtn.frame = CGRectMake(20*WIDTH_SCALE, DEVICE_HEIGHT-140*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 40*HEIGHT_SCALE);
    self.namelab.frame = CGRectMake(100*WIDTH_SCALE,  264/2*HEIGHT_SCALE+(DEVICE_WIDTH/2-283/2*WIDTH_SCALE)*2, DEVICE_WIDTH-200*WIDTH_SCALE, 30);
    self.zhijiebtn.frame = CGRectMake(DEVICE_WIDTH-50*WIDTH_SCALE-20*WIDTH_SCALE, DEVICE_HEIGHT-24*WIDTH_SCALE-12*WIDTH_SCALE, 50*WIDTH_SCALE, 12*HEIGHT_SCALE);
    self.aggrentlab.frame = CGRectMake(14*WIDTH_SCALE, DEVICE_HEIGHT-24*HEIGHT_SCALE-12*HEIGHT_SCALE, DEVICE_WIDTH-40*WIDTH_SCALE, 12*HEIGHT_SCALE);
    self.gobackbtn.frame = CGRectMake(DEVICE_WIDTH-120, DEVICE_HEIGHT-24*HEIGHT_SCALE-12*HEIGHT_SCALE, 120-14*WIDTH_SCALE, 12*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgimg.image = [UIImage imageNamed:@"背景"];
    }
    return _bgimg;
}

-(UIImageView *)logoimg
{
    if(!_logoimg)
    {
        _logoimg = [[UIImageView alloc] init];
        _logoimg.image = [UIImage imageNamed:@"LOGO"];
    }
    return _logoimg;
}


-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.textColor = [UIColor wjColorFloat:@"FFFFFF"];
        _namelab.text = @"文鱼";
        _namelab.textAlignment = NSTextAlignmentCenter;
    }
    return _namelab;
}


-(UIButton *)gobackbtn
{
    if(!_gobackbtn)
    {
        _gobackbtn = [[UIButton alloc] init];
        [_gobackbtn addTarget:self action:@selector(gobackbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_gobackbtn setTitle:@"直接使用" forState:normal];
        _gobackbtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        _gobackbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_gobackbtn setTitleColor:[UIColor wjColorFloat:@"54D48A"] forState:normal];
        //_gobackbtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _gobackbtn;
}


-(UIButton *)loginbtn
{
    if(!_loginbtn)
    {
        _loginbtn = [[UIButton alloc] init];
        _loginbtn.backgroundColor = [UIColor wjColorFloat:@"54D48A"];
        _loginbtn.layer.masksToBounds = YES;
        _loginbtn.layer.cornerRadius = 20;
    }
    return _loginbtn;
}

-(UILabel *)aggrentlab
{
    if(!_aggrentlab)
    {
        _aggrentlab = [[UILabel alloc] init];
        NSString *str = @"登录即表示您同意用户协议";
        _aggrentlab.font = [UIFont systemFontOfSize:12];
        //创建NSMutableAttributedString
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        //设置字体和设置字体的范围
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(8
                                                                                                       , 4)];
        //添加文字颜色
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"54D48A"] range:NSMakeRange(8, 4)];
        //添加下划线
        [attrStr addAttribute:NSUnderlineStyleAttributeName
                        value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
                        range:NSMakeRange(8, 4)];
        
        _aggrentlab.textColor = [UIColor wjColorFloat:@"CDCDC7"];
        _aggrentlab.attributedText = attrStr;
        
        [_aggrentlab sizeToFit];
        
        [_aggrentlab yb_addAttributeTapActionWithStrings:@[@"用户协议"] delegate:self];
        
        [_aggrentlab yb_addAttributeTapActionWithStrings:@[@"用户协议"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
            NSLog(@"122");
            xieyiViewController *xieyivc = [[xieyiViewController alloc] init];
            [self presentViewController:xieyivc animated:YES completion:^{
                
            }];
        }];
        _aggrentlab.textAlignment = NSTextAlignmentLeft;
    }
    return _aggrentlab;
}

#pragma mark - 实现方法

-(void)weixinLogin{
    if([WXApi isWXAppInstalled]){
        
        [_loginbtn setTitle:@"微信登录" forState:normal];
        [self.loginbtn addTarget:self action:@selector(loginbtnclick) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        [_loginbtn setTitle:@"访客模式" forState:normal];
        [self.loginbtn addTarget:self action:@selector(gobackbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [self noLoginAlertController];
    }
}

-(void)loginbtnclick
{
    //[self weixinLogin];
    SendAuthReq *req = [[SendAuthReq alloc]init];
    req.scope = WX_SCOPE;
    req.state = WX_STATE; //可省，不影响功能
    [WXApi sendReq:req];
}

-(void)WXLogin:(NSNotificationCenter *)center
{
    NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
    NSString *tokenkey = [userdefat objectForKey:@"access_token"];
    NSDictionary *dic = [userdefat objectForKey:@"userinfo"];
    NSString *nickname = [dic objectForKey:@"nickname"];
    NSString *path = [dic objectForKey:@"headimgurl"];
    NSString *openid = [dic objectForKey:@"openid"];
    NSLog(@"openid---------%@",openid);
    NSDictionary *para = @{@"login_type":@"quickLogin",@"openid":openid,@"token_key":tokenkey,@"nickname":nickname,@"type":@"4",@"path":path};
    
    
    [PPNetworkHelper POST:denglu parameters:para success:^(id responseObject) {
        NSLog(@"response ------- %@",responseObject);
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSString *token = [responseObject objectForKey:@"token"];
            NSString *uid = [responseObject objectForKey:@"uid"];
            NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
            [userdefat setObject:token forKey:@"tokenuser"];
            [userdefat setObject:uid forKey:@"useruid"];
            
            NSLog(@"tolen-------------%@",token);
            [userdefat synchronize];
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
        }

    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"状态异常，请稍后再试"];
    }];
    
//    [AFManager postReqURL:denglu reqBody:para block:^(id infor) {
//        if ([[infor objectForKey:@"code"] intValue]==1) {
//            NSString *token = [infor objectForKey:@"token"];
//            NSString *uid = [infor objectForKey:@"uid"];
//            NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
//            [userdefat setObject:token forKey:@"tokenuser"];
//            [userdefat setObject:uid forKey:@"useruid"];
//            
//            NSLog(@"tolen-------------%@",token);
//            [userdefat synchronize];
//            NSString *hudstr = [infor objectForKey:@"msg"];
//            [MBProgressHUD showSuccess:hudstr];
//            
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }else
//        {
//            NSString *hud = [infor objectForKey:@"msg"];
//            [MBProgressHUD showSuccess:hud];
//        }
//    }];
    
}


-(void)gobackbtnclick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 设置弹出提示语

- (void)noLoginAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)isLoginedAlertController{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您已经登陆了，请先退出登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
