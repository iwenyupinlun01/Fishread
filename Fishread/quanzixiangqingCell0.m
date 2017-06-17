//
//  quanzixiangqingCell0.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "quanzixiangqingCell0.h"
#import "dongtaixiangqingModel.h"

@interface quanzixiangqingCell0()
@property (nonatomic,strong) UIImageView *iconimg;
@property (nonatomic,strong) UILabel *nicknamelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UIButton *rightbtn;
@property (nonatomic,strong) UILabel *contentlab;

@property (nonatomic,strong) UIImageView *img0;
@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;
@property (nonatomic,strong) UIImageView *img3;
@property (nonatomic,strong) UIImageView *img4;
@property (nonatomic,strong) UIImageView *img5;
@property (nonatomic,strong) UIImageView *img6;
@property (nonatomic,strong) UIImageView *img7;
@property (nonatomic,strong) UIImageView *img8;

@property (nonatomic,strong) UIButton *zanBtn;
@property (nonatomic,strong) UIButton *commentsBtn;
@property (nonatomic,strong) UIButton *shareBtn;

@property (nonatomic,strong) UILabel *thumlabel;

@property (nonatomic,strong) dongtaixiangqingModel *dmodel;
@end

@implementation quanzixiangqingCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.iconimg];
        [self.contentView addSubview:self.nicknamelab];
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.rightbtn];
        [self.contentView addSubview:self.contentlab];
        
        [self.contentView addSubview:self.img0];
        [self.contentView addSubview:self.img1];
        [self.contentView addSubview:self.img2];
        [self.contentView addSubview:self.img3];
        [self.contentView addSubview:self.img4];
        [self.contentView addSubview:self.img5];
        [self.contentView addSubview:self.img6];
        [self.contentView addSubview:self.img7];
        [self.contentView addSubview:self.img8];
        
        [self.contentView addSubview:self.zanBtn];
        [self.contentView addSubview:self.commentsBtn];
        [self.contentView addSubview:self.shareBtn];
        
        [self.contentView addSubview:self.thumlabel];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.iconimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_equalTo(36*WIDTH_SCALE);
        make.height.mas_equalTo(36*WIDTH_SCALE);
    }];
    [self.nicknamelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_equalTo(DEVICE_WIDTH/2-14*WIDTH_SCALE);
        //make.height.mas_equalTo(20);
    }];
    
    [self.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.self.iconimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.nicknamelab.mas_bottom).with.offset(5);
        make.width.mas_equalTo(250);
    }];
    [self.rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(20*HEIGHT_SCALE);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(10);
        
    }];
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timelab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(64*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_equalTo(60);
    }];
    
    [self.img0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(64*WIDTH_SCALE);
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.height.mas_equalTo(75*WIDTH_SCALE);
        make.width.mas_equalTo(75*WIDTH_SCALE);
    }];
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.img0.mas_right).with.offset(4*WIDTH_SCALE);
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.height.mas_equalTo(75*WIDTH_SCALE);
        make.width.mas_equalTo(75*WIDTH_SCALE);
    }];
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.img1.mas_right).with.offset(4*WIDTH_SCALE);
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.height.mas_equalTo(75*WIDTH_SCALE);
        make.width.mas_equalTo(75*WIDTH_SCALE);
    }];
    
    [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(64*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img0.mas_bottom).with.offset(4*HEIGHT_SCALE);
        make.height.mas_equalTo(75*WIDTH_SCALE);
        make.width.mas_equalTo(75*WIDTH_SCALE);
    }];
    
    [self.img4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.img3.mas_right).with.offset(4*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img0.mas_bottom).with.offset(4*HEIGHT_SCALE);
        make.height.mas_equalTo(75*WIDTH_SCALE);
        make.width.mas_equalTo(75*WIDTH_SCALE);
    }];
    
    [self.img5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.img4.mas_right).with.offset(4*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img0.mas_bottom).with.offset(4*HEIGHT_SCALE);
        make.height.mas_equalTo(75*WIDTH_SCALE);
        make.width.mas_equalTo(75*WIDTH_SCALE);
    }];
    
    [self.img6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(64*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img3.mas_bottom).with.offset(4*HEIGHT_SCALE);
        make.height.mas_equalTo(75*WIDTH_SCALE);
        make.width.mas_equalTo(75*WIDTH_SCALE);
    }];

    [self.img7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.img6.mas_right).with.offset(4*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img3.mas_bottom).with.offset(4*HEIGHT_SCALE);
        make.height.mas_equalTo(75*WIDTH_SCALE);
        make.width.mas_equalTo(75*WIDTH_SCALE);
    }];
    [self.img8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.img7.mas_right).with.offset(4*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img3.mas_bottom).with.offset(4*HEIGHT_SCALE);
        make.height.mas_equalTo(75*WIDTH_SCALE);
        make.width.mas_equalTo(75*WIDTH_SCALE);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.img7.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.height.mas_equalTo(24*WIDTH_SCALE);
        make.width.mas_equalTo(24*WIDTH_SCALE);
    }];
    
    [self.zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.shareBtn.mas_left).with.offset(-30*WIDTH_SCALE);
        make.top.equalTo(weakSelf.shareBtn.mas_top);
        make.height.mas_equalTo(24*WIDTH_SCALE);
        make.width.mas_equalTo(24*WIDTH_SCALE);
    }];
    
    [self.commentsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.zanBtn.mas_left).with.offset(-30*WIDTH_SCALE);
        make.top.equalTo(weakSelf.shareBtn.mas_top);
        make.height.mas_equalTo(24*WIDTH_SCALE);
        make.width.mas_equalTo(24*WIDTH_SCALE);
    }];
    
    [self.thumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(64*WIDTH_SCALE);
        make.top.equalTo(weakSelf.shareBtn.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.height.mas_equalTo(24*WIDTH_SCALE);
    }];
    
}

#pragma mark - getters

-(UIImageView *)iconimg
{
    if(!_iconimg)
    {
        _iconimg = [[UIImageView alloc] init];
        _iconimg.backgroundColor = [UIColor greenColor];
        _iconimg.layer.masksToBounds = YES;
        _iconimg.layer.cornerRadius = 18*WIDTH_SCALE;
    }
    return _iconimg;
}

-(UILabel *)nicknamelab
{
    if(!_nicknamelab)
    {
        _nicknamelab = [[UILabel alloc] init];
        _nicknamelab.text = @"姓名姓名";
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
        _timelab.text = @"time";
        _timelab.font = [UIFont systemFontOfSize:12];
    }
    return _timelab;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setImage:[UIImage imageNamed:@"展开"] forState:normal];
    }
    return _rightbtn;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.backgroundColor = [UIColor orangeColor];
        _contentlab.numberOfLines = 0;
    }
    return _contentlab;
}

-(UIImageView *)img0
{
    if(!_img0)
    {
        _img0 = [[UIImageView alloc] init];
        _img0.backgroundColor = [UIColor redColor];
    }
    return _img0;
}

-(UIImageView *)img1
{
    if(!_img1)
    {
        _img1 = [[UIImageView alloc] init];
        _img1.backgroundColor = [UIColor greenColor];
    }
    return _img1;
}
-(UIImageView *)img2
{
    if(!_img2)
    {
        _img2 = [[UIImageView alloc] init];
        _img2.backgroundColor = [UIColor grayColor];
    }
    return _img2;
}
-(UIImageView *)img3
{
    if(!_img3)
    {
        _img3 = [[UIImageView alloc] init];
        _img3.backgroundColor = [UIColor orangeColor];
    }
    return _img3;
}
-(UIImageView *)img4
{
    if(!_img4)
    {
        _img4 = [[UIImageView alloc] init];
        _img4.backgroundColor = [UIColor blueColor];
    }
    return _img4;
}
-(UIImageView *)img5
{
    if(!_img5)
    {
        _img5 = [[UIImageView alloc] init];
        _img5.backgroundColor = [UIColor redColor];
    }
    return _img5;
}
-(UIImageView *)img6
{
    if(!_img6)
    {
        _img6 = [[UIImageView alloc] init];
        _img6.backgroundColor = [UIColor lightGrayColor];
    }
    return _img6;
}
-(UIImageView *)img7
{
    if(!_img7)
    {
        _img7 = [[UIImageView alloc] init];
        _img7.backgroundColor = [UIColor greenColor];
    }
    return _img7;
}
-(UIImageView *)img8
{
    if(!_img8)
    {
        _img8 = [[UIImageView alloc] init];
        _img8.backgroundColor = [UIColor redColor];
    }
    return _img8;
}


-(UIButton *)zanBtn
{
    if(!_zanBtn)
    {
        _zanBtn = [[UIButton alloc] init];
        [_zanBtn setImage:[UIImage imageNamed:@"点赞-拷贝"] forState:normal];
    }
    return _zanBtn;
}

-(UIButton *)commentsBtn
{
    if(!_commentsBtn)
    {
        _commentsBtn = [[UIButton alloc] init];
        [_commentsBtn setImage:[UIImage imageNamed:@"评"] forState:normal];
    }
    return _commentsBtn;
}

-(UIButton *)shareBtn
{
    if(!_shareBtn)
    {
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setImage:[UIImage imageNamed:@"设置"] forState:normal];
    }
    return _shareBtn;
}

-(UILabel *)thumlabel
{
    if(!_thumlabel)
    {
        _thumlabel = [[UILabel alloc] init];
        _thumlabel.backgroundColor = [UIColor greenColor];
    }
    return _thumlabel;
}

-(void)setdata:(dongtaixiangqingModel *)model
{
    self.dmodel = model;
    [self.iconimg sd_setImageWithURL:[NSURL URLWithString:model.Avatarpathstr]];
    self.nicknamelab.text = model.ForumBookmarknicknamestr;
    self.nicknamelab.text = model.Membernickname;
    self.contentlab.text = model.contentstr;
    self.timelab.text = [Timestr datetime:model.create_timestr];
    
}

@end
