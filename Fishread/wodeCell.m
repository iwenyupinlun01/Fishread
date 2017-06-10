//
//  wodeCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/2.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "wodeCell.h"
#import "wodeModel.h"

@interface wodeCell()
@property (nonatomic,strong) wodeModel *wmodel;

@end

@implementation wodeCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.textlab];
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.xiaohongdianlab];
        [self setuplayout];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.leftimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.height.mas_equalTo(134/2*HEIGHT_SCALE);
        make.width.mas_equalTo(50*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(14*HEIGHT_SCALE);
    }];

    
    CGSize size = [self.textlab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 18) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textlab.font} context:nil].size;

    [self.textlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftimg.mas_right).with.offset(16*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(38*HEIGHT_SCALE);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(size.width+2);
    }];
    
    [self.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.textlab).with.offset(16*WIDTH_SCALE+size.width);
        make.top.equalTo(weakSelf).with.offset(40*HEIGHT_SCALE);
        make.height.mas_equalTo(13);
        
    }];
    
    [self.xiaohongdianlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(DEVICE_WIDTH-35*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(45*HEIGHT_SCALE);
        make.height.mas_equalTo(6);
        make.width.mas_equalTo(6);
    }];
}

#pragma mark - getters

-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        _leftimg.backgroundColor = [UIColor greenColor];
    }
    return _leftimg;
}

-(UILabel *)textlab
{
    if(!_textlab)
    {
        _textlab = [[UILabel alloc] init];
        _textlab.font = [UIFont systemFontOfSize:18];
        _textlab.text = @"读书读书";
        _textlab.textColor = [UIColor wjColorFloat:@"333333"];
    }
    return _textlab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"圈子";
        _typelab.textColor = [UIColor wjColorFloat:@"54D48A"];
        _typelab.font = [UIFont systemFontOfSize:13];
    }
    return _typelab;
}

-(UILabel *)xiaohongdianlab
{
    if(!_xiaohongdianlab)
    {
        _xiaohongdianlab = [[UILabel alloc] init];
        _xiaohongdianlab.layer.masksToBounds = YES;
        _xiaohongdianlab.layer.cornerRadius = 3;
        _xiaohongdianlab.backgroundColor = [UIColor redColor];
    }
    return _xiaohongdianlab;
}

-(void)setdatamodel:(wodeModel*)model
{
    self.wmodel = model;
    [self.leftimg sd_setImageWithURL:[NSURL URLWithString:model.coverstr]];
    self.textlab.text = model.titlestr;
    if ([model.is_showstr isEqualToString:@"1"]) {
        [self.xiaohongdianlab setHidden:NO];
    }else
    {
        [self.xiaohongdianlab setHidden:YES];
    }
}

@end
