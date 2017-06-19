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

@property (nonatomic,strong) NSString *is_bookmarkstr;
@property (nonatomic,strong) NSString *Avatarpathstr;
@property (nonatomic,strong) NSString *Membernickname;

@property (nonatomic,strong) NSMutableArray *ForumBookmarkArray;
@property (nonatomic,strong) NSString *ForumBookmarkuidstr;
@property (nonatomic,strong) NSString *ForumBookmarknicknamestr;



@property (nonatomic,strong) NSString *allCommentidstr;
@property (nonatomic,strong) NSString *allCommentcomment_iconstr;
@property (nonatomic,strong) NSString *allCommentcomment_namestr;
@property (nonatomic,strong) NSString *allCommentcontentstr;
@property (nonatomic,strong) NSString *allCommentto_reply_idstr;
@property (nonatomic,strong) NSString *allCommentuidstr;
@property (nonatomic,strong) NSString *allCommentto_uidstr;
@property (nonatomic,strong) NSString *allCommentsupport_numstr;
@property (nonatomic,strong) NSString *allCommentpidstr;
@property (nonatomic,strong) NSString *allCommentctimestr;
@property (nonatomic,strong) NSString *comment_namestr;
@property (nonatomic,strong) NSString *allCommentto_comment_namestr;

@property (nonatomic,strong) NSMutableArray *pinglunarr;

@end
