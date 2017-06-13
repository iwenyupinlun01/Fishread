//
//  searchCell1.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "searchCell1.h"
#import "historyModel.h"
@interface searchCell1()
@property (nonatomic,strong) historyModel *model;
@end

@implementation searchCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.textLabel.textColor = [UIColor wjColorFloat:@"333333"];
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

-(void)setdata:(historyModel *)hmodel
{
    self.model = hmodel;
    self.textLabel.text = hmodel.historysearchkey;
}
@end
