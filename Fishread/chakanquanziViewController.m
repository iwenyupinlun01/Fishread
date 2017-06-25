//
//  chakanquanziViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chakanquanziViewController.h"
#import "chuangjianCell.h"
#import "chakanCell.h"
#import "chuangjianCell2.h"

@interface chakanquanziViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *chakantableView;
@end


static NSString *chakanidentfid0 = @"chakanidentfid0";
static NSString *chakanidentfid1 = @"chakanidentfid1";
static NSString *chakanidentfid2 = @"chakanidentfid2";


@implementation chakanquanziViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"查看";
    [self.view addSubview:self.chakantableView];
    
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

#pragma mark - getters

-(UITableView *)chakantableView
{
    if(!_chakantableView)
    {
        _chakantableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _chakantableView.dataSource = self;
        _chakantableView.delegate = self;
        _chakantableView.separatorStyle = NO;
    }
    return _chakantableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        chuangjianCell *cell = [tableView dequeueReusableCellWithIdentifier:chakanidentfid0];
        if (!cell) {
            cell = [[chuangjianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chakanidentfid0];
            cell.chuangjianView.image = [UIImage imageNamed:@"默认-拷贝"];
        }
        cell.chuangjianText.tag = 101;
        cell.chuangjianView.tag = 202;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        chakanCell *cell = [tableView dequeueReusableCellWithIdentifier:chakanidentfid1];
        cell = [[chakanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chakanidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //[cell.irregulatBtn getArrayDataSourse:self.listArray];
        //重置frame
//        CGSize size = [cell.irregulatBtn returnSize];
//        cell.irregulatBtn.frame = CGRectMake(14*WIDTH_SCALE, 0, DEVICE_WIDTH - 28*WIDTH_SCALE, size.height);
//        NSLog(@"%f",size.height);
        
        return cell;
    }
    if (indexPath.row==2) {
        chuangjianCell2 *cell = [tableView dequeueReusableCellWithIdentifier:chakanidentfid2];
        cell = [[chuangjianCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chakanidentfid2];
        cell.textView.tag = 102;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 300;
    }
    if (indexPath.row==1) {
        return 78*HEIGHT_SCALE;
    }
    if (indexPath.row==2) {
        return 144*HEIGHT_SCALE;
    }
    return 0;
}


#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    //    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


@end
