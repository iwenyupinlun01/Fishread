//
//  chuangjianCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chuangjianCell.h"
#import "quanzileibieModel.h"
@interface chuangjianCell()
@property (nonatomic,strong) UILabel *xuanzelab;
@property (nonatomic,strong) NSArray *btnArray;
@property (nonatomic,strong) quanzileibieModel *qmodel;
@end

@implementation chuangjianCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.chuangjianView];
        [self.contentView addSubview:self.chuangjianText];
        [self.contentView addSubview:self.xuanzelab];
       // self.irregulatBtn = [[HLZIrregulatBtn alloc]initWithFrame:CGRectMake(14*WIDTH_SCALE, 150, DEVICE_WIDTH - 28*WIDTH_SCALE, DEVICE_HEIGHT)];
        [self addSubview:self.irregulatBtn];
        //数据源
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
    [self.chuangjianView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(135*WIDTH_SCALE, 135*WIDTH_SCALE));
        make.top.equalTo(self).with.offset(58/2);
        make.left.equalTo(self).with.offset(DEVICE_WIDTH/2-135/2*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-(DEVICE_WIDTH/2-135/2*WIDTH_SCALE));
        
    }];
    
    [self.chuangjianText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chuangjianView.mas_bottom).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(452/2*WIDTH_SCALE, 36));
        make.left.equalTo(self).with.offset(DEVICE_WIDTH/2-452/4*WIDTH_SCALE);
    }];
    [self.xuanzelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chuangjianText.mas_bottom).with.offset(36);
        make.left.equalTo(self).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH, 36));
    }];
    
}

#pragma mark - getters

-(UIImageView *)chuangjianView
{
    if(!_chuangjianView)
    {
        _chuangjianView = [[UIImageView alloc] init];
        _chuangjianView.layer.masksToBounds = YES;
        _chuangjianView.layer.cornerRadius = 4;
        //_chuangjianView.image = [UIImage imageNamed:@"默认-拷贝"];
        _chuangjianView.userInteractionEnabled = YES;
        UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgclick)];
        TapGestureTecognizer.cancelsTouchesInView=NO;
        [_chuangjianView addGestureRecognizer:TapGestureTecognizer];
    }
    return _chuangjianView;
}

-(UITextField *)chuangjianText
{
    if(!_chuangjianText)
    {
        _chuangjianText = [[UITextField alloc] init];
        _chuangjianText.layer.masksToBounds = YES;
        _chuangjianText.layer.cornerRadius = 18 ;
        _chuangjianText.layer.borderWidth = 1;
        _chuangjianText.textAlignment = NSTextAlignmentCenter;
        _chuangjianText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _chuangjianText.tintColor = [UIColor wjColorFloat:@"333333"];
        _chuangjianText.layer.borderColor = [UIColor wjColorFloat:@"C7C7CD"].CGColor;
        _chuangjianText.placeholder = @"圈子名称";
        UILabel * placeholderLabel = [_chuangjianText valueForKey:@"_placeholderLabel"];
        placeholderLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _chuangjianText;
}

-(UILabel *)xuanzelab
{
    if(!_xuanzelab)
    {
        _xuanzelab = [[UILabel alloc] init];
        _xuanzelab.text = @" 选择类型 （必选）";
        _xuanzelab.textAlignment = NSTextAlignmentCenter;
        _xuanzelab.textColor = [UIColor wjColorFloat:@"333333"];
        
    }
    return _xuanzelab;
}

-(void)imgclick
{
    [self.delegate myTabVClick:self];
}

@end
