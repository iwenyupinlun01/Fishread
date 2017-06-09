//
//  mymessageCell0.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "mymessageCell0.h"

@implementation mymessageCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //[self.contentView addSubview:self.redlab];
        self.textLabel.textColor = [UIColor wjColorFloat:@"333333"];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.redlab.frame = CGRectMake(DEVICE_WIDTH-60, 20, 20, 20);
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
        _redlab.text = @"12";
    }
    return _redlab;
}



@end
