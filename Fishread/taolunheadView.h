//
//  taolunheadView.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/22.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface taolunheadView : UIView
@property (nonatomic,strong) UIImageView *bgimg;
@property (nonatomic,strong) UIImageView *bookimg;
@property (nonatomic,strong) UILabel *namelab;
@property (nonatomic,strong) UILabel *authorlab;
@property (nonatomic,strong) UILabel *typelab;
@property (nonatomic,strong) UILabel *numberlab;

@property (nonatomic,strong) UIButton *btn01;
@property (nonatomic,strong) UIButton *btn02;

@property (nonatomic,strong) UILabel *contentlab;

-(void)setdata:(NSDictionary *)dit;

@end
