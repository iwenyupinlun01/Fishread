//
//  headView.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "headView.h"

@implementation headView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.namelab];
        [self addSubview:self.infoimg];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.namelab.frame = CGRectMake(0, 0, DEVICE_WIDTH, 44*HEIGHT_SCALE);
    self.infoimg.frame = CGRectMake(DEVICE_WIDTH/2-35*WIDTH_SCALE, 26*HEIGHT_SCALE+34*HEIGHT_SCALE, 70*WIDTH_SCALE, 70*WIDTH_SCALE);
}

#pragma mark - getters

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.textColor = [UIColor wjColorFloat:@"333333"];
        _namelab.textAlignment = NSTextAlignmentCenter;
        _namelab.text = @"呼啦圈";
        _namelab.font = [UIFont systemFontOfSize:18];
    }
    return _namelab;
}

-(UIImageView *)infoimg
{
    if(!_infoimg)
    {
        _infoimg = [[UIImageView alloc] init];
        _infoimg.backgroundColor = [UIColor orangeColor];
        _infoimg.layer.masksToBounds = YES;
        _infoimg.layer.cornerRadius = 35*WIDTH_SCALE;
        
    }
    return _infoimg;
}



@end
