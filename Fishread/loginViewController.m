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
@interface loginViewController ()<YBAttributeTapActionDelegate>
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UIImageView *logoimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UIButton *loginbtn;
@property (nonatomic,strong) UIButton *zhijiebtn;
@property (nonatomic,strong) UILabel *aggrentlab;
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



-(UIButton *)loginbtn
{
    if(!_loginbtn)
    {
        _loginbtn = [[UIButton alloc] init];
        [_loginbtn setTitle:@"微信登陆" forState:normal];
        _loginbtn.backgroundColor = [UIColor wjColorFloat:@"54D48A"];
        _loginbtn.layer.masksToBounds = YES;
        _loginbtn.layer.cornerRadius = 20;
        [_loginbtn addTarget:self action:@selector(loginbtnclick) forControlEvents:UIControlEventTouchUpInside];
        //[_loginbtn setTitleColor:[UIColor wjColorFloat:@"54D48A"] forState:normal];
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
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"576b95"] range:NSMakeRange(8, 4)];
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
           
        }];
        _aggrentlab.textAlignment = NSTextAlignmentLeft;
    }
    return _aggrentlab;
}

#pragma mark - 实现方法

-(void)loginbtnclick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
