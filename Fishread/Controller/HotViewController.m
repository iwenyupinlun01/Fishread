//
//  HotViewController.m
//  CustomNav
//
//  Created by xuehaodong on 2016/12/29.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "HotViewController.h"
#import "quanbuCell.h"
#import "quanbuModel.h"
#import "democontentViewController.h"
@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate>
{
    int pn;
}
@property (nonatomic,strong) UITableView *quanzitableView;
@property (nonatomic,strong) NSMutableArray *quanbuArray;
@end

static NSString *quanziidentfid = @"quanziidentfid";

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    self.quanbuArray = [NSMutableArray array];
    [self.view addSubview:self.quanzitableView];
    [self addHeader];
    [self addFooter];
    self.quanzitableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.quanzitableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.quanzitableView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.quanzitableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
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
    [self.quanbuArray removeAllObjects];
    NSString *urlstr = [NSString stringWithFormat:quanziquanbu,[tokenstr tokenstrfrom],@"1",@"1"];
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
                [self.quanbuArray addObject:model];
            }
            [self.quanzitableView reloadData];
            [self.quanzitableView.mj_header endRefreshing];
        }else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
            [self.quanzitableView.mj_header endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.quanzitableView.mj_header endRefreshing];
    }];
}

-(void)footerRefreshEndAction
{
    pn++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *urlstr = [NSString stringWithFormat:quanziquanbu,[tokenstr tokenstrfrom],pnstr,@"1"];
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
                [self.quanbuArray addObject:model];
            }
            [self.quanzitableView reloadData];
            [self.quanzitableView.mj_footer endRefreshing];
        }else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
            [self.quanzitableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
        [self.quanzitableView.mj_header endRefreshing];
    }];
}

#pragma mark - getters

-(UITableView *)quanzitableView
{
    if(!_quanzitableView)
    {
        _quanzitableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64-50)];
        _quanzitableView.dataSource = self;
        _quanzitableView.delegate = self;
    }
    return _quanzitableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.quanbuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    quanbuCell *cell = [tableView dequeueReusableCellWithIdentifier:quanziidentfid];
    cell = [[quanbuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:quanziidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    [cell setdata:self.quanbuArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    quanbuCell *cell = [[quanbuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:quanziidentfid];
    return [cell setdata:self.quanbuArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    democontentViewController *shuquanvc = [[democontentViewController alloc] init];
    quanbuModel *model = self.quanbuArray[indexPath.row];
    shuquanvc.idstr = model.idstr;
    shuquanvc.object_idstr = model.object_idstr;
    [self.navigationController pushViewController:shuquanvc animated:YES];
}

-(void)myTabVClick1:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.quanzitableView indexPathForCell:cell];
    NSLog(@"333===%ld   点赞",index.row);
    
}

-(void)myTabVClick2:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.quanzitableView indexPathForCell:cell];
    NSLog(@"333===%ld   评论",index.row);
}

@end
