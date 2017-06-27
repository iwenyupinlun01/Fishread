//
//  yueduquanViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "yueduquanViewController.h"

#import <SDAutoLayout.h>


#import "WZBSegmentedControl.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "taolunheadView.h"

#import "taolunquanModel.h"
#import "taolunCell0.h"
#import "DemoCommentModel.h"

#import "democontentViewController.h"

#import "chengyuanViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "chakanquanziViewController.h"
#define WZBScreenWidth [UIScreen mainScreen].bounds.size.width
#define WZBScreenHeight [UIScreen mainScreen].bounds.size.height
// san最大的
#define MAXValue(a,b) (a>b?)
// rgb
#define WZBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1.0]
@interface yueduquanViewController () <UITableViewDelegate, UITableViewDataSource,mycellVdelegate>
{
    int pn;
    int pn2;
}
// 左边的tableView
@property (nonatomic, strong) UITableView *leftTableView;

// 中间的tableView
@property (nonatomic, strong) UITableView *centerTableView;

// 顶部的headeView
@property (nonatomic, strong) UIView *segueView;
// 顶部的headeView

@property (nonatomic, strong) WZBSegmentedControl *sectionView;

// 底部横向滑动的scrollView，上边放着三个tableView
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic,strong) taolunheadView *headview;
@property (nonatomic,strong) NSString *headheistr;
@property (nonatomic,strong) NSDictionary *headdit;
@property (nonatomic,strong) UIView *jiaheaderView;
@property (nonatomic,strong) NSString *is_creator;
@property (nonatomic,strong) NSMutableArray *leftArray;
@property (nonatomic,strong) NSMutableArray *rightArray;
@property (nonatomic,strong) UIButton *jiaruBtn;
@property (nonatomic,strong) NSString *isleft;
@end

@implementation yueduquanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"椭圆-14"] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    
    [self getui];

    self.isleft = @"1";
    [self addHeaderleft];
    [self addFooterleft];
    [self addHeaderright];
    [self addFooterfight];
    [self.view addSubview:self.jiaruBtn];
    self.leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.centerTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navBarBgAlpha = @"0.0";
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
}

-(NSMutableArray *)leftArray
{
    if(!_leftArray)
    {
        _leftArray = [NSMutableArray array];
        
    }
    return _leftArray;
}

-(NSMutableArray *)rightArray
{
    if(!_rightArray)
    {
        _rightArray = [NSMutableArray array];
        
    }
    return _rightArray;
}

-(void)network
{
    self.headheistr = @"370";
    CGFloat hei = [self.headheistr floatValue];
    self.headview.frame = CGRectMake(0, -64, DEVICE_WIDTH, hei*HEIGHT_SCALE);
    self.jiaheaderView.frame = CGRectMake(0, -64, DEVICE_WIDTH, hei*HEIGHT_SCALE+44);
    self.sectionView.frame = CGRectMake(0, hei*HEIGHT_SCALE-64, DEVICE_WIDTH, 44);
    self.jiaheaderView = [[UIView alloc] initWithFrame:CGRectMake(0, -64, DEVICE_WIDTH, hei*HEIGHT_SCALE+44)];
    self.jiaheaderView.backgroundColor = [UIColor whiteColor];
    self.centerTableView.tableHeaderView = self.jiaheaderView;
    self.leftTableView.tableHeaderView = self.jiaheaderView;
}

- (void)addHeaderleft
{
    // 头部刷新控件
    self.leftTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshActionleft)];
    [self.leftTableView.mj_header beginRefreshing];
}

- (void)addFooterleft
{
    self.leftTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMoreleft)];
}

- (void)addHeaderright
{
    // 头部刷新控件
    self.centerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshActionright)];
    [self.centerTableView.mj_header beginRefreshing];
}

- (void)addFooterfight
{
    self.centerTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMoreright)];
}

- (void)refreshActionleft {
    [self headerRefreshEndActionleft];
}

- (void)refreshLoadMoreleft {
    
    [self footerRefreshEndActionleft];
}

- (void)refreshActionright {
    [self headerRefreshEndActionright];
}

- (void)refreshLoadMoreright {
    
    [self footerRefreshEndActionright];
    
}

-(void)headerRefreshEndActionleft{

    pn = 1;
    [self.leftArray removeAllObjects];
    NSString *urlstr = [NSString stringWithFormat:shuquanxiangqing,self.idstr,@"1",[tokenstr tokenstrfrom],@"1"];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSDictionary *infodic = [responseObject objectForKey:@"info"];
            NSString *is_creator = [infodic objectForKey:@"is_creator"];
            self.is_creator = is_creator;
            if ([is_creator isEqualToString:@"2"]) {
                [self.jiaruBtn setHidden:NO];
            }else
            {
                [self.jiaruBtn setHidden:YES];
            }
            NSString *newSectionNum = [infodic objectForKey:@"newSectionNum"];
            NSString *newSectionTitle = [infodic objectForKey:@"newSectionTitle"];
            NSString *pubContent = [infodic objectForKey:@"pubContent"];
            NSString *pubNickname = [infodic objectForKey:@"pubNickname"];
            NSString *pubPath = [infodic objectForKey:@"pubPath"];
            NSString *pubTitle = [infodic objectForKey:@"pubTitle"];
            NSString *read_section = [infodic objectForKey:@"read_section"];
            NSString *relation_id = [infodic objectForKey:@"relation_id"];
            NSString *typeTitle = [infodic objectForKey:@"typeTitle"];
            NSString *background = [infodic objectForKey:@"background"];
            NSString *collecCount = [infodic objectForKey:@"collecCount"];
            
            self.headdit = [NSDictionary dictionary];
            
            self.headdit = @{@"is_creator":is_creator,@"newSectionNum":newSectionNum,@"newSectionTitle":newSectionTitle,@"pubContent":pubContent,@"pubNickname":pubNickname,@"pubPath":pubPath,@"pubTitle":pubTitle,@"read_section":read_section,@"relation_id":relation_id,@"typeTitle":typeTitle,@"background":background,@"collecCount":collecCount};
            
            [self.headview setdata:self.headdit];
            
            NSArray *infoarr = [infodic objectForKey:@"info"];
            for (int i = 0; i<infoarr.count; i++) {
                NSDictionary *dit = [infoarr objectAtIndex:i];
                taolunquanModel *model = [[taolunquanModel alloc] init];
                NSDictionary *member = [dit objectForKey:@"Member"];
                model.namestr = [member objectForKey:@"nickname"];
                model.contentstr = [dit objectForKey:@"content"];
                model.pathurlstr = [dit objectForKey:@"icon_path"];
                model.timestr = [dit objectForKey:@"create_time"];
                model.idstr = [dit objectForKey:@"id"];
                model.uidstr = [dit objectForKey:@"uid"];
                model.is_supportstr = [dit objectForKey:@"is_support"];
                model.support_numstr = [dit objectForKey:@"support_num"];
                model.reply_numstr = [dit objectForKey:@"reply_num"];
                model.ForumBookmarkArray = [NSMutableArray array];
                NSArray *forarr = [dit objectForKey:@"ForumBookmark"];
                
                for (int k = 0; k<forarr.count; k++) {
                    NSDictionary *dit = [forarr objectAtIndex:k];
                    NSString *nicknamestr = [dit objectForKey:@"nickname"];
                    [model.ForumBookmarkArray addObject:nicknamestr];
                }
                
                model.picNamesArray = [dit objectForKey:@"all_image"];
                model.commentArray = [NSMutableArray array];
                NSArray *comarr =[dit objectForKey:@"pComment"];
                
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
                
                NSLog(@"arr-----%@",model.commentArray);
                [self.leftArray addObject:model];
                
            }
            
            [self.leftTableView reloadData];
        }
        else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
        }
        [self.leftTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.leftTableView.mj_header endRefreshing];
    }];
    

}

-(void)footerRefreshEndActionleft
{
    pn++;
    NSString* pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *urlstr = [NSString stringWithFormat:taolunquanxiangqing,self.idstr,pnstr,[tokenstr tokenstrfrom],@"1"];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSDictionary *infodic = [responseObject objectForKey:@"info"];
            NSArray *infoarr = [infodic objectForKey:@"info"];
            for (int i = 0; i<infoarr.count; i++) {
                NSDictionary *dit = [infoarr objectAtIndex:i];
                taolunquanModel *model = [[taolunquanModel alloc] init];
                NSDictionary *member = [dit objectForKey:@"Member"];
                model.namestr = [member objectForKey:@"nickname"];
                model.contentstr = [dit objectForKey:@"content"];
                model.pathurlstr = [dit objectForKey:@"icon_path"];
                model.timestr = [dit objectForKey:@"create_time"];
                model.idstr = [dit objectForKey:@"id"];
                model.uidstr = [dit objectForKey:@"uid"];
                model.is_supportstr = [dit objectForKey:@"is_support"];
                model.support_numstr = [dit objectForKey:@"support_num"];
                model.reply_numstr = [dit objectForKey:@"reply_num"];
                model.picNamesArray = [dit objectForKey:@"all_image"];
                model.commentArray = [NSMutableArray array];
                NSArray *comarr =[dit objectForKey:@"pComment"];
                
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
                
                NSLog(@"arr-----%@",model.commentArray);
                [self.leftArray addObject:model];
                
            }
            [self.leftTableView reloadData];
        }
        else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
        }
        [self.leftTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.leftTableView.mj_footer endRefreshing];
    }];

}

-(void)headerRefreshEndActionright
{
    pn2 = 1;
    [self.rightArray removeAllObjects];
    NSString *urlstr = [NSString stringWithFormat:shuquanxiangqing,self.idstr,@"1",[tokenstr tokenstrfrom],@"2"];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
            NSDictionary *infodic = [responseObject objectForKey:@"info"];
            
        
            NSArray *infoarr = [infodic objectForKey:@"info"];
            for (int i = 0; i<infoarr.count; i++) {
                NSDictionary *dit = [infoarr objectAtIndex:i];
                taolunquanModel *model = [[taolunquanModel alloc] init];
                NSDictionary *member = [dit objectForKey:@"Member"];
                model.namestr = [member objectForKey:@"nickname"];
                model.contentstr = [dit objectForKey:@"content"];
                model.pathurlstr = [dit objectForKey:@"icon_path"];
                model.timestr = [dit objectForKey:@"create_time"];
                model.idstr = [dit objectForKey:@"id"];
                model.uidstr = [dit objectForKey:@"uid"];
                model.is_supportstr = [dit objectForKey:@"is_support"];
                model.support_numstr = [dit objectForKey:@"support_num"];
                model.reply_numstr = [dit objectForKey:@"reply_num"];
                model.ForumBookmarkArray = [NSMutableArray array];
                NSArray *forarr = [dit objectForKey:@"ForumBookmark"];
                
                for (int k = 0; k<forarr.count; k++) {
                    NSDictionary *dit = [forarr objectAtIndex:k];
                    NSString *nicknamestr = [dit objectForKey:@"nickname"];
                    [model.ForumBookmarkArray addObject:nicknamestr];
                }
                
                model.picNamesArray = [dit objectForKey:@"all_image"];
                model.commentArray = [NSMutableArray array];
                NSArray *comarr =[dit objectForKey:@"pComment"];
                
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
                
                NSLog(@"arr-----%@",model.commentArray);
                [self.rightArray addObject:model];
                
            }
            
            [self.centerTableView reloadData];
        }
        else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
        }
        [self.centerTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.centerTableView.mj_header endRefreshing];
    }];

}

-(void)footerRefreshEndActionright
{
    pn2++;
    NSString* pnstr = [NSString stringWithFormat:@"%d",pn2];
    NSString *urlstr = [NSString stringWithFormat:taolunquanxiangqing,self.idstr,pnstr,[tokenstr tokenstrfrom],@"2"];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSDictionary *infodic = [responseObject objectForKey:@"info"];
            NSArray *infoarr = [infodic objectForKey:@"info"];
            for (int i = 0; i<infoarr.count; i++) {
                NSDictionary *dit = [infoarr objectAtIndex:i];
                taolunquanModel *model = [[taolunquanModel alloc] init];
                NSDictionary *member = [dit objectForKey:@"Member"];
                model.namestr = [member objectForKey:@"nickname"];
                model.contentstr = [dit objectForKey:@"content"];
                model.pathurlstr = [dit objectForKey:@"icon_path"];
                model.timestr = [dit objectForKey:@"create_time"];
                model.idstr = [dit objectForKey:@"id"];
                model.uidstr = [dit objectForKey:@"uid"];
                model.is_supportstr = [dit objectForKey:@"is_support"];
                model.support_numstr = [dit objectForKey:@"support_num"];
                model.reply_numstr = [dit objectForKey:@"reply_num"];
                model.picNamesArray = [dit objectForKey:@"all_image"];
                model.commentArray = [NSMutableArray array];
                NSArray *comarr =[dit objectForKey:@"pComment"];
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
                NSLog(@"arr-----%@",model.commentArray);
                [self.rightArray addObject:model];
            }
            [self.centerTableView reloadData];
        }
        else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
        }
        [self.centerTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.centerTableView.mj_footer endRefreshing];
    }];

}
-(void)getui
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 底部横向滑动的scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-40)];
    
    [self.view addSubview:scrollView];
    
    scrollView.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
    // 绑定代理
    scrollView.delegate = self;
    // 设置滑动区域
    scrollView.contentSize = CGSizeMake(2 * WZBScreenWidth, 0);
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    self.headview = [[taolunheadView alloc] initWithFrame:CGRectMake(0, -64, DEVICE_WIDTH, 370*HEIGHT_SCALE)];
    
    self.headview.backgroundColor = [UIColor whiteColor];
    
    // 创建segmentedControl
    WZBSegmentedControl *sectionView = [WZBSegmentedControl segmentWithFrame:(CGRect){0, 370*HEIGHT_SCALE-64, WZBScreenWidth, 44} titles:@[@"全部", @"神呐"] tClick:^(NSInteger index) {
        
        // 改变scrollView的contentOffset
        self.scrollView.contentOffset = CGPointMake(index * WZBScreenWidth, 0);
        
        // 刷新最大OffsetY
        //[self reloadMaxOffsetY];
        
    }];
    
    // 赋值给全局变量
    self.sectionView = sectionView;
    
    // 设置其他颜色
    [sectionView setNormalColor:[UIColor blackColor] selectColor:[UIColor wjColorFloat:@"54d48a"] sliderColor:[UIColor wjColorFloat:@"54d48a"] edgingColor:[UIColor whiteColor] edgingWidth:0];
    // 去除圆角
    sectionView.backgroundColor = [UIColor whiteColor];
    sectionView.layer.cornerRadius = sectionView.backgroundView.layer.cornerRadius = .0f;
    
    // 加两条线
    for (NSInteger i = 0; i < 2; i++) {
        UIView *line = [UIView new];
        line.backgroundColor = WZBColor(228, 227, 230);
        line.frame = CGRectMake(0, 43.5 * i, WZBScreenWidth, 0.5);
        [sectionView addSubview:line];
    }
    
    // 调下frame
    CGRect frame = sectionView.backgroundView.frame;
    frame.origin.y = frame.size.height - 1.5;
    frame.size.height = 1;
    sectionView.backgroundView.frame = frame;
    
    // headerView
    UIView *headerView = [[UIView alloc] initWithFrame:(CGRect){0, 0, WZBScreenWidth, CGRectGetMaxY(sectionView.frame)}];
    [headerView addSubview:self.headview];
    [headerView addSubview:sectionView];
    self.segueView = headerView;
    [self.view addSubview:headerView];
    // 创建2个tableView
    self.leftTableView = [self tableViewWithX:0];
    self.centerTableView = [self tableViewWithX:WZBScreenWidth];
    
}

-(UIButton *)jiaruBtn
{
    if(!_jiaruBtn)
    {
        _jiaruBtn = [[UIButton alloc] init];
        _jiaruBtn.frame = CGRectMake(0, DEVICE_HEIGHT-64-40, DEVICE_WIDTH, 40);
        [_jiaruBtn setTitle:@"加入圈子" forState:normal];
        _jiaruBtn.userInteractionEnabled = YES;
        _jiaruBtn.backgroundColor = [UIColor wjColorFloat:@"54d48a"];
        [_jiaruBtn addTarget:self action:@selector(jiaruquanziclick) forControlEvents:UIControlEventTouchUpInside];
        [_jiaruBtn setHidden:YES];
    }
    return _jiaruBtn;
}

// 创建tableView
- (UITableView *)tableViewWithX:(CGFloat)x {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, -64, WZBScreenWidth, WZBScreenHeight - 40)];
    
    [self.scrollView addSubview:tableView];
    tableView.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
    tableView.showsVerticalScrollIndicator = NO;
    
    // 代理&&数据源
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // 创建一个假的headerView，高度等于headerView的高度
    UIView *headerView = [[UIView alloc] initWithFrame:(CGRect){0, -64, WZBScreenWidth, 370*HEIGHT_SCALE+44}];
    tableView.tableHeaderView = headerView;
    return tableView;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftTableView) {
        taolunquanModel *model = self.leftArray[indexPath.row];
        NSString *idstr = model.idstr;
        democontentViewController *shuquanvc = [[democontentViewController alloc] init];
        shuquanvc.idstr = idstr;
        shuquanvc.object_idstr = self.idstr;
        [self.navigationController pushViewController:shuquanvc animated:YES];
    }
    if (tableView==self.centerTableView) {
        taolunquanModel *model = self.rightArray[indexPath.row];
        NSString *idstr = model.idstr;
        democontentViewController *shuquanvc = [[democontentViewController alloc] init];
        shuquanvc.idstr = idstr;
        shuquanvc.object_idstr = self.idstr;
        [self.navigationController pushViewController:shuquanvc animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.leftTableView) {
        return self.leftArray.count;
    }
    if (tableView==self.centerTableView) {
        return self.rightArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        
        taolunCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID111"];
        cell = [[taolunCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID111"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
        cell.delegate = self;
        [cell setdata:self.leftArray[indexPath.row]];
        return cell;
    }
    if (tableView==self.centerTableView) {
        taolunCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID222"];
        cell = [[taolunCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID222"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
        cell.delegate = self;
        [cell setdata:self.rightArray[indexPath.row]];
        return cell;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat hei = 370;
    
    // 如果当前滑动的是tableView
    if ([scrollView isKindOfClass:[UITableView class]]) {
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        // 如果滑动没有超过150
        
        if (contentOffsetY < hei*HEIGHT_SCALE-20-44) {
            // 让这2个tableView的偏移量相等
            self.leftTableView.contentOffset = self.centerTableView.contentOffset = scrollView.contentOffset;

            // 改变headerView的y值
            CGRect frame = self.segueView.frame;
            CGFloat y = -self.centerTableView.contentOffset.y;
            frame.origin.y = y;
            self.segueView.frame = frame;
            self.navBarBgAlpha = @"0.0";

            
     
        } else if (contentOffsetY >= hei*HEIGHT_SCALE-20-44) {
            CGRect frame = self.segueView.frame;
            frame.origin.y = -hei*HEIGHT_SCALE+20+44;
            
            self.segueView.frame = frame;
             self.navBarBgAlpha = @"1";

            
        }
    }
    
    if (scrollView == self.scrollView) {
        // 改变segmentdControl
        [self.sectionView setContentOffset:(CGPoint){scrollView.contentOffset.x / 2, 0}];
        return;
    }
}

// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        CGFloat contentOffsetx = scrollView.contentOffset.x;
        if (contentOffsetx>=DEVICE_WIDTH) {
            self.isleft = @"1";
        }
        else
        {
            self.isleft = @"2";
        }
    }
    
}

-(void)backAction
{
    //    [self.navigationController popViewControllerAnimated:YES];
    //    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSString *urlstr = [NSString stringWithFormat:fanhuiquanziquanye,[tokenstr tokenstrfrom],self.idstr];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)rightAction
{
    if ([self.is_creator isEqualToString:@"0"]) {
        [self right02];
    }
    if ([self.is_creator isEqualToString:@"1"]) {
        [self right01];
    }
    if ([self.is_creator isEqualToString:@"2"])
    {
        [MBProgressHUD showSuccess:@"没有加入书圈"];
    }
}

-(void)right01
{
    UIAlertController *control = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"编辑书圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"成员管理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        chengyuanViewController *chengyuanVC = [[chengyuanViewController alloc] init];
        chengyuanVC.idstr = self.idstr;
        [self.navigationController pushViewController:chengyuanVC animated:YES];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [control addAction:action0];
    [control addAction:action1];
    [control addAction:action2];
    [control addAction:action3];
    
    [self presentViewController:control animated:YES completion:nil];
    
}

-(void)right02
{
    UIAlertController *control = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shareclick];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIAlertController *control = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"广告等垃圾信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"色情淫秽内容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"恶意营销" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"人身攻击" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [control addAction:action0];
        [control addAction:action1];
        [control addAction:action2];
        [control addAction:action3];
        [control addAction:action4];
        [self presentViewController:control animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"查看圈子资料" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        chakanquanziViewController *chakanvc = [[chakanquanziViewController alloc] init];
        chakanvc.idstr = self.idstr;
        [self.navigationController pushViewController:chakanvc animated:YES];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"退出书圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [control addAction:action0];
    [control addAction:action1];
    [control addAction:action2];
    [control addAction:action3];
    [control addAction:action4];
    [self presentViewController:control animated:YES completion:nil];
}

-(void)jiaruquanziclick
{
    NSString *urlstr = [NSString stringWithFormat:shoucang,[tokenstr tokenstrfrom],self.idstr,@"1",@"1"];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        NSString *hud = [responseObject objectForKey:@"msg"];
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
            [MBProgressHUD showSuccess:hud];
            [self headerRefreshEndActionleft];
        }else
        {
            [MBProgressHUD showSuccess:hud];
        }
    } failure:^(NSError *error) {
        
    }];
    NSLog(@"加入");
}

#pragma mark - 协议绑定

-(void)morebtnClick:(UITableViewCell *)cell
{
    if ([self.isleft isEqualToString:@"1"]) {
        NSIndexPath *index = [self.leftTableView indexPathForCell:cell];
        taolunquanModel *model = self.leftArray[index.row];
        model.isOpening = ! model.isOpening;
        [self.leftTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    }else
    {
        NSIndexPath *index = [self.centerTableView indexPathForCell:cell];
        taolunquanModel *model = self.rightArray[index.row];
        model.isOpening = ! model.isOpening;
        [self.centerTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    // [self.leftTableView reloadData];
}

-(void)rightbtnClick:(UITableViewCell *)cell
{
    // NSIndexPath *index = [self.leftTableView indexPathForCell:cell];
    NSLog(@"right");
    
}

-(void)nextbtnClick:(UITableViewCell *)cell
{
    if ([self.isleft isEqualToString:@"1"]) {
        NSIndexPath *index = [self.leftTableView indexPathForCell:cell];
        taolunquanModel *model = self.leftArray[index.row];
        NSString *idstr = model.idstr;
        democontentViewController *shuquanvc = [[democontentViewController alloc] init];
        shuquanvc.idstr = idstr;
        [self.navigationController pushViewController:shuquanvc animated:YES];
    }else
    {
        NSIndexPath *index = [self.centerTableView indexPathForCell:cell];
        taolunquanModel *model = self.rightArray[index.row];
        NSString *idstr = model.idstr;
        democontentViewController *shuquanvc = [[democontentViewController alloc] init];
        shuquanvc.idstr = idstr;
        [self.navigationController pushViewController:shuquanvc animated:YES];
    }
}

#pragma mark -  分享

-(void)shareclick
{
    NSLog(@"分享");
    //1、创建分享参数
    NSString *urlstr = @"http://www.np.iwenyu.cn/Public/images/share.jpg";
    NSArray* imageArray = @[[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstr]]]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"" images:imageArray url:[NSURL URLWithString:@""] title:@"" type:SSDKContentTypeImage];
        
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertController *control = [UIAlertController alertControllerWithTitle:@"分享成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                               UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                   
                               }];
                               [control addAction:action];
                               [self presentViewController:control animated:YES completion:nil];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertController *control = [UIAlertController alertControllerWithTitle:@"您还没有安装微信" message:nil preferredStyle:UIAlertControllerStyleAlert];
                               UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                   
                               }];
                               [control addAction:action];
                               [self presentViewController:control animated:YES completion:nil];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}

@end
