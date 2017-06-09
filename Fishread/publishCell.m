//
//  publishCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "publishCell.h"

@implementation publishCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.contentlab];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - getters


-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        
    }
    return _timelab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        
    }
    return _typelab;
}


-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        
    }
    return _contentlab;
}




@end
