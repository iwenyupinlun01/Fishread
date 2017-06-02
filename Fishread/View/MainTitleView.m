//
//  MainTitleView.m
//  CustomNav
//
//  Created by xuehaodong on 2016/12/29.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import "MainTitleView.h"

@interface MainTitleView ()

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,copy) MainTitleBlock block;

@property (nonatomic,strong) NSMutableArray *buttonArray;
@end

@implementation MainTitleView


- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (instancetype)initWithFrame:(CGRect)frame WithTitleName:(NSArray *)titleName WithBlock:(MainTitleBlock)block{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.block = block;
        
        CGFloat width = self.bounds.size.width/titleName.count;
        CGFloat height = self.bounds.size.height;
        
        for (NSInteger i = 0; i < titleName.count; i ++) {
            
            UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
             [self.buttonArray addObject:topButton];
            
            [topButton setTitleColor:[UIColor wjColorFloat:@"54d48a"] forState:UIControlStateNormal];
            [topButton setTitle:titleName[i] forState:UIControlStateNormal];
            topButton.titleLabel.font = [UIFont systemFontOfSize:18];
            topButton.tag = i + 100;
            [topButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            topButton.frame = CGRectMake(i*width, 0, width, height);
            
            
            if (i ==1) {
                
                CGFloat h = 2;
                CGFloat y = 35;
                
                UIView *lineView = [[UIView alloc] init];
                
                [topButton.titleLabel sizeToFit];
                lineView.frame = CGRectMake(0, y, topButton.titleLabel.bounds.size.width,h);
                lineView.center = CGPointMake(topButton.center.x, lineView.center.y);
                lineView.backgroundColor = [UIColor wjColorFloat:@"54d48a"];
                
                self.lineView = lineView;

                [self addSubview:lineView];
                
            }
            
            [self addSubview:topButton];
        }
    }
    return self;
}

- (void)scrollingWithTag:(NSInteger)tag{
    
    UIButton *button = self.buttonArray[tag];
    [UIView animateWithDuration:0.5 animations:^{
        self.lineView.center = CGPointMake(button.center.x, 36);
    }];
}

- (void)buttonAction:(UIButton *)button{
    [self scrollingWithTag:button.tag-100];
    if (self.block) {
        self.block(button.tag-100);
    }
}

@end
