//
//  UIView+Utils.m
//  Fishread
//
//  Created by 王俊钢 on 2017/6/12.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)
- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}
@end
