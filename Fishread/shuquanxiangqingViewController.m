//
//  shuquanxiangqingViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "shuquanxiangqingViewController.h"
#import "quanzixiangqingCell0.h"
#import "dongtaixiangqingModel.h"

@interface shuquanxiangqingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *xiangqingtableView;


@end

static NSString *shuquanxiangqingidentfid0 = @"shuquanxiangqingidentfid0";
static NSString *shuquanxiangqingidentfid1 = @"shuquanxiangqingidentfid1";

@implementation shuquanxiangqingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
      
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";
    
    [self.view addSubview:self.xiangqingtableView];
    [self addHeader];
    [self addFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}


#pragma mark - web

- (void)addHeader
{
    // 头部刷新控件
    self.xiangqingtableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.xiangqingtableView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.xiangqingtableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
}

- (void)refreshAction {
    
    [self headerRefreshEndAction];
    
}

- (void)refreshLoadMore {
    
    [self footerRefreshEndAction];
}


-(void)headerRefreshEndAction
{
    NSString *urlstr = [NSString stringWithFormat:dongtaixiangqing,[tokenstr tokenstrfrom],@"1",self.idstr];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
//        NSLog(@"res------%@",responseObject);
        //if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
        NSDictionary *infodit = [responseObject objectForKey:@"info"];
            //NSLog(@"info------%@",infodit);
        NSDictionary *avatardit = [infodit objectForKey:@"Avatar"];
        NSLog(@"avar-----%@",avatardit);
        
        //}
    } failure:^(NSError *error) {
        
    }];
}

-(void)footerRefreshEndAction
{
    
}

#pragma mark - getters

-(UITableView *)xiangqingtableView
{
    if(!_xiangqingtableView)
    {
        _xiangqingtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _xiangqingtableView.dataSource = self;
        _xiangqingtableView.delegate = self;
    }
    return _xiangqingtableView;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    quanzixiangqingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:shuquanxiangqingidentfid0];
    cell = [[quanzixiangqingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shuquanxiangqingidentfid0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500*HEIGHT_SCALE;
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
