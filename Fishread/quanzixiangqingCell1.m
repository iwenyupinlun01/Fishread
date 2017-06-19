//
//  quanzixiangqingCell1.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "quanzixiangqingCell1.h"
#import "dongtaixiangqingModel.h"
#import "dianzanBtn.h"

@interface quanzixiangqingCell1()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIImageView *headimg;
@property (nonatomic,strong) UILabel *nicknamelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) dianzanBtn *zanBtn;

@property (nonatomic,strong) UITableView *texttable;
@property (nonatomic,strong) NSMutableArray *dataarr;
@property (nonatomic,strong) dongtaixiangqingModel *dmodel;
@property (nonatomic,assign) UIEdgeInsets insets;

@property (nonatomic,strong) NSMutableArray *heiarrary;
@end

@implementation quanzixiangqingCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.dataarr = [NSMutableArray array];
        self.heiarrary = [NSMutableArray array];
        [self.contentView addSubview:self.headimg];
        [self.contentView addSubview:self.nicknamelab];
        [self.contentView  addSubview:self.timelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.zanBtn];
        [self.contentView addSubview:self.texttable];
        [self setuplayout];
        self.insets = UIEdgeInsetsMake(0, DEVICE_WIDTH, 0, 0);
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.headimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_equalTo(36*WIDTH_SCALE);
        make.height.mas_equalTo(36*WIDTH_SCALE);
    }];
    [self.nicknamelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_equalTo(DEVICE_WIDTH/2-14*WIDTH_SCALE);

    }];
    
    [self.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.self.headimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.nicknamelab.mas_bottom).with.offset(5);
        make.width.mas_equalTo(250);
    }];
    [self.zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.self.headimg.mas_top);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
    
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timelab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(64*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);

    }];
    
    [self.texttable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentlab.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
    }];
    
}

#pragma mark - getters

-(UIImageView *)headimg
{
    if(!_headimg)
    {
        _headimg = [[UIImageView alloc] init];
        _headimg.backgroundColor = [UIColor greenColor];
        _headimg.layer.masksToBounds = YES;
        _headimg.layer.cornerRadius = 18*WIDTH_SCALE;
    }
    return _headimg;
}

-(UILabel *)nicknamelab
{
    if(!_nicknamelab)
    {
        _nicknamelab = [[UILabel alloc] init];
        _nicknamelab.textColor = [UIColor wjColorFloat:@"455F8E"];
        _nicknamelab.font = [UIFont systemFontOfSize:14];
    }
    return _nicknamelab;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.textColor = [UIColor wjColorFloat:@"C7C7CD"];
        _timelab.font = [UIFont systemFontOfSize:12];
    }
    return _timelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.numberOfLines = 0;
    }
    return _contentlab;
}

-(dianzanBtn *)zanBtn
{
    if(!_zanBtn)
    {
        _zanBtn = [[dianzanBtn alloc] init];
 
        _zanBtn.zanimg.image =  [UIImage imageNamed:@"点赞-拷贝"];
    }
    return _zanBtn;
}

-(UITableView *)texttable
{
    if(!_texttable)
    {
        _texttable = [[UITableView alloc] init];
        _texttable.dataSource = self;
        _texttable.delegate = self;
        _texttable.scrollEnabled = NO;
        
    }
    return _texttable;
}

-(CGFloat )setdata:(dongtaixiangqingModel *)model
{
    CGFloat hei = 0.01f;
    self.dmodel = model;
    [self.headimg sd_setImageWithURL:[NSURL URLWithString:model.allCommentcomment_iconstr]];
    self.nicknamelab.text = model.comment_namestr;
    self.timelab.text = [Timestr datetime:model.create_timestr];
    
    self.contentlab.font = [UIFont systemFontOfSize:15];
    self.contentlab.text  = model.allCommentcontentstr;
    self.contentlab.preferredMaxLayoutWidth = DEVICE_WIDTH-78*WIDTH_SCALE;
    [self.contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.contentlab.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    [self.contentlab setText:model.contentstr lines:0 andLineSpacing:5 constrainedToSize:CGSizeMake(DEVICE_WIDTH-78*WIDTH_SCALE, 0)];
    [self.contentlab sizeToFit];
    
    
    self.zanBtn.zanlab.text = model.allCommentsupport_numstr;
    self.zanBtn.zanlab.textColor = [UIColor wjColorFloat:@"C7C7CD"];
    [self.zanBtn.zanlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.self.headimg.mas_top).with.offset(1*HEIGHT_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.height.mas_equalTo(20);
    }];
    
    [self.zanBtn.zanimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.self.headimg.mas_top);
        make.right.equalTo(self.zanBtn.zanlab.mas_left).with.offset(-4*WIDTH_SCALE);
        make.height.mas_equalTo(16*WIDTH_SCALE);
        make.width.mas_equalTo(16*WIDTH_SCALE);
    }];
    
    for (int i = 0; i<model.pinglunarr.count; i++) {
        NSDictionary *dit = [model.pinglunarr objectAtIndex:i];
        [self.dataarr addObject:dit];
        
      
      
    }
    
    [super layoutIfNeeded];
    
    hei = self.contentlab.frame.size.height+28*HEIGHT_SCALE+self.texttable.frame.size.height+30*HEIGHT_SCALE+28*HEIGHT_SCALE;
    [self.texttable reloadData];
    return hei;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic = [self.dataarr objectAtIndex:indexPath.row];
    NSString *str1 = [dic objectForKey:@"comment_name"];
    NSString *str2 = @"回复";
    NSString *str3 = [dic objectForKey:@"to_comment_name"];
    NSString *str4 = [NSString stringWithFormat:@"%@%@",@":",[dic objectForKey:@"content"]];
    
    NSString *str = [NSString stringWithFormat:@"%@%@%@%@",str1,str2,str3,str4];
    
    CGSize textsize= [str boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-64*WIDTH_SCALE-14*WIDTH_SCALE, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    NSString *hei = [NSString stringWithFormat:@"%f",textsize.height];
    
    [self.heiarrary addObject:hei];
    
    [self.texttable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((textsize.height+16)*self.dataarr.count);
    }];
    
    NSLog(@"heiarr-------%@",self.heiarrary);
    return textsize.height+16;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    secondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondidentfid"];
    cell = [[secondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secondidentfid"];
    NSDictionary *dic = [self.dataarr objectAtIndex:indexPath.row];
    cell.pinglunlab.font = [UIFont systemFontOfSize:14];
    cell.pinglunlab.numberOfLines = 0;
    
    
    NSString *str1 = [dic objectForKey:@"comment_name"];
    NSString *str2 = @"回复";
    NSString *str3 = [dic objectForKey:@"to_comment_name"];
    NSString *str4 = [NSString stringWithFormat:@"%@%@",@":",[dic objectForKey:@"content"]];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@",str1,str2,str3,str4]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"576b95"] range:NSMakeRange(0,str1.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"333333"] range:NSMakeRange(str1.length,str2.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"576b95"] range:NSMakeRange(str1.length+str2.length,str3.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"333333"] range:NSMakeRange(str1.length+str2.length+str3.length,str4.length)];
    NSLog(@"str===============%@",str);
    cell.pinglunlab.attributedText = str;
    cell.pinglunlab.lineBreakMode = NSLineBreakByCharWrapping;
    cell.pinglunlab.preferredMaxLayoutWidth = (DEVICE_WIDTH-64*WIDTH_SCALE-14*WIDTH_SCALE);
    [cell.pinglunlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [cell.pinglunlab sizeToFit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark 用于将cell分割线补全

-(void)viewDidLayoutSubviews {
    if ([self.texttable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.texttable setSeparatorInset:self.insets];
    }
    if ([self.texttable respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.texttable setLayoutMargins:self.insets];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:self.insets];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:self.insets];
    }
}
@end
