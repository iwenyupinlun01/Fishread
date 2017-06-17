//
//  taolunquanViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "taolunquanViewController.h"

#import "TableViewController.h"
#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJDefaultTabViewBar.h"

#import "HeaderView.h"
#import "WZBSegmentedControl.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "quanziheadView.h"

#define WZBScreenWidth [UIScreen mainScreen].bounds.size.width
#define WZBScreenHeight [UIScreen mainScreen].bounds.size.height
// san最大的
#define MAXValue(a,b) (a>b?)
// rgb
#define WZBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1.0]
@interface taolunquanViewController () <UITableViewDelegate, UITableViewDataSource>

// 左边的tableView
@property (nonatomic, strong) UITableView *leftTableView;

// 中间的tableView
@property (nonatomic, strong) UITableView *centerTableView;

// 顶部的headeView
@property (nonatomic, strong) UIView *segueView;

// 可滑动的segmentedControl
@property (nonatomic, strong) WZBSegmentedControl *sectionView;

// 底部横向滑动的scrollView，上边放着三个tableView
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIButton *fabiaoBtn;

@end

@implementation taolunquanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"讨论圈";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self getui];
    
    [self.view addSubview:self.fabiaoBtn];
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
    quanziheadView *header = [[quanziheadView alloc] initWithFrame:CGRectMake(0, -64, DEVICE_WIDTH, 195+HEIGHT_SCALE)];
    header.backgroundColor = [UIColor orangeColor];
    // 创建segmentedControl
    WZBSegmentedControl *sectionView = [WZBSegmentedControl segmentWithFrame:(CGRect){0, 195*HEIGHT_SCALE-64, WZBScreenWidth, 44} titles:@[@"动态", @"文章"] tClick:^(NSInteger index) {
        
        // 改变scrollView的contentOffset
        self.scrollView.contentOffset = CGPointMake(index * WZBScreenWidth, 0);
        
        // 刷新最大OffsetY
        //[self reloadMaxOffsetY];
        
    }];
    
    // 赋值给全局变量
    self.sectionView = sectionView;
    // 设置其他颜色
    [sectionView setNormalColor:[UIColor blackColor] selectColor:[UIColor redColor] sliderColor:[UIColor redColor] edgingColor:[UIColor clearColor] edgingWidth:0];
    // 去除圆角
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
    headerView.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
    [headerView addSubview:header];
    [headerView addSubview:sectionView];
    self.segueView = headerView;
    
    [self.view addSubview:headerView];
    
    // 创建2个tableView
    self.leftTableView = [self tableViewWithX:0];
    self.centerTableView = [self tableViewWithX:WZBScreenWidth];
    

}

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

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.backgroundColor = [UIColor colorWithWhite:0.998 alpha:1];
    if (tableView == self.leftTableView) {
        cell.textLabel.text = @"左边tableView";
    }
    if (tableView == self.centerTableView) {
        cell.textLabel.text = @"中间tableView";
    }
    
    return cell;
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
            self.title = @"讨论圈";
        } else if (contentOffsetY >= 195*HEIGHT_SCALE-20-44) {
            CGRect frame = self.segueView.frame;
            frame.origin.y = -195*HEIGHT_SCALE+20+44;
            self.segueView.frame = frame;
            self.title = @"title";
            
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
        NSLog(@"left");
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

@end
