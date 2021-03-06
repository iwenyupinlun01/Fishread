//
//  searchViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "searchViewController.h"
#import "searchCell0.h"
#import "searchCell1.h"
#import "UIView+Utils.h"
#import "historyModel.h"
#import "searchheadView.h"
#import "jieguoCell.h"
#import "jieguoModel.h"
#import "taolunquanViewController.h"
#import "yueduquanViewController.h"

@interface searchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,mycellVdelegate,myheadviewVdelegate>
{
    int pn;
    int jieguopn;
}
@property (nonatomic,strong) UISearchBar *customSearchBar;
@property (nonatomic,strong) UITableView *searchtableView;
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) NSMutableArray *listidArray;
@property (nonatomic,strong) NSMutableArray *relation_idArray;
@property (nonatomic,strong) NSMutableArray *historyDatasourceArray;
@property (nonatomic,strong) UITableView *jieguotableView;
@property (nonatomic,strong) NSMutableArray *jieguodataArray;

@end

static NSString *searchidentfid0 = @"searchidentfid0";
static NSString *searchidentfid1 = @"searchudebtfud1";
static NSString *jieguoideentfid = @"jieguoidentfid";

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"baise"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色为F5F5F5
    [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor wjColorFloat:@"333333"]];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
    [self.navigationController.view addSubview: self.customSearchBar];
    self.listArray = [NSMutableArray array];
    self.listidArray = [NSMutableArray array];
    self.relation_idArray = [NSMutableArray array];
    self.historyDatasourceArray = [NSMutableArray array];
    self.jieguodataArray = [NSMutableArray array];
    [self addHeader];
    [self.view addSubview:self.searchtableView];
    self.searchtableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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

#pragma mark - web

- (void)addHeader
{
    // 头部刷新控件
    self.searchtableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.searchtableView.mj_header beginRefreshing];
}

- (void)refreshAction {
    
    [self headerRefreshEndAction];
    
}

-(void)headerRefreshEndAction
{
    [self.historyDatasourceArray removeAllObjects];
    [self.listArray removeAllObjects];
    [self.listidArray removeAllObjects];
    [self.relation_idArray removeAllObjects];
    
    NSString *urlstr = [NSString stringWithFormat:sousuolishi,[tokenstr tokenstrfrom]];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {

        NSDictionary *infodit = [responseObject objectForKey:@"info"];
        NSArray *hotarr = [infodit objectForKey:@"hot"];
            for (int i = 0; i<hotarr.count; i++) {
                NSDictionary *hotdit = [NSDictionary dictionary];
                hotdit = [hotarr objectAtIndex:i];
                NSString *hotname = [hotdit objectForKey:@"title"];
                NSString *hotid = [hotdit objectForKey:@"id"];
                NSString *relation_id = [hotdit objectForKey:@"relation_id"];
                [self.listArray addObject:hotname];
                [self.listidArray addObject:hotid];
                [self.relation_idArray addObject:relation_id];
            }
        
        
        NSArray *hisarr = [infodit objectForKey:@"history"];
        for (int i = 0; i<hisarr.count; i++) {
            historyModel *hmodel = [[historyModel alloc] init];
            NSDictionary *dit = [hisarr objectAtIndex:i];
            hmodel.historysearchkey = [dit objectForKey:@"search_key"];
            hmodel.historystarchid = [dit objectForKey:@"id"];
//            hmodel.historysearchkey = @"demo";
            [self.historyDatasourceArray addObject:hmodel];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.searchtableView.mj_header endRefreshing];
            [self.searchtableView reloadData];
        });

        
        
    } failure:^(NSError *error) {
        [self.searchtableView.mj_header endRefreshing];
    }];
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
        _customSearchBar.placeholder = @"搜索";
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
        _searchtableView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
        TapGestureTecognizer.cancelsTouchesInView=NO;
        [self.searchtableView addGestureRecognizer:TapGestureTecognizer];

    }
    return _searchtableView;
}

-(UITableView *)jieguotableView
{
    if(!_jieguotableView)
    {
        _jieguotableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
        _jieguotableView.dataSource = self;
        _jieguotableView.delegate = self;
        [_jieguotableView setHidden:NO];
        
        UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide2)];
        TapGestureTecognizer.cancelsTouchesInView=NO;
        [self.jieguotableView addGestureRecognizer:TapGestureTecognizer];
        
    }
    return _jieguotableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.searchtableView) {
        if (section==0) {
            return 0.01f;
        }else
        {
            return 50*HEIGHT_SCALE;
        }
    }else
    {
        return 0.01f;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.searchtableView) {
        if (self.historyDatasourceArray.count!=0) {
            return 2;
        }else
        {
            return 1;
        }
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.searchtableView) {
        if (section==0) {
            return 1;
        }
        if (section==1) {
            return self.historyDatasourceArray.count;
        }
        return 0;
    }
    else
    {
        return self.jieguodataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.searchtableView) {
        if (indexPath.section==0) {
            searchCell0 *cell = [tableView dequeueReusableCellWithIdentifier:searchidentfid0];
            cell = [[searchCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchidentfid0];
            cell.delegate = self;
            [cell.tagview getArrayDataSourse:self.listArray];
            //重置frame
            CGSize size = [cell.tagview returnSize];
            cell.tagview.frame = CGRectMake(14*WIDTH_SCALE, 46*HEIGHT_SCALE, DEVICE_WIDTH - 28*WIDTH_SCALE, size.height);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            searchCell1 *cell = [tableView dequeueReusableCellWithIdentifier:searchidentfid1];
            cell = [[searchCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchidentfid1];
            [cell setdata:self.historyDatasourceArray[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else
    {
        jieguoCell *cell = [tableView dequeueReusableCellWithIdentifier:jieguoideentfid];
        cell = [[jieguoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jieguoideentfid];
        //cell.textLabel.text = @"搜索结果展示";
        [cell setdata:self.jieguodataArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.searchtableView) {
        if (indexPath.section==0) {
            //return 200;
            searchCell0 *cell = [[searchCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchidentfid0];
            [cell.tagview getArrayDataSourse:self.listArray];
            //重置frame
            CGSize size = [cell.tagview returnSize];
            return size.height+60*HEIGHT_SCALE;
            
        }else
        {
            return 60*HEIGHT_SCALE;
        }

    }
    else
    {
        return 192/2*HEIGHT_SCALE;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section==1) {
        searchheadView *view = [[searchheadView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 60)];
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        return view;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.jieguotableView) {
        jieguoModel *hmodel = self.jieguodataArray[indexPath.row];
        NSString *homeidstr = hmodel.idstr;
        NSString *relation_idstr = hmodel.typestr;
        self.hidesBottomBarWhenPushed = YES;
        if ([relation_idstr isEqualToString:@"0"]) {
            taolunquanViewController *taolunquanVC = [[taolunquanViewController alloc] init];
            taolunquanVC.idstr = homeidstr;
            [self.navigationController pushViewController:taolunquanVC animated:YES];
            
        }else
        {
            yueduquanViewController *yueduvc = [[yueduquanViewController alloc] init];
            yueduvc.idstr = homeidstr;
            [self.navigationController pushViewController:yueduvc animated:YES];
        }
    }
}

-(void)myTabVClick:(UITableViewCell *)cell
{
    NSLog(@"换一批");
}

-(void)myheadVClick:(UIView *)view
{
    NSLog(@"清空");
    
    NSString *urlstr = [NSString stringWithFormat:shanchusosuo,[tokenstr tokenstrfrom],@"all"];
    
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        NSLog(@"res-------%@",responseObject);
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            [MBProgressHUD showSuccess:@"操作成功"];
            [self headerRefreshEndActionjieguo];
        }
        else if ([[responseObject objectForKey:@"code"] intValue]==0) {
            [MBProgressHUD showSuccess:@"token错误"];
        }else
        {
            [MBProgressHUD showSuccess:@"系统繁忙，请稍后再试"];
        }
        
        [self headerRefreshEndAction];
        
    } failure:^(NSError *error) {
       
    }];
}

//先要设Cell可编辑

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchtableView) {
        if (indexPath.section==1) {
            return YES;
        }
    }
    return NO;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        historyModel *model = self.historyDatasourceArray[indexPath.row];
        NSString *idstr = model.historystarchid;
        NSLog(@"idstr ----%@",idstr);
        
        NSString *urlstr = [NSString stringWithFormat:shanchusosuo,[tokenstr tokenstrfrom],idstr];
        
        [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
            if ([[responseObject objectForKey:@"code"] intValue]==1) {
                [MBProgressHUD showSuccess:@"操作成功"];
                
                
            }
            else if ([[responseObject objectForKey:@"code"] intValue]==0) {
                [MBProgressHUD showSuccess:@"token错误"];
            }else
            {
                [MBProgressHUD showSuccess:@"系统繁忙，请稍后再试"];
            }
            
            [self headerRefreshEndAction];
        } failure:^(NSError *error) {
            
        }];
        
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - UISearchBarDelegate

//cancel按钮点击时调用

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //[self.jieguotableView setHidden:NO];
    [self.jieguotableView removeFromSuperview];
    self.customSearchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    [self headerRefreshEndAction];
    [self.navigationController popViewControllerAnimated:YES];
}

//点击搜索框时调用

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.customSearchBar.showsCancelButton = YES;
}
//点击键盘上的search按钮时调用

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view addSubview:self.jieguotableView];

    [self addHeaderjieguo];
    [self addFooterjiegup];
    
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

#pragma mark - 搜索界面加载方法

- (void)addHeaderjieguo
{
    // 头部刷新控件
    self.jieguotableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshActionjieguo)];
    [self.jieguotableView.mj_header beginRefreshing];
}

- (void)addFooterjiegup
{
    self.jieguotableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMorejiegup)];
}

- (void)refreshActionjieguo {
    
    [self headerRefreshEndActionjieguo];
    
}

- (void)refreshLoadMorejiegup {
    
    [self footerRefreshEndActionjieguo];
}

-(void)headerRefreshEndActionjieguo
{
    [self.jieguodataArray removeAllObjects];
    
    jieguopn = 1;
    NSString *typestr = self.customSearchBar.text;
    NSString *urlstr = [NSString stringWithFormat:sousuo,[tokenstr tokenstrfrom],@"1",typestr];
    
   // urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
     urlstr = [urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [PPNetworkHelper GET: urlstr parameters:nil success:^(id responseObject) {
       
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *ditarr = [responseObject objectForKey:@"circle"];
            for (int i = 0 ; i<ditarr.count; i++) {
                NSDictionary *dit = [ditarr objectAtIndex:i];
                jieguoModel *model = [[jieguoModel alloc] init];
                model.idstr = [dit objectForKey:@"id"];
                model.leftimgstr = [dit objectForKey:@"cover"];
                model.namestr = [dit objectForKey:@"title"];
                model.typestr = [dit objectForKey:@"relation_id"];
                
                [self.jieguodataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.jieguotableView.mj_header endRefreshing];
                [self.jieguotableView reloadData];
                [self.jieguotableView setHidden:NO];
            });
        }else
        {
            [MBProgressHUD showSuccess:@"没有查询出任何数据"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.jieguotableView.mj_header endRefreshing];
                [self.jieguotableView reloadData];
            });
        }

     
    } failure:^(NSError *error) {
        [self.jieguotableView.mj_header endRefreshing];

    }];
    

}

-(void)footerRefreshEndActionjieguo
{
    jieguopn++;
    NSString *typestr = self.customSearchBar.text;
    NSString *pnstr = [NSString stringWithFormat:@"%d",jieguopn];
    NSString *urlstr =  [NSString stringWithFormat:sousuo,[tokenstr tokenstrfrom],pnstr,typestr];
    [PPNetworkHelper GET: urlstr parameters:nil success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSArray *ditarr = [responseObject objectForKey:@"circle"];
            for (int i = 0 ; i<ditarr.count; i++) {
                NSDictionary *dit = [ditarr objectAtIndex:i];
                jieguoModel *model = [[jieguoModel alloc] init];
                model.idstr = [dit objectForKey:@"id"];
                model.leftimgstr = [dit objectForKey:@"cover"];
                model.namestr = [dit objectForKey:@"title"];
                model.typestr = [dit objectForKey:@"relation_id"];
                
                [self.jieguodataArray addObject:model];
            }
        }else
        {
            [MBProgressHUD showSuccess:@"没有查询出任何数据"];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.jieguotableView.mj_footer endRefreshing];
            [self.jieguotableView reloadData];
        });
    } failure:^(NSError *error) {
        [self.jieguotableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)keyboardHide
{
    self.customSearchBar.showsCancelButton = NO;
    [self.customSearchBar resignFirstResponder];
}

-(void)keyboardHide2
{
    self.customSearchBar.showsCancelButton = NO;
    [self.customSearchBar resignFirstResponder];
}
@end
