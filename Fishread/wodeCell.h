//
//  wodeCell.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/2.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class wodeModel;

@interface wodeCell : UITableViewCell
@property (nonatomic,strong) UIImageView *leftimg;
@property (nonatomic,strong) UILabel *textlab;
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *xiaohongdianlab;
-(void)setdatamodel:(wodeModel*)model;
@end
