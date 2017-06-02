//
//  MainTitleView.h
//  CustomNav
//
//  Created by xuehaodong on 2016/12/29.
//  Copyright © 2016年 NJQY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTitleBlock)(NSInteger index);
@interface MainTitleView : UIView


/**
 初始化
 */
- (instancetype)initWithFrame:(CGRect)frame WithTitleName:(NSArray *)titleName WithBlock:(MainTitleBlock) block;


/**
 滚动标题线
 */
- (void)scrollingWithTag:(NSInteger)tag;
@end
