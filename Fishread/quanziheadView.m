//
//  quanziheadView.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "quanziheadView.h"

@interface quanziheadView()

@end

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
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view2 = [[UIVisualEffectView alloc]initWithEffect:beffect];
    view2.frame = self.bgimg.frame;
    [self addSubview:view2];
    
    self.titlelab.frame = CGRectMake(75*WIDTH_SCALE, 60*HEIGHT_SCALE, DEVICE_WIDTH-150*WIDTH_SCALE, 50*HEIGHT_SCALE);
    self.typelab.frame = CGRectMake(20, 140*HEIGHT_SCALE, DEVICE_WIDTH-40, 30);
    self.typelab.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.titlelab];
    [self addSubview:self.typelab];
    
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

-(UILabel *)titlelab
{
    if(!_titlelab)
    {
        _titlelab = [[UILabel alloc] init];
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.textColor = [UIColor whiteColor];
        _titlelab.numberOfLines = 0;
        [_titlelab sizeToFit];
    }
    return _titlelab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        //_typelab.backgroundColor = [UIColor orangeColor];
        _typelab.textAlignment = NSTextAlignmentCenter;
        _typelab.font = [UIFont systemFontOfSize:12];
        _typelab.textColor = [UIColor whiteColor];
    }
    return _typelab;
}




@end
