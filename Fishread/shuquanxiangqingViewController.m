//
//  shuquanxiangqingViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "shuquanxiangqingViewController.h"

@interface shuquanxiangqingViewController ()
@property (nonatomic,strong) UITableView *xiangqingtableView;
@end

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
    self.title = @"书圈详情";
    
    [self.view addSubview:self.xiangqingtableView];
    

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

#pragma mark - getters



#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
