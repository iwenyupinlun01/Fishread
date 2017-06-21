//
//  FocusViewController.m
//  CustomNav
//
//  Created by xuehaodong on 2016/12/29.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "FocusViewController.h"
#import "wodeCell.h"
#import "wodeModel.h"
@interface FocusViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int pn;
}

@property (nonatomic,strong) UITableView *wodeTableview;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end
static NSString *wodecellidentfid = @"wodecellidentfid";
@implementation FocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.wodeTableview];
    [self headerRefreshEndAction];
    self.wodeTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - 刷新控件

-(void)headerRefreshEndAction
{

    NSString *urlstr = [NSString stringWithFormat:quanziwode,[tokenstr tokenstrfrom]];
    [self.dataSource removeAllObjects];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]intValue]==1) {
            NSArray *ditarr = [responseObject objectForKey:@"info"];
            for (int i = 0; i<ditarr.count; i++) {
                NSDictionary *dit = [ditarr objectAtIndex:i];
                wodeModel *wmodel = [[wodeModel alloc] init];
                wmodel.relation_idstr = [dit objectForKey:@"relation_id"];
                wmodel.idstr = [dit objectForKey:@"id"];
                wmodel.titlestr = [dit objectForKey:@"title"];
                wmodel.coverstr = [dit objectForKey:@"cover"];
                wmodel.is_joinstr = [dit objectForKey:@"is_join"];
                wmodel.is_showstr = [dit objectForKey:@"is_show"];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.wodeTableview reloadData];
            });

        }else if ([[responseObject objectForKey:@"code"]intValue]==2)
        {
            [MBProgressHUD showSuccess:@"没有查询到任何数据"];
        }else
        {
            [MBProgressHUD showSuccess:@"token错误"];
        }
        
    } failure:^(NSError *error) {
        
    }];
}



#pragma mark - getters

-(UITableView *)wodeTableview
{
    if(!_wodeTableview)
    {
        _wodeTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64-52)];
        _wodeTableview.dataSource = self;
        _wodeTableview.delegate = self;
        
    }
    return _wodeTableview;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    wodeCell *cell = [tableView dequeueReusableCellWithIdentifier:wodecellidentfid];
    cell = [[wodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wodecellidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [cell setdatamodel:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 134/2*HEIGHT_SCALE+28*HEIGHT_SCALE;
}

@end
