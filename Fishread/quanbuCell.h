//
//  quanbuCell.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/6.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dianzanBtn.h"
#import "pinglunBtn.h"
@class quanbuModel;
//创建一个代理
@protocol mycellVdelegate <NSObject>
-(void)myTabVClick1:(UITableViewCell *)cell;
-(void)myTabVClick2:(UITableViewCell *)cell;
@end
@interface quanbuCell : UITableViewCell

@property (nonatomic,strong) dianzanBtn *zanBtn;
@property (nonatomic,strong) pinglunBtn *pingBtn;

@property(assign,nonatomic)id<mycellVdelegate>delegate;
-(CGFloat )setdata:(quanbuModel *)model;

@end
