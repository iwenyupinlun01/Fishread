//
//  quanbuCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "quanbuCell.h"
#import "quanbuModel.h"
#import "UILabel+MultipleLines.h"
@interface quanbuCell()
@property (nonatomic,strong) UIImageView *iconimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UILabel *bookname;
@property (nonatomic,strong) UIImageView *shenimg;

@property (nonatomic,strong) UIImageView *img0;
@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;
@property (nonatomic,strong) UIImageView *img3;
@property (nonatomic,strong) UIImageView *img4;

@property (nonatomic,strong) quanbuModel *qmodel;

@end

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
        [self.contentView addSubview:self.shenimg];
        
        [self.contentView addSubview:self.img0];
        [self.contentView addSubview:self.img1];
        [self.contentView addSubview:self.img2];
        [self.contentView addSubview:self.img3];
        [self.contentView addSubview:self.img4];
        
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

    [self.iconimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_equalTo(36*WIDTH_SCALE);
        make.height.mas_equalTo(36*WIDTH_SCALE);
    }];
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_equalTo(DEVICE_WIDTH/2-14*WIDTH_SCALE);
        //make.height.mas_equalTo(20);
    }];
    [self.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.self.iconimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.top.equalTo(weakSelf.namelab.mas_bottom).with.offset(5);
        make.width.mas_equalTo(50);
    }];
    
    [self.bookname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(16*HEIGHT_SCALE);
        make.width.mas_equalTo(DEVICE_WIDTH/2-14*WIDTH_SCALE);
    }];
    
    [self.shenimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconimg.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(26*WIDTH_SCALE);
        make.width.mas_equalTo(16*WIDTH_SCALE);
        make.height.mas_equalTo(16*WIDTH_SCALE);
        
    }];
    
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timelab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(64*WIDTH_SCALE);
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);

    }];
    
    [self.img0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf).with.offset(64*WIDTH_SCALE);
        make.height.mas_equalTo(57*WIDTH_SCALE);
        make.width.mas_equalTo(57*WIDTH_SCALE);
    }];
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.img0.mas_right).with.offset(3*WIDTH_SCALE);
        make.height.mas_equalTo(57*WIDTH_SCALE);
        make.width.mas_equalTo(57*WIDTH_SCALE);
    }];
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.img1.mas_right).with.offset(3*WIDTH_SCALE);
        make.height.mas_equalTo(57*WIDTH_SCALE);
        make.width.mas_equalTo(57*WIDTH_SCALE);
    }];
    [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.img2.mas_right).with.offset(3*WIDTH_SCALE);
        make.height.mas_equalTo(57*WIDTH_SCALE);
        make.width.mas_equalTo(57*WIDTH_SCALE);
    }];
    [self.img4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.img3.mas_right).with.offset(3*WIDTH_SCALE);
        make.height.mas_equalTo(57*WIDTH_SCALE);
        make.width.mas_equalTo(57*WIDTH_SCALE);
    }];
    
}

#pragma mark - getters

-(UIImageView *)iconimg
{
    if(!_iconimg)
    {
        _iconimg = [[UIImageView alloc] init];
        _iconimg.backgroundColor = [UIColor greenColor];
        _iconimg.layer.masksToBounds = YES;
        _iconimg.layer.cornerRadius = 18*WIDTH_SCALE;
        
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
        _bookname.textAlignment = NSTextAlignmentRight;
    }
    return _bookname;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.textColor = [UIColor wjColorFloat:@"C7C7CD"];
        _timelab.text = @"time";
        _timelab.font = [UIFont systemFontOfSize:12];
    }
    return _timelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.backgroundColor = [UIColor orangeColor];
        _contentlab.numberOfLines = 0;
        
        _contentlab.textColor = [UIColor wjColorFloat:@"333333"];
        [_contentlab sizeToFit];
    }
    return _contentlab;
}

-(UIImageView *)shenimg
{
    if(!_shenimg)
    {
        _shenimg = [[UIImageView alloc] init];
        _shenimg.image = [UIImage imageNamed:@"椭圆-22"];
    }
    return _shenimg;
}


-(UIImageView *)img0
{
    if(!_img0)
    {
        _img0 = [[UIImageView alloc] init];
        _img0.backgroundColor = [UIColor greenColor];
    }
    return _img0;
}


-(UIImageView *)img1
{
    if(!_img1)
    {
        _img1 = [[UIImageView alloc] init];
        _img1.backgroundColor = [UIColor redColor];
    }
    return _img1;
}


-(UIImageView *)img2
{
    if(!_img2)
    {
        _img2 = [[UIImageView alloc] init];
        _img2.backgroundColor = [UIColor lightGrayColor];
    }
    return _img2;
}

-(UIImageView *)img3
{
    if(!_img3)
    {
        _img3 = [[UIImageView alloc] init];
        _img3.backgroundColor = [UIColor orangeColor];
    }
    return _img3;
}

-(UIImageView *)img4
{
    if(!_img4)
    {
        _img4 = [[UIImageView alloc] init];
        _img4.backgroundColor = [UIColor redColor];
    }
    return _img4;
}

-(CGFloat )setdata:(quanbuModel *)model
{
    self.qmodel = model;
    self.namelab.text = model.nicknamestr;
    self.bookname.text = model.titlestr;
    self.contentlab.text = model.contentstr;
    [self.iconimg sd_setImageWithURL:[NSURL URLWithString:model.pathstr] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    self.contentlab.font = [UIFont systemFontOfSize:15];
    self.contentlab.numberOfLines = 0;
    self.contentlab.text = model.contentstr;
    self.contentlab.preferredMaxLayoutWidth = DEVICE_WIDTH-78*WIDTH_SCALE;
    [self.contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.contentlab.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    [self.contentlab setText:model.contentstr lines:0 andLineSpacing:5 constrainedToSize:CGSizeMake(DEVICE_WIDTH-78*WIDTH_SCALE, 0)];
    [self.contentlab sizeToFit];
    [self layoutIfNeeded];
    return self.contentlab.frame.size.height+180*HEIGHT_SCALE;
    
}


@end
