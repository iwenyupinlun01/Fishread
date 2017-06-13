//
//  searchViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "searchViewController.h"
#import "searchCell0.h"
#import "UIView+Utils.h"
@interface searchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,mycellVdelegate>
@property (nonatomic,strong) UISearchBar *customSearchBar;
@property (nonatomic,strong) UITableView *searchtableView;
@property (nonatomic,strong) NSMutableArray *listArray;
@end

static NSString *searchidentfid0 = @"searchidentfid";

@implementation searchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title = @"搜索";
     //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor wjColorFloat:@"333333"]];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    [self.navigationController.view addSubview: self.customSearchBar];
    self.listArray = [NSMutableArray arrayWithObjects:@"测试1",@"测试2",@"测试3",@"测试4",@"测试5", nil];
    [self.view addSubview:self.searchtableView];
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
    [self.customSearchBar setHidden:YES];
    [self.customSearchBar resignFirstResponder];
}

#pragma mark - getters

-(UISearchBar *)customSearchBar
{
    if(!_customSearchBar)
    {
        _customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, 44)];
        _customSearchBar.delegate = self;
     
        _customSearchBar.showsCancelButton = NO;
        //找到取消按钮
        _customSearchBar.placeholder = @"搜索书圈，标签，用户";
        _customSearchBar.searchBarStyle = UISearchBarStyleMinimal;
        
        UIView* backgroundView = [_customSearchBar subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
        backgroundView.layer.cornerRadius = 14.0f;
        backgroundView.clipsToBounds = YES;
    }
    return _customSearchBar;
}


-(UITableView *)searchtableView
{
    if(!_searchtableView)
    {
        _searchtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
        _searchtableView.dataSource = self;
        _searchtableView.delegate = self;
    }
    return _searchtableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchCell0 *cell = [tableView dequeueReusableCellWithIdentifier:searchidentfid0];
    cell = [[searchCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchidentfid0];
    cell.delegate = self;
    
    
    [cell.tagview getArrayDataSourse:self.listArray];
    //重置frame
    CGSize size = [cell.tagview returnSize];
    cell.tagview.frame = CGRectMake(14*WIDTH_SCALE, 46*HEIGHT_SCALE, DEVICE_WIDTH - 28*WIDTH_SCALE, size.height);

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    //return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}

-(void)myTabVClick:(UITableViewCell *)cell
{
    NSLog(@"换一批");
}
#pragma mark - UISearchBarDelegate

//cancel按钮点击时调用

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.customSearchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

//点击搜索框时调用

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.customSearchBar.showsCancelButton = YES;
}
//点击键盘上的search按钮时调用

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    
}


//输入文本实时更新时调用

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
//    if (searchText.length == 0) {
//        
//        [self resetSearch];
//        
//        [table reloadData];
//        
//        return;
//        
//    }
//    
//    
//    
//    [self handleSearchForTerm:searchText];
}
#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
