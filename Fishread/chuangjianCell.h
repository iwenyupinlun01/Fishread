//
//  chuangjianCell.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLZIrregulatBtn.h"

//创建一个代理
@protocol mycellVdelegate <NSObject>

-(void)myTabVClick:(UITableViewCell *)cell;



@end
@interface chuangjianCell : UITableViewCell

@property (nonatomic,strong) HLZIrregulatBtn *irregulatBtn;
@property (nonatomic,strong) UIImageView *chuangjianView;
@property (nonatomic,strong) UITextField *chuangjianText;
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@end
