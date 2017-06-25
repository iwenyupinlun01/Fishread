//
//  democontentViewController.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/20.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "democontentViewController.h"
#import "DemoTableViewCell.h"
#import "DemoCellModel.h"
#import "DemoCommentModel.h"
#import <SDAutoLayout.h>
#import "DemoCommentView.h"
#import "quanzixiangqingCell0.h"
#import "dongtaixiangqingModel.h"
#define CellKey @"UITableViewCell"
#define cellkey2 @"quanzixiangqingCell0"
#import "IQKeyboardManager.h" 
#import "keyboardView.h"
#import "AppDelegate.h"
@interface democontentViewController () <DemoTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate,myviewVdelegate,UITextViewDelegate>
{
    int pn;
}

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *contentTableview;
@property (nonatomic,strong) NSMutableArray *headArray;
@property (nonatomic,strong) NSString *righttitleStr;
@property (nonatomic,strong) NSString *numstr;
@property (nonatomic,strong) NSString *fromkeyboard;
@property (nonatomic,strong) keyboardView *keyView;
@property (nonatomic,strong) UIView *bgview;

@property (nonatomic,strong) NSString *yonghuuid;
@property (nonatomic,strong) NSString *to_uid;
@property (nonatomic,strong) NSString *parent_id;

@property (nonatomic,strong) NSString *pid;
@end

@implementation democontentViewController
{
    BOOL _wasKeyboardManagerEnabled;
}

#pragma mark 懒加载
-(NSMutableArray *)dataArray{
    if (!_dataArray){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


-(NSMutableArray *)headArray
{
    if(!_headArray)
    {
        _headArray = [NSMutableArray new];
        
    }
    return _headArray;
}

-(UITableView *)contentTableview
{
    if(!_contentTableview)
    {
        _contentTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
        _contentTableview.dataSource = self;
        _contentTableview.delegate = self;
    }
    return _contentTableview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor wjColorFloat:@"333333"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor wjColorFloat:@"333333"]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";

    
    [self.view addSubview:self.contentTableview];
    self.contentTableview.tableFooterView = [UIView new];
    [self.contentTableview registerClass:[DemoTableViewCell class] forCellReuseIdentifier:CellKey];
    self.dataArray = [NSMutableArray array];
    [self addHeader];
    [self addFooter];
    [self.view addSubview:self.keyView];
    
    [self bgviewadd];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

#pragma mark - web

- (void)addHeader
{
    // 头部刷新控件
    self.contentTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    [self.contentTableview.mj_header beginRefreshing];
}

- (void)addFooter
{
    self.contentTableview.mj_footer = [MJRefreshBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshLoadMore)];
}

- (void)refreshAction {
    
    [self headerRefreshEndAction];
    
}

- (void)refreshLoadMore {
    
    [self footerRefreshEndAction];
}

-(void)headerRefreshEndAction
{
    pn = 1;
    [self.dataArray removeAllObjects];
    [self.headArray removeAllObjects];
    
    NSString *urlstr = [NSString stringWithFormat:dongtaixiangqing,[tokenstr tokenstrfrom],@"1",self.idstr];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        
        
        if ([[responseObject objectForKey:@"code"] intValue]==1) {
            
            NSDictionary *infodit = [responseObject objectForKey:@"info"];
            NSDictionary *avatardit = [infodit objectForKey:@"Avatar"];
            NSMutableArray *formatarray = [infodit objectForKey:@"ForumBookmark"];
            
            NSDictionary *Memberdit = [infodit objectForKey:@"Member"];
            dongtaixiangqingModel *model = [[dongtaixiangqingModel alloc] init];
            model.Avatarpathstr = [avatardit objectForKey:@"path"];
            
            
            self.yonghuuid = [infodit objectForKey:@"uid"];
            self.parent_id = [infodit objectForKey:@"object_id"];
   
            
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
            self.numstr = [NSString stringWithFormat:@"%@%@",model.reply_numstr,@"人评论"];
            [self.headArray addObject:model];
        
        }
        
        NSDictionary *infodit = [responseObject objectForKey:@"info"];
        NSArray *dataarr = [infodit objectForKey:@"allComment"];
        for (int i = 0; i<dataarr.count; i++) {
            NSDictionary *dit = [dataarr objectAtIndex:i];
            DemoCellModel *model = [[DemoCellModel alloc]init];
            model.name = [dit objectForKey:@"comment_name"];
            model.msgContent = [dit objectForKey:@"content"];
            model.iconName = [dit objectForKey:@"comment_icon"];
            model.timestr = [dit objectForKey:@"ctime"];
            model.support_numstr = [dit objectForKey:@"support_num"];
            model.idstr = [dit objectForKey:@"id"];
            model.commentArray = [NSMutableArray array];
            NSArray *comarr =[dit objectForKey:@"son_comment"];
            for (int j=0; j<comarr.count; j++) {
                DemoCommentModel *commentModel = [[DemoCommentModel alloc] init];
                NSDictionary *dict = [comarr objectAtIndex:j];
                commentModel.firstUserId = [dict objectForKey:@"uid"];
                commentModel.firstUserName = [dict objectForKey:@"comment_name"];
                commentModel.secondUserId = [dict objectForKey:@"to_uid"];
                commentModel.secondUserName = [dict objectForKey:@"to_comment_name"];
                commentModel.commentString = [dict objectForKey:@"content"];
                
                [model.commentArray addObject:commentModel];
            }
            
            [self.dataArray addObject:model];
        }
        [self.contentTableview reloadData];
        [self.contentTableview.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"请检查网络"];
        [self.contentTableview.mj_header endRefreshing];
    }];

}

-(void)footerRefreshEndAction
{
    pn++;
    NSString *pnstr = [NSString stringWithFormat:@"%d",pn];
    NSString *urlstr = [NSString stringWithFormat:dongtaixiangqing,[tokenstr tokenstrfrom],pnstr,self.idstr];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        
         if ([[responseObject objectForKey:@"code"] intValue]==1)
         {
             NSDictionary *infodit = [responseObject objectForKey:@"info"];
             NSArray *dataarr = [infodit objectForKey:@"allComment"];
             for (int i = 0; i<dataarr.count; i++) {
                 NSDictionary *dit = [dataarr objectAtIndex:i];
                 DemoCellModel *model = [[DemoCellModel alloc]init];
                 model.name = [dit objectForKey:@"comment_name"];
                 model.msgContent = [dit objectForKey:@"content"];
                 model.iconName = [dit objectForKey:@"comment_icon"];
                 model.timestr = [dit objectForKey:@"ctime"];
                 model.support_numstr = [dit objectForKey:@"support_num"];
                 model.idstr = [dit objectForKey:@"id"];
                 model.commentArray = [NSMutableArray array];
                 NSArray *comarr =[dit objectForKey:@"son_comment"];
                 
                 for (int j=0; j<comarr.count; j++) {
                     DemoCommentModel *commentModel = [[DemoCommentModel alloc] init];
                     NSDictionary *dict = [comarr objectAtIndex:j];
                     commentModel.firstUserId = [dict objectForKey:@"uid"];
                     commentModel.firstUserName = [dict objectForKey:@"comment_name"];
                     commentModel.secondUserId = [dict objectForKey:@"to_uid"];
                     commentModel.secondUserName = [dict objectForKey:@"to_comment_name"];
                     commentModel.commentString = [dict objectForKey:@"content"];
                     [model.commentArray addObject:commentModel];
                 }
                 
                 [self.dataArray addObject:model];
             }

         }
         else if ([[responseObject objectForKey:@"code"] intValue]==2200)
         {
             NSString *hudstr = [responseObject objectForKey:@"msg"];
             [MBProgressHUD showSuccess:hudstr];
         }
         else if ([[responseObject objectForKey:@"code"] intValue]==2201)
         {
             NSString *hudstr = [responseObject objectForKey:@"msg"];
             [MBProgressHUD showSuccess:hudstr];
         }
        [self.contentTableview reloadData];
        [self.contentTableview.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有更多了"];
        [self.contentTableview.mj_footer endRefreshing];
    }];

}


#pragma mark UITableViewDataSource&&UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        quanzixiangqingCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellkey2];
        cell = [[quanzixiangqingCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellkey2];
        [cell setdata:self.headArray[indexPath.row]];
        [cell.rightbtn addTarget:self action:@selector(alertshow) forControlEvents:UIControlEventTouchUpInside];
        [cell.zanBtn addTarget:self action:@selector(dianzanclick) forControlEvents:UIControlEventTouchUpInside];
        [cell.commentsBtn addTarget:self action:@selector(pinglinclick) forControlEvents:UIControlEventTouchUpInside];
        [cell.shareBtn addTarget:self action:@selector(shareclick) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shuquanxiangqingidentfid1"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shuquanxiangqingidentfid1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.numstr;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor wjColorFloat:@"333333"];
        return cell;

    }
    if (indexPath.section==2) {
        DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellKey];
        cell.sd_indexPath = indexPath;
        cell.model = self.dataArray[indexPath.row];
        cell.delegate = self;
        cell.commentView.delegate = self;
        return cell;
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.headArray.count;
    }
    if (section==1) {
        return 1;
    }
    if (section==2) {
        return self.dataArray.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        return [tableView cellHeightForIndexPath:indexPath
                            cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                       tableView:tableView];
    }
    if (indexPath.section==1) {
        return  42*HEIGHT_SCALE;
    }
    if (indexPath.section==2) {
        return [tableView cellHeightForIndexPath:indexPath
                            cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                       tableView:tableView];
        
    }
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        self.fromkeyboard = @"section";
        [self.keyView.textview becomeFirstResponder];
    }
}

//自定义cell代理方法
-(void)didClickCellMoreComment:(UIButton *)moredButton With:(UITableViewCell *)cell{
    DemoCellModel *model = self.dataArray[cell.sd_indexPath.row];
    model.isMore = !model.isMore;
    [self.contentTableview reloadData];
}

-(void)myTabVClick:(NSDictionary *)dic
{
    NSLog(@"duc==------%@",dic);
    self.fromkeyboard = @"cellpinglun";
    [self.keyView.textview becomeFirstResponder];
}

#pragma mark - 实现方法

-(void)rightAction
{
    NSLog(@"right");
}

-(void)dianzanclick
{
    NSLog(@"点赞");
    dongtaixiangqingModel *model = [self.headArray objectAtIndex:0];
    NSString *objid = model.idstr;
    NSString *urlstr = [NSString stringWithFormat:dianzan,[tokenstr tokenstrfrom],objid,@"1"];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        NSString *hud = [responseObject objectForKey:@"msg"];
        [MBProgressHUD showSuccess:hud];
        [self headerRefreshEndAction];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
}

-(void)pinglinclick
{
    NSLog(@"评论");
    self.fromkeyboard = @"1";
    [self.keyView.textview becomeFirstResponder];
}

-(void)shareclick
{
    NSLog(@"分享");
    
}

-(void)alertshow
{
    
    UIAlertController *control = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"alert0" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"alert1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"alert2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"alert3" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"alert4" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [control addAction:action0];
    [control addAction:action1];
    [control addAction:action2];
    [control addAction:action3];
    [control addAction:action4];
    [self presentViewController:control animated:YES completion:nil];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 回复点赞

-(void)myTabVClickdianzan:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.contentTableview indexPathForCell:cell];
    DemoCellModel *model = self.dataArray[index.row];
    NSString *idstr = model.idstr;
    NSString *urlstr = [NSString stringWithFormat:dianzan,[tokenstr tokenstrfrom],idstr,@"2"];
    [PPNetworkHelper GET:urlstr parameters:nil success:^(id responseObject) {
        NSString *hud = [responseObject objectForKey:@"msg"];
        [MBProgressHUD showSuccess:hud];
        [self headerRefreshEndAction];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
    
}

#pragma mark - 回复消息


-(keyboardView *)keyView
{
    if(!_keyView)
    {
        _keyView = [[keyboardView alloc] init];
        _keyView.frame = CGRectMake(0, DEVICE_HEIGHT-64, DEVICE_WIDTH, 64);
        //增加监听，当键盘出现或改变时收出消息
        _keyView.textview.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        
        
        
        _keyView.textview.delegate = self;
        [_keyView.sendbtn addTarget:self action:@selector(sendbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _keyView.backgroundColor = [UIColor whiteColor];
        _keyView.textview.backgroundColor = [UIColor whiteColor];
        _keyView.textview.customPlaceholder = @"写评论";
        _keyView.textview.customPlaceholderColor = [UIColor wjColorFloat:@"C7C7CD"];
    }
    return _keyView;
}

#pragma mark - 输入框方法


//当键盘出现或改变时调用

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.keyView.transform=CGAffineTransformMakeTranslation(0, -height);
        self.bgview.alpha = 0.6;
        self.bgview.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-44-14-height);
        self.bgview.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

//当键退出时调用

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.keyView.transform=CGAffineTransformIdentity;
        self.bgview.hidden = YES;
        self.bgview.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
        self.bgview.alpha = 1;
    } completion:^(BOOL finished) {
        
        self.keyView.textview.text=@"";
        _fromkeyboard = @"";
        _keyView.textview.customPlaceholder = @"写评论";
        
    }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length==0) {
        [self.keyView.sendbtn setTitleColor:[UIColor  wjColorFloat:@"C7C7CD"] forState:normal];
        
    }else
    {
        [self.keyView.sendbtn setTitleColor:[UIColor wjColorFloat:@"576b95"] forState:normal];
        
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //_keyView.textview.customPlaceholder = [NSString stringWithFormat:@"%@%@",@"评论@",self.namestr];
}

-(void)bgviewadd
{
    //添加屏幕的蒙罩
    self.bgview = [[UIView alloc]initWithFrame:self.view.frame];
    self.bgview.backgroundColor = [UIColor blackColor];
    self.bgview.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTapped:)];
    [self.bgview addGestureRecognizer:tap];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self.bgview];
    
}

-(void)backgroundTapped:(UIGestureRecognizer *)tgp
{
    [self.keyView.textview resignFirstResponder];
    NSLog(@"空白处");
}

#pragma mark - UITextViewDelegate

//将要结束/退出编辑模式

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"退出编辑模式");
    
    return YES;
}

//发送按钮

-(void)sendbtnclick
{
    if ([self isNullToString:self.keyView.textview.text])
    {
        [self.keyView.textview resignFirstResponder];
    }
    else
    {
        [self.keyView.textview resignFirstResponder];
        //三级评论
        if ([_fromkeyboard isEqualToString:@"cellpinglun"]) {
            
            if ([tokenstr tokenstrfrom].length!=0&&self.keyView.touidstr.length!=0&&self.idstr.length!=0&&self.keyView.pidstr.length!=0&&self.keyView.textview.text.length!=0) {
                
                NSDictionary *para = @{@"token":[tokenstr tokenstrfrom],@"to_uid":self.keyView.touidstr,@"object_id":self.idstr,@"content":self.keyView.textview.text,@"pid":self.keyView.pidstr};
                
                [PPNetworkHelper POST:pinglun parameters:para success:^(id responseObject) {
                    
                } failure:^(NSError *error) {
                    
                }];
            }
            
        }else if([_fromkeyboard isEqualToString:@"section"])
        {
            //二级评论
            
            DemoCellModel *fmodel  = self.dataArray[self.keyView.secindex];
            NSString *pidstr = fmodel.idstr;
            NSString *uidstr = fmodel.toidstr;
            
            
            if ([tokenstr tokenstrfrom].length!=0&&uidstr.length!=0&&self.idstr.length!=0&&pidstr.length!=0&&self.keyView.textview.text.length!=0) {
                
                //网络请求
                NSDictionary *para = @{@"token":[tokenstr tokenstrfrom],@"to_uid":uidstr,@"object_id":self.idstr,@"content":self.keyView.textview.text,@"pid":pidstr};
                
                [PPNetworkHelper POST:pinglun parameters:para success:^(id responseObject) {
                    
                } failure:^(NSError *error) {
                    
                }];
            }
            
        }
        else
        {
            //一级评论
            
            if ([tokenstr tokenstrfrom].length!=0&&self.idstr.length!=0&&self.keyView.textview.text.length!=0) {
                //网络请求
                NSDictionary *para = @{@"token":[tokenstr tokenstrfrom],@"parent_uid":self.yonghuuid,@"to_uid":self.yonghuuid,@"parent_id":self.parent_id,@"content":self.keyView.textview.text,@"post_id":self.idstr};
                
                [PPNetworkHelper POST:pinglun parameters:para success:^(id responseObject) {
                    NSString *hud = [responseObject objectForKey:@"msg"];
                    [MBProgressHUD showSuccess:hud];
                    [self headerRefreshEndAction];
                } failure:^(NSError *error) {
                    [MBProgressHUD showSuccess:@"没有网络"];
                }];
                
                
            }
        }
    }
}

#pragma mark - 判断字符串为空

- (BOOL )isNullToString:(id)string
{
    if ([string isEqual:@"NULL"] || [string isKindOfClass:[NSNull class]] || [string isEqual:[NSNull null]] || [string isEqual:NULL] || [[string class] isSubclassOfClass:[NSNull class]] || string == nil || string == NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0 || [string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])
    {
        return YES;
        
    }else
    {
        
        return NO;
    }
}


@end
