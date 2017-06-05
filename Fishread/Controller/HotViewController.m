//
//  HotViewController.m
//  CustomNav
//
//  Created by xuehaodong on 2016/12/29.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "HotViewController.h"
#import "wodeCell.h"

@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *wodeTableview;

@end
static NSString *wodecellidentfid = @"wodecellidentfid";
@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.wodeTableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    wodeCell *cell = [tableView dequeueReusableCellWithIdentifier:wodecellidentfid];
    cell = [[wodeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wodecellidentfid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 134/2*HEIGHT_SCALE+28*HEIGHT_SCALE;
}
@end
