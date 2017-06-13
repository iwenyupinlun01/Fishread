//
//  jieguoCell.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class jieguoModel;

@interface jieguoCell : UITableViewCell
@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *typelab;

-(void)setdata:(jieguoModel *)model;

@end
