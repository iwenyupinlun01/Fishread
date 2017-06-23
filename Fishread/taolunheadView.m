//
//  taolunheadView.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/22.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "taolunheadView.h"

@interface taolunheadView()
@property (nonatomic,strong) UIImageView *beijin;
@property (nonatomic,strong) UIView *lineview0;
@property (nonatomic,strong) UIView *lineview1;
@end

@implementation taolunheadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self addSubview:self.bgimg];
        
        [self addSubview:self.lineview0];
        [self addSubview:self.lineview1];
        [self addSubview:self.zhangjielab];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    
}


#pragma mark - getters


-(UIImageView *)bgimg
{
    if(!_bgimg)
    {
        _bgimg = [[UIImageView alloc] init];
        //_bgimg.backgroundColor = [UIColor orangeColor];
    }
    return _bgimg;
}

-(UIImageView *)bookimg
{
    if(!_bookimg)
    {
        _bookimg = [[UIImageView alloc] init];
       // _bookimg.backgroundColor = [UIColor redColor];
    }
    return _bookimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.numberOfLines = 0;
        _namelab.lineBreakMode = NSLineBreakByWordWrapping;//换行模式，
        _namelab.textColor = [UIColor wjColorFloat:@"333333"];
        //_namelab.backgroundColor = [UIColor greenColor];
        _namelab.font = [UIFont systemFontOfSize:14];
        
        [_namelab sizeToFit];
    }
    return _namelab;
}

-(UILabel *)authorlab
{
    if(!_authorlab)
    {
        _authorlab = [[UILabel alloc] init];
        _authorlab.textColor = [UIColor wjColorFloat:@"333333"];
        _authorlab.font = [UIFont systemFontOfSize:13];
    }
    return _authorlab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textColor = [UIColor wjColorFloat:@"333333"];
        _typelab.font = [UIFont systemFontOfSize:13];
    }
    return _typelab;
}

-(UILabel *)numberlab
{
    if(!_numberlab)
    {
        _numberlab = [[UILabel alloc] init];
        _numberlab.textColor = [UIColor wjColorFloat:@"333333"];
        _numberlab.font = [UIFont systemFontOfSize:13];
    }
    return _numberlab;
}


-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.numberOfLines = 3;
    }
    return _contentlab;
}

-(UIButton *)btn01
{
    if(!_btn01)
    {
        _btn01 = [[UIButton alloc] init];
        [_btn01 setTitle:@"目录" forState:normal];
        [_btn01 setTitleColor:[UIColor wjColorFloat:@"0099cc"] forState:normal];
        _btn01.layer.masksToBounds = YES;
        _btn01.layer.borderWidth = 1;
        _btn01.layer.borderColor = [UIColor wjColorFloat:@"0099cc"].CGColor;
        _btn01.layer.cornerRadius = 20*HEIGHT_SCALE;
        
    }
    return _btn01;
}

-(UIButton *)btn02
{
    if(!_btn02)
    {
        _btn02 = [[UIButton alloc] init];
        [_btn02 setTitle:@"立即阅读" forState:normal];
        [_btn02 setTitleColor:[UIColor wjColorFloat:@"FB7085"] forState:normal];
        _btn02.layer.masksToBounds = YES;
        _btn02.layer.borderWidth = 1;
        _btn02.layer.borderColor = [UIColor wjColorFloat:@"FB7085"].CGColor;
        _btn02.layer.cornerRadius = 20*HEIGHT_SCALE;
    }
    return _btn02;
}

-(UIImageView *)beijin
{
    if(!_beijin)
    {
        _beijin = [[UIImageView alloc] init];
        _beijin.image = [UIImage imageNamed:@"背景-1"];
    }
    return _beijin;
}

-(UIView *)lineview0
{
    if(!_lineview0)
    {
        _lineview0 = [[UIView alloc] init];
        _lineview0.backgroundColor = [UIColor wjColorFloat:@"F4F5F6"];
    }
    return _lineview0;
}

-(UIView *)lineview1
{
    if(!_lineview1)
    {
        _lineview1 = [[UIView alloc] init];
        _lineview1.backgroundColor = [UIColor wjColorFloat:@"F4F5F6"];
    }
    return _lineview1;
}

-(UILabel *)zhangjielab
{
    if(!_zhangjielab)
    {
        _zhangjielab = [[UILabel alloc] init];
        _zhangjielab.textColor = [UIColor wjColorFloat:@"333333"];
        _zhangjielab.font = [UIFont systemFontOfSize:14];
    }
    return _zhangjielab;
}


-(void)setdata:(NSDictionary *)dit
{
    
    self.bgimg.frame = CGRectMake(0, 0, DEVICE_WIDTH, 378/2*HEIGHT_SCALE);
    self.beijin.frame = CGRectMake(0, 0, DEVICE_WIDTH, 378/2*HEIGHT_SCALE);
    NSString *bgimgstr = [dit objectForKey:@"background"];
    
    [self.bgimg sd_setImageWithURL:[NSURL URLWithString:bgimgstr]placeholderImage:[UIImage imageNamed:@"默认-拷贝"]];
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view2 = [[UIVisualEffectView alloc]initWithEffect:beffect];
    view2.frame = self.bgimg.frame;
    [self addSubview:self.bgimg];
    [self addSubview:view2];
    
    self.beijin.alpha = 0.8;
//    [self addSubview:self.beijin];
    
    
    
    [self.bookimg sd_setImageWithURL:[NSURL URLWithString:[dit objectForKey:@"pubPath"]] placeholderImage:[UIImage imageNamed:@"默认-拷贝"]];
    NSString *nametex = [dit objectForKey:@"pubTitle"];
    self.namelab.text = nametex;
    self.namelab.textColor = [UIColor wjColorFloat:@"333333"];
    self.namelab.preferredMaxLayoutWidth = DEVICE_WIDTH-28*WIDTH_SCALE-120*WIDTH_SCALE;
    [self.namelab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.namelab.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    self.bookimg.frame = CGRectMake(14*WIDTH_SCALE, 64*HEIGHT_SCALE, 85*WIDTH_SCALE, 120*HEIGHT_SCALE);
    
    
    [self addSubview:self.namelab];
    [self addSubview:self.bookimg];
    [self addSubview:self.authorlab];
    [self addSubview:self.typelab];
    [self addSubview:self.numberlab];
    [self addSubview:self.btn01];
    [self addSubview:self.btn02];
    [self addSubview:self.contentlab];
    
    
    
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(64*HEIGHT_SCALE);
        make.left.equalTo(self.bookimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        //make.height.mas_equalTo(25*HEIGHT_SCALE);
    }];
    self.authorlab.text = @"作者";
    [self.authorlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.namelab.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.left.equalTo(self.bookimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.height.mas_equalTo(13);
    }];
    self.typelab.text = @"leibie";
    [self.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorlab.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.left.equalTo(self.bookimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
    }];
    self.numberlab.text = @"num";
    [self.numberlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typelab.mas_bottom).with.offset(14*HEIGHT_SCALE);
        make.left.equalTo(self.bookimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
    }];
    
    [self.btn01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookimg.mas_bottom).with.offset(16*HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(14*WIDTH_SCALE);
        make.width.mas_equalTo(DEVICE_WIDTH/2-28*WIDTH_SCALE);
        make.height.mas_equalTo(40*HEIGHT_SCALE);
        
    }];
    [self.btn02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookimg.mas_bottom).with.offset(16*HEIGHT_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(DEVICE_WIDTH/2-28*WIDTH_SCALE);
        make.height.mas_equalTo(40*HEIGHT_SCALE);
    }];
    
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn01.mas_bottom).with.offset(16*HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        
    }];
    
    self.authorlab.text = [dit objectForKey:@"pubNickname"];
    self.contentlab.text = [dit objectForKey:@"pubContent"];
    self.typelab.text = [dit objectForKey:@"typeTitle"];
    
    self.numberlab.text = [NSString stringWithFormat:@"%@%@",[dit objectForKey:@"collecCount"],@"成员"];
    
    self.contentlab.font = [UIFont systemFontOfSize:13];
    self.contentlab.preferredMaxLayoutWidth = (DEVICE_WIDTH - 14.0 * 2);
    [self.contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.contentlab sizeToFit];
    CGFloat texth = self.contentlab.frame.size.height;
    NSLog(@"hei-------%f",texth);
    
    [self.lineview0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentlab.mas_bottom).with.offset(13*HEIGHT_SCALE);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(10*HEIGHT_SCALE);
    }];
    
    self.zhangjielab.text = @"涉及到了使用两个TabBar,然后我需要显示,涉及到了使用两个TabBar,然后我需要显示,涉及到了使用两个TabBar,然后我需要显示";
    
    [self.zhangjielab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineview0.mas_bottom).with.offset(2*HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
    
    [self.lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zhangjielab.mas_bottom).with.offset(2*HEIGHT_SCALE);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(10*HEIGHT_SCALE);
    }];
    
}


@end
