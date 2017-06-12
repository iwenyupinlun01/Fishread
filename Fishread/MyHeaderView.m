//
//  MyHeaderView.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/3.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "MyHeaderView.h"

@implementation MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.searchtext];
    }
    return self;
}

-(UITextField *)searchtext
{
    if(!_searchtext)
    {
        _searchtext = [[UITextField alloc] initWithFrame:CGRectMake(14*WIDTH_SCALE, 10*HEIGHT_SCALE, DEVICE_WIDTH-28*WIDTH_SCALE, 31*HEIGHT_SCALE)];
        _searchtext.backgroundColor = [UIColor wjColorFloat:@"F5F5F5"];
        _searchtext.placeholder = @"搜索";
        _searchtext.layer.masksToBounds = YES;
        _searchtext.layer.cornerRadius = 15;
        UIImageView *passwordImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"放大镜"]];
        _searchtext.leftView = passwordImage;
        _searchtext.leftViewMode = UITextFieldViewModeAlways;
    }
    return _searchtext;
}

@end
