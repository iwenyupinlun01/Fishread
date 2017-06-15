//
//  YAImageTableViewVC.m
//  YAHeadImageTableViewDemo
//
//  Created by yinyao on 2017/3/13.
//  Copyright © 2017年 yinyao. All rights reserved.
//
//  GitHub: https://github.com/yaomars/YAHeadImageTableView

#import "YAImageTableViewVC.h"
#import "UINavigationBar+AlphaAnimation.h"
#import "YYImage.h"
#import "UIView+Extension.h"

@interface YAImageTableViewVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIImageView *headerImageView;
@property (nonatomic, weak) UILabel *titleLbl;
@property (nonatomic, assign) CGFloat headerView_height;
@property (nonatomic, assign) CGFloat navbar_change_point;
@property (nonatomic, assign) CGFloat introLbl_height;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UILabel *introLbl;
@property (nonatomic, weak) UIButton *moreTextBtn;

@end

@implementation YAImageTableViewVC

static NSString *cellIdentifier = @"YAImageTableViewVCCell";

#pragma mark - 重写init

- (instancetype)init {

    self = [super init];
    if (self) {
        //
    }
    return self;
}

#pragma mark - 视图生命周期
/** 控制器销毁 */
- (void)dealloc {
    NSLog(@"YAImageTableViewVC -- dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //初始化变量
    if (_imageTableViewStyle == YAImageTableViewStyleOne) {
        _headerView_height = 180.0f;
        _navbar_change_point = 50.0f;
    } else if (_imageTableViewStyle == YAImageTableViewStyleTwo) {
        _headerView_height = 340.0f;
        _navbar_change_point = 180.0f;
        _introLbl_height = 50.0f;
    }
    
    //初始化视图
    [self setupUI];
    
   
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [self.navigationController.navigationBar ya_setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    //还原导航栏
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar ya_reset];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

#pragma mark - 初始化
/** 初始化视图 */
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];

    //导航栏标题
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    titleLbl.text = _navbarTitle ? : @"默认标题";
    titleLbl.textColor = [UIColor clearColor];
    titleLbl.alpha = 0.0;
    self.navigationItem.titleView = titleLbl;
    self.titleLbl = titleLbl;
    
    //设置tableView
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(_headerView_height, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.rowHeight = 55.0f;
    
    //顶部视图设置
    NSString *imageName = nil;
    if (_imageTableViewStyle == YAImageTableViewStyleOne) {
        imageName = @"niconiconi@2x.gif";
        UIImageView *headerImageView = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0, -_headerView_height, SCREENWIDTH, _headerView_height)];
        headerImageView.image = [YYImage imageNamed:imageName];
        headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        headerImageView.clipsToBounds = YES;
        headerImageView.backgroundColor = [UIColor greenColor];
        [self.tableView addSubview:headerImageView];
        self.headerImageView = headerImageView;
    }
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"我是 cell";
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"indexPath = %ld", indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //修改透明度  弹性
    CGFloat offsetY = scrollView.contentOffset.y + _headerView_height;
    UIColor * color = nil;
    if (_imageTableViewStyle == YAImageTableViewStyleOne) {
    
        color = [UIColor colorWithRed:0.16 green:0.17 blue:0.21 alpha:1.00];
        self.headerImageView.height = MAX(0, _headerView_height - offsetY);
        self.headerImageView.y = scrollView.contentOffset.y;
    } else if (_imageTableViewStyle == YAImageTableViewStyleTwo) {
    
        color = [UIColor colorWithRed:0.23 green:0.66 blue:0.87 alpha:1.00];
        if (offsetY <= 8) {
            self.tableView.bounces = NO;
        } else {
            self.tableView.bounces = YES;
        }
    }
    
    if (offsetY > _navbar_change_point) {
        CGFloat alpha = MIN(1, 1 - ((_navbar_change_point + 64 - offsetY) / 64));
        [self.navigationController.navigationBar ya_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        [self.titleLbl setTextColor:[UIColor colorWithWhite:1.0 alpha:alpha]];
    } else {
        [self.navigationController.navigationBar ya_setBackgroundColor:[color colorWithAlphaComponent:0]];
        [self.titleLbl setTextColor:[UIColor clearColor]];
    }
    
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
        [self.view addSubview:_tableView];
        //注册cell
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}

///tableView 滚动到最顶部

- (void)scrollToTop {
    CGPoint off = self.tableView.contentOffset;
    off.y = 0 - self.tableView.contentInset.top;
    [self.tableView setContentOffset:off animated:YES];
}


@end
