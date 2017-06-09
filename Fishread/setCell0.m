//
//  setCell0.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "setCell0.h"

@implementation setCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.rightlab];
        self.textLabel.textColor = [UIColor wjColorFloat:@"333333"];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.rightlab.frame = CGRectMake(DEVICE_WIDTH-90*WIDTH_SCALE, 15*HEIGHT_SCALE, 60*WIDTH_SCALE, 30*HEIGHT_SCALE);

}

-(UILabel *)rightlab
{
    if(!_rightlab)
    {
        _rightlab = [[UILabel alloc] init];
        _rightlab.textColor = [UIColor wjColorFloat:@"999999"];
        _rightlab.textAlignment = NSTextAlignmentRight;
        _rightlab.font = [UIFont systemFontOfSize:14];
    }
    return _rightlab;
}



@end
