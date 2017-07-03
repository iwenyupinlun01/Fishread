//
//  itemimgView.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "itemimgView.h"

@implementation itemimgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.rightimg];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.rightimg.frame = CGRectMake(self.frame.size.width/2+10, 0, self.frame.size.width/2-10, self.frame.size.width/2-10);
}

#pragma mark - getters


-(UIImageView *)rightimg
{
    if(!_rightimg)
    {
        _rightimg = [[UIImageView alloc] init];
       //_rightimg.image = [UIImage imageNamed:@"阅读-拷贝-2"];
    }
    return _rightimg;
}


@end
