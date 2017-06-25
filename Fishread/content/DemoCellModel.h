//
//  DemoCellModel.h
//  Demo
//
//  Created by venusource on 16/9/1.
//  Copyright © 2016年 venusource.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DemoCommentModel;
@interface DemoCellModel : NSObject

@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, copy) NSString *timestr;

@property (nonatomic, copy) NSString *support_numstr;

@property (nonatomic,strong) NSString *idstr;
@property (nonatomic,strong) NSString *toidstr;
@property (nonatomic, assign) BOOL isMore;
//盛放评论的数组
@property (nonatomic,strong) NSMutableArray<DemoCommentModel *> *commentArray;

@end
