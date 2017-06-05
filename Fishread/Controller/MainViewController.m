//
//  MainViewController.m
//  CustomNav
//
//  Created by xuehaodong on 2016/12/29.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "MainViewController.h"
#import "MainTitleView.h"
#import "chuangjianViewController.h"
@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *titleNames;
@property (nonatomic,strong) MainTitleView *topView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
}

#pragma mark - initializer
- (void)initUI{
    
    [self addChildVC];
    [self initNav];
}

- (void)initNav{
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"放大镜-拷贝"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"矩形-34-拷贝-2"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"54d48a"];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"54d48a"];
}

- (void)addChildVC{
    NSArray *viewArray = @[@"FocusViewController",@"HotViewController",@"NearViewController"];
    for (NSInteger i = 0; i < self.titleNames.count; i ++) {
        UIViewController *viewClass = [[NSClassFromString(viewArray[i]) alloc] init];
        viewClass.title = self.titleNames[i];
        [self addChildViewController:viewClass];
    }
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.titleNames.count, 0);
    
    //默认显示第二页 热门
    //self.scrollView.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
    
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
}

#pragma mark - Scroll View delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX/width;
    
    UIViewController *viewClass = self.childViewControllers[index];
    
    //滚动标题线
    [self.topView scrollingWithTag:index];
    //判断是否加载过
    if ([viewClass isViewLoaded])return;
    
    viewClass.view.frame = CGRectMake(offsetX, 0, width, height);
    [self.scrollView addSubview:viewClass.view];
}

#pragma mark - UIBarButton Action

- (void)leftBarAction{
    NSLog(@"leftBarAction...");
}

- (void)rightBarAction{
    NSLog(@"rightBarAction...");
    chuangjianViewController *chuangjianVC = [[chuangjianViewController alloc] init];
    [self.navigationController pushViewController:chuangjianVC animated:YES];
}

#pragma mark - setter and getter
- (NSArray *)titleNames{
    if (!_titleNames) {
        _titleNames = @[@"全部",@"我的",@"神贴"];
    }
    return _titleNames;
}

- (MainTitleView *)topView{
    if (!_topView) {
        _topView = [[MainTitleView alloc] initWithFrame:CGRectMake(0, 0, 200, 40) WithTitleName:self.titleNames WithBlock:^(NSInteger index) {
            
            CGPoint point = CGPointMake(index * [UIScreen mainScreen].bounds.size.width, self.scrollView.contentOffset.y);
            [self.scrollView setContentOffset:point animated:YES];
            
        }];
    }
    
    return _topView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
