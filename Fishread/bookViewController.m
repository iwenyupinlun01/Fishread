//
//  bookViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "bookViewController.h"



@interface bookViewController ()


@end

@implementation bookViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setHidden:YES];
}



@end
