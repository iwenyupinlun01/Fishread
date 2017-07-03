//
//  setViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "setViewController.h"
#import "setCell0.h"
#import "setCell1.h"
#import "SZKCleanCache.h"
#import "TopViewController.h"
#import "questionViewController.h"
#import "aboutViewController.h"

@interface setViewController ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate>
@property (nonatomic,strong) UITableView *settableView;
@end
static NSString *setidentifd0 = @"setidentfid0";
static NSString *setidentfid1 = @"setidentfid1";
@implementation setViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
   
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色为F5F5F5
    [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor wjColorFloat:@"F5F5F5"]]];

    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.settableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.settableView];
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

//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self.navigationController.navigationBar setHidden:YES];
//    [self.tabBarController.tabBar setHidden:NO];
//}

#pragma mark - getters


-(UITableView *)settableView
{
    if(!_settableView)
    {
        _settableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _settableView.dataSource = self;
        _settableView.delegate = self;
    }
    return _settableView;
}


#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }
    else
    {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        setCell0 *cell = [tableView dequeueReusableCellWithIdentifier:setidentifd0];
        cell = [[setCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setidentifd0];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.textLabel.text = @"清理缓存";
            cell.textLabel.textColor = [UIColor wjColorFloat:@"333333"];
            NSString *str = [NSString stringWithFormat:@"%.2fM",[SZKCleanCache folderSizeAtPath]];
            cell.rightlab.text = str;
            
        }
        if (indexPath.row==1) {
            cell.textLabel.text = @"去评分";
        }
        if (indexPath.row==2) {
            cell.textLabel.text = @"常见问题";
        }
        if (indexPath.row==3) {
            cell.textLabel.text = @"关于文鱼";
        }
        return cell;
    }else
    {
        setCell1 *cell = [tableView dequeueReusableCellWithIdentifier:setidentfid1];
        cell = [[setCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60*HEIGHT_SCALE;
    }else
    {
        return 160*HEIGHT_SCALE;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            //输出缓存大小 m
            NSLog(@"%.2fM",[SZKCleanCache folderSizeAtPath]);
            
            //清楚缓存
            [SZKCleanCache cleanCache:^{
                NSLog(@"清除成功");
                [self.settableView reloadData];
            }];

        }
        if (indexPath.row==1) {
            NSLog(@"去评分");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1242766779"] options:@{} completionHandler:nil];
        }
        if (indexPath.row==2) {
            NSLog(@"常见问题");
            questionViewController *questionvc = [[questionViewController alloc] init];
            [self.navigationController pushViewController:questionvc animated:YES];
        }
        if (indexPath.row==3) {
            NSLog(@"关于文鱼");
            aboutViewController *aboutvc = [[aboutViewController alloc] init];
            [self.navigationController pushViewController:aboutvc animated:YES];
        }
    }
}

-(void)myTabVClick:(UITableViewCell *)cell
{
    NSLog(@"推出登录");

    
    
    UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSString *urlstr = [NSString stringWithFormat:tuichudenglu,[tokenstr tokenstrfrom]];
        
        [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
            if ([[responseObject objectForKey:@"code"] intValue]==1)
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:@"tokenuser"];
                [defaults removeObjectForKey:@"access_token"];
                [defaults removeObjectForKey:@"namestr"];
                [defaults removeObjectForKey:@"pathurlstr"];
                [defaults removeObjectForKey:@"useruid"];
                [MBProgressHUD showSuccess:@"退出成功"];
                self.view.window.rootViewController = [[TopViewController alloc] init];
            }else if ([[responseObject objectForKey:@"code"] intValue]==0)
            {
                [MBProgressHUD showSuccess:@"token错误"];
            }else
            {
                [MBProgressHUD showSuccess:@"系统繁忙，请稍后再试"];
            }
            
        } failure:^(NSError *error) {
            [MBProgressHUD showSuccess:@"系统繁忙，请稍后再试"];
        }];
    }];
    [control addAction:action0];
    [control addAction:action1];
    [self presentViewController:control animated:YES completion:nil];
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
