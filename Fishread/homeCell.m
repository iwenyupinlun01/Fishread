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
        [self setuplayout];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.itemimg.frame = CGRectMake(0, 0, self.frame.size.width, 120*HEIGHT_SCALE);
    //self.namelab.frame = CGRectMake(0, 120*HEIGHT_SCALE, self.frame.size.width, 30);
}

-(void)setuplayout
{
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemimg.mas_bottom).with.offset(8*HEIGHT_SCALE);
        make.left.equalTo(self.itemimg.mas_left);
        make.right.equalTo(self.itemimg.mas_right);
    }];
}

#pragma mark - getters

-(itemimgView *)itemimg
{
    if(!_itemimg)
    {
        _itemimg = [[itemimgView alloc] init];
        //_itemimg.backgroundColor = [UIColor orangeColor];
        _itemimg.layer.masksToBounds = YES;
        _itemimg.layer.cornerRadius = 4;
        _itemimg.layer.borderWidth = 0.5;
        _itemimg.layer.borderColor = [UIColor wjColorFloat:@"E8E8E8"].CGColor;
    }
    return _itemimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        //_namelab.backgroundColor = [UIColor redColor];
        //_namelab.textAlignment = NSTextAlignmentCenter;
        _namelab.font = [UIFont systemFontOfSize:14];
        _namelab.numberOfLines = 0;
        _namelab.lineBreakMode = NSLineBreakByWordWrapping;
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
