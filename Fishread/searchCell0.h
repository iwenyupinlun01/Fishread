//
//  searchCell0.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/9.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchtagView.h"
//创建一个代理
@protocol mycellVdelegate <NSObject>

-(void)myTabVClick:(UITableViewCell *)cell;



@end
@interface searchCell0 : UITableViewCell
@property (nonatomic,strong) UIButton *replacebtn;
@property (assign,nonatomic)id<mycellVdelegate>delegate;
@property (nonatomic,strong) searchtagView *tagview;
@end
