//
//  messageViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "messageViewController.h"
#import "TopViewController.h"
@interface messageViewController ()
@property (nonatomic,strong) UIButton *demobtn;

@end

@implementation messageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - getters

-(UIButton *)demobtn
{
    if(!_demobtn)
    {
        _demobtn = [[UIButton alloc] init];
        _demobtn.frame = CGRectMake(20, 80, 100, 40);
        [_demobtn setTitleColor:[UIColor blackColor] forState:normal];
        [_demobtn addTarget:self action:@selector(demobtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_demobtn setTitle:@"测试" forState:normal];
    }
    return _demobtn;
}

#pragma mark - 实现方法

-(void)demobtnclick
{
    self.view.window.rootViewController = [[TopViewController alloc] init];
    
}



@end
