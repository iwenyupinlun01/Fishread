//
//  NearViewController.m
//  CustomNav
//
//  Created by xuehaodong on 2016/12/29.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "NearViewController.h"
#import "quanbuCell.h"
#import "quanbuModel.h"

#import "democontentViewController.h"

@interface NearViewController ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *shentableView;
@property (nonatomic,strong) NSMutableArray *shenArray;
@end
static NSString *shenidentfid = @"shenidentfid";
@implementation NearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
//    [navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    //此处使底部线条颜色为F5F5F5
//    [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor wjColorFloat:@"F5F5F5"]]];

    // Do any additional setup after loading the view from its nib.
    self.shenArray = [NSMutableArray array];
    [self.view addSubview:self.shentableView];
    self.shentableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self addHeader];
    [self addFooter];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - web

- (void)addHeader
{
    // 头部刷新控件
    self.shentableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.shentableView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.shentableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
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
    [self.shenArray removeAllObjects];
    NSString *urlstr = [NSString stringWithFormat:quanziquanbu,[tokenstr tokenstrfrom],@"1",@"3"];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *dataarr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dit = [dataarr objectAtIndex:i];
                quanbuModel *model = [[quanbuModel alloc] init];
                model.object_idstr = [dit objectForKey:@"object_id"];
                model.reward_numstr = [dit objectForKey:@"reward_num"];
                model.parsestr = [dit objectForKey:@"parse"];
                model.create_timestr = [dit objectForKey:@"create_time"];
                model.contentstr = [dit objectForKey:@"content"];
                model.idstr = [dit objectForKey:@"id"];
                model.reply_numstr = [dit objectForKey:@"reply_num"];
                model.statusstr = [dit objectForKey:@"status"];
                model.support_numstr = [dit objectForKey:@"support_num"];
                model.imagesArray = [dit objectForKey:@"images"];
                model.titlestr = [dit objectForKey:@"title"];
                model.post_statusstr = [dit objectForKey:@"post_status"];
                model.member_statusstr = [dit objectForKey:@"member_status"];
                model.nicknamestr = [dit objectForKey:@"nickname"];
                model.pathstr = [dit objectForKey:@"path"];
                model.is_supportstr = [dit objectForKey:@"is_support"];
                [self.shenArray addObject:model];
            }
            [self.shentableView reloadData];
            [self.shentableView.mj_header endRefreshing];
        }else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
            [self.shentableView.mj_header endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.shentableView.mj_header endRefreshing];
    }];
}

-(void)footerRefreshEndAction
{
    pn++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *urlstr = [NSString stringWithFormat:quanziquanbu,[tokenstr tokenstrfrom],pnstr,@"3"];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *dataarr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<dataarr.count; i++) {
                NSDictionary *dit = [dataarr objectAtIndex:i];
                quanbuModel *model = [[quanbuModel alloc] init];
                model.object_idstr = [dit objectForKey:@"object_id"];
                model.reward_numstr = [dit objectForKey:@"reward_num"];
                model.parsestr = [dit objectForKey:@"parse"];
                model.create_timestr = [dit objectForKey:@"create_time"];
                model.contentstr = [dit objectForKey:@"content"];
                model.idstr = [dit objectForKey:@"id"];
                model.reply_numstr = [dit objectForKey:@"reply_num"];
                model.statusstr = [dit objectForKey:@"status"];
                model.support_numstr = [dit objectForKey:@"support_num"];
                model.imagesArray = [dit objectForKey:@"images"];
                model.titlestr = [dit objectForKey:@"title"];
                model.post_statusstr = [dit objectForKey:@"post_status"];
                model.member_statusstr = [dit objectForKey:@"member_status"];
                model.nicknamestr = [dit objectForKey:@"nickname"];
                model.pathstr = [dit objectForKey:@"path"];
                model.is_supportstr = [dit objectForKey:@"is_support"];
                [self.shenArray addObject:model];
            }
            [self.shentableView reloadData];
            [self.shentableView.mj_footer endRefreshing];
        }else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
            [self.shentableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.shentableView.mj_header endRefreshing];
    }];
}

#pragma mark - getters

-(UITableView *)shentableView
{
    if(!_shentableView)
    {
        _shentableView =  [[UITableView alloc] initWithFrame:CGRectMake(0,0 , DEVICE_WIDTH, DEVICE_HEIGHT-50-64)];
        _shentableView.dataSource = self;
        _shentableView.delegate = self;
        [_shentableView setSeparatorColor:[UIColor wjColorFloat:@"e8e8e8"]];
    }
    return _shentableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shenArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    quanbuCell *cell = [tableView dequeueReusableCellWithIdentifier:shenidentfid];
    cell = [[quanbuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shenidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.separatorInset = UIEdgeInsetsMake(0, 14, 0, 14);
    [cell setdata:self.shenArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    quanbuCell *cell = [[quanbuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shenidentfid];
    return [cell setdata:self.shenArray[indexPath.row]];
}

-(void)myTabVClick1:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.shentableView indexPathForCell:cell];
    NSLog(@"333===%ld   点赞",index.row);
    
    
    quanbuModel *model = self.shenArray[index.row];
    NSString *idsr = model.idstr;
    [PPNetworkHelper GET:[NSString stringWithFormat:dianzan,[tokenstr tokenstrfrom],idsr,@"1"] parameters:nil success:^(id responseObject) {
        NSString *hud = [responseObject objectForKey:@"msg"];
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            [self headerRefreshEndAction];
            [MBProgressHUD showSuccess:@"点赞+1"];
        }else
        {
            [MBProgressHUD showSuccess:hud];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
}

-(void)myTabVClick2:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.shentableView indexPathForCell:cell];
    NSLog(@"333===%ld   评论",index.row);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    democontentViewController *demo = [[democontentViewController alloc] init];
    quanbuModel *model = self.shenArray[indexPath.row];
    demo.idstr = model.idstr;
    demo.fromtype = @"2";
    demo.object_idstr = model.object_idstr;
    [self.navigationController pushViewController:demo animated:YES];
}

@end
