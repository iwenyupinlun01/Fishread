//
//  dongtaixiangqingModel.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "dongtaixiangqingModel.h"

@implementation dongtaixiangqingModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(NSMutableArray *)imagesArray
{
    if(!_imagesArray)
    {
        _imagesArray = [NSMutableArray array];
        
    }
    return _imagesArray;
}


-(NSMutableArray *)ForumBookmarkArray
{
    if(!_ForumBookmarkArray)
    {
        _ForumBookmarkArray = [NSMutableArray array];
        
    }
    return _ForumBookmarkArray;
}

//
//-(NSMutableArray *)pinglunarr
//{
//    if(!_pinglunarr)
//    {
//        _pinglunarr = [NSMutableArray array];
//        
//    }
//    return _pinglunarr;
//}




@end
