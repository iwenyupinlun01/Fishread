//
//  taolunquanModel.h
//  Fishread
//
//  Created by 王俊钢 on 2017/6/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DemoCommentModel;

@interface taolunquanModel : NSObject
@property (nonatomic,strong) NSString *pathurlstr;
@property (nonatomic,strong) NSString *namestr;
@property (nonatomic,strong) NSString *contentstr;
@property (nonatomic,strong) NSString *timestr;
@property (nonatomic,strong) NSMutableArray *picNamesArray;

@property (nonatomic, assign) BOOL isOpening;
@property (nonatomic,strong) NSMutableArray<DemoCommentModel *> *commentArray;
@property (nonatomic, assign) BOOL isMore;
@end
