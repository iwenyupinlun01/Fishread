//
//  searchCell0.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "searchCell0.h"

@interface searchCell0()
@property (nonatomic,strong) UILabel *typelab;
@end

@implementation searchCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.replacebtn];
        
        self.tagview = [[searchtagView alloc]initWithFrame:CGRectMake(14*WIDTH_SCALE, 46*HEIGHT_SCALE, DEVICE_WIDTH - 28*WIDTH_SCALE, DEVICE_HEIGHT)];
        _tagview.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.tagview];
        
        [self setuplayout];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
   
}

-(void)setuplayout
{
     __weak typeof (self) weakSelf = self;
    [self.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.width.mas_equalTo(150*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
    }];
    
    [self.replacebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_equalTo(60*WIDTH_SCALE);
        make.height.mas_equalTo(14*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(DEVICE_WIDTH-60*WIDTH_SCALE-14*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textColor = [UIColor wjColorFloat:@"999999"];
        _typelab.font = [UIFont systemFontOfSize:14];
        _typelab.text = @"大家都在搜";
        
    }
    return _typelab;
}

-(UIButton *)replacebtn
{
    if(!_replacebtn)
    {
        _replacebtn = [[UIButton alloc] init];
        [_replacebtn setTitle:@"换一批" forState:normal];
        [_replacebtn setTitleColor:[UIColor wjColorFloat:@"54D48A"] forState:normal];
        //_replacebtn.backgroundColor =  [UIColor orangeColor];
        _replacebtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_replacebtn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
        _replacebtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _replacebtn;
}

#pragma mark - 实现方法

-(void)btnclick
{
    [self.delegate myTabVClick:self];
}

@end
