//
//  TwoViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/7/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "TwoViewController.h"
#import "LLSegmentBarVC.h"
#import "FocusViewController.h"
#import "HotViewController.h"
#import "NearViewController.h"
#import "chuangjianViewController.h"
#import "searchViewController.h"

@interface TwoViewController ()
@property (nonatomic,weak) LLSegmentBarVC * segmentVC;
@end

@implementation TwoViewController
// lazy init
- (LLSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        LLSegmentBarVC *vc = [[LLSegmentBarVC alloc]init];
        // 添加到到控制器
        [self addChildViewController:vc];
        _segmentVC = vc;
    }
    return _segmentVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"放大镜-拷贝"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"矩形-34-拷贝-2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    
    // 1 设置segmentBar的frame
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, 320, 35);
    self.navigationItem.titleView = self.segmentVC.segmentBar;
    
    // 2 添加控制器的View
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    
    NSArray *items = @[@"我的", @"全部", @"神贴"];
    FocusViewController *vc1 = [FocusViewController new];
    HotViewController *vc2 = [HotViewController new];
    NearViewController *vc3 = [NearViewController new];
    
    // 3 添加标题数组和控住器数组
    [self.segmentVC setUpWithItems:items childVCs:@[vc1,vc2,vc3]];
    
    
    // 4  配置基本设置  可采用链式编程模式进行设置
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemNormalColor([UIColor wjColorFloat:@"333333"]).itemSelectColor([UIColor wjColorFloat:@"54d48a"]).indicatorColor([UIColor wjColorFloat:@"54d48a"]);
        config.itemFont([UIFont systemFontOfSize:18]);
    }];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarMetrics:UIBarMetricsDefault];
//    
//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
//    [navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色为F5F5F5
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor wjColorFloat:@"F5F5F5"]]];

}
- (void)leftBarAction{
    NSLog(@"leftBarAction...");
    searchViewController *searchvc = [[searchViewController alloc] init];
    [self.navigationController pushViewController:searchvc animated:YES];
}

- (void)rightBarAction{
    NSLog(@"rightBarAction...");
    chuangjianViewController *chuangjianVC = [[chuangjianViewController alloc] init];
    [self.navigationController pushViewController:chuangjianVC animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void)backAction
{
    
}

@end
