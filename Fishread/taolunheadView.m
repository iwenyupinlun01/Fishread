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

@property (nonatomic,strong) UIImageView *typeimg;

@property (strong, nonatomic) CAGradientLayer *gradientLayer;

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
        
        [self addSubview:self.typeimg];
        
        [self addSubview:self.morebtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    
}


#pragma mark - getters

-(UIButton *)morebtn
{
    if(!_morebtn)
    {
        _morebtn = [[UIButton alloc] init];
        [_morebtn setImage:[UIImage imageNamed:@"展开"] forState:normal];
    }
    return _morebtn;
}

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
        _bookimg.layer.masksToBounds = YES;
        _bookimg.layer.cornerRadius = 4;
        _bookimg.layer.borderWidth = 0.5;
        _bookimg.layer.borderColor = [UIColor wjColorFloat:@"E8E8E8"].CGColor;
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
        _namelab.font = [UIFont systemFontOfSize:18];
        
        [_namelab sizeToFit];
    }
    return _namelab;
}

-(UILabel *)authorlab
{
    if(!_authorlab)
    {
        _authorlab = [[UILabel alloc] init];
        _authorlab.textColor = [UIColor wjColorFloat:@"999999"];
        _authorlab.font = [UIFont systemFontOfSize:13];
    }
    return _authorlab;
}

-(UILabel *)typelab
{
    if(!_typelab)
    {
        _typelab = [[UILabel alloc] init];
        _typelab.textColor = [UIColor wjColorFloat:@"999999"];
        _typelab.font = [UIFont systemFontOfSize:13];
    }
    return _typelab;
}

-(UILabel *)numberlab
{
    if(!_numberlab)
    {
        _numberlab = [[UILabel alloc] init];
        _numberlab.textColor = [UIColor wjColorFloat:@"54d48a"];
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


-(UIImageView *)typeimg
{
    if(!_typeimg)
    {
        _typeimg = [[UIImageView alloc] init];
        
    }
    return _typeimg;
}



-(UIButton *)btn01
{
    if(!_btn01)
    {
        _btn01 = [[UIButton alloc] init];
        [_btn01 setTitle:@"目录" forState:normal];
        [_btn01 setTitleColor:[UIColor wjColorFloat:@"54d48a"] forState:normal];
        _btn01.layer.masksToBounds = YES;
        _btn01.layer.borderWidth = 1;
        _btn01.layer.borderColor = [UIColor wjColorFloat:@"54d48a"].CGColor;
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
        [_btn02 setTitleColor:[UIColor whiteColor] forState:normal];
        _btn02.layer.masksToBounds = YES;
        //_btn02.layer.borderWidth = 1;
        _btn02.backgroundColor = [UIColor wjColorFloat:@"54d48a"];
        //_btn02.layer.borderColor = [UIColor wjColorFloat:@"FB7085"].CGColor;
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


-(CAGradientLayer *)gradientLayer
{
    if(!_gradientLayer)
    {
        _gradientLayer = [[CAGradientLayer alloc] init];
        //设置渐变颜色方向
        self.gradientLayer.startPoint = CGPointMake(0, 0);
        self.gradientLayer.endPoint = CGPointMake(0, 1);
        
        
        //_gradientLayer.locations = @[@(0.1f),@(1.0f)];
        //_gradientLayer.locations =  @[(__bridge id)[UIColor clearColor].CGColor,
                                      //(__bridge id)[UIColor whiteColor].CGColor];
        
        
        // 设置颜色
        _gradientLayer.colors = @[(id)[[UIColor clearColor] colorWithAlphaComponent:0.0f].CGColor,
                                 (id)[[UIColor whiteColor] colorWithAlphaComponent:0.1f].CGColor];
        _gradientLayer.locations = @[[NSNumber numberWithFloat:0.5f],
                                    [NSNumber numberWithFloat:1.0f]];
        
        
        
        //self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                     // (__bridge id)[UIColor whiteColor].CGColor];
        
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0, 1);
    }
    return _gradientLayer;
}

-(void)setdata:(NSDictionary *)dit
{
    
//    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *view2 = [[UIVisualEffectView alloc]initWithEffect:beffect];
//    view2.frame = self.bgimg.frame;

//    [self addSubview:view2];
    
    
   // [self addSubview:self.bgimg];
    self.bgimg.frame = CGRectMake(0, 0, DEVICE_WIDTH, 378/2*HEIGHT_SCALE);
    self.gradientLayer.frame = self.bgimg.bounds;
    
  //  [view2.layer addSublayer:self.gradientLayer];
    
    //NSString *bgimgstr = [dit objectForKey:@"background"];
    
   //[self.bgimg sd_setImageWithURL:[NSURL URLWithString:bgimgstr]placeholderImage:[UIImage imageNamed:@"默认-拷贝"]];
    
//    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:bgimgstr]]];
//    
//    UIImage * sourceImage = img;
//    CIImage * ciImage    = [[CIImage alloc] initWithImage:sourceImage];
//    CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    //将图片输入到滤镜中
//    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
//    //设置模糊程度
//    [blurFilter setValue:@(5) forKey:@"inputRadius"];
//    NSLog(@"查看blurFilter的属性--- %@",blurFilter.attributes);
//    //将处理之后的图片输出
//    CIImage * outCiImage    = [blurFilter valueForKey:kCIOutputImageKey];
//    CIContext * context      = [CIContext contextWithOptions:nil];
//    //获取CGImage句柄
//    CGImageRef outCGImageRef = [context createCGImage:outCiImage fromRect:[outCiImage extent]];
//    //获取到最终图片
//    UIImage * resultImage    = [UIImage imageWithCGImage:outCGImageRef];
//    //释放句柄
//    CGImageRelease(outCGImageRef);
//    self.bgimg.image = resultImage;
//    
//    [self.bgimg.layer addSublayer:self.gradientLayer];
    
    [self.bookimg sd_setImageWithURL:[NSURL URLWithString:[dit objectForKey:@"pubPath"]] placeholderImage:[UIImage imageNamed:@"默认-拷贝"]];
    NSString *nametex = [dit objectForKey:@"pubTitle"];
    self.namelab.text = nametex;
    self.namelab.textColor = [UIColor wjColorFloat:@"333333"];
    self.namelab.preferredMaxLayoutWidth = DEVICE_WIDTH-28*WIDTH_SCALE-120*WIDTH_SCALE;
    [self.namelab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.namelab.lineBreakMode = NSLineBreakByWordWrapping;//换行方式
    self.bookimg.frame = CGRectMake(14*WIDTH_SCALE, 64*HEIGHT_SCALE, 90*WIDTH_SCALE, 120*HEIGHT_SCALE);
    
    
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

    [self.authorlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.namelab.mas_bottom).with.offset(8*HEIGHT_SCALE);
        make.left.equalTo(self.bookimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.height.mas_equalTo(13);
    }];
    [self.typelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorlab.mas_bottom).with.offset(8*HEIGHT_SCALE);
        make.left.equalTo(self.bookimg.mas_right).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
    }];
    [self.numberlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typelab.mas_bottom).with.offset(8*HEIGHT_SCALE);
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
    self.authorlab.text = [NSString stringWithFormat:@"%@%@",@"作者：",[dit objectForKey:@"pubNickname"]];
    //self.contentlab.text = [dit objectForKey:@"pubContent"];
    self.typelab.text = [dit objectForKey:@"typeTitle"];
    self.typelab.text = [NSString stringWithFormat:@"%@%@",@"类型：",[dit objectForKey:@"typeTitle"]];
    NSString *all_post = [dit objectForKey:@"all_post"];
    NSString *collecCount = [dit objectForKey:@"collecCount"];
    
    self.numberlab.text = [NSString stringWithFormat:@"%@%@%@%@%@",collecCount,@"成员",@"/",all_post,@"跟帖"];
    
    self.contentlab.font = [UIFont systemFontOfSize:13];
    
    [self.contentlab setText:[dit objectForKey:@"pubContent"] lines:3 andLineSpacing:8 constrainedToSize:CGSizeMake(DEVICE_WIDTH-14*2, MAXFLOAT)];
    
    self.contentlab.preferredMaxLayoutWidth = (DEVICE_WIDTH - 14.0 * 2);
    [self.contentlab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.contentlab sizeToFit];
    
    CGFloat texth = self.contentlab.frame.size.height;
    NSLog(@"hei-------%f",texth);
    
    if (texth < 62) {
        [self.morebtn setHidden:YES];
    }
    
    [self.morebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentlab.mas_bottom).with.offset(4*HEIGHT_SCALE);
        make.width.mas_offset(16*WIDTH_SCALE);
        make.left.equalTo(self).with.offset(DEVICE_WIDTH/2-8*WIDTH_SCALE);
        make.height.mas_offset(10*HEIGHT_SCALE);

    }];
    
    [self.morebtn setEnlargeEdgeWithTop:50 right:50 bottom:50 left:50];
    
    [self.lineview0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.morebtn.mas_bottom).with.offset(10*HEIGHT_SCALE);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(10*HEIGHT_SCALE);
    }];
    
    
    
    NSString *sectiontitle = [dit objectForKey:@"newSectionTitle"];
    NSString *newSectionNum = [dit objectForKey:@"newSectionNum"];
    NSString *num =  [NSString stringWithFormat:@"%@%@%@",@"第",newSectionNum,@"章"];
    self.zhangjielab.text = [NSString stringWithFormat:@"%@%@%@%@%@",@"最新章节",@"  ",num,@"  ",sectiontitle];
    if ([[dit objectForKey:@"book_status"]isEqualToString:@"0"]) {
        //连载中
        self.typeimg.image = [UIImage imageNamed:@"连载"];
    }else
    {
        //完结
        self.typeimg.image = [UIImage imageNamed:@"完结"];
    }
    
    [self.zhangjielab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineview0.mas_bottom).with.offset(2*HEIGHT_SCALE);
        make.left.equalTo(self).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(40*HEIGHT_SCALE);
    }];
    
    
    [self.typeimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zhangjielab.mas_top).with.offset(12*HEIGHT_SCALE);
        //make.left.equalTo(self).with.offset(14*WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-14*WIDTH_SCALE);
        make.height.mas_offset(16*HEIGHT_SCALE);
        make.width.mas_offset(32*WIDTH_SCALE);
    }];
    
    [self.lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zhangjielab.mas_bottom).with.offset(2*HEIGHT_SCALE);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(10*HEIGHT_SCALE);
    }];
    
    
}


@end
