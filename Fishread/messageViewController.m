//
//  messageViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "messageViewController.h"
#import "TopViewController.h"
#import "mymessageCell0.h"
#import "mymessageCell1.h"
#import "systemViewController.h"
#import "xiaoxitongzhiViewController.h"

@interface messageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *messagetableView;
@property (nonatomic,strong) NSArray *textarr;

@end

static NSString *messagetableidentfid0 = @"messagetableidentfid0";
static NSString *messagetableidentfid1 = @"messagetableidentfid1";

@implementation messageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的消息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.messagetableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.messagetableView];
    
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

-(UITableView *)messagetableView
{
    if(!_messagetableView)
    {
        _messagetableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _messagetableView.dataSource = self;
        _messagetableView.delegate = self;
    }
    return _messagetableView;
}


-(NSArray *)textarr
{
    if(!_textarr)
    {
        _textarr = [[NSArray alloc] init];
        _textarr = @[@"评论",@"回复",@"赞"];
    }
    return _textarr;
}


#pragma mark -UITableViewDataSource&&UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.textarr.count;
    }else
    {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        mymessageCell0 *cell = [tableView dequeueReusableCellWithIdentifier:messagetableidentfid0];
        if (!cell) {
            cell = [[mymessageCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messagetableidentfid0];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.textarr[indexPath.row];
        return cell;
    }else
    {
        mymessageCell1 *cell = [tableView dequeueReusableCellWithIdentifier:messagetableidentfid1];
        if (!cell) {
            cell = [[mymessageCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messagetableidentfid1];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"文鱼管理员";
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        xiaoxitongzhiViewController *xiaoxivc = [[xiaoxitongzhiViewController alloc] init];
        if (indexPath.row==0) {
            xiaoxivc.titlestr = @"评论";
            xiaoxivc.typestr = @"1";
        }
        if (indexPath.row==1) {
            xiaoxivc.titlestr = @"回复";
            xiaoxivc.typestr = @"2";
        }
        if (indexPath.row==2) {
            xiaoxivc.titlestr = @"赞";
            xiaoxivc.typestr = @"3";
        }
//        if (indexPath.row==3) {
//            xiaoxivc.titlestr = @"打赏";
//            xiaoxivc.typestr = @"4";
//        }
        [self.navigationController pushViewController:xiaoxivc animated:YES];
    }
    if (indexPath.section==1) {
        systemViewController *sysvc = [[systemViewController alloc] init];
        [self.navigationController pushViewController:sysvc animated:YES];
    }
}
#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
