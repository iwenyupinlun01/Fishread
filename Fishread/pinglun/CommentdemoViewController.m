//
//  CommentdemoViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/19.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "CommentdemoViewController.h"
#import "CommmentTableViewCell.h"
#import "AFNetworking.h"
#import "CommentModel.h"
static NSString *const indentifier = @"CommmentTableViewCell";
static NSString *const indentifierNormal = @"UITableViewCell";

@interface CommentdemoViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;


@end

@implementation CommentdemoViewController

- (NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}


-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    

    
    [_tableView registerClass:[CommmentTableViewCell class] forCellReuseIdentifier:indentifier];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:indentifierNormal];
    
    [self.view addSubview:self.tableView];
    [self networking];
}

- (void)networking{
    /*
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager POST:@"http://192.168.2.152:808/OtherApi/GetCommentList.do" parameters:@{@"pagesize" : @"5",
     @"pageindex": @"1",
     @"mid": @"1",
     @"taskId"   : @"1"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
     NSArray *dataArr = responseObject[@"data"];
     for (NSDictionary *dict in dataArr) {
     CommentModel *model = [[CommentModel alloc] init];
     [model setValuesForKeysWithDictionary:dict];
     [self.datasource addObject:model];
     }
     NSLog(@"%@",responseObject);
     [_tableView reloadData];
     
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"%@",error);
     }];
     */
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    
    NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    for (NSDictionary *dict in dataArr) {
        CommentModel *model = [[CommentModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.datasource addObject:model];
    }
    
    [self.tableView reloadData];
    
//    NSString *urlstr = [NSString stringWithFormat:dongtaixiangqing,[tokenstr tokenstrfrom],@"1",self.idstr];
//    
//    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
//        //NSLog(@"res------%@",responseObject);
//        NSArray *comdit = [responseObject objectForKey:@"allComment"];
//        //NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:filePath];
//        NSArray* dataArr = comdit;
//        for (NSDictionary *dict in dataArr) {
//            CommentModel *model = [[CommentModel alloc] init];
//            [model setValuesForKeysWithDictionary:dict];
//            [self.datasource addObject:model];
//        }
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        
//    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifierNormal ];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifierNormal];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"评论";
        return cell;
    }else
    {
        CommmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        cell = [[CommmentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.assignment(self.datasource[indexPath.row - 1]);
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }
    
    CommentModel *commentModel = self.datasource[indexPath.row - 1];
    //51为第一个内容剧 cell 上的距离
    CGFloat cellHeight = 51 + (commentModel.Replay.count * 8) + commentModel.contentHeight;
    
    //如果没有回复,直接返回
    if (commentModel.Replay == nil) {
        //8为据底部的边距
        return cellHeight + 8;
    }
    //计算回复的评论高度
    for (ReplayModel *replayModel in commentModel.Replay) {
        NSArray *replayArr = [replayModel.Content componentsSeparatedByString:@"#"];
        cellHeight += [replayArr.firstObject floatValue];
    }
    return cellHeight;
}

@end
