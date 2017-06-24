//
//  chuangjianCell2.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chuangjianCell2.h"


@interface chuangjianCell2()

@end

@implementation chuangjianCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.textView];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = CGRectMake(14*WIDTH_SCALE, 0, DEVICE_WIDTH-28*WIDTH_SCALE, 144*HEIGHT_SCALE);
}

#pragma mark - getters

-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] init];
        _textView.backgroundColor = [UIColor wjColorFloat:@"F5F5F5"];
        _textView.customPlaceholder = @"圈子介绍";
        _textView.customPlaceholderColor = [UIColor wjColorFloat:@"C7C7CD"];
    }
    return _textView;
}

@end
