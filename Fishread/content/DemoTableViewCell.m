//
//  DemoTableViewCell.m
//  Demo
//
//  Created by venusource on 16/8/31.
//  Copyright © 2016年 venusource.com. All rights reserved.
//

#import "DemoTableViewCell.h"
#import "DemoCellModel.h"
#import "DemoCommentView.h"

#import "dianzanBtn.h"

@interface DemoTableViewCell ()
//头像
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic,strong)  UIButton *moreButton;

@property (nonatomic,strong) dianzanBtn *zanBtn;

@end

@implementation DemoTableViewCell

-(UIImageView *)iconView{
    if (!_iconView){
        _iconView = [[UIImageView alloc]init];
        // _iconView.layer.borderColor = [[UIColor blackColor] CGColor];
        // _iconView.layer.borderWidth = 1;
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 18*WIDTH_SCALE;
        
    }
    return _iconView;
}

-(UILabel *)nameLable{
    if (!_nameLable){
        _nameLable = [[UILabel alloc]init];
        _nameLable.font = [UIFont systemFontOfSize:14];
        _nameLable.textColor = [UIColor wjColorFloat:@"455F8E"];
    }
    return _nameLable;
}

-(UILabel *)contentLabel{
    if (!_contentLabel){
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textColor = [UIColor wjColorFloat:@"333333"];
    }
    return _contentLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel){
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor wjColorFloat:@"C7C7CD"];
    }
    return _timeLabel;
}

-(UIButton *)moreButton{
    if (!_moreButton){
        _moreButton = [[UIButton alloc]init];
        [_moreButton setTitle:@"加载更多" forState:UIControlStateNormal];
        [_moreButton setTitle:@"收起" forState:UIControlStateSelected];
        [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_moreButton addTarget:self action:@selector(didClickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

-(DemoCommentView *)commentView{
    if (!_commentView){
        _commentView = [[DemoCommentView alloc]init];
    }
    return _commentView;
}


-(void)prepareForReuse{
    [super prepareForReuse];
    NSLog(@"over");
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
        [self.contentView addGestureRecognizer:gesture];
    }
    return self;
}

-(void)action:(UILongPressGestureRecognizer*)gesture{
    [self becomeFirstResponder];
    
    
    
    UIMenuItem *cellshanchu = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(cellshanchuAction)];
    UIMenuItem *celljubao = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(celljubaoAction)];
    UIMenuController *menus = [[UIMenuController alloc] init];
    menus.arrowDirection = UIMenuControllerArrowDown;
    menus.menuItems = @[cellshanchu,celljubao];
    //设置弹出的位置和箭头指向的控件
    [menus setTargetRect:CGRectMake(40, 0, 0, 0) inView:self.contentView];
    //弹出menu
    [menus setMenuVisible:YES animated:YES];
}
//由于某些控件在响应者链中不能成为第一响应者故重写canBecomeFirstResponder方法，返回YES，否则无法弹出menu
-(BOOL)canBecomeFirstResponder{
    return YES;
}
//弹出menu必须要实现这个方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(cellshanchuAction)||action == @selector(celljubaoAction)) {
        return YES;
    }
    //返回YES则弹出系统默认的menu
    return NO;
}


-(void)cellshanchuAction{
    //复制文本到粘贴板
    NSLog(@"cell删除");
}
-(void)celljubaoAction{
    NSLog(@"cell举报");
}


-(dianzanBtn *)zanBtn
{
    if(!_zanBtn)
    {
        _zanBtn = [[dianzanBtn alloc] init];
        _zanBtn.zanimg.image =  [UIImage imageNamed:@"点赞-拷贝"];
        [_zanBtn addTarget:self action:@selector(dianzanclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zanBtn;
}

- (void)setupUI{
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.zanBtn];
    _iconView.sd_layout
    .leftSpaceToView(self.contentView,14*WIDTH_SCALE)
    .topSpaceToView(self.contentView,16*WIDTH_SCALE)
    .heightIs(36*WIDTH_SCALE)
    .widthEqualToHeight();
    _nameLable.sd_layout
    .topEqualToView(_iconView)
    .leftSpaceToView(_iconView,10*WIDTH_SCALE)
    .heightIs(25*HEIGHT_SCALE);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    _timeLabel.sd_layout
    .topSpaceToView(_nameLable,4*WIDTH_SCALE)
    .leftEqualToView(_nameLable)
    .heightIs(10*HEIGHT_SCALE);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    _contentLabel.sd_layout
    .leftEqualToView(_nameLable)
    .rightSpaceToView(self.contentView,10)
    .topSpaceToView(_iconView,20)
    .autoHeightRatio(0);
    [self.zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_top);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
}

- (void)setModel:(DemoCellModel *)model{
    _model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.iconName]];
    self.nameLable.text = model.name;
    self.contentLabel.text = model.msgContent;
    self.timeLabel.text = [Timestr datetime:model.timestr];
    self.zanBtn.zanlab.text = model.support_numstr;
    self.zanBtn.zanlab.textColor = [UIColor wjColorFloat:@"C7C7CD"];
    [self.zanBtn.zanlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_top).with.offset(1*HEIGHT_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.height.mas_equalTo(20);
    }];
    [self.zanBtn.zanimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_top);
        make.right.equalTo(self.zanBtn.zanlab.mas_left).with.offset(-4*WIDTH_SCALE);
        make.height.mas_equalTo(16*WIDTH_SCALE);
        make.width.mas_equalTo(16*WIDTH_SCALE);
    }];
    UIView *bottomView = self.contentLabel;
    if (model.commentArray.count){
        [self.contentView addSubview:self.commentView];
        bottomView = self.commentView;
        _commentView.sd_layout
        .leftEqualToView(_contentLabel)
        .rightSpaceToView(self.contentView,10)
        .topSpaceToView(_contentLabel,10);
        self.commentView.commentArray = model.commentArray;
        if (model.commentArray.count >= 1024){
            [self.contentView addSubview:self.moreButton];
            self.moreButton.selected = model.isMore;
            self.moreButton.sd_layout
            .topSpaceToView(self.commentView,10)
            .rightSpaceToView(self.contentView,10)
            .widthIs(70)
            .heightIs(20);
            if (!model.isMore){
                NSMutableArray * tempArray = [NSMutableArray new];
                for (int i = 0;i < 5; ++i){
                    [tempArray addObject:model.commentArray[i]];
                }
                self.commentView.commentArray = tempArray;
            }
            bottomView = self.moreButton;
        }
    }else{
        [self.commentView removeFromSuperview];
    }
    [self layoutIfNeeded];
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:10];
}

-(void)didClickMoreButton:(UIButton *)sender{
    
    __weak typeof(self) weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(didClickCellMoreComment:With:)]){
        [weakSelf.delegate didClickCellMoreComment:sender With:weakSelf];
    }
}

-(void)dianzanclick
{
    [self.delegate myTabVClickdianzan:self];
}

@end
