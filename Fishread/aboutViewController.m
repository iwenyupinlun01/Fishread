//
//  aboutViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "aboutViewController.h"

@interface aboutViewController ()
@property (nonatomic,strong) UIImageView *logoimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *versionlab;
@property (nonatomic,strong) UILabel *companylab;
@property (nonatomic,strong) UILabel *urllab;
@end

@implementation aboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于文鱼";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色为F5F5F5
    [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor wjColorFloat:@"F5F5F5"]]];

    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.view addSubview:self.logoimg];
    [self.view addSubview:self.namelab];
    [self.view addSubview:self.versionlab];
    [self.view addSubview:self.companylab];
    [self.view addSubview:self.urllab];
    
    [self loaddataformweb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.logoimg.frame = CGRectMake(DEVICE_WIDTH/2-45*WIDTH_SCALE, 94*HEIGHT_SCALE+20, 90*WIDTH_SCALE, 90*WIDTH_SCALE);
    self.namelab.frame = CGRectMake(DEVICE_WIDTH/2-45*WIDTH_SCALE, 194*HEIGHT_SCALE+20, 90*WIDTH_SCALE, 20*HEIGHT_SCALE);
    self.versionlab.frame = CGRectMake(DEVICE_WIDTH/2-45*WIDTH_SCALE, 225*HEIGHT_SCALE+20, 90*WIDTH_SCALE, 10*HEIGHT_SCALE);
    self.companylab.frame = CGRectMake(50*WIDTH_SCALE, DEVICE_HEIGHT-180*HEIGHT_SCALE+20, DEVICE_WIDTH-100*WIDTH_SCALE, 30*HEIGHT_SCALE);
    self.urllab.frame = CGRectMake(50*WIDTH_SCALE, DEVICE_HEIGHT-150*HEIGHT_SCALE+20, DEVICE_WIDTH-100*WIDTH_SCALE, 25*HEIGHT_SCALE);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)loaddataformweb
{
    [PPNetworkHelper GET:guanyuwode parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSDictionary *dit = [responseObject objectForKey:@"info"];
            [self.logoimg sd_setImageWithURL:[NSURL URLWithString:[dit objectForKey:@"logo"]] placeholderImage:[UIImage imageNamed:@"LOGO"]];
            self.namelab.text = [dit objectForKey:@"intro"];
            self.versionlab.text = [dit objectForKey:@"version"];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - getters

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
        _namelab.text = @"文鱼";
        _namelab.textAlignment = NSTextAlignmentCenter;
        _namelab.textColor = [UIColor wjColorFloat:@"333333"];
    }
    return _namelab;
}

-(UILabel *)versionlab
{
    if(!_versionlab)
    {
        _versionlab = [[UILabel alloc] init];
        _versionlab.text = @"V1.0";
        _versionlab.textColor = [UIColor wjColorFloat:@"999999"];
        _versionlab.textAlignment = NSTextAlignmentCenter;
        _versionlab.adjustsFontSizeToFitWidth = YES;
        _versionlab.font = [UIFont systemFontOfSize:12];
    }
    return _versionlab;
}

-(UILabel *)companylab
{
    if(!_companylab)
    {
        _companylab = [[UILabel alloc] init];
        _companylab.text = @"北京文鱼互动科技有限公司";
        _companylab.textAlignment = NSTextAlignmentCenter;
        _companylab.textColor = [UIColor wjColorFloat:@"333333"];
    }
    return _companylab;
}

-(UILabel *)urllab
{
    if(!_urllab)
    {
        _urllab = [[UILabel alloc] init];
        _urllab.textAlignment = NSTextAlignmentCenter;
        _urllab.textColor = [UIColor wjColorFloat:@"333333"];
        _urllab.text = @"官网 : www.iwenyu.cn";
        _urllab.font = [UIFont systemFontOfSize:15];
    }
    return _urllab;
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
