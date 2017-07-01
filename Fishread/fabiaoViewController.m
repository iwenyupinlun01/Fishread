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
#import "DzyImgPicker.h"

#import "AFHTTPSessionManager.h"

@interface fabiaoViewController ()<DzyImgDelegate>


@property (nonatomic,strong) WJGtextView *textView;
@property (nonatomic,strong) NSMutableArray *imgArray;
@property (nonatomic ) DzyImgPicker *dzyView;
@property (nonatomic ) NSArray *data;


@end

@implementation fabiaoViewController

- (DzyImgPicker *)dzyView {
    
    if (!_dzyView) {
        //此处需要注意  自己计算一下  我设置的每个cell 是60*60  间距10 所以 这里一般是设置 全屏宽度  如有特殊需求自行修改
        DzyImgPicker *picker = [[DzyImgPicker alloc] initWithFrame:CGRectMake(0, 160, DEVICE_WIDTH, 200) andParentV:self andMaxNum:9];
        picker.delegate = self;
        
        picker.backgroundColor = [UIColor orangeColor];
        _dzyView = picker;
    }
    return _dzyView;
}

- (void)getImages:(NSArray *)imgData
{
    for (int i = 0; i<imgData.count; i++) {
        UIImage *img = [imgData objectAtIndex:i];
        [self.imgArray addObject:img];
    }
}

-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 150)];
        _textView.customPlaceholder = @"发表帖子";
        //textView.backgroundColor = [UIColor wjColorFloat:@"C7C7CD"];
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
    [self.view addSubview:self.textView];
    self.data = [NSArray new];
    [self.view addSubview:self.dzyView];
    __weak typeof(self)weakSelf = self;
    [_dzyView setDzyImgs:^(NSArray *data) {
        weakSelf.data = data;
        NSLog(@"block --- %lu",(unsigned long)data.count);
    }];

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
#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction
{
    NSDictionary *para = @{@"token":[tokenstr tokenstrfrom],@"id":self.idstr,@"content":self.textView.text,@"images":self.imgArray};
    
    NSMutableArray *namearr = [NSMutableArray array];
    NSString *name  = [NSString string];
    
    for (int i = 0; i<self.imgArray.count; i++) {
        name = [NSString stringWithFormat:@"%d%@",i,@"img"];
        [namearr addObject:name];
    }
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/plain",@"multipart/form-data"]];
    [manager POST:fatie parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<self.imgArray.count; i++) {
            UIImage * image =self.imgArray[i];
            NSDate *date = [NSDate date];
            NSDateFormatter *formormat = [[NSDateFormatter alloc]init];
            [formormat setDateFormat:@"HHmmss"];
            NSString *dateString = [formormat stringFromDate:date];
           // NSString *fileName = [NSString  stringWithFormat:@"%@%d.png",dateString,i];
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            double scaleNum = (double)300*1024/imageData.length;
            NSLog(@"图片压缩率：%f",scaleNum);
            if(scaleNum <1){
                
                imageData = UIImageJPEGRepresentation(image, scaleNum);
            }else{
                
                imageData = UIImageJPEGRepresentation(image, 0.1);
                
            }
            
            [formData appendPartWithFileData:imageData name:@"fileToUpload[]" fileName:[NSString stringWithFormat:@"%d.jpg",i] mimeType:@"image/jpeg"];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---%@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"`````````%@",responseObject);
        NSDictionary *datas = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        //
        NSLog(@"请求成功%@",datas);
        NSString *hud = [responseObject objectForKey:@"msg"];
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            [MBProgressHUD showError:hud];
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:hud];
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //[MBProgressHUD showSuccess:@"请求失败"];
        
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    }];
    

    
    
    

}

@end
