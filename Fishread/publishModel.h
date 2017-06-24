//
//  publishModel.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface publishModel : NSObject
@property (nonatomic,strong) NSString *timestr;
@property (nonatomic,strong) NSString *contentstr;
@property (nonatomic,strong) NSMutableArray *imgArray;
@property (nonatomic,strong) NSString *idstr;
@property (nonatomic,strong) NSString *circle_idstr;
@property (nonatomic,strong) NSString *titlestr;
@property (nonatomic,strong) NSString *uidstr;
@property (nonatomic,strong) NSString *circle_creatorstr;
@end
