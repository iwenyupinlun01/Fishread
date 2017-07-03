//
//  chengyuanViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/23.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chengyuanViewController.h"
#import "chengyuanCell.h"
#import "FriendModel.h"

#import "ContactDataHelper.h"
#import "NSString+Utils.h"

@interface chengyuanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *sectionTitles;
@property (nonatomic,strong) NSMutableArray *contactsSource;

@end
static NSString *chengyuanidentfid = @"chengyuanidentfid";
@implementation chengyuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"成员管理";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor wjColorFloat:@"F5F5F5"]]];
    
    self.contactsSource = [NSMutableArray array];
    self.sectionTitles = [NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    [self network];
    
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

-(void)network
{
    self.contactsSource = [NSMutableArray array];
    [PPNetworkHelper GET:[NSString stringWithFormat:chengyuanguanli,[tokenstr tokenstrfrom],self.idstr] parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *arr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<arr.count; i++) {
                FriendModel *model = [[FriendModel alloc] init];
                NSDictionary *dit = [arr objectAtIndex:i];
                model.nameStr = [dit objectForKey:@"nickname"];
                model.imageName = [dit objectForKey:@"path"];
                model.uidstr = [dit objectForKey:@"uid"];
                [self.contactsSource addObject:model];
            }
            [self sortDataArrayWithContactDataHelper];
        }
        NSLog(@"arr------%@",self.contactsSource);
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.contactsSource.count == 0) {
        return 0;
    }
    return self.sectionTitles.count - 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ((self.contactsSource.count == 0)) {
        return 0;
    }
    return [self.contactsSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    chengyuanCell * cell = [tableView dequeueReusableCellWithIdentifier:chengyuanidentfid];
    cell = [[chengyuanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chengyuanidentfid];
    FriendModel * model = self.contactsSource[indexPath.section][indexPath.row];
    [cell setdata:model];
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(14, 0, 30, 30)];
    [btn setTitle:self.sectionTitles[section + 1] forState:UIControlStateNormal];
    btn.tag = section;
    [btn setTitleColor:[UIColor wjColorFloat:@"333333"] forState:normal];
    [view addSubview:btn];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.editing == NO) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        FriendModel *model = self.contactsSource[indexPath.section][indexPath.row];
        NSString *uid = model.uidstr;
        NSLog(@"uid----%@",uid);
        
        NSDictionary *para = @{@"token":[tokenstr tokenstrfrom],@"id":self.idstr,@"user_id":uid};
        
        [PPNetworkHelper POST:quanzichengyuanshanchu parameters:para success:^(id responseObject) {
            NSString *hud = [responseObject objectForKey:@"msg"];
            if ([[responseObject objectForKey:@"code"] intValue]==1) {
                [self network];
                [MBProgressHUD showSuccess:hud];
            }else
            {
                [MBProgressHUD showSuccess:hud];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD showSuccess:@"没有网络"];
        }];
        
//        [self.contactsSource[indexPath.section] removeObjectAtIndex:indexPath.row];
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//        
//        if ([self.contactsSource[indexPath.section] count] == 0) {
//            [self.sectionTitles removeObjectAtIndex:indexPath.section + 1];
//            [self.contactsSource removeObjectAtIndex:indexPath.section];
//        }
//        [tableView reloadData];
    }
}

- (void)sortDataArrayWithContactDataHelper{
    
    NSMutableArray *contactsSource = [NSMutableArray arrayWithArray:self.contactsSource];
    [self.contactsSource removeAllObjects];
    [self.sectionTitles removeAllObjects];
    self.contactsSource = [ContactDataHelper getFriendListDataBy:contactsSource];
    self.sectionTitles = [ContactDataHelper getFriendListSectionBy:[self.contactsSource mutableCopy]];
    [self.tableView reloadData];
}

#pragma mark - getters

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
