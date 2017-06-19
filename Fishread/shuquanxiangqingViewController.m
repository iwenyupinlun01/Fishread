//
//  shuquanxiangqingViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/15.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "shuquanxiangqingViewController.h"
#import "quanzixiangqingCell0.h"
#import "dongtaixiangqingModel.h"
#import "ImageEnlargeCell.h"
#import "quanzixiangqingCell1.h"
@interface shuquanxiangqingViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    int pn;

    NSArray *mImages;//车型图片
    NSInteger selectIndex;//选中的图片
    UIWindow *mWindow;

}
@property (nonatomic,strong) UITableView *xiangqingtableView;
@property (nonatomic,strong) NSDictionary *headdic;
@property (nonatomic,strong) NSMutableArray *datasourceArray;
@property (nonatomic,strong) NSString *righttitleStr;
@property (nonatomic,strong) NSString *numstr;
@property (nonatomic,strong) NSMutableArray *allCommentArr;


// 显示缩放视图
@property (nonatomic,strong) UICollectionView *collectionView ;
#pragma mark - 变量-------------------------------------------------------------
// 图片url地址的数组
@property (nonatomic,strong) NSArray *imageUrlArrays ;

#pragma mark - 视图-------------------------------------------------------------
// 第几张图片的文本
@property (nonatomic,strong) UILabel *label ;
@end

static NSString *shuquanxiangqingidentfid0 = @"shuquanxiangqingidentfid0";
static NSString *shuquanxiangqingidentfid1 = @"shuquanxiangqingidentfid1";
static NSString *shuquanxiangqingidentfid2 = @"shuquanxiangqingidentfid2";
@implementation shuquanxiangqingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //图片组
    mImages = @[@"http://resource.bdzcf.com/images/project/1231/list1459393259070.jpeg",
                @"http://img2.3lian.com/img2009/01/02/ebe.jpg08a114ef82febede.jpg"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";
    self.allCommentArr = [NSMutableArray array];
    [self.view addSubview:self.xiangqingtableView];
    [self addHeader];
    [self addFooter];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
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

- (void)addHeader
{
    // 头部刷新控件
    self.xiangqingtableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.xiangqingtableView.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.xiangqingtableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
}

- (void)refreshAction {
    
    [self headerRefreshEndAction];
    
}

- (void)refreshLoadMore {
    
    [self footerRefreshEndAction];
}


-(void)headerRefreshEndAction
{
    [self.datasourceArray removeAllObjects];
    [self.allCommentArr removeAllObjects];
    NSString *urlstr = [NSString stringWithFormat:dongtaixiangqing,[tokenstr tokenstrfrom],@"1",self.idstr];
    [PPNetworkHelper GET:urlstr parameters:nil responseCache:^(id responseCache) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
            NSDictionary *infodit = [responseObject objectForKey:@"info"];
            NSDictionary *avatardit = [infodit objectForKey:@"Avatar"];
            NSMutableArray *formatarray = [infodit objectForKey:@"ForumBookmark"];
        
            NSDictionary *Memberdit = [infodit objectForKey:@"Member"];
            dongtaixiangqingModel *model = [[dongtaixiangqingModel alloc] init];
            model.Avatarpathstr = [avatardit objectForKey:@"path"];
            
            
            if ((formatarray != nil && ![formatarray isKindOfClass:[NSNull class]] && formatarray.count !=0)){
                for (int i = 0; i<formatarray.count; i++) {
                    NSDictionary *dit = [formatarray objectAtIndex:i];
                    model.ForumBookmarknicknamestr = [dit objectForKey:@"nickname"];
                    model.ForumBookmarkuidstr = [dit objectForKey:@"uid"];
                    [model.ForumBookmarkArray addObject:model.ForumBookmarknicknamestr];
                }
            }
            
            model.Membernickname = [Memberdit objectForKey:@"nickname"];
            model.contentstr = [infodit objectForKey:@"content"];
            model.create_timestr = [infodit objectForKey:@"create_time"];
            model.idstr = [infodit objectForKey:@"id"];
            model.imagesArray = [infodit objectForKey:@"images"];
            model.titlestr = [infodit objectForKey:@"title"];
            
            self.righttitleStr = [NSString stringWithFormat:@"%@%@",@"来自",model.titlestr];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.righttitleStr style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
            self.navigationItem.rightBarButtonItem.tintColor = [UIColor wjColorFloat:@"576B95"];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
            
            model.object_idstr = [infodit objectForKey:@"object_id"];
            model.relation_idstr = [infodit objectForKey:@"relation_id"];
            model.reply_numstr = [infodit objectForKey:@"reply_num"];
            model.reward_numstr = [infodit objectForKey:@"reward_num"];
            model.support_numstr = [infodit objectForKey:@"support_num"];
            model.uidstr = [infodit objectForKey:@"uid"];
            model.is_bookmarkstr = [infodit objectForKey:@"is_bookmark"];
            
            [self.datasourceArray addObject:model];
            
            
            NSArray *commentarr = [infodit objectForKey:@"allComment"];
            self.numstr = [NSString stringWithFormat:@"%@%@",model.reply_numstr,@"人评论"];
            for (int i = 0; i<commentarr.count; i++) {
                model = [[dongtaixiangqingModel alloc] init];
                NSDictionary *dit = [commentarr objectAtIndex:i];
                model.allCommentidstr = [dit objectForKey:@"id"];
                model.allCommentcontentstr  = [dit objectForKey:@"content"];
                model.allCommentto_reply_idstr = [dit objectForKey:@"to_reply_id"];
                model.allCommentuidstr = [dit objectForKey:@"uid"];
                model.allCommentto_uidstr = [dit objectForKey:@"to_uid"];
                model.allCommentcomment_iconstr = [dit objectForKey:@"comment_icon"];
                model.comment_namestr = [dit objectForKey:@"comment_name"];
                model.allCommentsupport_numstr = [dit objectForKey:@"support_num"];
                
                
                model.pinglunarr = [dit objectForKey:@"son_comment"];
                [self.allCommentArr addObject:model];
            }
            
            
            [self.xiangqingtableView reloadData];
            [self.xiangqingtableView.mj_header endRefreshing];
            
        }
        
    } failure:^(NSError *error) {
        [self.xiangqingtableView.mj_header endRefreshing];
    }];
}

-(void)footerRefreshEndAction
{
    
}

#pragma mark - getters

-(UITableView *)xiangqingtableView
{
    if(!_xiangqingtableView)
    {
        _xiangqingtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _xiangqingtableView.dataSource = self;
        _xiangqingtableView.delegate = self;
    }
    return _xiangqingtableView;
}


-(NSDictionary *)headdic
{
    if(!_headdic)
    {
        _headdic = [NSDictionary dictionary];
        
    }
    return _headdic;
}

-(NSMutableArray *)datasourceArray
{
    if(!_datasourceArray)
    {
        _datasourceArray = [NSMutableArray array];
        
    }
    return _datasourceArray;
}


#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.datasourceArray.count;
    }
    if (section==1) {
        return 1;
    }
    if (section==2) {
        return self.allCommentArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        quanzixiangqingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:shuquanxiangqingidentfid0];
        cell = [[quanzixiangqingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shuquanxiangqingidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.datasourceArray[indexPath.row]];
        return cell;
    }
    if (indexPath.section==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shuquanxiangqingidentfid1];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shuquanxiangqingidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.numstr;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor wjColorFloat:@"333333"];
        return cell;
    }
    if (indexPath.section==2) {
        quanzixiangqingCell1 *cell = [tableView dequeueReusableCellWithIdentifier:shuquanxiangqingidentfid2];
        cell = [[quanzixiangqingCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shuquanxiangqingidentfid2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.allCommentArr[indexPath.row]];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        quanzixiangqingCell0 *cell = [[quanzixiangqingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shuquanxiangqingidentfid0];
        CGFloat hei = [cell setdata:self.datasourceArray[indexPath.row]];
        return hei;
    }
    if (indexPath.section==1) {
        return 42*HEIGHT_SCALE;
    }
    if (indexPath.section==2) {
        quanzixiangqingCell1 *cell = [[quanzixiangqingCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shuquanxiangqingidentfid2];
        CGFloat hei = [cell setdata:self.allCommentArr[indexPath.row]];
        return hei;
    }
    return 0.01f;
}

#pragma mark - 实现方法

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction
{
    NSLog(@"right");
}


/***
 ***
 UICollectionView  delegate
 ***
 ***
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionView) {
        return self.imageUrlArrays.count;
    }
    return mImages.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        static NSString *cellID = @"cellID" ;
        ImageEnlargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath] ;
        // 传数据
        cell.imageUrlString = self.imageUrlArrays[indexPath.row] ;
        // 刷新视图
        [cell setNeedsLayout] ;
        return cell ;
    }
    static NSString *cellID = @"myCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    if (mImages.count > 0) {
        UIImageView *mImageView = [[UIImageView alloc] initWithFrame:cell.bounds];
        mImageView.backgroundColor = [UIColor clearColor];
        mImageView.contentMode = UIViewContentModeScaleAspectFit;
        [mImageView sd_setImageWithURL:[NSURL URLWithString:mImages[indexPath.row]]];
        [cell.contentView addSubview:mImageView];
    }
    
    
    return cell;
}
#pragma mark ---- UICollectionViewDelegateFlowLayout
//配置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        return CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT);
    }
    return CGSizeMake((DEVICE_WIDTH-40)/3, (DEVICE_HEIGHT-40)/5);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.collectionView) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectIndex = indexPath.row;
    [self createWindowForBigPicture];
}
#pragma mark - UICollectionView 继承父类的方法------------------------------------
// 减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    NSLog(@"停止减速，滑动视图停止了");
    
    // 视图停止滑动的时候执行一些操作
    int pageIndex = (int)self.collectionView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;
    self.label.text = [NSString stringWithFormat:@"%d/%lu",pageIndex+1,(unsigned long)self.imageUrlArrays.count] ;
    NSLog(@"====%f====%f====%d",self.collectionView.contentOffset.x,[UIScreen mainScreen].bounds.size.width ,pageIndex);
    
}
#pragma mark - Show Big Picture
- (void)createWindowForBigPicture
{
    self.imageUrlArrays = mImages;
    mWindow = [UIApplication sharedApplication].keyWindow;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init] ;
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
    flowLayout.minimumInteritemSpacing = 0 ;
    flowLayout.minimumLineSpacing = 0;
    
    // 设置方法
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout] ;
    self.collectionView.backgroundColor = [UIColor blackColor] ;
    self.collectionView.delegate = self ;
    self.collectionView.dataSource = self ;
    self.collectionView.pagingEnabled = YES ;
    self.collectionView.contentOffset = CGPointMake(([UIScreen mainScreen].bounds.size.width)*selectIndex, [UIScreen mainScreen].bounds.size.height);
    self.collectionView.showsHorizontalScrollIndicator = NO ;
    [self.collectionView registerClass:[ImageEnlargeCell class] forCellWithReuseIdentifier:@"cellID"] ;
    [mWindow addSubview:self.collectionView] ;
    
    
    // 创建下面页数显示的文本
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(100, [UIScreen mainScreen].bounds.size.height-60, [UIScreen mainScreen].bounds.size.width-200, 20)] ;
    self.label.textAlignment = NSTextAlignmentCenter ;
    self.label.textColor = [UIColor whiteColor] ;
    self.label.text = [NSString stringWithFormat:@"%ld/%lu",selectIndex+1,(unsigned long)self.imageUrlArrays.count] ;
    [mWindow addSubview:self.label] ;
    
    
    
    // 自定义返回按键button
    UIImage *image = [UIImage imageNamed:@"sitting_04@2x.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom] ;
    button.frame = CGRectMake(10, 20, 30, 30) ;
    [button setImage:image forState:UIControlStateNormal] ;
    [button addTarget:self action:@selector(returnButtonAction:) forControlEvents:UIControlEventTouchUpInside] ;
    [mWindow addSubview:button] ;
    
}
#pragma mark button等视图的点击事件-------------------------------------
- (void)returnButtonAction:(UIButton *)sender
{
    [self.collectionView removeFromSuperview];
    [self.label removeFromSuperview];
    [sender removeFromSuperview];
}


@end
