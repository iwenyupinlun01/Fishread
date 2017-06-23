//
//  quanzixiangqingCell0.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/16.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class dongtaixiangqingModel;
@interface quanzixiangqingCell0 : UITableViewCell
-(void)setdata:(dongtaixiangqingModel *)model;
@property (nonatomic,strong) UIButton *zanBtn;
@property (nonatomic,strong) UIButton *commentsBtn;
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *rightbtn;
@end
