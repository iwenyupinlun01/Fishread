//
//  publishedViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "publishedViewController.h"
#import "publishCell.h"
#import "headView.h"
#import "publishModel.h"

@interface publishedViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *publishtable;
@property (nonatomic,strong) headView *hview;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSString *namestr;
@property (nonatomic,strong) NSString *pathicon;
@end
static NSString *publishidentfid = @"publishidentfid";
@implementation publishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的发表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.publishtable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.publishtable];
    self.dataSource = [NSMutableArray array];
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
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
}
#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.publishtable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.publishtable.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.publishtable.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
}

- (void)refreshAction {
    [self headerRefreshEndAction];
}

- (void)refreshLoadMore {
    
    [self footerRefreshEndAction];
}

-(void)headerRefreshEndAction
{
    pn = 1;
    [self.dataSource removeAllObjects];
    NSString *urlstr = [NSString stringWithFormat:wodefabiao,[tokenstr tokenstrfrom],@"1",@""];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *dic = [responseObject objectForKey:@"info"];
            self.namestr = [responseObject objectForKey:@"nickname"];
            self.pathicon = [responseObject objectForKey:@"userIcon"];
            [self.hview.infoimg sd_setImageWithURL:[NSURL URLWithString:self.pathicon] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            self.hview.namelab.text = self.namestr;
            for (int i = 0; i<dic.count; i++) {
                NSDictionary *dit = [dic objectAtIndex:i];
                publishModel *model = [[publishModel alloc] init];
                model.titlestr = [dit objectForKey:@"create_time"];
                model.contentstr = [dit objectForKey:@"content"];
                model.idstr = [dit objectForKey:@"id"];
                model.uidstr = [dit objectForKey:@"uid"];
                model.imgArray = [NSMutableArray array];
                model.imgArray = [dit objectForKey:@"images"];
                [self.dataSource addObject:model];
            }
        }
        else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
        }
        
        [self.publishtable.mj_header endRefreshing];
        [self.publishtable reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.publishtable.mj_header endRefreshing];
    }];
    
}

-(void)footerRefreshEndAction
{
    pn++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *urlstr = [NSString stringWithFormat:wodefabiao,[tokenstr tokenstrfrom],pnstr,@""];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *dic = [responseObject objectForKey:@"info"];
            for (int i = 0; i<dic.count; i++) {
                NSDictionary *dit = [dic objectAtIndex:i];
                publishModel *model = [[publishModel alloc] init];
                model.titlestr = [dit objectForKey:@"create_time"];
                model.contentstr = [dit objectForKey:@"content"];
                model.idstr = [dit objectForKey:@"id"];
                model.uidstr = [dit objectForKey:@"uid"];
                model.imgArray = [NSMutableArray array];
                model.imgArray = [dit objectForKey:@"images"];
                [self.dataSource addObject:model];
            }
        }
        else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
        }
        
        [self.publishtable.mj_footer endRefreshing];
        [self.publishtable reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.publishtable.mj_footer endRefreshing];
    }];

}
#pragma mark - getters

-(UITableView *)publishtable
{
    if(!_publishtable)
    {
        _publishtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _publishtable.dataSource = self;
        _publishtable.delegate = self;
        _publishtable.tableHeaderView = self.hview;
    }
    return _publishtable;
}

-(headView *)hview
{
    if(!_hview)
    {
        _hview = [[headView alloc] init];
        
        _hview.frame = CGRectMake(0, 0, DEVICE_WIDTH, (412-64)/2*HEIGHT_SCALE);
    }
    return _hview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    publishCell *cell = [tableView dequeueReusableCellWithIdentifier:publishidentfid];
    cell = [[publishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:publishidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    publishCell *cell = [[publishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:publishidentfid];
    CGFloat hei = [cell setdata:self.dataSource[indexPath.row]];
    return hei;
}


#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
