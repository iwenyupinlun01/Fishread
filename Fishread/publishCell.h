//
//  publishCell.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class publishModel;

@interface publishCell : UITableViewCell
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *contentlab;
-(CGFloat )setdata:(publishModel *)model;
@end
