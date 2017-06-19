//
//  quanzixiangqingCell1.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "quanzixiangqingCell1.h"

@interface quanzixiangqingCell1()
@property (nonatomic,strong) UIImageView *headimg;
@property (nonatomic,strong) UILabel *nicknamelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *contentlab;
@end

@implementation quanzixiangqingCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.headimg];
        [self.contentView addSubview:self.nicknamelab];
        [self.contentView  addSubview:self.timelab];
        [self.contentView addSubview:self.contentlab];
        [self setuplayout];
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
        //make.height.mas_equalTo(20);
    }];
    
    [self.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.self.headimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.nicknamelab.mas_bottom).with.offset(5);
        make.width.mas_equalTo(250);
    }];
   
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timelab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(64*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        //make.height.mas_equalTo(60);
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
        //_timelab.text = @"time";
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





@end
