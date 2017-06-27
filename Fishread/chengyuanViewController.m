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


@property (nonatomic, strong) NSArray *modelList;

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic,strong) NSMutableArray *sectionTitles;
@property (nonatomic,strong) NSMutableArray *contactsSource;

@end

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
    
    self.contactsSource = [NSMutableArray array];
    
    self.sectionTitles = [NSMutableArray array];

    
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
        NSLog(@"red-------%@",responseObject);
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *arr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<arr.count; i++) {
                FriendModel *model = [[FriendModel alloc] init];
                NSDictionary *dit = [arr objectAtIndex:i];
                model.nameStr = [dit objectForKey:@"nickname"];
                [self.contactsSource addObject:model];
            }
            [self.tableView reloadData];

        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
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
    
    chengyuanCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    FriendModel * model = self.contactsSource[indexPath.section][indexPath.row];
    cell.textLabel.text = model.nameStr;
    //cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpeg",model.imageName]];
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
    
    return 80;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    view.backgroundColor = [UIColor orangeColor];
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(25, 0, 30, 30)];
    [btn setTitle:self.sectionTitles[section + 1] forState:UIControlStateNormal];
    btn.tag = section;
    //[btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
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
        
        [self.contactsSource[indexPath.section] removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        if ([self.contactsSource[indexPath.section] count] == 0) {
            [self.sectionTitles removeObjectAtIndex:indexPath.section + 1];
            [self.contactsSource removeObjectAtIndex:indexPath.section];
        }
        [tableView reloadData];
    }
}
- (void)sortDataArrayWithContactDataHelper{
    
    NSMutableArray *contactsSource = [NSMutableArray arrayWithArray:self.contactsSource];
    [self.contactsSource removeAllObjects];
    [self.sectionTitles removeAllObjects];
    
    self.contactsSource = [ContactDataHelper getFriendListDataBy:contactsSource];
    
    self.sectionTitles = [ContactDataHelper getFriendListSectionBy:[self.contactsSource mutableCopy]];
}
#pragma mark - getters

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
