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
#import "feedbackViewController.h"
@interface infoViewController ()<UITableViewDataSource,UITableViewDelegate,myheadviewdelegate>
@property (nonatomic,strong) UITableView *infotableView;

@property (nonatomic, strong) NSArray *carGroups;

@property (nonatomic,strong) UILabel *redlab;
@end

static NSString *infocellidentfid0 = @"infocellidentfid0";

@implementation infoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    [self.view addSubview:self.infotableView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self network];
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

#pragma mark - network

-(void)network
{
    NSString *urlstr = [NSString stringWithFormat:wodeshouye,[tokenstr tokenstrfrom]];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        NSString *hudstr = [responseObject objectForKey:@"msg"];
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            if ([[responseObject objectForKey:@"info"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *infodit = [responseObject objectForKey:@"info"];
                NSString *namestr = [infodit objectForKey:@"nickname"];
                NSString *pathstr = [infodit objectForKey:@"icon"];
                NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
                [userdefat setObject:namestr forKey:@"namestr"];
                [userdefat setObject:pathstr forKey:@"pathurlstr"];
                [userdefat synchronize];
                [self.infotableView reloadData];
            }
        }
        else
        {
            [MBProgressHUD showSuccess:hudstr];
        }
    } failure:^(NSError *error) {
        
    }];
    
    NSString *urlstr2 = [NSString stringWithFormat:dibucaidanlankejian,[tokenstr tokenstrfrom]];
    [PPNetworkHelper GET:urlstr2 parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSDictionary *dit = [responseObject objectForKey:@"info"];
            NSString *circle = [dit objectForKey:@"circle"];
            if ([circle isEqualToString:@"1"]) {
                [self.redlab setHidden:NO];
                NSString *num = [dit objectForKey:@"informNum"];
                self.redlab.text = num;
            }else
            {
                [self.redlab setHidden:YES];
            }
            [self.infotableView reloadData];
        }else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
        }
    } failure:^(NSError *error) {
        
    }];
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

-(UILabel *)redlab
{
    if(!_redlab)
    {
        _redlab = [[UILabel alloc] init];
        _redlab.textAlignment = NSTextAlignmentCenter;
        _redlab.backgroundColor = [UIColor redColor];
        _redlab.textColor = [UIColor whiteColor];
        _redlab.layer.masksToBounds = YES;
        _redlab.layer.cornerRadius = 10;
        //_redlab.text = @"12";
        [_redlab setHidden:YES];
    }
    return _redlab;
}


-(NSArray *)carGroups
{
    if(!_carGroups)
    {
        _carGroups = [[NSArray alloc] init];
        infoGroup *cg1 = [[infoGroup alloc] init];
        cg1.textarr = @[@"消息通知",@"我的发表",@"我的收藏"];
        cg1.imgarr = @[@"矩形-39",@"矩形-41",@"收藏"];
//        infoGroup *cg2 = [[infoGroup alloc] init];
//        cg2.textarr = @[@"钱包"];
//        cg2.imgarr = @[@"钱包"];
        infoGroup *cg3 = [[infoGroup alloc] init];
        cg3.textarr = @[@"设置",@"帮助与反馈"];
        cg3.imgarr = @[@"设置",@"帮助与反馈"];
         _carGroups = @[cg1, cg3];
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
        view.namelab.text = [tokenstr nicknamestrfrom];
        [view.infoimg sd_setImageWithURL:[NSURL URLWithString:[tokenstr userimgstrfrom]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
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
    if (indexPath.section==0&&indexPath.row==0) {
        self.redlab.frame = CGRectMake(DEVICE_WIDTH-60, 20, 20, 20);
        [cell addSubview:self.redlab];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

        if (indexPath.section==0) {
            if (indexPath.row==0) {
                if ([tokenstr tokenstrfrom].length==0) {
                    [MBProgressHUD showSuccess:@"请先登录"];
                }
                else
                {
                    messageViewController *messagevc = [[messageViewController alloc] init];
                    [self.navigationController pushViewController:messagevc animated:YES];
                }
            }
            if (indexPath.row==1) {
                if ([tokenstr tokenstrfrom].length==0) {
                    [MBProgressHUD showSuccess:@"请先登录"];
                }
                else
                {
                    publishedViewController *publishvc = [[publishedViewController alloc] init];
                    [self.navigationController pushViewController:publishvc animated:YES];
                }
            }
            if (indexPath.row==2) {
                if ([tokenstr tokenstrfrom].length==0) {
                    [MBProgressHUD showSuccess:@"请先登录"];
                }
                else
                {
                    collectionViewController *collectionvc = [[collectionViewController alloc] init];
                    [self.navigationController pushViewController:collectionvc animated:YES];
                }
            }
        }
        //    if (indexPath.section==1) {
        //
        //    }
        if (indexPath.section==1) {
            if (indexPath.row==0) {
                setViewController *setvc = [[setViewController alloc] init];
                [self.navigationController pushViewController:setvc animated:YES];
            }
            if (indexPath.row==1) {
                if ([tokenstr tokenstrfrom].length==0) {
                    [MBProgressHUD showSuccess:@"请先登录"];
                }
                else
                {
                    feedbackViewController *feedbackvc = [[feedbackViewController alloc] init];
                    [self.navigationController pushViewController:feedbackvc animated:YES];
                }
            }
        }

}

-(void)myTabVClick1:(UIView *)view
{
    NSLog(@"点击头像");
    if ([tokenstr tokenstrfrom].length==0) {
        [MBProgressHUD showSuccess:@"请先登录"];
    }else
    {
        myinfoViewController *myinfoVC = [[myinfoViewController alloc] init];
        [self.navigationController pushViewController:myinfoVC animated:YES];
    }
}
@end
