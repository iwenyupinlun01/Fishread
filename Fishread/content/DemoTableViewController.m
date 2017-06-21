//
//  DemoTableViewController.m
//  Demo
//
//  Created by venusource on 16/9/1.
//  Copyright © 2016年 venusource.com. All rights reserved.
//

#import "DemoTableViewController.h"
#import "DemoTableViewCell.h"
#import "DemoCellModel.h"
#import "DemoCommentModel.h"

#import <SDAutoLayout.h>

#define CellKey @"UITableViewCell"
@interface DemoTableViewController () <DemoTableViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation DemoTableViewController

#pragma mark 懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataArray = [self creatModelsWithCount:10];
    self.tableView.tableFooterView = [UIView new];

    [self.tableView registerClass:[DemoTableViewCell class] forCellReuseIdentifier:CellKey];

}

//创建随机数组
- (NSMutableArray *)creatModelsWithCount:(NSInteger)count
{
    //头像数组
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    //用户名数组
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    //内容数组
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时 当你的 app 没有提供 3x 的 LaunchImage 时当你的 app 没有提供 3x 的 LaunchImage 时当你的 app 没有提供 3x 的 LaunchImage 时当你的 app 没有提供 3x 的 LaunchImage 时当你的 app 没有提供 3x 的 LaunchImage 时",
                           @"等比例拉伸到大屏。这种情况下对界面不会产生任何影响，",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320"
                           ];

    
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        //头像下标
        int iconRandomIndex = arc4random_uniform(5);
        //名字下标
        int nameRandomIndex = arc4random_uniform(5);
        //内容下标
        int contentRandomIndex = arc4random_uniform(5);
        
        DemoCellModel *model = [[DemoCellModel alloc]init];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        model.commentArray = [self creatCommentArray:namesArray];
        
        [resArr addObject:model];
        
    }
    return resArr;
}

-(NSMutableArray *)creatCommentArray:(NSArray *)names{
    
    //评论数组
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];
    
    
    int commentRandom = arc4random_uniform(3);
    NSMutableArray *tempComments = [NSMutableArray new];
    
    for (int i = 0; i < commentRandom; i++) {
        
        int index = arc4random_uniform((int)names.count);
        
        DemoCommentModel *commentModel = [DemoCommentModel new];
        commentModel.firstUserName = names[index];
        commentModel.firstUserId = @"回复";
        
        if (arc4random_uniform(10) < 5) {
            commentModel.secondUserName = names[arc4random_uniform((int)names.count)];
            commentModel.secondUserId = @"被回复";
        }
        
        commentModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
        [tempComments addObject:commentModel];
    }
    return tempComments;
}

#pragma mark tableview代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellKey];
    
    cell.sd_indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoCellModel *model = self.dataArray[indexPath.row];
    DemoCommentModel *commentModel = [[DemoCommentModel alloc]init];
    commentModel.commentString = @"添加一个评论";
    [model.commentArray addObject:commentModel];
    [tableView reloadData];
}

//自定义cell代理方法
-(void)didClickCellMoreComment:(UIButton *)moredButton With:(UITableViewCell *)cell{
    DemoCellModel *model = self.dataArray[cell.sd_indexPath.row];
    model.isMore = !model.isMore;
    [self.tableView reloadData];
}

@end





