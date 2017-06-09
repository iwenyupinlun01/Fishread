//
//  infoViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "infoViewController.h"
#import "infoCell.h"
#import "messageViewController.h"
#import "infoGroup.h"
#import "headView.h"
#import "myinfoViewController.h"
#import "setViewController.h"
#import "publishedViewController.h"
#import "collectionViewController.h"
@interface infoViewController ()<UITableViewDataSource,UITableViewDelegate,myheadviewdelegate>
@property (nonatomic,strong) UITableView *infotableView;

@property (nonatomic, strong) NSArray *carGroups;
@end

static NSString *infocellidentfid0 = @"infocellidentfid0";

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.infotableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setHidden:YES];
}

#pragma mark - getters

-(UITableView *)infotableView
{
    if(!_infotableView)
    {
        _infotableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
        _infotableView.dataSource = self;
        _infotableView.delegate = self;
    }
    return _infotableView;
}


-(NSArray *)carGroups
{
    if(!_carGroups)
    {
        _carGroups = [[NSArray alloc] init];
        infoGroup *cg1 = [[infoGroup alloc] init];
        cg1.textarr = @[@"消息通知",@"我的发表",@"我的收藏"];
        cg1.imgarr = @[@"矩形-39",@"矩形-41",@"收藏"];
        infoGroup *cg2 = [[infoGroup alloc] init];
        cg2.textarr = @[@"钱包"];
        cg2.imgarr = @[@"钱包"];
        infoGroup *cg3 = [[infoGroup alloc] init];
        cg3.textarr = @[@"设置",@"帮助与反馈"];
        cg3.imgarr = @[@"设置",@"帮助与反馈"];
         _carGroups = @[cg1, cg2, cg3];
    }
    return _carGroups;
}





#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return (88+284)/2*HEIGHT_SCALE;
    }
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.carGroups.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        headView *view = [[headView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 100)];
        view.backgroundColor = [UIColor wjColorFloat:@"F5F5F5"];
        view.delegate = self;
        return view;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    infoGroup *g = self.carGroups[section];
    return g.textarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    infoCell *cell = [tableView dequeueReusableCellWithIdentifier:infocellidentfid0];
    cell = [[infoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infocellidentfid0];
    infoGroup *g = self.carGroups[indexPath.section];
    NSString *name = g.textarr[indexPath.row];
    cell.textlab.text = name;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.leftimg.image = [UIImage imageNamed:g.imgarr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            messageViewController *messagevc = [[messageViewController alloc] init];
            [self.navigationController pushViewController:messagevc animated:YES];
        }
        if (indexPath.row==1) {
            publishedViewController *publishvc = [[publishedViewController alloc] init];
            [self.navigationController pushViewController:publishvc animated:YES];
        }
        if (indexPath.row==2) {
            collectionViewController *collectionvc = [[collectionViewController alloc] init];
            [self.navigationController pushViewController:collectionvc animated:YES];
        }
    }
    if (indexPath.section==1) {
      
    }
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            setViewController *setvc = [[setViewController alloc] init];
            [self.navigationController pushViewController:setvc animated:YES];
        }
        if (indexPath.row==1) {
            
        }
    }
}

-(void)myTabVClick1:(UIView *)view
{
    NSLog(@"点击头像");
    myinfoViewController *myinfoVC = [[myinfoViewController alloc] init];
    [self.navigationController pushViewController:myinfoVC animated:YES];
}
@end
