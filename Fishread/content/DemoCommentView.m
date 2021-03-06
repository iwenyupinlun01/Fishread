//
//  DemoCommentView.m
//  Demo
//
//  Created by venusource on 16/9/1.
//  Copyright © 2016年 venusource.com. All rights reserved.
//

#import "DemoCommentView.h"
#import "DemoCommentModel.h"
#import <SDAutoLayout.h>

@interface DemoCommentView ()

@property (nonatomic,strong) NSMutableArray * labelsArray;

@property (nonatomic,strong) NSDictionary *labeldic;

@property (nonatomic,strong) DemoCommentModel *demomodel;
@end

@implementation DemoCommentView

-(NSMutableArray *)labelsArray{
    if (!_labelsArray){
        _labelsArray = [[NSMutableArray alloc]init];
    }
    return _labelsArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor wjColorFloat:@"F5F5F5"];
    }
    return self;
}

-(void)setCommentArray:(NSArray *)commentArray{

    _commentArray = commentArray;
    
    long labelsCount = self.labelsArray.count;
    
    long addCount = commentArray.count > labelsCount ? (commentArray.count - labelsCount) : 0;
    
    [self.labelsArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
        [label sd_clearAutoLayoutSettings];
        label.hidden = YES; //重用时先隐藏所以评论label，然后根据评论个数显示label
    }];
    
    //需要添加的评论
    for (int i = 0; i < addCount; i++) {
        UILabel* textlab = [[UILabel alloc] init];
        textlab.font = [UIFont systemFontOfSize:14];
        [self addSubview:textlab];
        [self.labelsArray addObject:textlab];
    }


    
    
    //根据评论的数量添加label
    for (int i = 0; i < commentArray.count; i++) {
        DemoCommentModel *model = commentArray[i];
        
        UILabel* textlab = [[UILabel alloc] init];
        textlab = self.labelsArray[i];
        
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
        // 2. 将点击事件添加到label上
        
        textlab.tag = i;
        
        [textlab addGestureRecognizer:labelTapGestureRecognizer];
        textlab.userInteractionEnabled = YES; // 可以理解为设置label可被点击
        
        
        //添加长按手势
        UILongPressGestureRecognizer * longPressGesture =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
        longPressGesture.minimumPressDuration=1.0f;//设置长按 时间
        [self addGestureRecognizer:longPressGesture];
        
        
        NSString *str1 = model.firstUserName;
        NSString *str2 = @"回复";
        NSString *str3 = model.secondUserName;
        NSString *str4 = [NSString stringWithFormat:@"%@%@",@":",model.commentString];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@%@",str1,str2,str3,str4]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"576b95"] range:NSMakeRange(0,str1.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"333333"] range:NSMakeRange(str1.length,str2.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"576b95"] range:NSMakeRange(str1.length+str2.length,str3.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"333333"] range:NSMakeRange(str1.length+str2.length+str3.length,str4.length)];
        
        textlab.attributedText = str;
    }
    
    if (self.labelsArray.count) {
        
        UIView *bottmView = nil;
        
        for (int i = 0; i < commentArray.count; i++) {
            UILabel *label = (UILabel *)self.labelsArray[i];
            label.hidden = NO;
            
            label.sd_layout
            .leftSpaceToView(self, 8)
            .rightSpaceToView(self, 5)
            .topSpaceToView(bottmView, 5)
            .autoHeightRatio(0);
            
            bottmView = label;
        }
        
        [self setupAutoHeightWithBottomView:bottmView bottomMargin:5];
        
    }
}

- (void)labelClick:(UITapGestureRecognizer *)gesture{
    
    //NSLog(@"%ld",[gesture view].tag);
    NSInteger taginter = [gesture view].tag;
    self.demomodel = [[DemoCommentModel alloc] init];
    self.demomodel = [_commentArray objectAtIndex:taginter];
    //NSLog(@"str-------%@",self.demomodel.commentString);
    
    NSDictionary *dic = [NSDictionary dictionary];
    NSString *firstid = self.demomodel.firstUserId;
    NSString *secondid = self.demomodel.secondUserId;
    NSString *pid = self.demomodel.pidstr;
    dic = @{@"firstid":firstid,@"secondid":secondid,@"pid":pid};
    [self.delegate myTabVClick:dic];
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return action==@selector(cellshanchu:)|| action==@selector(jubaocell:);
}



-(void)cellLongPress:(UILongPressGestureRecognizer *)longRecognizer{
    
    
    NSInteger taginter = [longRecognizer view].tag;
    self.demomodel = [[DemoCommentModel alloc] init];
    self.demomodel = [_commentArray objectAtIndex:taginter];
    
    NSString *firstid = self.demomodel.firstUserId;
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        //成为第一响应者，需重写该方法
        [self becomeFirstResponder];
        
        //在此添加你想要完成的功能
        NSLog(@"modl-----%@",firstid);
        
        UIMenuController * menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.bounds inView:self.superview];
        
        if ([self.demomodel.firstUserId isEqualToString:[tokenstr useruid]]) {
            
            UIMenuItem * item0 = [[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(cellshanchu:)];
            menu.menuItems = @[item0];
            [menu setMenuVisible:YES animated:YES];
            
            
        }else
        {
            
            UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(jubaocell:)];
            menu.menuItems = @[item1];
            [menu setMenuVisible:YES animated:YES];
        }
    }
}

-(void)cellshanchu:(UIMenuController *)menu
{
    [menu setMenuVisible:NO animated:YES];
    
    NSString *idstr = self.demomodel.idstr;
    NSLog(@"uid---------%@",idstr);
    [self.delegate myTabVClickshanchuview:idstr];
    
}

-(void)jubaocell:(UIMenuController *)menu
{
    [menu setMenuVisible:NO animated:YES];
//    [self.delegate myTabVClickjubao:self];
    NSString *firstid = self.demomodel.firstUserId;
    NSLog(@"uid---------%@",firstid);
    NSString *idstr = self.demomodel.idstr;
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"firstid":firstid,@"idstr":idstr};
    [self.delegate myTabVClickjubaoview:dic];
}

@end
