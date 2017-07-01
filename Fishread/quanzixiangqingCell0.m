//
//  quanzixiangqingCell0.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "quanzixiangqingCell0.h"
#import "dongtaixiangqingModel.h"
#import "dianzanBtn.h"
#import "pinglunBtn.h"
#import "SDWeiXinPhotoContainerView.h"

@interface quanzixiangqingCell0()
@property (nonatomic,strong) UIImageView *iconimg;
@property (nonatomic,strong) UILabel *nicknamelab;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *contentlab;

@property (nonatomic,strong) SDWeiXinPhotoContainerView *picContainerView;

@property (nonatomic,strong) UILabel *thumlabel;
@property (nonatomic,strong) dongtaixiangqingModel *dmodel;
@end

@implementation quanzixiangqingCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.iconimg];
        [self.contentView addSubview:self.nicknamelab];
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.rightbtn];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.picContainerView];
        [self.contentView addSubview:self.zanBtn];
        [self.contentView addSubview:self.commentsBtn];
        [self.contentView addSubview:self.shareBtn];
        [self.contentView addSubview:self.thumlabel];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    
    _iconimg.sd_layout
    .leftSpaceToView(self.contentView,14*WIDTH_SCALE)
    .topSpaceToView(self.contentView,16*WIDTH_SCALE)
    .heightIs(36*WIDTH_SCALE)
    .widthEqualToHeight();
    
    
    _nicknamelab.sd_layout
    .topEqualToView(_iconimg)
    .leftSpaceToView(_iconimg,10*WIDTH_SCALE)
    .heightIs(25*HEIGHT_SCALE);
    [_nicknamelab setSingleLineAutoResizeWithMaxWidth:200];
    
    _timelab.sd_layout
    .topSpaceToView(_nicknamelab,4*WIDTH_SCALE)
    .leftEqualToView(_nicknamelab)
    .heightIs(10*HEIGHT_SCALE);
    [_timelab setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentlab.sd_layout
    .leftEqualToView(_nicknamelab)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(_iconimg,20)
    .autoHeightRatio(0);

    
    _picContainerView.sd_layout
    .leftEqualToView(_contentlab); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    [self.rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(20*HEIGHT_SCALE);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(10);
        
    }];
}

-(SDWeiXinPhotoContainerView *)picContainerView
{
    if(!_picContainerView)
    {
        _picContainerView = [SDWeiXinPhotoContainerView new];
        
    }
    return _picContainerView;
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

-(UILabel *)nicknamelab
{
    if(!_nicknamelab)
    {
        _nicknamelab = [[UILabel alloc] init];
        _nicknamelab.textColor = [UIColor wjColorFloat:@"455F8E"];
        _nicknamelab.font = [UIFont systemFontOfSize:14];

    }
    return _nicknamelab;
}

-(UILabel *)timelab
{
    if(!_timelab)
    {
        _timelab = [[UILabel alloc] init];
        _timelab.textColor = [UIColor wjColorFloat:@"C7C7CD"];
        _timelab.font = [UIFont systemFontOfSize:12];
    }
    return _timelab;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setImage:[UIImage imageNamed:@"展开"] forState:normal];
    }
    return _rightbtn;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];
        _contentlab.numberOfLines = 0;
    }
    return _contentlab;
}

-(UIButton *)zanBtn
{
    if(!_zanBtn)
    {
        _zanBtn = [[UIButton alloc] init];
        [_zanBtn setImage:[UIImage imageNamed:@"点赞"] forState:normal];
    }
    return _zanBtn;
}

-(UIButton *)commentsBtn
{
    if(!_commentsBtn)
    {
        _commentsBtn = [[UIButton alloc] init];
        [_commentsBtn setImage:[UIImage imageNamed:@"评"] forState:normal];
    }
    return _commentsBtn;
}

-(UIButton *)shareBtn
{
    if(!_shareBtn)
    {
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:normal];
    }
    return _shareBtn;
}

-(UILabel *)thumlabel
{
    if(!_thumlabel)
    {
        _thumlabel = [[UILabel alloc] init];
        _thumlabel.numberOfLines = 0;
        _thumlabel.textColor = [UIColor wjColorFloat:@"576B95"];
    }
    return _thumlabel;
}

-(void)setdata:(dongtaixiangqingModel *)model
{
    self.dmodel = model;
    [self.iconimg sd_setImageWithURL:[NSURL URLWithString:model.Avatarpathstr]];
    self.nicknamelab.text = model.Membernickname;
    self.contentlab.font = [UIFont systemFontOfSize:15];
    self.contentlab.numberOfLines = 0;
    self.contentlab.text = model.contentstr;
    self.contentlab.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    self.timelab.text = [Timestr datetime:model.create_timestr];
    _picContainerView.picPathStringsArray = model.imagesArray;
    CGFloat picContainerTopMargin = 0;
    if (model.imagesArray.count) {
        picContainerTopMargin = 10;
    }
     UIView *bottomView = self.picContainerView;
    _picContainerView.sd_layout.topSpaceToView(_contentlab,picContainerTopMargin);

    _shareBtn.sd_layout.rightSpaceToView(self.contentView, 14*WIDTH_SCALE).topSpaceToView(self.picContainerView, 8*HEIGHT_SCALE).widthIs(16*HEIGHT_SCALE).heightIs(16*HEIGHT_SCALE);
    
    _zanBtn.sd_layout.rightSpaceToView(self.shareBtn, 30*WIDTH_SCALE).topEqualToView(self.shareBtn).widthIs(16*WIDTH_SCALE).heightIs(16*WIDTH_SCALE);
    
    _commentsBtn.sd_layout.rightSpaceToView(self.zanBtn, 30*WIDTH_SCALE).topEqualToView(self.shareBtn).widthIs(16*WIDTH_SCALE).heightIs(16*WIDTH_SCALE);
    
    _thumlabel.sd_layout
    .leftEqualToView(_nicknamelab)
    .rightSpaceToView(self.contentView,14*WIDTH_SCALE)
    .topSpaceToView(_shareBtn,8*HEIGHT_SCALE)
    .autoHeightRatio(0);
    
    if (model.ForumBookmarkArray != nil && ![model.ForumBookmarkArray isKindOfClass:[NSNull class]] && model.ForumBookmarkArray.count !=0) {
        if (model.ForumBookmarkArray.count<=12) {
            NSString *goodTotalString2 = [model.ForumBookmarkArray componentsJoinedByString:@", "];
            NSString *goodTotalString = [NSString stringWithFormat:@"%@%@%lu%@",goodTotalString2,@" ",(unsigned long)model.ForumBookmarkArray.count,@"人已赞"];
            NSMutableAttributedString *newGoodString = [[NSMutableAttributedString alloc] initWithString:goodTotalString];
            [newGoodString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, goodTotalString.length)];
            //设置行距 实际开发中间距为0太丑了，根据项目需求自己把握
            NSMutableParagraphStyle *paragraphstyle = [[NSMutableParagraphStyle alloc] init];
            paragraphstyle.lineSpacing = 3;
            [newGoodString addAttribute:NSParagraphStyleAttributeName value:paragraphstyle range:NSMakeRange(0, goodTotalString.length)];
            // 添加图片
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            // 图片
            attch.image = [UIImage imageNamed:@"点赞-拷贝-2"];
            // 设置图片大小
            attch.bounds = CGRectMake(0, 0, 14*WIDTH_SCALE, 14*WIDTH_SCALE);
            // 创建带有图片的富文本
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [newGoodString insertAttributedString:string atIndex:0];
            NSMutableAttributedString
            * attStr = [[NSMutableAttributedString alloc]initWithString:@" "];
            [newGoodString insertAttributedString:attStr atIndex:1];
            self.thumlabel.attributedText = newGoodString;
            //self.thumlabel.font = [UIFont systemFontOfSize:14];
        }else
        {
            NSArray *smallArray = [model.ForumBookmarkArray subarrayWithRange:NSMakeRange(0, 12)];
            NSString *goodTotalString2 = [smallArray componentsJoinedByString:@", "];
            NSString *goodTotalString = [NSString stringWithFormat:@"%@%@%@%lu%@",goodTotalString2,@"等",@" ",(unsigned long)model.ForumBookmarkArray.count,@"人已赞"];
            NSMutableAttributedString *newGoodString = [[NSMutableAttributedString alloc] initWithString:goodTotalString];
            [newGoodString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, goodTotalString.length)];
            //设置行距 实际开发中间距为0太丑了，根据项目需求自己把握
            NSMutableParagraphStyle *paragraphstyle = [[NSMutableParagraphStyle alloc] init];
            paragraphstyle.lineSpacing = 3;
            [newGoodString addAttribute:NSParagraphStyleAttributeName value:paragraphstyle range:NSMakeRange(0, goodTotalString.length)];
            // 添加图片
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            // 图片
            attch.image = [UIImage imageNamed:@"点赞-拷贝-2"];
            // 设置图片大小
            attch.bounds = CGRectMake(0, 0, 14*WIDTH_SCALE, 14*WIDTH_SCALE);
            // 创建带有图片的富文本
            NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
            [newGoodString insertAttributedString:string atIndex:0];
            NSMutableAttributedString
            * attStr = [[NSMutableAttributedString alloc]initWithString:@" "];
            [newGoodString insertAttributedString:attStr atIndex:1];
            self.thumlabel.attributedText = newGoodString;
//            self.thumlabel.font = [UIFont systemFontOfSize:14];
        }
    }
    if ([model.is_bookmarkstr isEqualToString:@"1"]) {
        [self.zanBtn setImage:[UIImage imageNamed:@"点赞-点击后"] forState:normal];
    }else
    {
        [self.zanBtn setImage:[UIImage imageNamed:@"点赞-拷贝"] forState:normal];
    }
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:20];
    [self setupAutoHeightWithBottomViewsArray:@[_contentlab ,_picContainerView,_thumlabel,_zanBtn,_shareBtn,_commentsBtn] bottomMargin:14*WIDTH_SCALE];
}

- (void)imgClick:(UITapGestureRecognizer *)gesture{
    
    //NSLog(@"%ld",[gesture view].tag);
    NSInteger taginter = [gesture view].tag;
    NSLog(@"tag=------%ld",taginter);
}

@end
