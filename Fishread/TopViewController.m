//
//  TopViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "TopViewController.h"
#import "homeViewController.h"
#import "bookViewController.h"
#import "infoViewController.h"
@interface TopViewController ()

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeVC];
}

-(void)makeVC
    {

        
        homeViewController *frist = [[homeViewController alloc]init];
        [self setupChildViewController:frist title:@"首页" imageName:@"" selectedImageName:@""];
        
        bookViewController *second = [[bookViewController alloc]init];
        [self setupChildViewController:second title:@"书圈" imageName:@"" selectedImageName:@""];
        
        infoViewController *thrid = [[infoViewController alloc]init];
        [self setupChildViewController:thrid title:@"个人中心" imageName:@"" selectedImageName:@""];
        
    }
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
    {
        // 1.设置控制器的属性
        childVc.title = title;
        // 设置图标
        childVc.tabBarItem.image = [UIImage imageNamed:imageName];
        
        // 设置选中的图标
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
        //    nav.navigationBarHidden = YES;
        nav.navigationBar.barStyle = UIBarStyleDefault;
        
        childVc.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.299 green:0.988 blue:0.970 alpha:1.000];
        UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
        bgView.backgroundColor = [UIColor whiteColor];
        
        [self.tabBar insertSubview:bgView atIndex:0];
        self.tabBar.opaque = YES;
        
        [self addChildViewController:nav];
    }
    

@end
