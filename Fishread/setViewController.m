//
//  setViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "setViewController.h"
#import "setCell0.h"

@interface setViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *settableView;
@end
static NSString *setidentifd0 = @"setidentfid0";

@implementation setViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
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

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

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
            cell.textLabel.text = @"清理缓冲";
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
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60*HEIGHT_SCALE;
    }else
    {
        return 120*HEIGHT_SCALE;
    }
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
