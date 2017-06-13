//
//  searchheadView.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建一个代理
@protocol myheadviewVdelegate <NSObject>

-(void)myheadVClick:(UIView *)view;

@end
@interface searchheadView : UIView
@property (assign,nonatomic)id<myheadviewVdelegate>delegate;
@end
