//
//  quanbuModel.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/14.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface quanbuModel : NSObject
@property (nonatomic,strong) NSString *object_idstr;
@property (nonatomic,strong) NSString *reward_numstr;
@property (nonatomic,strong) NSString *parsestr;
@property (nonatomic,strong) NSString *create_timestr;
@property (nonatomic,strong) NSString *contentstr;
@property (nonatomic,strong) NSString *idstr;
@property (nonatomic,strong) NSString *reply_numstr;
@property (nonatomic,strong) NSString *statusstr;
@property (nonatomic,strong) NSString *support_numstr;
@property (nonatomic,strong) NSMutableArray *imagesArray;
@property (nonatomic,strong) NSString *titlestr;
@property (nonatomic,strong) NSString *post_statusstr;
@property (nonatomic,strong) NSString *member_statusstr;
@property (nonatomic,strong) NSString *nicknamestr;
@property (nonatomic,strong) NSString *pathstr;

@end
