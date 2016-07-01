//
//  NSObject+Extension.m
//  XBFilterFrame
//
//  Created by WYZ on 16/7/1.
//  Copyright © 2016年 com.WYZ. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)
- (BOOL)isNotEmpty{
    if (self == nil) {
        return NO;
    }else{
        if ([self isKindOfClass:[NSString class]]) {
            return ((NSString *)self).length != 0;
        }else if ([self isKindOfClass:[NSArray class]]){
            return ((NSArray *)self).count != 0;
        }else if ([self isKindOfClass:[NSDictionary class]]){
            return ((NSDictionary *)self).allKeys.count != 0;
        }
        return YES;
    }
}
@end
