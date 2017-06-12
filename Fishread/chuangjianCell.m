//
//  chuangjianCell.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "chuangjianCell.h"
#import "HLZIrregulatBtn.h"

@interface chuangjianCell()
@property (nonatomic,strong) UILabel *xuanzelab;



@property (nonatomic,strong) HLZIrregulatBtn *irregulatBtn;
@property (nonatomic,strong) NSArray *btnArray;
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

        
        self.irregulatBtn = [[HLZIrregulatBtn alloc]initWithFrame:CGRectMake(14*WIDTH_SCALE, 150, DEVICE_WIDTH - 28*WIDTH_SCALE, DEVICE_HEIGHT)];

        [self addSubview:self.irregulatBtn];
        
        //数据源
        NSArray *listArray = @[@"古代言情",
                               @"现代言情",
                               @"仙侠奇幻",
                               @"悬疑灵异",
                               @"历史军事",
                               @"游戏竞技",
                               @"耽美同人",
                               @" 二次元  "];
        [self.irregulatBtn getArrayDataSourse:listArray];
        
        //回调
        [self.irregulatBtn setChooseBlock:^(UIButton *button) {
            NSLog(@"index:%ld    indexName:%@",(long)button.tag,listArray[button.tag]);
        }];
        
        //self.irregulatBtn.backgroundColor = [UIColor orangeColor];
        //重置frame
        CGSize size = [self.irregulatBtn returnSize];
        self.irregulatBtn.frame = CGRectMake(14*WIDTH_SCALE, 300, DEVICE_WIDTH - 28*WIDTH_SCALE, size.height);
        NSLog(@"%f",size.height);
        
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
    
//    [self.irregulatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.xuanzelab.mas_bottom).with.offset(16);
//        make.left.equalTo(self).with.offset(14*WIDTH_SCALE);
//        make.right.equalTo(self).width.offset(-14*WIDTH_SCALE);
//       // make.size.width.offset(DEVICE_WIDTH);
//        //make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH-28*WIDTH_SCALE, 180));
//    }];

}

#pragma mark - getters

-(UIImageView *)chuangjianView
{
    if(!_chuangjianView)
    {
        _chuangjianView = [[UIImageView alloc] init];
        _chuangjianView.layer.masksToBounds = YES;
        _chuangjianView.layer.cornerRadius = 4;
        _chuangjianView.backgroundColor = [UIColor greenColor];
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

//
//-(HLZIrregulatBtn *)irregulatBtn
//{
//    if(!_irregulatBtn)
//    {
//        _irregulatBtn = [[HLZIrregulatBtn alloc] init];
//        _irregulatBtn.backgroundColor = [UIColor orangeColor];
//        self.btnArray = [NSArray array];
//        _btnArray = @[@"古代言情",@"现代言情",@"仙侠奇幻",@"悬疑灵异",@"历史军事",@"游戏竞技",@"耽美同人",@"二次元"];
//        
//        [_irregulatBtn getArrayDataSourse:_btnArray];
////        //重置frame
////        CGSize size = [_irregulatBtn returnSize];
////        _irregulatBtn.frame = CGRectMake(15, 150, DEVICE_WIDTH - 30, size.height);
//    }
//    
//    return _irregulatBtn;
//}






@end
