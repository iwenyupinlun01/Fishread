//
//  publishedViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "publishedViewController.h"
#import "publishCell.h"
#import "headView.h"
@interface publishedViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *publishtable;
@property (nonatomic,strong) headView *hview;

@end
static NSString *publishidentfid = @"publishidentfid";
@implementation publishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的发表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.publishtable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.publishtable];
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

-(UITableView *)publishtable
{
    if(!_publishtable)
    {
        _publishtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _publishtable.dataSource = self;
        _publishtable.delegate = self;
        _publishtable.tableHeaderView = self.hview;
    }
    return _publishtable;
}

-(headView *)hview
{
    if(!_hview)
    {
        _hview = [[headView alloc] init];
        [_hview.infoimg sd_setImageWithURL:[NSURL URLWithString:[tokenstr userimgstrfrom]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        _hview.namelab.text = [tokenstr nicknamestrfrom];
        _hview.frame = CGRectMake(0, 0, DEVICE_WIDTH, (412-64)/2*HEIGHT_SCALE);
    }
    return _hview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    publishCell *cell = [tableView dequeueReusableCellWithIdentifier:publishidentfid];
    cell = [[publishCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:publishidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"测试";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
