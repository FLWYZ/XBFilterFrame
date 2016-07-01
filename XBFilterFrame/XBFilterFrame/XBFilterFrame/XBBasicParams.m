//
//  XBBasicParams.m
//  XBFilterFrame
//
//  Created by WYZ on 16/7/1.
//  Copyright © 2016年 com.WYZ. All rights reserved.
//

#import "XBBasicParams.h"

static XBBasicParams * instance = nil;

@implementation XBBasicParams
+ (instancetype)shareBasicParams{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XBBasicParams alloc]init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        self.screenWidth = screenBounds.size.width;
        self.screenHeight = screenBounds.size.height;
        self.singleLineHeight = (1.0 / [UIScreen mainScreen].scale);
    }
    return self;
}

@end
