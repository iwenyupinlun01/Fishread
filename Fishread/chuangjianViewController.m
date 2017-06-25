//
//  chuangjianViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/3.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chuangjianViewController.h"
#import "chuangjianCell.h"
#import "chuangjianCell1.h"
#import "chuangjianCell2.h"
#import "quanzileibieModel.h"
@interface chuangjianViewController ()<UITableViewDataSource,UITableViewDelegate,mycellVdelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *chuangjiantableView;
@property (nonatomic,strong) NSMutableArray *quanzetypearr;
@property (nonatomic,strong) NSMutableArray *listArray;

@property (nonatomic,strong) NSString *bastimgstr;
@property (nonatomic,strong) NSString *fromidstr;
@property (nonatomic,strong) NSString *pathstr;


@end

static NSString *chuangjianidentfid0 = @"chuangjianidentfid0";
static NSString *chuangjianidentfid1 = @"chuangjianidentfid1";
static NSString *chuangjianidentfid2 = @"chuangjianidentfid2";

@implementation chuangjianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"创建";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finifshAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.quanzetypearr = [NSMutableArray array];
    self.listArray = [NSMutableArray array];
    
    self.chuangjiantableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.chuangjiantableView];
    [self loaddatafromweb];
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    TapGestureTecognizer.cancelsTouchesInView=NO;
    [self.chuangjiantableView addGestureRecognizer:TapGestureTecognizer];
    
   
    

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
}

#pragma mark - web

-(void)loaddatafromweb
{
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
            [self.chuangjiantableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

#pragma mark - getters

-(UITableView *)chuangjiantableView
{
    if(!_chuangjiantableView)
    {
        _chuangjiantableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _chuangjiantableView.dataSource = self;
        _chuangjiantableView.delegate = self;
        _chuangjiantableView.separatorStyle = NO;
    }
    return _chuangjiantableView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        chuangjianCell *cell = [tableView dequeueReusableCellWithIdentifier:chuangjianidentfid0];
        if (!cell) {
            cell = [[chuangjianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chuangjianidentfid0];
            cell.chuangjianView.image = [UIImage imageNamed:@"默认-拷贝"];
            UIImage *originImage = cell.chuangjianView.image;
            NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
            NSString *base64str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            NSLog(@"base64str-------%@",base64str);
            self.bastimgstr = base64str;
            self.fromidstr = @"1";
        }
        cell.chuangjianText.tag = 101;
        cell.chuangjianView.tag = 202;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    if (indexPath.row==1) {
        chuangjianCell1 *cell = [tableView dequeueReusableCellWithIdentifier:chuangjianidentfid2];
        cell = [[chuangjianCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chuangjianidentfid2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.irregulatBtn getArrayDataSourse:self.listArray];
        //重置frame
        CGSize size = [cell.irregulatBtn returnSize];
        cell.irregulatBtn.frame = CGRectMake(14*WIDTH_SCALE, 0, DEVICE_WIDTH - 28*WIDTH_SCALE, size.height);
        NSLog(@"%f",size.height);
        //回调
        [cell.irregulatBtn setChooseBlock:^(UIButton *button) {
            //NSLog(@"index:%ld    indexName:%@",(long)button.tag,listArray[button.tag]);
            // NSLog(@"index:%ld",(long)button.tag);
            NSLog(@"index=%@",self.quanzetypearr[button.tag]);
            self.fromidstr = [NSString stringWithFormat:@"%@",self.quanzetypearr[button.tag]];
            
        }];
        return cell;
    }
    if (indexPath.row==2) {
        chuangjianCell2 *cell = [tableView dequeueReusableCellWithIdentifier:chuangjianidentfid1];
        cell = [[chuangjianCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chuangjianidentfid1];
        cell.textView.tag = 102;
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

-(void)myTabVClick:(UITableViewCell *)cell
{
    NSLog(@"pic");
    [self changeIcon];
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];

//    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

-(void)finifshAction
{
    NSLog(@"完成");
    UITextField *text1 = [self.chuangjiantableView viewWithTag:101];
    UITextView *text2 = [self.chuangjiantableView viewWithTag:102];
    
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

-(void)keyboardHide
{
    UITextField *text1 = [self.chuangjiantableView viewWithTag:101];
    UITextView *text2 = [self.chuangjiantableView viewWithTag:102];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
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
    NSLog(@"图片返回--------------数据信息");
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImageView *picimage = [self.chuangjiantableView viewWithTag:202];
    picimage.image = image;
    [self.chuangjiantableView reloadData];
    
    UIImage *originImage = image;
    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
    NSString *base64str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"base64str-------%@",base64str);
    self.bastimgstr = base64str;
}
@end
