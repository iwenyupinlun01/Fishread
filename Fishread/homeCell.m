//
//  homeCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/3.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "homeCell.h"

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
}

#pragma mark - getters


-(UIImageView *)itemimg
{
    if(!_itemimg)
    {
        _itemimg = [[UIImageView alloc] init];
        _itemimg.backgroundColor = [UIColor orangeColor];
    }
    return _itemimg;
}



@end
