//
//  pinglunBtn.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "pinglunBtn.h"

@implementation pinglunBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor greenColor];
        [self addSubview:self.leftimg];
        [self addSubview:self.textlab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - getters

-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        _leftimg.image = [UIImage imageNamed:@"评"];
    }
    return _leftimg;
}

-(UILabel *)textlab
{
    if(!_textlab)
    {
        _textlab = [[UILabel alloc] init];
        _textlab.textColor = [UIColor wjColorFloat:@"C7C7CD"];
        _textlab.textAlignment = NSTextAlignmentRight;
        _textlab.font = [UIFont systemFontOfSize:13];
    }
    return _textlab;
}

@end
