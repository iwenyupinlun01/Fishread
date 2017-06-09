//
//  setCell1.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/8.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建一个代理
@protocol mycellVdelegate <NSObject>

-(void)myTabVClick:(UITableViewCell *)cell;

@end
@interface setCell1 : UITableViewCell
@property (nonatomic,strong) UIButton *gobackbtn;
@property(assign,nonatomic)id<mycellVdelegate>delegate;
@end
