//
//  DemoCommentView.h
//  Demo
//
//  Created by venusource on 16/9/1.
//  Copyright © 2016年 venusource.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myviewVdelegate <NSObject>
-(void)myTabVClick:(NSDictionary *)dic;

-(void)myTabVClickshanchuview:(NSString *)uidstr;
-(void)myTabVClickjubaoview:(NSDictionary *)dic;

@end

@interface DemoCommentView : UIView
//盛放评论数据模型的数组
@property(nonatomic,strong) NSArray *commentArray;
@property(assign,nonatomic)id<myviewVdelegate>delegate;
@end
