//
//  homeViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "homeViewController.h"
#import "homeCell.h"
#import "MyHeaderView.h"
#import "loginViewController.h"
#import "homeModel.h"
#import "taolunquanViewController.h"
#import "yueduquanViewController.h"
#import "searchViewController.h"

@interface homeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    int pn;
}

@property (strong,nonatomic) UICollectionView *myCollectionV;
@property (nonatomic,strong) NSMutableArray *datasourcearr;

@end

//设置标识
static NSString *indentify = @"indentify";

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"推荐";
 
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
    NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"放大镜-拷贝"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色为clear
    [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
    self.datasourcearr = [NSMutableArray array];
    [self addTheCollectionView];
    // 3.1.下拉刷新
    [self addHeader];
    // 3.2.上拉加载更多
    [self addFooter];
    if ([tokenstr tokenstrfrom].length==0) {
        [self dengluclick];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
    
}

#pragma mark - 刷新控件

- (void)addHeader
{
    // 头部刷新控件
    self.myCollectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.myCollectionV.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.myCollectionV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
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
    NSString *urlstr = [NSString stringWithFormat:shouye,@"1",[tokenstr tokenstrfrom]];
    [self.datasourcearr removeAllObjects];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *ditarr = [responseObject objectForKey:@"info"];
            if ([ditarr isKindOfClass:[NSArray class]]) {
                for (int i = 0; i<ditarr.count; i++) {
                    NSDictionary *dicarr = [ditarr objectAtIndex:i];
                    homeModel *model = [[homeModel alloc] init];
                    model.homeidstr = [dicarr objectForKey:@"id"];
                    model.hometitlestr = [dicarr objectForKey:@"title"];
                    model.homecoverurlstr = [dicarr objectForKey:@"cover"];
                    model.is_join = [dicarr objectForKey:@"is_join"];
                    model.relation_id = [dicarr objectForKey:@"relation_id"];
                    [self.datasourcearr addObject:model];
                }
            }
        }else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionV.mj_header endRefreshing];
            [self.myCollectionV reloadData];
        });
    } failure:^(NSError *error) {
        [self.myCollectionV.mj_header endRefreshing];
    }];
}

-(void)footerRefreshEndAction
{
    pn++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *strurl = [NSString stringWithFormat:shouye,pnstr,[tokenstr tokenstrfrom]];
    [PPNetworkHelper GET:strurl parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
            NSArray *ditarr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<ditarr.count; i++) {
                NSDictionary *dicarr = [ditarr objectAtIndex:i];
                homeModel *model = [[homeModel alloc] init];
                model.hometitlestr = [dicarr objectForKey:@"title"];
                model.homecoverurlstr = [dicarr objectForKey:@"cover"];
                model.is_join = [dicarr objectForKey:@"is_join"];
                model.relation_id = [dicarr objectForKey:@"relation_id"];
                model.homeidstr = [dicarr objectForKey:@"id"];
                [self.datasourcearr addObject:model];
            }
        }else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionV.mj_footer endRefreshing];
            [self.myCollectionV reloadData];
        });
    } failure:^(NSError *error) {
        [self.myCollectionV.mj_footer endRefreshing];
    }];
    
}

#pragma mark - getters

//创建视图

-(void)addTheCollectionView{
    
    //=======================1===========================
    //创建一个块状表格布局对象
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    
    //格子的大小 (长，高)
    flowL.itemSize = CGSizeMake(90*WIDTH_SCALE, 160*HEIGHT_SCALE);
    //横向最小距离
    flowL.minimumInteritemSpacing = 1.f;
    //    flowL.minimumLineSpacing=60.f;//代表的是纵向的空间间隔
    //设置，上／左／下／右 边距 空间间隔数是多少
    flowL.sectionInset = UIEdgeInsetsMake(16*HEIGHT_SCALE, 24*WIDTH_SCALE, 24*HEIGHT_SCALE, 24*WIDTH_SCALE);
    
    //创建一个UICollectionView
    _myCollectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -8, DEVICE_WIDTH, DEVICE_HEIGHT) collectionViewLayout:flowL];
    //设置代理为当前控制器
    _myCollectionV.backgroundColor = [UIColor whiteColor];
    _myCollectionV.delegate = self;
    _myCollectionV.dataSource = self;

    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.myCollectionV addGestureRecognizer:TapGestureTecognizer];
    
    [_myCollectionV registerClass:[homeCell class] forCellWithReuseIdentifier:indentify];

    //添加视图
    [self.view addSubview:_myCollectionV];
    
}

#pragma mark --UICollectionView dataSource
//有多少个Section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section有多少个元素
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasourcearr.count;
}

//每个单元格的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化每个单元格
    homeCell *cell = (homeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentify forIndexPath:indexPath];
    [cell setdatafrommodel:self.datasourcearr[indexPath.item]];
    //给单元格上的元素赋值
    //cell.backgroundColor = [UIColor redColor];
    return cell;
    
}

//点击单元格
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    
    homeModel *hmodel = self.datasourcearr[indexPath.row];
    NSString *homeidstr = hmodel.homeidstr;
    NSString *relation_idstr = hmodel.relation_id;
    self.hidesBottomBarWhenPushed = YES;
    if ([relation_idstr isEqualToString:@"0"]) {
        taolunquanViewController *taolunquanVC = [[taolunquanViewController alloc] init];
        taolunquanVC.idstr = homeidstr;
        [self.navigationController pushViewController:taolunquanVC animated:YES];
        
    }else
    {
        yueduquanViewController *yueduvc = [[yueduquanViewController alloc] init];
        yueduvc.idstr = homeidstr;
        [self.navigationController pushViewController:yueduvc animated:YES];
    }
}

#pragma mark - UITextFieldDelegate

-(void)keyboardHide
{
    UITextField *text = [self.myCollectionV viewWithTag:100];
    [text resignFirstResponder];
}

-(void)leftAction
{
    searchViewController *searchvc = [[searchViewController alloc] init];
    [self.navigationController pushViewController:searchvc animated:YES];
}

#pragma mark - 实现方法

-(void)dengluclick
{
    loginViewController *logvc = [[loginViewController alloc] init];
    [self presentViewController:logvc animated:YES completion:^{
        
    }];
}


@end
