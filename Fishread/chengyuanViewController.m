//
//  chengyuanViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chengyuanViewController.h"

@interface chengyuanViewController ()

@end

@implementation chengyuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"成员管理";
    
    [self network];
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
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)network
{
    [PPNetworkHelper GET:[NSString stringWithFormat:chengyuanguanli,[tokenstr tokenstrfrom],self.idstr] parameters:nil success:^(id responseObject) {
        NSLog(@"red-------%@",responseObject);
        
    } failure:^(NSError *error) {
        
    }];
}


@end
