//
//  democontentViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/20.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "democontentViewController.h"
#import "DemoTableViewCell.h"
#import "DemoCellModel.h"
#import "DemoCommentModel.h"

#import <SDAutoLayout.h>
#import "DemoCommentView.h"
#import "quanzixiangqingCell0.h"
#import "dongtaixiangqingModel.h"

#define CellKey @"UITableViewCell"
#define cellkey2 @"quanzixiangqingCell0"

@interface democontentViewController () <DemoTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate,myviewVdelegate>
{
    int pn;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *contentTableview;
@property (nonatomic,strong) NSMutableArray *headArray;
@property (nonatomic,strong) NSString *righttitleStr;
@end

@implementation democontentViewController

#pragma mark 懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


-(NSMutableArray *)headArray
{
    if(!_headArray)
    {
        _headArray = [NSMutableArray new];
        
    }
    return _headArray;
}

-(UITableView *)contentTableview
{
    if(!_contentTableview)
    {
        _contentTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _contentTableview.dataSource = self;
        _contentTableview.delegate = self;
    }
    return _contentTableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";

    
    
    [self.view addSubview:self.contentTableview];
    self.contentTableview.tableFooterView = [UIView new];
    [self.contentTableview registerClass:[DemoTableViewCell class] forCellReuseIdentifier:CellKey];
    self.dataArray = [NSMutableArray array];
    [self addHeader];
    [self addFooter];
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
    self.contentTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.contentTableview.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.contentTableview.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
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
    [self.dataArray removeAllObjects];
    [self.headArray removeAllObjects];
    
    NSString *urlstr = [NSString stringWithFormat:dongtaixiangqing,[tokenstr tokenstrfrom],@"1",self.idstr];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
            NSDictionary *infodit = [responseObject objectForKey:@"info"];
            NSDictionary *avatardit = [infodit objectForKey:@"Avatar"];
            NSMutableArray *formatarray = [infodit objectForKey:@"ForumBookmark"];
            
            NSDictionary *Memberdit = [infodit objectForKey:@"Member"];
            dongtaixiangqingModel *model = [[dongtaixiangqingModel alloc] init];
            model.Avatarpathstr = [avatardit objectForKey:@"path"];
            
            
            if ((formatarray != nil && ![formatarray isKindOfClass:[NSNull class]] && formatarray.count !=0)){
                for (int i = 0; i<formatarray.count; i++) {
                    NSDictionary *dit = [formatarray objectAtIndex:i];
                    model.ForumBookmarknicknamestr = [dit objectForKey:@"nickname"];
                    model.ForumBookmarkuidstr = [dit objectForKey:@"uid"];
                    [model.ForumBookmarkArray addObject:model.ForumBookmarknicknamestr];
                }
            }
            
            model.Membernickname = [Memberdit objectForKey:@"nickname"];
            model.contentstr = [infodit objectForKey:@"content"];
            model.create_timestr = [infodit objectForKey:@"create_time"];
            model.idstr = [infodit objectForKey:@"id"];
            model.imagesArray = [infodit objectForKey:@"images"];
            
            model.titlestr = [infodit objectForKey:@"title"];
            
            self.righttitleStr = [NSString stringWithFormat:@"%@%@",@"来自",model.titlestr];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.righttitleStr style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"576B95"];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
            
            model.object_idstr = [infodit objectForKey:@"object_id"];
            model.relation_idstr = [infodit objectForKey:@"relation_id"];
            model.reply_numstr = [infodit objectForKey:@"reply_num"];
            model.reward_numstr = [infodit objectForKey:@"reward_num"];
            model.support_numstr = [infodit objectForKey:@"support_num"];
            model.uidstr = [infodit objectForKey:@"uid"];
            model.is_bookmarkstr = [infodit objectForKey:@"is_bookmark"];
            [self.headArray addObject:model];
        
        }
        
        NSDictionary *infodit = [responseObject objectForKey:@"info"];
        NSArray *dataarr = [infodit objectForKey:@"allComment"];
        for (int i = 0; i<dataarr.count; i++) {
            NSDictionary *dit = [dataarr objectAtIndex:i];
            DemoCellModel *model = [[DemoCellModel alloc]init];
            model.name = [dit objectForKey:@"comment_name"];
            model.msgContent = [dit objectForKey:@"content"];
            model.iconName = [dit objectForKey:@"comment_icon"];
            model.timestr = [dit objectForKey:@"ctime"];
            model.support_numstr = [dit objectForKey:@"support_num"];
            model.commentArray = [NSMutableArray array];
            NSArray *comarr =[dit objectForKey:@"son_comment"];
            for (int j=0; j<comarr.count; j++) {
                DemoCommentModel *commentModel = [[DemoCommentModel alloc] init];
                NSDictionary *dict = [comarr objectAtIndex:j];
                commentModel.firstUserId = [dict objectForKey:@"uid"];
                commentModel.firstUserName = [dict objectForKey:@"comment_name"];
                commentModel.secondUserId = [dict objectForKey:@"to_uid"];
                commentModel.secondUserName = [dict objectForKey:@"to_comment_name"];
                commentModel.commentString = [dict objectForKey:@"content"];
                
                [model.commentArray addObject:commentModel];
            }
            
            [self.dataArray addObject:model];
        }
        [self.contentTableview reloadData];
        [self.contentTableview.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"请检查网络"];
        [self.contentTableview.mj_header endRefreshing];
    }];

}

-(void)footerRefreshEndAction
{
    pn++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *urlstr = [NSString stringWithFormat:dongtaixiangqing,[tokenstr tokenstrfrom],pnstr,self.idstr];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        
         if ([[responseObject objectForKey:@"code"] intValue]==1)
         {
             NSDictionary *infodit = [responseObject objectForKey:@"info"];
             NSArray *dataarr = [infodit objectForKey:@"allComment"];
             for (int i = 0; i<dataarr.count; i++) {
                 NSDictionary *dit = [dataarr objectAtIndex:i];
                 DemoCellModel *model = [[DemoCellModel alloc]init];
                 model.name = [dit objectForKey:@"comment_name"];
                 model.msgContent = [dit objectForKey:@"content"];
                 model.iconName = [dit objectForKey:@"comment_icon"];
                 model.timestr = [dit objectForKey:@"ctime"];
                 model.support_numstr = [dit objectForKey:@"support_num"];
                 model.commentArray = [NSMutableArray array];
                 
                 NSArray *comarr =[dit objectForKey:@"son_comment"];
                 
                 for (int j=0; j<comarr.count; j++) {
                     DemoCommentModel *commentModel = [[DemoCommentModel alloc] init];
                     NSDictionary *dict = [comarr objectAtIndex:j];
                     commentModel.firstUserId = [dict objectForKey:@"uid"];
                     commentModel.firstUserName = [dict objectForKey:@"comment_name"];
                     commentModel.secondUserId = [dict objectForKey:@"to_uid"];
                     commentModel.secondUserName = [dict objectForKey:@"to_comment_name"];
                     commentModel.commentString = [dict objectForKey:@"content"];
                     [model.commentArray addObject:commentModel];
                 }
                 
                 [self.dataArray addObject:model];
             }

         }
         else if ([[responseObject objectForKey:@"code"] intValue]==2200)
         {
             NSString *hudstr = [responseObject objectForKey:@"msg"];
             [MBProgressHUD showSuccess:hudstr];
         }
         else if ([[responseObject objectForKey:@"code"] intValue]==2201)
         {
             NSString *hudstr = [responseObject objectForKey:@"msg"];
             [MBProgressHUD showSuccess:hudstr];
         }
        [self.contentTableview reloadData];
        [self.contentTableview.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有更多了"];
        [self.contentTableview.mj_footer endRefreshing];
    }];

}


#pragma mark UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        quanzixiangqingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellkey2];
        cell = [[quanzixiangqingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellkey2];
        [cell setdata:self.headArray[indexPath.row]];
        [cell.rightbtn addTarget:self action:@selector(alertshow) forControlEvents:UIControlEventTouchUpInside];
        [cell.zanBtn addTarget:self action:@selector(dianzanclick) forControlEvents:UIControlEventTouchUpInside];
        [cell.commentsBtn addTarget:self action:@selector(pinglinclick) forControlEvents:UIControlEventTouchUpInside];
        [cell.shareBtn addTarget:self action:@selector(shareclick) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellKey];
        cell.sd_indexPath = indexPath;
        cell.model = self.dataArray[indexPath.row];
        cell.delegate = self;
        cell.commentView.delegate = self;
        return cell;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.headArray.count;
    }
    if (section==1) {
        return self.dataArray.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        return [tableView cellHeightForIndexPath:indexPath
                            cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                       tableView:tableView];
    }
    if (indexPath.section==1) {
        return [tableView cellHeightForIndexPath:indexPath
                            cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                       tableView:tableView];
        
    }
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

//自定义cell代理方法
-(void)didClickCellMoreComment:(UIButton *)moredButton With:(UITableViewCell *)cell{
    DemoCellModel *model = self.dataArray[cell.sd_indexPath.row];
    model.isMore = !model.isMore;
    [self.contentTableview reloadData];
}

-(void)myTabVClick:(NSDictionary *)dic
{
    NSLog(@"duc==------%@",dic);
}

#pragma mark - 实现方法

-(void)rightAction
{
    NSLog(@"right");
}

-(void)dianzanclick
{
    NSLog(@"点赞");
}

-(void)pinglinclick
{
    NSLog(@"评论");
}

-(void)shareclick
{
    NSLog(@"分享");
}

-(void)alertshow
{
    NSLog(@"alertshow");
    UIAlertController *control = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"alert0" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"alert1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"alert2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"alert3" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"alert4" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [control addAction:action0];
    [control addAction:action1];
    [control addAction:action2];
    [control addAction:action3];
    [control addAction:action4];
    [self presentViewController:control animated:YES completion:nil];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
