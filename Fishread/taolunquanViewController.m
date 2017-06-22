//
//  taolunquanViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "taolunquanViewController.h"

#import <SDAutoLayout.h>

#import "TableViewController.h"
#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJDefaultTabViewBar.h"

#import "HeaderView.h"
#import "WZBSegmentedControl.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "quanziheadView.h"

#import "taolunCell0.h"
#import "taolunquanModel.h"

#import "DemoCommentModel.h"

#define WZBScreenWidth [UIScreen mainScreen].bounds.size.width
#define WZBScreenHeight [UIScreen mainScreen].bounds.size.height
// san最大的
#define MAXValue(a,b) (a>b?)
// rgb
#define WZBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1.0]
@interface taolunquanViewController () <UITableViewDelegate, UITableViewDataSource,mycellVdelegate>
{
    int pn;
}
// 左边的tableView
@property (nonatomic, strong) UITableView *leftTableView;

// 右边的tableView
@property (nonatomic, strong) UITableView *centerTableView;

// 顶部的headeView
@property (nonatomic, strong) UIView *segueView;

// 可滑动的segmentedControl
@property (nonatomic, strong) WZBSegmentedControl *sectionView;

// 底部横向滑动的scrollView，上边放着两个tableView
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIButton *fabiaoBtn;
@property (nonatomic,strong) quanziheadView *headview;

@property (nonatomic,strong) NSMutableArray *leftArray;
@property (nonatomic,strong) NSMutableArray *rightArray;

@property (nonatomic,strong) UIButton *jiaruBtn;
@end

@implementation taolunquanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //self.title = @"讨论圈";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self getui];
    [self.view addSubview:self.jiaruBtn];
    [self.view addSubview:self.fabiaoBtn];
    [self addHeaderleft];
    [self addFooterleft];
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

#pragma mark - 刷新控件

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

- (void)refreshActionleft {
    [self headerRefreshEndActionleft];
}

- (void)refreshLoadMoreleft {
    
    [self footerRefreshEndActionleft];
    
}

-(void)headerRefreshEndActionleft
{
    pn = 1;
    [self.leftArray removeAllObjects];
    //NSString *urlstr = [NSString stringWithFormat:taolunquanxiangqing,@"1",self.idstr,[tokenstr tokenstrfrom],@"1"];
    
     NSString *urlstr = [NSString stringWithFormat:taolunquanxiangqing,self.idstr,@"1",[tokenstr tokenstrfrom],@"1"];
    
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
            NSDictionary *infodic = [responseObject objectForKey:@"info"];
            NSString *titlestr = [infodic objectForKey:@"pubTitle"];
            self.headview.titlelab.text = titlestr;
            NSString *pathstr = [infodic objectForKey:@"pubPath"];
            pathstr = @"http://pic30.nipic.com/20130615/12994184_133342233160_2.jpg";
            [self.headview.bgimg sd_setImageWithURL:[NSURL URLWithString:pathstr]];
            NSString *type = [infodic objectForKey:@"circleType"];
            if ([type isEqualToString:@"1"]) {
                self.headview.typelab.text = @"讨论圈";
            }else
            {
                self.headview.typelab.text = @"阅读圈";
            }
            
            NSArray *infoarr = [infodic objectForKey:@"info"];
            for (int i = 0; i<infoarr.count; i++) {
                NSDictionary *dit = [infoarr objectAtIndex:i];
                taolunquanModel *model = [[taolunquanModel alloc] init];
                NSDictionary *member = [dit objectForKey:@"Member"];
                model.namestr = [member objectForKey:@"nickname"];
                model.contentstr = [dit objectForKey:@"content"];
                model.pathurlstr = [dit objectForKey:@"icon_path"];
                model.timestr = [dit objectForKey:@"create_time"];
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
        else if ([[responseObject objectForKey:@"code"] intValue]==3503)
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
        else if ([[responseObject objectForKey:@"code"] intValue]==3503)
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
        }
        [self.leftTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.leftTableView.mj_footer endRefreshing];
    }];
}

-(void)getui
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 底部横向滑动的scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
    // 绑定代理
    scrollView.delegate = self;
    // 设置滑动区域
    scrollView.contentSize = CGSizeMake(2 * WZBScreenWidth, 0);
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    self.headview = [[quanziheadView alloc] initWithFrame:CGRectMake(0, -64, DEVICE_WIDTH, 195+HEIGHT_SCALE)];
    
    self.headview.backgroundColor = [UIColor whiteColor];
    
    // 创建segmentedControl
    WZBSegmentedControl *sectionView = [WZBSegmentedControl segmentWithFrame:(CGRect){0, 195*HEIGHT_SCALE-64, WZBScreenWidth, 44} titles:@[@"全部", @"神呐"] tClick:^(NSInteger index) {
        
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

#pragma mark - getters

// 创建tableView
- (UITableView *)tableViewWithX:(CGFloat)x {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, -64, WZBScreenWidth, WZBScreenHeight - 0)];
    
    [self.scrollView addSubview:tableView];
    tableView.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
    tableView.showsVerticalScrollIndicator = NO;
    
    // 代理&&数据源
    tableView.delegate = self;
    tableView.dataSource = self;
    
    // 创建一个假的headerView，高度等于headerView的高度
    UIView *headerView = [[UIView alloc] initWithFrame:(CGRect){0, -64, WZBScreenWidth, 195*HEIGHT_SCALE+44}];
    tableView.tableHeaderView = headerView;
    return tableView;
}

-(UIButton *)fabiaoBtn
{
    if(!_fabiaoBtn)
    {
        _fabiaoBtn = [[UIButton alloc] init];
        _fabiaoBtn.frame = CGRectMake(DEVICE_WIDTH-14*WIDTH_SCALE-50*WIDTH_SCALE, DEVICE_HEIGHT-200*HEIGHT_SCALE, 50*WIDTH_SCALE, 50*WIDTH_SCALE);
        [_fabiaoBtn setImage:[UIImage imageNamed:@"发表"] forState:normal];
        [_fabiaoBtn addTarget:self action:@selector(fabiaobtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fabiaoBtn;
}

-(UIButton *)jiaruBtn
{
    if(!_jiaruBtn)
    {
        _jiaruBtn = [[UIButton alloc] init];
        _jiaruBtn.frame = CGRectMake(0, DEVICE_HEIGHT-64-40, DEVICE_WIDTH, 40);
        [_jiaruBtn setTitle:@"加入圈子" forState:normal];
        _jiaruBtn.backgroundColor = [UIColor wjColorFloat:@"54d48a"];
        [_jiaruBtn addTarget:self action:@selector(jiaruquanziclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jiaruBtn;
}

-(NSMutableArray *)leftArray
{
    if(!_leftArray)
    {
        _leftArray = [NSMutableArray new];
    }
    return _leftArray;
}

-(NSMutableArray *)rightArray
{
    if(!_rightArray)
    {
        _rightArray = [NSMutableArray new];
    }
    return _rightArray;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.leftTableView) {
        return self.leftArray.count;
    }
    if (tableView==self.centerTableView) {
        return 3;
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
        
        taolunCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        cell = [[taolunCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
        cell.delegate = self;
        [cell setdata:self.leftArray[indexPath.row]];
        return cell;
    }
    if (tableView==self.centerTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID2"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
        return cell;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 如果当前滑动的是tableView
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        
        // 如果滑动没有超过150
        if (contentOffsetY < 195*HEIGHT_SCALE-20-44) {
            
            // 让这2个tableView的偏移量相等
            self.leftTableView.contentOffset = self.centerTableView.contentOffset = scrollView.contentOffset;
            // 改变headerView的y值
            CGRect frame = self.segueView.frame;
            CGFloat y = -self.centerTableView.contentOffset.y;
            frame.origin.y = y;
            self.segueView.frame = frame;
            //self.title = @"讨论圈";
        } else if (contentOffsetY >= 195*HEIGHT_SCALE-20-44) {
            CGRect frame = self.segueView.frame;
            frame.origin.y = -195*HEIGHT_SCALE+20+44;
            self.segueView.frame = frame;
            //self.title = @"title";
            
        }
        if (contentOffsetY<25) {
            //向下滑动
            [self.fabiaoBtn setHidden:NO];
            
        }else
        {
            [self.fabiaoBtn setHidden:YES];
            //向上滑动
        }
        
    }
    if (scrollView==self.leftTableView) {
       //NSLog(@"left");
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
        
    }
   
}

#pragma mark - 实现方法

-(void)fabiaobtnclick
{
    NSLog(@"发表");
}

-(void)backAction
{
        [self.navigationController popViewControllerAnimated:YES];
    //    [self.navigationController.navigationBar setHidden:NO];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)morebtnClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.leftTableView indexPathForCell:cell];
    taolunquanModel *model = self.leftArray[index.row];
    model.isOpening = ! model.isOpening;
    [self.leftTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
   // [self.leftTableView reloadData];
}

-(void)rightbtnClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.leftTableView indexPathForCell:cell];
    NSLog(@"right");
}

-(void)jiaruquanziclick
{
    NSLog(@"加入圈子");
}

@end
