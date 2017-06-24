//
//  myinfoViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "myinfoViewController.h"
#import "myinfoCell0.h"
#import "myinfoCell1.h"
#import "nicknameViewController.h"
@interface myinfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *myinfotableView;
@end

static NSString *myinfocellidentfid0 = @"myinfocellidentfid0";
static NSString *myinfocellidentfid1 = @"myinfocellidentfid1";

@implementation myinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑资料";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.view addSubview:self.myinfotableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    [self.myinfotableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - getters

-(UITableView *)myinfotableView
{
    if(!_myinfotableView)
    {
        _myinfotableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
        _myinfotableView.dataSource = self;
        _myinfotableView.delegate = self;
        
    }
    return _myinfotableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        myinfoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:myinfocellidentfid0];
        if (!cell) {
            cell = [[myinfoCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfocellidentfid0];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.infoimage.tag = 2001;
        [cell.infoimage sd_setImageWithURL:[NSURL URLWithString:[tokenstr userimgstrfrom]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        return cell;
    }
    if (indexPath.row==1) {
        myinfoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:myinfocellidentfid1];
        if (!cell) {
            cell = [[myinfoCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myinfocellidentfid1];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        cell.rightlab.tag = 201;
        cell.rightlab.text = [tokenstr nicknamestrfrom];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8*HEIGHT_SCALE;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self changeIcon];
    }
    if (indexPath.row==1) {
        nicknameViewController *nicknamevc = [[nicknameViewController alloc] init];
        [self.navigationController pushViewController:nicknamevc animated:YES];
    }
}

#pragma mark - 选择图片

- (void)changeIcon
{
    UIAlertController *alertController;
    
    __block NSUInteger blockSourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //支持访问相机与相册情况
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择图片" preferredStyle:    UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击从相册中选取");
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击拍照");
            //相机
            blockSourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        //只支持访问相册情况
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击从相册中选取");
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:^{
                
            }];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - 选择图片后,回调选择

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImageView *picimage = [self.myinfotableView viewWithTag:2001];
    picimage.image = image;
    [self.myinfotableView reloadData];
   
    UIImage *originImage = image;
    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
    NSString *base64str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"base64str-------%@",base64str);
    NSDictionary *dit = @{@"token":[tokenstr tokenstrfrom],@"str":base64str};
    
    NSString *str = @"http://www.3a406.cn/forum/user/userIcon.html";
    
    [PPNetworkHelper POST:str parameters:dit success:^(id responseObject) {
        NSString *hudstr = [responseObject objectForKey:@"msg"];
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            [MBProgressHUD showSuccess:hudstr];
            NSString *pathstr = [responseObject objectForKey:@"info"];
            NSUserDefaults *userdefat = [NSUserDefaults standardUserDefaults];
            [userdefat setObject:pathstr forKey:@"pathurlstr"];
            [userdefat synchronize];
            [MBProgressHUD showSuccess:hudstr];
        }else
        {
            [MBProgressHUD showSuccess:hudstr];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];

}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
