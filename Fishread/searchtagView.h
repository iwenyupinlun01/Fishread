//
//  searchtagView.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^chooseBlock)(UIButton *button);

@interface searchtagView : UIView
@property (nonatomic, strong) UIColor  *btnBgColor;
@property (nonatomic, assign) CGSize   heightSize;
@property (nonatomic, strong) UIView   *ltView;
@property (nonatomic, strong) NSArray  *arrDataSourse;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) NSMutableArray *buttonArray;//存放button，实现按钮单选
@property (nonatomic, copy) chooseBlock block;

- (void) setChooseBlock:(chooseBlock)block;
- (void) setLabelBackgroundColor:(UIColor *)color;
- (void) getArrayDataSourse:(NSArray *)array;
- (CGSize) returnSize;
@end
