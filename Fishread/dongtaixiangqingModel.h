//
//  dongtaixiangqingModel.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/17.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dongtaixiangqingModel : NSObject
@property (nonatomic,strong) NSString *idstr;
@property (nonatomic,strong) NSString *uidstr;
@property (nonatomic,strong) NSString *contentstr;
@property (nonatomic,strong) NSString *object_idstr;
@property (nonatomic,strong) NSString *reward_numstr;
@property (nonatomic,strong) NSString *support_numstr;
@property (nonatomic,strong) NSMutableArray *imagesArray;
@property (nonatomic,strong) NSString *create_timestr;
@property (nonatomic,strong) NSString *reply_numstr;
@property (nonatomic,strong) NSString *book_idstr;
@property (nonatomic,strong) NSString *titlestr;
@property (nonatomic,strong) NSString *relation_idstr;

@property (nonatomic,strong) NSString *Avatarpathstr;
@property (nonatomic,strong) NSString *Membernickname;

@property (nonatomic,strong) NSMutableArray *ForumBookmarkArray;
@property (nonatomic,strong) NSString *ForumBookmarkuidstr;
@property (nonatomic,strong) NSString *ForumBookmarknicknamestr;
@end
