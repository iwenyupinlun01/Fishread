//
//  DemoCommentModel.h
//  Demo
//
//  Created by venusource on 16/9/1.
//  Copyright © 2016年 venusource.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoCommentModel : NSObject

@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end
