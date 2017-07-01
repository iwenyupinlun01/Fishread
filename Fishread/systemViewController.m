//
//  systemViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "systemViewController.h"
#import "systemCell.h"
#import "xitongModel.h"
@interface systemViewController ()<UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *systemtabeView;

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) xitongModel *ximodel;
@property (nonatomic,strong) NSMutableArray *xitongarr;
@end
static NSString * const kShowTextCellReuseIdentifier = @"QSShowTextCell";

@implementation systemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"系统消息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.systemtabeView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.systemtabeView];
    
    self.dataSource = [NSMutableArray array];
    self.xitongarr = [NSMutableArray array];
    
    
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

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.systemtabeView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.systemtabeView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.systemtabeView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
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
    [self.xitongarr removeAllObjects];
    NSString *urlstr = [NSString stringWithFormat:xitongxiaoxi,[tokenstr tokenstrfrom],@"1"];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
            NSArray *dit = [responseObject objectForKey:@"info"];
            for (int i = 0; i<dit.count; i++)
            {
                NSDictionary *dicarr = [dit objectAtIndex:i];
                self.ximodel = [[xitongModel alloc] init];
                self.ximodel.puttimestr = dicarr[@"pubtime"];
                self.ximodel.idstr = dicarr[@"id"];
                NSString *concent = dicarr[@"inform_content"];
                
                [self.dataSource addObject:concent];
                
                [self.xitongarr addObject:self.ximodel];
                
            }
        }else
        {
            NSString *huds= [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:huds];
            self.systemtabeView.emptyDataSetSource = self;
            self.systemtabeView.emptyDataSetDelegate = self;
        }
        [self.systemtabeView.mj_header endRefreshing];
        [self.systemtabeView reloadData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.systemtabeView.mj_header endRefreshing];
        self.systemtabeView.emptyDataSetSource = self;
        self.systemtabeView.emptyDataSetDelegate = self;
    }];
}

-(void)footerRefreshEndAction
{
    pn ++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *urlstr = [NSString stringWithFormat:xitongxiaoxi,[tokenstr tokenstrfrom],pnstr];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
            NSArray *dit = [responseObject objectForKey:@"info"];
            for (int i = 0; i<dit.count; i++)
            {
                NSDictionary *dicarr = [dit objectAtIndex:i];
                self.ximodel = [[xitongModel alloc] init];
                self.ximodel.puttimestr = dicarr[@"pubtime"];
                self.ximodel.idstr = dicarr[@"id"];
                NSString *concent = dicarr[@"inform_content"];

                [self.dataSource addObject:concent];
                [self.xitongarr addObject:self.ximodel];
            }
        }else
        {
            NSString *huds= [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:huds];
        }
        [self.systemtabeView.mj_footer endRefreshing];
        [self.systemtabeView reloadData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.systemtabeView.mj_footer endRefreshing];
    }];
}

#pragma mark - getters

-(UITableView *)systemtabeView
{
    if(!_systemtabeView)
    {
        _systemtabeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _systemtabeView.dataSource = self;
        _systemtabeView.delegate = self;
    }
    return _systemtabeView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [systemCell cellHeightWithText:[self p_textAtIndexPath:indexPath]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.01f;
    }
    return 10.00f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    systemCell *cell = [tableView dequeueReusableCellWithIdentifier:kShowTextCellReuseIdentifier];
    if (!cell) {
        
        cell = [[systemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kShowTextCellReuseIdentifier];
        cell.rightUtilityButtons = [self rightButtons];
        [cell setcelldata:self.xitongarr[indexPath.row]];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell layoutSubviewsWithText:[self p_textAtIndexPath:indexPath]];
    return cell;
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    return rightUtilityButtons;
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                icon:[UIImage imageNamed:@"clock.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross.png"]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                icon:[UIImage imageNamed:@"list.png"]];
    return leftUtilityButtons;
}


#pragma mark - SWTableViewDelegate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"check button was pressed");
            break;
        case 1:
            NSLog(@"clock button was pressed");
            break;
        case 2:
            NSLog(@"cross button was pressed");
            break;
        case 3:
            NSLog(@"list button was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:{
            NSIndexPath *cellIndexPath = [self.systemtabeView indexPathForCell:cell];
            NSInteger row = cellIndexPath.row;
            self.ximodel = [self.xitongarr objectAtIndex:row];
            
            NSString *idstr = self.ximodel.idstr;
            NSLog(@"idstr========%@",idstr);
            
            NSString *urlstr = [NSString stringWithFormat:shanchuxiaoxi2,[tokenstr tokenstrfrom],@"2",idstr];
            [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
                NSString *hud = [responseObject objectForKey:@"msg"];
                if ([[responseObject objectForKey:@"code"] intValue]==1) {
                    [self p_removeTextAtIndexPath:cellIndexPath];
                    [self.xitongarr removeObject:cellIndexPath];
                    [self.systemtabeView deleteRowsAtIndexPaths:@[cellIndexPath]
                                               withRowAnimation:UITableViewRowAnimationAutomatic];
                    
                    [self.systemtabeView reloadData];
                    [MBProgressHUD showSuccess:hud];
                }else
                {
                    [MBProgressHUD showSuccess:hud];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showSuccess:@"没有网络"];
            }];
        }
            break;
        default:
            break;
    }
}

- (NSString *)p_textAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.dataSource objectAtIndex:indexPath.row];
}

- (void)p_removeTextAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"row = %ld,section = %ld",indexPath.row,indexPath.section);
    [self.dataSource removeObjectAtIndex:indexPath.row];
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
