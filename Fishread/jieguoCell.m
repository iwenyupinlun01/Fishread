//
//  jieguoCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "jieguoCell.h"
#import "jieguoModel.h"

@interface jieguoCell()
@property (nonatomic,strong) jieguoModel *jmodel;

@end

@implementation jieguoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.typelab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.leftimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(14*HEIGHT_SCALE);
        make.width.mas_equalTo(50*WIDTH_SCALE);
        make.height.mas_equalTo(134/2*HEIGHT_SCALE);
    }];
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftimg.mas_right).with.offset(16*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(81/2*HEIGHT_SCALE-9/2*HEIGHT_SCALE);
        make.width.mas_equalTo(200*WIDTH_SCALE);
        make.height.mas_equalTo(18*HEIGHT_SCALE);
    }];
    [self.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(DEVICE_WIDTH-14*WIDTH_SCALE-60*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(81/2*HEIGHT_SCALE-7.5/2*HEIGHT_SCALE);
        make.width.mas_equalTo(60*WIDTH_SCALE);
        make.height.mas_equalTo(13*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        //_leftimg.backgroundColor = [UIColor greenColor];
    }
    return _leftimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.font = [UIFont systemFontOfSize:18];
        _namelab.textColor = [UIColor wjColorFloat:@"333333"];
        _namelab.text = @"namename";
    }
    return _namelab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.font = [UIFont systemFontOfSize:13];
        //_typelab.backgroundColor = [UIColor greenColor];
        _typelab.textAlignment = NSTextAlignmentRight;
    }
    return _typelab;
}

-(void)setdata:(jieguoModel *)model
{
    self.jmodel = model;
    [self.leftimg sd_setImageWithURL:[NSURL URLWithString:model.leftimgstr] placeholderImage:[UIImage imageNamed:@"默认图"]];
    self.namelab.text = model.namestr;
//    if ([model.typestr isEqualToString:@"0"]) {
//        //讨论圈
//        self.typelab.text = @"讨论圈";
//        self.typelab.textColor = [UIColor wjColorFloat:@"FD8B3F"];
//    }
//    else
//    {
//        self.typelab.text = @"阅读圈";
//        self.typelab.textColor = [UIColor wjColorFloat:@"54D48A"];
//    }
}

@end
