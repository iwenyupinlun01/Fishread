//
//  homeCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/3.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "homeCell.h"
#import "homeModel.h"

@interface homeCell()
@property (nonatomic,strong) homeModel *hmodel;
@end

@implementation homeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.itemimg];
        [self.contentView addSubview:self.namelab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.itemimg.frame = CGRectMake(0, 0, self.frame.size.width, 140);
    self.namelab.frame = CGRectMake(0, 140, self.frame.size.width, 30);
}

#pragma mark - getters

-(itemimgView *)itemimg
{
    if(!_itemimg)
    {
        _itemimg = [[itemimgView alloc] init];
        //_itemimg.backgroundColor = [UIColor orangeColor];
    }
    return _itemimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.textAlignment = NSTextAlignmentCenter;
        _namelab.font = [UIFont systemFontOfSize:12];
        _namelab.numberOfLines = 0;
        [_namelab sizeToFit];
        //_namelab.backgroundColor = [UIColor greenColor];
    }
    return _namelab;
}

-(void)setdatafrommodel:(homeModel *)model
{
    self.hmodel = model;
    [self.itemimg sd_setImageWithURL:[NSURL URLWithString:model.homecoverurlstr]];
    self.namelab.text = model.hometitlestr;
    if ([model.relation_id isEqualToString:@"0"]) {
        self.itemimg.rightimg.image = [UIImage imageNamed:@"讨论-拷贝-2"];
    }
    else
    {
        self.itemimg.rightimg.image = [UIImage imageNamed:@"阅读-拷贝-2"];
        
    }
}

@end
