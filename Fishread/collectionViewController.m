//
//  collectionViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "collectionViewController.h"
#import "publishCell.h"
#import "publishModel.h"
#import "democontentViewController.h"
@interface collectionViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *shoucangtableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end
static NSString *collecidentfid = @"collecidentfid";
@implementation collectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的收藏";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.shoucangtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.shoucangtableView];
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
    self.shoucangtableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.shoucangtableView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.shoucangtableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
}

- (void)refreshAction {
    [self headerRefreshEndAction];
}

- (void)refreshLoadMore {
    
    [self footerRefreshEndAction];
}

-(void)headerRefreshEndAction
{
    [self.dataSource removeAllObjects];
    pn = 1;
    NSString *urlstr = [NSString stringWithFormat:wodeshoucang,[tokenstr tokenstrfrom],@"1"];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *arr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<arr.count; i++) {
                publishModel *model = [[publishModel alloc] init];
                NSDictionary *dit = [arr objectAtIndex:i];
                model.timestr = [dit objectForKey:@"create_time"];
                model.idstr = [dit objectForKey:@"id"];
                model.contentstr = [dit objectForKey:@"content"];
                model.imgArray = [NSMutableArray array];
                model.imgArray = [dit objectForKey:@"images"];
                [self.dataSource addObject:model];
            }
        }else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
            self.shoucangtableView.emptyDataSetDelegate = self;
            self.shoucangtableView.emptyDataSetSource = self;
        }
        
        [self.shoucangtableView.mj_header endRefreshing];
        [self.shoucangtableView reloadData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.shoucangtableView.mj_header endRefreshing];
        self.shoucangtableView.emptyDataSetDelegate = self;
        self.shoucangtableView.emptyDataSetSource = self;
    }];
}

-(void)footerRefreshEndAction
{
    pn ++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *urlstr = [NSString stringWithFormat:wodeshoucang,[tokenstr tokenstrfrom],pnstr];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *arr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<arr.count; i++) {
                publishModel *model = [[publishModel alloc] init];
                NSDictionary *dit = [arr objectAtIndex:i];
                model.timestr = [dit objectForKey:@"create_time"];
                model.idstr = [dit objectForKey:@"id"];
                model.contentstr = [dit objectForKey:@"content"];
                model.imgArray = [NSMutableArray array];
                model.imgArray = [dit objectForKey:@"images"];
                [self.dataSource addObject:model];
            }
        }else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
        }
        [self.shoucangtableView reloadData];
        [self.shoucangtableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.shoucangtableView.mj_footer endRefreshing];
    }];
}

#pragma mark - getters

-(UITableView *)shoucangtableView
{
    if(!_shoucangtableView)
    {
        _shoucangtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _shoucangtableView.dataSource = self;
        _shoucangtableView.delegate = self;
    }
    return _shoucangtableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    publishCell *cell = [tableView dequeueReusableCellWithIdentifier:collecidentfid];
    cell = [[publishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collecidentfid];
    [cell setdata:self.dataSource[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    publishCell *cell = [[publishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collecidentfid];
    CGFloat hei = [cell setdata:self.dataSource[indexPath.row]];
    return hei;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    democontentViewController *demovc = [[democontentViewController alloc] init];
    publishModel *model = self.dataSource[indexPath.row];
    demovc.idstr = model.idstr;
    [self.navigationController pushViewController:demovc animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        publishModel *model = self.dataSource[indexPath.row];
        NSString *urlstr = [NSString stringWithFormat:shoucang,[tokenstr tokenstrfrom],model.idstr,@"2",@"2"];
        [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
            [self headerRefreshEndAction];
        } failure:^(NSError *error) {
            [MBProgressHUD showSuccess:@"没有网络"];
        }];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";//默认文字为 Delete
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"2222"];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"没有数据";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    // 空白页面被点击时开启动画，reloadEmptyDataSet
    [self addHeader];
}

@end
