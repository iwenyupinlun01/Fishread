//
//  chuangjianCell1.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chuangjianCell1.h"

@implementation chuangjianCell1


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.irregulatBtn = [[HLZIrregulatBtn alloc]initWithFrame:CGRectMake(14*WIDTH_SCALE, 0, DEVICE_WIDTH - 28*WIDTH_SCALE, DEVICE_HEIGHT)];
        [self addSubview:self.irregulatBtn];
        //数据源
    }
    return self;
}

@end
