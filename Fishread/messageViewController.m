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

@property (nonatomic,strong) NSString *commentstr;
@property (nonatomic,strong) NSString *replystr;
@property (nonatomic,strong) NSString *rewardstr;
@property (nonatomic,strong) NSString *supportstr;
@property (nonatomic,strong) NSString *systemstr;

@end

static NSString *messagetableidentfid0 = @"messagetableidentfid0";
static NSString *messagetableidentfid1 = @"messagetableidentfid1";

@implementation messageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的消息";
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色为F5F5F5
    [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor wjColorFloat:@"F5F5F5"]]];

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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self network];
}

-(void)network
{
    NSString *urlstr = [NSString stringWithFormat:dibucaidanlankejian,[tokenstr tokenstrfrom]];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSDictionary *dit = [responseObject objectForKey:@"info"];
            NSDictionary *inform = [dit objectForKey:@"inform"];
            self.commentstr = [inform objectForKey:@"comment"];
            self.replystr = [inform objectForKey:@"reply"];
            self.rewardstr = [inform objectForKey:@"reward"];
            self.supportstr = [inform objectForKey:@"support"];
            self.systemstr = [inform objectForKey:@"system"];
            
            UILabel *lab1 = [self.messagetableView viewWithTag:100];
            UILabel *lab2 = [self.messagetableView viewWithTag:101];
            UILabel *lab3 = [self.messagetableView viewWithTag:102];
            
            if ([self.commentstr isEqualToString:@"0"]) {
                [lab1 setHidden:YES];
            }else
            {
                lab1.text = self.commentstr;
                [lab1 setHidden:NO];
            }
            if ([self.replystr isEqualToString:@"0"]) {
                [lab2 setHidden:YES];
            }else
            {
                lab2.text = self.replystr;
                [lab2 setHidden:NO];
            }
            if ([self.rewardstr isEqualToString:@"0"]) {
                [lab3 setHidden:YES];
            }else
            {
                lab3.text = self.rewardstr;
                [lab3 setHidden:NO];
            }
            
            UILabel *lab4 = [self.messagetableView viewWithTag:103];
            if ([self.systemstr isEqualToString:@"0"]) {
                [lab4 setHidden:YES];
            }else
            {
                lab4.text = self.systemstr;
                [lab4 setHidden:NO];
            }
            
            [self.messagetableView reloadData];
            
        }else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
        }
    } failure:^(NSError *error) {
        
    }];
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
        if (indexPath.row==0) {
            cell.redlab.tag = 100;
        }
        if (indexPath.row==1) {
            cell.redlab.tag = 101;
        }
        if (indexPath.row==2) {
            cell.redlab.tag = 102;
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
        cell.redlab.tag = 103;
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
