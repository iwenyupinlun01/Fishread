//
//  quanziheadView.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "quanziheadView.h"

@implementation quanziheadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgimg];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgimg.frame = CGRectMake(0, 0, DEVICE_WIDTH, 195*HEIGHT_SCALE);
}

#pragma mark - getters


-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        
    }
    return _bgimg;
}


@end
