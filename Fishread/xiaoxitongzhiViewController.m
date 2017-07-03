//
//  xiaoxitongzhiViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "xiaoxitongzhiViewController.h"
#import "replyCell.h"
#import "replyModel.h"
#import "democontentViewController.h"
@interface xiaoxitongzhiViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *xiaoxitableView;
@property (nonatomic,strong) NSMutableArray *replyarr;
@property (nonatomic,strong) replyModel *rmodel;

@end
static NSString *replyidentfid = @"replyidentfid";
@implementation xiaoxitongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titlestr;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色为F5F5F5
    [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor wjColorFloat:@"F5F5F5"]]];

    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.xiaoxitableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.xiaoxitableView];
    
    
    self.replyarr = [NSMutableArray array];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self addHeader];
    [self addFooter];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}


#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.xiaoxitableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.xiaoxitableView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.xiaoxitableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
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
    [self.replyarr removeAllObjects];
    NSString *urlstr = [NSString stringWithFormat:xiaoxitongzhi,[tokenstr tokenstrfrom],self.typestr,@"1"];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *ditarr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<ditarr.count; i++) {
                NSDictionary *dit = [ditarr objectAtIndex:i];
                self.rmodel = [[replyModel alloc] init];
                self.rmodel.replyurl = dit[@"user_icon"];
                self.rmodel.replyname = dit[@"publisher_nickname"];
                self.rmodel.replytext = dit[@"comment_date"];
                self.rmodel.comment_img_type = dit[@"circle_cover_type"];
                self.rmodel.comment_imgstr = dit[@"circle_cover"];
                self.rmodel.replytimestr = dit[@"pubtime"];
                self.rmodel.obj_id = dit[@"object_id"];
                self.rmodel.is_checkstr = dit[@"is_check"];
                self.rmodel.replyidstr = dit[@"id"];
                [self.replyarr addObject:self.rmodel];
            }
        }else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
            self.xiaoxitableView.emptyDataSetDelegate = self;
            self.xiaoxitableView.emptyDataSetSource = self;
        }
        [self.xiaoxitableView reloadData];
        [self.xiaoxitableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.xiaoxitableView.mj_header endRefreshing];
        self.xiaoxitableView.emptyDataSetDelegate = self;
        self.xiaoxitableView.emptyDataSetSource = self;
    }];
}

-(void)footerRefreshEndAction
{
    pn++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *urlstr = [NSString stringWithFormat:xiaoxitongzhi,[tokenstr tokenstrfrom],self.typestr,pnstr];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *ditarr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<ditarr.count; i++) {
                NSDictionary *dit = [ditarr objectAtIndex:i];
                self.rmodel = [[replyModel alloc] init];
                self.rmodel.replyurl = dit[@"user_icon"];
                self.rmodel.replyname = dit[@"publisher_nickname"];
                self.rmodel.replytext = dit[@"comment_date"];
                self.rmodel.comment_img_type = dit[@"circle_cover_type"];
                self.rmodel.comment_imgstr = dit[@"circle_cover"];
                self.rmodel.replytimestr = dit[@"pubtime"];
                self.rmodel.obj_id = dit[@"object_id"];
                self.rmodel.is_checkstr = dit[@"is_check"];
                self.rmodel.replyidstr = dit[@"id"];
                [self.replyarr addObject:self.rmodel];
            }
        }else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
        }
        [self.xiaoxitableView reloadData];
        [self.xiaoxitableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.xiaoxitableView.mj_footer endRefreshing];
    }];
}

#pragma mark - getters

-(UITableView *)xiaoxitableView
{
    if(!_xiaoxitableView)
    {
        _xiaoxitableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _xiaoxitableView.dataSource = self;
        _xiaoxitableView.delegate = self;
    }
    return _xiaoxitableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.replyarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    replyCell *cell = [tableView dequeueReusableCellWithIdentifier:replyidentfid];
    if (!cell) {
        cell = [[replyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:replyidentfid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setdata:self.replyarr[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 248/2*HEIGHT_SCALE-30*HEIGHT_SCALE;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        self.rmodel = self.replyarr[indexPath.row];
        NSString* objid =   self.rmodel.replyidstr;
        
        [PPNetworkHelper GET:[NSString stringWithFormat:shanchuxiaoxi2,[tokenstr tokenstrfrom],@"1",objid] parameters:nil success:^(id responseObject) {
            NSString *hud = [responseObject objectForKey:@"msg"];
            if ([[responseObject objectForKey:@"code"] intValue]==1) {
                // 删除数据源的数据,self.cellData是你自己的数据
                [self.replyarr removeObjectAtIndex:indexPath.row];
                //删除列表中数据
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [MBProgressHUD showSuccess:hud];
            }else
            {
                 [MBProgressHUD showSuccess:hud];
            }
        } failure:^(NSError *error) {
             [MBProgressHUD showSuccess:@"没有网络"];
        }];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";//默认文字为 Delete
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    democontentViewController *demovc = [[democontentViewController alloc] init];
    replyModel *model = self.replyarr[indexPath.row];
    demovc.idstr = model.obj_id;
    NSString *msgid = model.replyidstr;
    [self.navigationController pushViewController:demovc animated:YES];
    
    [PPNetworkHelper GET:[NSString stringWithFormat:kanwanfanhui,[tokenstr tokenstrfrom],msgid] parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
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
