//
//  searchheadView.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "searchheadView.h"

@interface searchheadView()
@property (nonatomic,strong) UILabel *leftlab;
@property (nonatomic,strong) UIButton *rightbtn;
@end

@implementation searchheadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftlab];
        [self addSubview:self.rightbtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.width.mas_equalTo(150*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
    }];
    
    [self.rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_equalTo(60*WIDTH_SCALE);
        make.height.mas_equalTo(14*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(DEVICE_WIDTH-60*WIDTH_SCALE-14*WIDTH_SCALE);
    }];
}

#pragma mark - getters

-(UILabel *)leftlab
{
    if(!_leftlab)
    {
        _leftlab = [[UILabel alloc] init];
        _leftlab.text = @"搜索历史";
        _leftlab.textColor = [UIColor wjColorFloat:@"999999"];
        
    }
    return _leftlab;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setTitle:@"清空" forState:normal];
        [_rightbtn setTitleColor:[UIColor wjColorFloat:@"54D48A"] forState:normal];
        //_replacebtn.backgroundColor =  [UIColor orangeColor];
        _rightbtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_rightbtn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
        _rightbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    }
    return _rightbtn;
}

-(void)btnclick
{
    [self.delegate myheadVClick:self];
}


@end
