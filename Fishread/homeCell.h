//
//  homeCell.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/3.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "itemimgView.h"
@class homeModel;

@interface homeCell : UICollectionViewCell
@property (nonatomic,strong) itemimgView *itemimg;
@property (nonatomic,strong) UILabel *namelab;

-(void)setdatafrommodel:(homeModel *)model;
@end
