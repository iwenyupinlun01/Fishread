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
{
    int pn;
}
@property (nonatomic,strong) UITableView *xiangqingtableView;
@property (nonatomic,strong) NSDictionary *headdic;
@property (nonatomic,strong) NSMutableArray *datasourceArray;
@property (nonatomic,strong) NSString *righttitleStr;
@property (nonatomic,strong) NSString *numstr;
@property (nonatomic,strong) NSMutableArray *allCommentArr;
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
    self.allCommentArr = [NSMutableArray array];
    [self.view addSubview:self.xiangqingtableView];
    [self addHeader];
    [self addFooter];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
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
    
    [self.datasourceArray removeAllObjects];
    [self.allCommentArr removeAllObjects];
    NSString *urlstr = [NSString stringWithFormat:dongtaixiangqing,[tokenstr tokenstrfrom],@"1",self.idstr];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
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
            [self.datasourceArray addObject:model];
            
            
            NSArray *commentarr = [infodit objectForKey:@"allComment"];
            
            self.numstr = [NSString stringWithFormat:@"%ld%@",self.allCommentArr.count,@"人评论"];
            
            for (int i = 0; i<commentarr.count; i++) {
                model = [[dongtaixiangqingModel alloc] init];
                NSDictionary *dit = [commentarr objectAtIndex:i];
                model.allCommentidstr = [dit objectForKey:@"id"];
                
            }
            
            
            
            [self.xiangqingtableView reloadData];
            [self.xiangqingtableView.mj_header endRefreshing];
            
        }
        
    } failure:^(NSError *error) {
        [self.xiangqingtableView.mj_header endRefreshing];
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


-(NSDictionary *)headdic
{
    if(!_headdic)
    {
        _headdic = [NSDictionary dictionary];
        
    }
    return _headdic;
}

-(NSMutableArray *)datasourceArray
{
    if(!_datasourceArray)
    {
        _datasourceArray = [NSMutableArray array];
        
    }
    return _datasourceArray;
}


#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.datasourceArray.count;
    }
    if (section==1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        quanzixiangqingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:shuquanxiangqingidentfid0];
        cell = [[quanzixiangqingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shuquanxiangqingidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.datasourceArray[indexPath.row]];
        return cell;
    }
    if (indexPath.section==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shuquanxiangqingidentfid1];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shuquanxiangqingidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.numstr;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor wjColorFloat:@"333333"];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        quanzixiangqingCell0 *cell = [[quanzixiangqingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shuquanxiangqingidentfid0];
        CGFloat hei = [cell setdata:self.datasourceArray[indexPath.row]];
        return hei;
    }
    if (indexPath.section==1) {
        return 42*HEIGHT_SCALE;
    }
    return 0.01f;
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction
{
    NSLog(@"right");
}
@end
