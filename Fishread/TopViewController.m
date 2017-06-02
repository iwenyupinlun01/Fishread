//
//  TopViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "TopViewController.h"
#import "homeViewController.h"
#import "infoViewController.h"
#import "MainViewController.h"
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
    [self setupChildViewController:frist title:@"首页" imageName:@"未点击首页" selectedImageName:@"首页-拷贝"];
    MainViewController *second = [[MainViewController alloc]init];
    [self setupChildViewController:second title:@"书圈" imageName:@"2" selectedImageName:@"书圈"];
        
    infoViewController *thrid = [[infoViewController alloc]init];
    [self setupChildViewController:thrid title:@"个人中心" imageName:@"3" selectedImageName:@"4"];
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
        
        childVc.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
        UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.tabBar insertSubview:bgView atIndex:0];
        self.tabBar.opaque = YES;
        self.tabBar.tintColor = [UIColor wjColorFloat:@"54d48a"];
        [self addChildViewController:nav];
    }
    

@end
