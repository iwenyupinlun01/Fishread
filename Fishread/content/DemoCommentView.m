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
        self.backgroundColor = [UIColor lightGrayColor];
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
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        [self.labelsArray addObject:label];
    }

    //根据评论的数量添加label
    for (int i = 0; i < commentArray.count; i++) {
        DemoCommentModel *model = commentArray[i];
        UILabel *label = self.labelsArray[i];
        label.text = model.commentString;
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

@end
