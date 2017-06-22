//
//  taolunCell0.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "taolunCell0.h"
#import "taolunquanModel.h"
#import <SDAutoLayout.h>
#import "SDWeiXinPhotoContainerView.h"

#import "DemoCommentView.h"


@interface taolunCell0()
@property (nonatomic,strong) UIImageView *pathimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UIButton *rightbtn;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *contentlab;
@property (nonatomic,strong) UIButton *moreButton;
@property (nonatomic,strong) UIButton *zanbtn;
@property (nonatomic,strong) UIButton *commentbtn;

@property (nonatomic,strong) UIButton *tomorebtn;

@property (nonatomic,strong)  DemoCommentView *commentView;

@property (nonatomic,strong) SDWeiXinPhotoContainerView *picContainerView;
@property (nonatomic,strong) taolunquanModel *tmodel;
@end
const CGFloat contentLabelFontSize = 14;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定
@implementation taolunCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.pathimg];
        [self.contentView addSubview:self.namelab];
        [self.contentView addSubview:self.rightbtn];
        [self.contentView addSubview:self.timelab];
        [self.contentView addSubview:self.contentlab];
        [self.contentView addSubview:self.zanbtn];
        [self.contentView addSubview:self.commentbtn];
        [self.contentView addSubview:self.moreButton];
        [self.contentView addSubview:self.tomorebtn];
        [self.contentView addSubview:self.picContainerView];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    _pathimg.sd_layout
    .leftSpaceToView(self.contentView,14*WIDTH_SCALE)
    .topSpaceToView(self.contentView,16*WIDTH_SCALE)
    .heightIs(36*WIDTH_SCALE)
    .widthEqualToHeight();
    
    _namelab.sd_layout
    .topEqualToView(_pathimg)
    .leftSpaceToView(_pathimg,10*WIDTH_SCALE)
    .heightIs(25*HEIGHT_SCALE);
    [_namelab setSingleLineAutoResizeWithMaxWidth:200];
    
    _timelab.sd_layout
    .topSpaceToView(_namelab,4*WIDTH_SCALE)
    .leftEqualToView(_namelab)
    .heightIs(10*HEIGHT_SCALE);
    [_timelab setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentlab.sd_layout
    .leftEqualToView(_namelab)
    .rightSpaceToView(self.contentView,14*WIDTH_SCALE)
    .topSpaceToView(_pathimg,14*HEIGHT_SCALE)
    .autoHeightRatio(0);
    
    _contentlab.numberOfLines = 0;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentlab.font.lineHeight * 4;
    }
    
    self.contentlab.font = [UIFont systemFontOfSize:14];
    
    self.contentlab.sd_layout.maxHeightIs(maxContentLabelHeight);
    
    [self.rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(20*HEIGHT_SCALE);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(10);
        
    }];
    
    
    
    // morebutton的高度在setmodel里面设置
    _moreButton.sd_layout
    .leftEqualToView(_contentlab)
    .topSpaceToView(_contentlab, 10)
    .widthIs(30).heightIs(14);
    
    
    
    _picContainerView.sd_layout
    .leftEqualToView(_moreButton); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    
    [self setupAutoHeightWithBottomViewsArray:@[_contentlab ,_picContainerView,_moreButton] bottomMargin:14*WIDTH_SCALE];
    
    
    
}

#pragma mark - getters


-(SDWeiXinPhotoContainerView *)picContainerView
{
    if(!_picContainerView)
    {
        _picContainerView = [SDWeiXinPhotoContainerView new];
        
    }
    return _picContainerView;
}

-(UIButton *)tomorebtn
{
    if(!_tomorebtn)
    {
        _tomorebtn = [[UIButton alloc] init];
        _tomorebtn.backgroundColor = [UIColor whiteColor];
        [_tomorebtn setTitle:@"加载更多" forState:normal];
        [_tomorebtn setTitleColor:[UIColor wjColorFloat:@"54d48a"] forState:normal];
    }
    return _tomorebtn;
}



-(UIButton *)moreButton
{
    if(!_moreButton)
    {
        _moreButton = [UIButton new];
        [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];

    }
    return _moreButton;
}


-(UIImageView *)pathimg
{
    if(!_pathimg)
    {
        _pathimg = [[UIImageView alloc] init];
        _pathimg.layer.masksToBounds = YES;
        _pathimg.layer.cornerRadius = 18*WIDTH_SCALE;
    }
    return _pathimg;
}

-(UILabel *)namelab
{
    if(!_namelab)
    {
        _namelab = [[UILabel alloc] init];
        _namelab.text = @"namename";
    }
    return _namelab;
}

-(UILabel *)contentlab
{
    if(!_contentlab)
    {
        _contentlab = [[UILabel alloc] init];

    }
    return _contentlab;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setImage:[UIImage imageNamed:@"展开"] forState:normal];
        [_rightbtn addTarget:self action:@selector(rightclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightbtn;
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

-(DemoCommentView *)commentView{
    if (!_commentView){
        _commentView = [[DemoCommentView alloc]init];
    }
    return _commentView;
}


-(void)setdata:(taolunquanModel *)model
{
    self.tmodel = model;
    [self.pathimg sd_setImageWithURL:[NSURL URLWithString:model.pathurlstr]];
    self.namelab.text = model.namestr;
    self.timelab.text = [Timestr datetime:model.timestr];
    self.contentlab.text = model.contentstr;
    
    _picContainerView.picPathStringsArray = model.picNamesArray;
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }

    
    CGSize size = [model.contentstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH - 78*WIDTH_SCALE, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    
    
    BOOL isshow;
    
    
    if (size.height > 80) {
        isshow = YES;
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) {
            _contentlab.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];

        }else
        {
            _contentlab.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    }else{
        isshow = NO;
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    
    _picContainerView.sd_layout.topSpaceToView(_contentlab,picContainerTopMargin);
    
    UIView *bottomView = self.picContainerView;
    
    if (model.commentArray.count){
        [self.contentView addSubview:self.commentView];
        bottomView = self.commentView;
        _commentView.sd_layout
        .leftEqualToView(_contentlab)
        .rightSpaceToView(self.contentView,10)
        .topSpaceToView(_contentlab,10);
        
        self.commentView.commentArray = model.commentArray;
        
        if (model.commentArray.count >= 5){
            
            [self.contentView addSubview:self.tomorebtn];
            self.tomorebtn.selected = model.isMore;
            
            self.tomorebtn.sd_layout
            .topSpaceToView(self.commentView,10)
            .rightSpaceToView(self.contentView,14*WIDTH_SCALE)
            .leftSpaceToView(self.contentView, 64*WIDTH_SCALE)
            .heightIs(20);
            [self.tomorebtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            if (!model.isMore){
                NSMutableArray * tempArray = [NSMutableArray new];
                for (int i = 0;i < 5; ++i){
                    [tempArray addObject:model.commentArray[i]];
                }
                self.commentView.commentArray = tempArray;
            }
            bottomView = self.tomorebtn;
        }
        
    } else {
        
        [self.commentView removeFromSuperview];
    }
    
    [self layoutIfNeeded];
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:10];
    
}

#pragma mark - 协议绑定

-(void)rightclick
{
    [self.delegate rightbtnClick:self];
}

-(void)moreButtonClicked
{
    [self.delegate morebtnClick:self];
}

@end
