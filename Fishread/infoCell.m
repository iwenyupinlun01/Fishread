//
//  infoCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/1.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "infoCell.h"

@implementation infoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimg];
        [self.contentView addSubview:self.textlab];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftimg.frame = CGRectMake(14*WIDTH_SCALE, 20*HEIGHT_SCALE, 20*WIDTH_SCALE, 20*WIDTH_SCALE);
    self.textlab.frame = CGRectMake(96/2*WIDTH_SCALE, 20*HEIGHT_SCALE, 120*WIDTH_SCALE, 20*HEIGHT_SCALE);
}


#pragma mark - getters


-(UIImageView *)leftimg
{
    if(!_leftimg)
    {
        _leftimg = [[UIImageView alloc] init];
        
    }
    return _leftimg;
}


-(UILabel *)textlab
{
    if(!_textlab)
    {
        _textlab = [[UILabel alloc] init];
        _textlab.textColor = [UIColor wjColorFloat:@"333333"];
    }
    return _textlab;
}




@end
