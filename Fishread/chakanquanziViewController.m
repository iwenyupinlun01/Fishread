//
//  chakanquanziViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chakanquanziViewController.h"
#import "chuangjianCell.h"
#import "chakanCell.h"
#import "chuangjianCell2.h"
#import "chuangjianCell1.h"
#import "quanzileibieModel.h"
@interface chakanquanziViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong) UITableView *chakantableView;
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,strong) NSMutableArray *quanzetypearr;
@property (nonatomic,strong) NSString *contentstr;
@property (nonatomic,strong) NSString *coverstr;
@property (nonatomic,strong) NSString *circleTypestr;
@property (nonatomic,strong) NSString *titlestr;
@property (nonatomic,strong) NSString *fromidstr;
@property (nonatomic,strong) NSString *bastimgstr;
@end


static NSString *chakanidentfid0 = @"chakanidentfid0";
static NSString *chakanidentfid1 = @"chakanidentfid1";
static NSString *chakanidentfid2 = @"chakanidentfid2";


@implementation chakanquanziViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    if ([self.typestr isEqualToString:@"0"]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    }
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.typestr isEqualToString:@"0"]) {
        self.title = @"编辑";
    }else
    {
        self.title = @"查看";
    }
    self.listArray = [NSMutableArray array];
    self.quanzetypearr = [NSMutableArray array];
    [self.view addSubview:self.chakantableView];
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
    
    [self.quanzetypearr removeAllObjects];
    [self.listArray removeAllObjects];
    
    [PPNetworkHelper GET:[NSString stringWithFormat:quanzileimu,[tokenstr tokenstrfrom]] parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"]intValue]==1) {
            NSArray *ditarr = [responseObject objectForKey:@"info"];
            for (int i = 0 ; i<ditarr.count; i++) {
                NSDictionary *dit = [ditarr objectAtIndex:i];
                quanzileibieModel *model = [[quanzileibieModel alloc] init];
                model.quanzitypeid = [dit objectForKey:@"id"];
                model.quanzitypename = [dit objectForKey:@"title"];
                [self.quanzetypearr addObject:model.quanzitypeid];
                [self.listArray addObject:model.quanzitypename];
            }
            [self.chakantableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
    [PPNetworkHelper GET:[NSString stringWithFormat:chakanquqnizilian,[tokenstr tokenstrfrom],self.idstr,@"1"] parameters:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSDictionary *dit = [responseObject objectForKey:@"info"];
            self.contentstr = [dit objectForKey:@"content"];
            self.titlestr = [dit objectForKey:@"title"];
            self.coverstr = [dit objectForKey:@"cover"];
            self.fromidstr = [dit objectForKey:@"forum_id"];
            [self.chakantableView reloadData];
        }else
        {
            NSString *hud = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hud];
        }
    } failure:^(NSError *error) {
        
    }];

}

#pragma mark - getters

-(UITableView *)chakantableView
{
    if(!_chakantableView)
    {
        _chakantableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _chakantableView.dataSource = self;
        _chakantableView.delegate = self;
        _chakantableView.separatorStyle = NO;
    }
    return _chakantableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        chuangjianCell *cell = [tableView dequeueReusableCellWithIdentifier:chakanidentfid0];
        if (!cell) {
            cell = [[chuangjianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chakanidentfid0];
            cell.chuangjianView.image = [UIImage imageNamed:@"默认-拷贝"];
        }
        cell.chuangjianText.tag = 101;
        cell.chuangjianView.tag = 202;
        cell.chuangjianText.delegate = self;
        cell.chuangjianText.text = self.titlestr;
        [cell.chuangjianView sd_setImageWithURL:[NSURL URLWithString:self.coverstr] placeholderImage:[UIImage imageNamed:@"默认-拷贝"]];
        UIImage *originImage = cell.chuangjianView.image;
        NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
        NSString *base64str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSLog(@"base64str-------%@",base64str);
        self.bastimgstr = base64str;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        chuangjianCell1 *cell = [tableView dequeueReusableCellWithIdentifier:chakanidentfid1];
        cell = [[chuangjianCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chakanidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.irregulatBtn getArrayDataSourse:self.listArray];
        //重置frame
        CGSize size = [cell.irregulatBtn returnSize];
        cell.irregulatBtn.frame = CGRectMake(14*WIDTH_SCALE, 0, DEVICE_WIDTH - 28*WIDTH_SCALE, size.height);
        NSLog(@"%f",size.height);
        if ([self.typestr isEqualToString:@"0"]) {
            //回调
            [cell.irregulatBtn setChooseBlock:^(UIButton *button) {
                //NSLog(@"index:%ld    indexName:%@",(long)button.tag,listArray[button.tag]);
                // NSLog(@"index:%ld",(long)button.tag);
                //            NSLog(@"index=%@",self.quanzetypearr[button.tag]);
                self.fromidstr = [NSString stringWithFormat:@"%@",self.quanzetypearr[button.tag]];
            }];
        }
        return cell;
    }
    if (indexPath.row==2) {
        chuangjianCell2 *cell = [tableView dequeueReusableCellWithIdentifier:chakanidentfid2];
        cell = [[chuangjianCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chakanidentfid2];
        cell.textView.tag = 102;
        cell.textView.text = self.contentstr;
        cell.textView.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 300;
    }
    if (indexPath.row==1) {
        return 78*HEIGHT_SCALE;
    }
    if (indexPath.row==2) {
        return 144*HEIGHT_SCALE;
    }
    return 0;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.typestr isEqualToString:@"0"]) {
        return YES;
    }
    return NO;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}
#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    //    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

-(void)rightAction
{
    UITextField *text1 = [self.chakantableView viewWithTag:101];
    UITextView *text2 = [self.chakantableView viewWithTag:102];
    
    NSDictionary *dit = @{@"token":[tokenstr tokenstrfrom],@"forum_id":self.fromidstr,@"title":text1.text,@"content":text2.text,@"images":self.bastimgstr};
    
    [PPNetworkHelper POST:chuangjianquqnzi parameters:dit success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
        }else
        {
            NSString *hudstr = [responseObject objectForKey:@"msg"];
            [MBProgressHUD showSuccess:hudstr];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
