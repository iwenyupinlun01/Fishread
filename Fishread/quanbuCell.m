//
//  quanbuCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "quanbuCell.h"

@implementation quanbuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.iconimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.bookname];
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.contentlab];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - getters


-(UIImageView *)iconimg
{
    if(!_iconimg)
    {
        _iconimg = [[UIImageView alloc] init];
        _iconimg.backgroundColor = [UIColor greenColor];
        _iconimg.layer.masksToBounds = YES;
        _iconimg.layer.cornerRadius = 15;
        
    }
    return _iconimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.text = @"姓名姓名";
        _namelab.textColor = [UIColor wjColorFloat:@"455F8E"];
        _namelab.font = [UIFont systemFontOfSize:14];
    }
    return _namelab;
}

-(UILabel *)bookname
{
    if(!_bookname)
    {
        _bookname = [[UILabel alloc] init];
        _bookname.font = [UIFont systemFontOfSize:12];
        _bookname.text = @"书名书名书名";
        _bookname.textColor = [UIColor wjColorFloat:@"CDCDC7"];
    }
    return _bookname;
}


-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        
    }
    return _timelab;
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
