//
//  publishCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "publishCell.h"
#import "publishModel.h"

@interface publishCell()
@property (nonatomic,strong) publishModel *pmodel;
@property (nonatomic,strong) UIImageView *img0;
@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;
@property (nonatomic,strong) UIImageView *img3;
@property (nonatomic,strong) UIImageView *img4;
@property (nonatomic,strong) UILabel *numlab;
@end

@implementation publishCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.typelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.img0];
        [self.contentView addSubview:self.img1];
        [self.contentView addSubview:self.img2];
        [self.contentView addSubview:self.img3];
        [self.contentView addSubview:self.img4];
        [self.contentView addSubview:self.numlab];
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
    
    [self.timelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(14*WIDTH_SCALE);
        make.height.mas_equalTo(40*HEIGHT_SCALE);
        make.width.mas_equalTo(50*WIDTH_SCALE);
        make.top.equalTo(self).with.offset(14*HEIGHT_SCALE);
    }];
    [self.contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timelab.mas_right).with.offset(14*WIDTH_SCALE);
//        make.height.mas_equalTo(40*HEIGHT_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(self).with.offset(14*HEIGHT_SCALE);
    }];
    
    [self.img0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.contentlab);
        make.height.mas_equalTo(52*WIDTH_SCALE);
        make.width.mas_equalTo(52*WIDTH_SCALE);
    }];
    [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.img0.mas_right).with.offset(3*WIDTH_SCALE);
        make.height.mas_equalTo(52*WIDTH_SCALE);
        make.width.mas_equalTo(52*WIDTH_SCALE);
    }];
    [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.img1.mas_right).with.offset(3*WIDTH_SCALE);
        make.height.mas_equalTo(52*WIDTH_SCALE);
        make.width.mas_equalTo(52*WIDTH_SCALE);
    }];
    [self.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.img2.mas_right).with.offset(3*WIDTH_SCALE);
        make.height.mas_equalTo(52*WIDTH_SCALE);
        make.width.mas_equalTo(52*WIDTH_SCALE);
    }];
    [self.img4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.img3.mas_right).with.offset(3*WIDTH_SCALE);
        make.height.mas_equalTo(52*WIDTH_SCALE);
        make.width.mas_equalTo(52*WIDTH_SCALE);
    }];
    [self.numlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentlab.mas_bottom).with.offset(12*HEIGHT_SCALE);
        make.left.equalTo(weakSelf.img3.mas_right).with.offset(3*WIDTH_SCALE);
        make.height.mas_equalTo(52*WIDTH_SCALE);
        make.width.mas_equalTo(52*WIDTH_SCALE);
    }];

}

#pragma mark - getters

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        //_timelab.backgroundColor = [UIColor greenColor];
        _timelab.textColor = [UIColor wjColorFloat:@"333333"];
    }
    return _timelab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textColor = [UIColor wjColorFloat:@"C7C7CD"];
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
-(UIImageView *)img0
{
    if(!_img0)
    {
        _img0 = [[UIImageView alloc] init];
        //_img0.backgroundColor = [UIColor greenColor];
    }
    return _img0;
}


-(UIImageView *)img1
{
    if(!_img1)
    {
        _img1 = [[UIImageView alloc] init];
        // _img1.backgroundColor = [UIColor redColor];
    }
    return _img1;
}


-(UIImageView *)img2
{
    if(!_img2)
    {
        _img2 = [[UIImageView alloc] init];
        // _img2.backgroundColor = [UIColor lightGrayColor];
    }
    return _img2;
}

-(UIImageView *)img3
{
    if(!_img3)
    {
        _img3 = [[UIImageView alloc] init];
        //_img3.backgroundColor = [UIColor orangeColor];
    }
    return _img3;
}

-(UIImageView *)img4
{
    if(!_img4)
    {
        _img4 = [[UIImageView alloc] init];
        //_img4.backgroundColor = [UIColor redColor];
    }
    return _img4;
}

-(UILabel *)numlab
{
    if(!_numlab)
    {
        _numlab = [[UILabel alloc]init];
        _numlab.alpha = 0.4;
        _numlab.textAlignment = NSTextAlignmentCenter;
        _numlab.font = [UIFont systemFontOfSize:22];
        //_numlab.backgroundColor = [UIColor redColor];
        _numlab.textColor = [UIColor whiteColor];
    }
    return _numlab;
}

-(CGFloat )setdata:(publishModel *)model
{
    self.pmodel = model;
    model.timestr = @"1498466705";
    NSString *time = model.timestr;
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MMdd日"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:dateString];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:21] range:NSMakeRange(0, 2)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(2, 3)];
    self.timelab.attributedText = str;
    
    self.contentlab.text = model.contentstr;
    self.contentlab.numberOfLines = 0;
    self.contentlab.textColor = [UIColor wjColorFloat:@"333333"];
    self.contentlab.font = [UIFont systemFontOfSize:14];
    self.contentlab.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    self.contentlab.preferredMaxLayoutWidth = (DEVICE_WIDTH - 14 * 3*WIDTH_SCALE-50*WIDTH_SCALE);
    [self.contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.contentlab setText:model.contentstr lines:0 andLineSpacing:5 constrainedToSize:CGSizeMake(DEVICE_WIDTH - 14 * 3*WIDTH_SCALE-50*WIDTH_SCALE, 0)];
    
    if (model.imgArray.count==0) {
        [self.img0 setHidden:YES];
        [self.img1 setHidden:YES];
        [self.img2 setHidden:YES];
        [self.img3 setHidden:YES];
        [self.img4 setHidden:YES];
        [self.numlab setHidden:YES];
    }
    if (model.imgArray.count==1) {
        [self.img1 setHidden:YES];
        [self.img2 setHidden:YES];
        [self.img3 setHidden:YES];
        [self.img4 setHidden:YES];
        [self.numlab setHidden:YES];
        NSString *imgstr = [model.imgArray objectAtIndex:0];
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:imgstr]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        
    }
    if (model.imgArray.count==2) {
        [self.img2 setHidden:YES];
        [self.img3 setHidden:YES];
        [self.img4 setHidden:YES];
        [self.numlab setHidden:YES];
        NSString *imgstr0 = [model.imgArray objectAtIndex:0];
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:imgstr0]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr1 = [model.imgArray objectAtIndex:1];
        [self.img1 sd_setImageWithURL:[NSURL URLWithString:imgstr1]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        
    }
    if (model.imgArray.count==3) {
        NSString *imgstr0 = [model.imgArray objectAtIndex:0];
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:imgstr0]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr1 = [model.imgArray objectAtIndex:1];
        [self.img1 sd_setImageWithURL:[NSURL URLWithString:imgstr1]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr2 = [model.imgArray objectAtIndex:2];
        [self.img2 sd_setImageWithURL:[NSURL URLWithString:imgstr2]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        [self.img3 setHidden:YES];
        [self.img4 setHidden:YES];
        [self.numlab setHidden:YES];
    }
    if (model.imgArray.count==4) {
        NSString *imgstr0 = [model.imgArray objectAtIndex:0];
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:imgstr0]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr1 = [model.imgArray objectAtIndex:1];
        [self.img1 sd_setImageWithURL:[NSURL URLWithString:imgstr1]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr2 = [model.imgArray objectAtIndex:2];
        [self.img2 sd_setImageWithURL:[NSURL URLWithString:imgstr2]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr3 = [model.imgArray objectAtIndex:3];
        [self.img3 sd_setImageWithURL:[NSURL URLWithString:imgstr3]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        [self.img4 setHidden:YES];
        [self.numlab setHidden:YES];
    }
    if (model.imgArray.count==5) {
        NSString *imgstr0 = [model.imgArray objectAtIndex:0];
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:imgstr0]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr1 = [model.imgArray objectAtIndex:1];
        [self.img1 sd_setImageWithURL:[NSURL URLWithString:imgstr1]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr2 = [model.imgArray objectAtIndex:2];
        [self.img2 sd_setImageWithURL:[NSURL URLWithString:imgstr2]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr3 = [model.imgArray objectAtIndex:3];
        [self.img3 sd_setImageWithURL:[NSURL URLWithString:imgstr3]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr4 = [model.imgArray objectAtIndex:4];
        [self.img4 sd_setImageWithURL:[NSURL URLWithString:imgstr4]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        
    }
    if (model.imgArray.count>5)
    {
        NSString *imgstr0 = [model.imgArray objectAtIndex:0];
        [self.img0 sd_setImageWithURL:[NSURL URLWithString:imgstr0]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr1 = [model.imgArray objectAtIndex:1];
        [self.img1 sd_setImageWithURL:[NSURL URLWithString:imgstr1]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr2 = [model.imgArray objectAtIndex:2];
        [self.img2 sd_setImageWithURL:[NSURL URLWithString:imgstr2]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr3 = [model.imgArray objectAtIndex:3];
        [self.img3 sd_setImageWithURL:[NSURL URLWithString:imgstr3]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *imgstr4 = [model.imgArray objectAtIndex:4];
        [self.img4 sd_setImageWithURL:[NSURL URLWithString:imgstr4]placeholderImage:[UIImage imageNamed:@"文鱼加载失败图"]];
        NSString *num = [NSString stringWithFormat:@"%lu",model.imgArray.count-5];
        self.numlab.text = [NSString stringWithFormat:@"%@%@",@"+",num];
    }
    CGFloat hei = 0.01f;
    if (model.imgArray.count==0) {
        [self.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentlab.mas_bottom).with.offset(14*HEIGHT_SCALE);
            make.left.equalTo(self.contentlab);
            make.width.mas_equalTo(152*WIDTH_SCALE);
        }];
        hei = self.contentlab.frame.size.height+40*HEIGHT_SCALE;
    }else
    {
        [self.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.img0.mas_bottom).with.offset(14*HEIGHT_SCALE);
            make.left.equalTo(self.contentlab);
            make.width.mas_equalTo(152*WIDTH_SCALE);

        }];
        hei = self.contentlab.frame.size.height+94*HEIGHT_SCALE;
    }
    [_contentlab sizeToFit];
   // self.typelab.text = model.titlestr;
    return hei;
}

@end
