//
//  quanzixiangqingCell0.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "quanzixiangqingCell0.h"

@interface quanzixiangqingCell0()
@property (nonatomic,strong) UIImageView *iconimg;
@property (nonatomic,strong) UILabel *nicknamelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UIButton *rightbtn;
@property (nonatomic,strong) UILabel *contentlab;
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



@end
