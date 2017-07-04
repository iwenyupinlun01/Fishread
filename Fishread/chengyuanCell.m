//
//  chengyuanCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/26.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chengyuanCell.h"
#import "FriendModel.h"
@interface chengyuanCell()
@property (nonatomic,strong) UIImageView *iconimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) FriendModel *fmodel;
@end

@implementation chengyuanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.iconimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.typelab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iconimg.frame = CGRectMake(14*WIDTH_SCALE, 10, 40, 40);
    self.namelab.frame = CGRectMake(60*WIDTH_SCALE, 10, 250*WIDTH_SCALE, 40);
    self.typelab.frame = CGRectMake(320*WIDTH_SCALE, 10, 40*WIDTH_SCALE, 40);
}

#pragma mark - getters

-(UIImageView *)iconimg
{
    if(!_iconimg)
    {
        _iconimg = [[UIImageView alloc] init];
        
    }
    return _iconimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        //_namelab.backgroundColor = [UIColor greenColor];
    }
    return _namelab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.text = @"群主";
        [_typelab setHidden:YES];
        _typelab.font = [UIFont systemFontOfSize:12];
    }
    return _typelab;
}

-(void)setdata:(FriendModel *)model
{
    self.fmodel = model;
    [self.iconimg sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"默认-拷贝-1"]];
    self.namelab.text = model.nameStr;
    if ([model.uidstr isEqualToString:[tokenstr tokenstrfrom]]) {
        [self.typelab setHidden:NO];
    }else
    {
        [self.typelab setHidden:YES];
    }
}


@end
