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

@property (nonatomic, assign) BOOL isMore;
//盛放评论的数组
@property (nonatomic,strong) NSMutableArray<DemoCommentModel *> *commentArray;

@end
