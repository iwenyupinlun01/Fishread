//
//  mymessageCell1.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mymessageCell1.h"

@implementation mymessageCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.textLabel.textColor = [UIColor wjColorFloat:@"333333"];
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.redlab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.redlab.frame = CGRectMake(DEVICE_WIDTH-60, 20, 20, 20);
    self.typelab.frame =CGRectMake(110, 22*HEIGHT_SCALE, 30, 18*HEIGHT_SCALE);
}

#pragma mark - getters


-(UILabel *)redlab
{
    if(!_redlab)
    {
        _redlab = [[UILabel alloc] init];
        _redlab.textAlignment = NSTextAlignmentCenter;
        _redlab.backgroundColor = [UIColor redColor];
        _redlab.textColor = [UIColor whiteColor];
        _redlab.layer.masksToBounds = YES;
        _redlab.layer.cornerRadius = 10;
        [_redlab setHidden:YES];
    }
    return _redlab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.backgroundColor = [UIColor wjColorFloat:@"EF4572"];
        _typelab.textColor = [UIColor whiteColor];
        _typelab.text = @"官方";
        _typelab.textAlignment = NSTextAlignmentCenter;
        _typelab.font = [UIFont systemFontOfSize:13];
        _typelab.layer.masksToBounds = YES;
        _typelab.layer.cornerRadius = 3;
    }
    return _typelab;
}




@end
