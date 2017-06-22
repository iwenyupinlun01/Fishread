//
//  taolunCell0.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class taolunquanModel;
@protocol mycellVdelegate <NSObject>
-(void)morebtnClick:(UITableViewCell *)cell;
-(void)rightbtnClick:(UITableViewCell *)cell;
@end
@interface taolunCell0 : UITableViewCell
-(void)setdata:(taolunquanModel *)model;
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@end
