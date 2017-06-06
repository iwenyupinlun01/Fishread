//
//  headView.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol myheadviewdelegate <NSObject>
-(void)myTabVClick1:(UIView *)view;
@end
@interface headView : UIView
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UIImageView *infoimg;
@property(assign,nonatomic)id<myheadviewdelegate>delegate;
@end
