//
//  fabiaoViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "fabiaoViewController.h"
#import "HXPhotoViewController.h"
#import "HXPhotoView.h"
#import "WJGtextView.h"
@interface fabiaoViewController ()<HXPhotoViewDelegate>
@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (nonatomic,strong) WJGtextView *textView;
@property (nonatomic,strong) NSMutableArray *imgArray;
@end

@implementation fabiaoViewController

- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.openCamera = NO;
        _manager.outerCamera = NO;
        _manager.photoMaxNum = 9;
        _manager.videoMaxNum = 9;
        _manager.maxNum = 9;
        _manager.rowCount = 4;
    }
    return _manager;
}

-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 150)];
        _textView.customPlaceholder = @"发表帖子";
        _textView.backgroundColor = [UIColor wjColorFloat:@"C7C7CD"];
    }
    return _textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    
    self.imgArray = [NSMutableArray array];
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    CGFloat width = self.view.frame.size.width;
    [self.view addSubview:self.textView];
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(12, 180, width - 24, 0);
    photoView.delegate = self;
    //photoView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:photoView];
    self.photoView = photoView;
    
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

- (void)photoViewChangeComplete:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)isOriginal
{
    NSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    for (int i = 0; i<photos.count; i++) {
        HXPhotoModel *model = [photos objectAtIndex:i];
        UIImage *img = model.thumbPhoto;
        [self.imgArray addObject:img];
    }
}

- (void)photoViewDeleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSLog(@"%@",networkPhotoUrl);
}

- (void)photoViewUpdateFrame:(CGRect)frame WithView:(UIView *)view
{
    NSLog(@"%@",NSStringFromCGRect(frame));
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction
{
    NSDictionary *para = @{@"token":[tokenstr tokenstrfrom],@"id":@"",@"content":self.textView.text,@"file":self.imgArray};
    [PPNetworkHelper GET:fatie parameters:para success:^(id responseObject) {
        NSString *hud = [responseObject objectForKey:@"msg"];
        [MBProgressHUD showError:hud];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"没有网络"];
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [self.textView resignFirstResponder];
}

@end
