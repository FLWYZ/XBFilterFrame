//
//  XBBasicParams.h
//  XBFilterFrame
//
//  Created by WYZ on 16/7/1.
//  Copyright © 2016年 com.WYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kShareBasicParams [XBBasicParams shareBasicParams]

@interface XBBasicParams : NSObject

@property (assign, nonatomic) CGFloat screenWidth;
@property (assign, nonatomic) CGFloat screenHeight;
@property (assign, nonatomic) CGFloat singleLineHeight;

+ (instancetype) shareBasicParams;

@end
