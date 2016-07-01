//
//  UIColor+Extension.h
//  XBFilterFrame
//
//  Created by WYZ on 16/7/1.
//  Copyright © 2016年 com.WYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)colorWithRGBHex:(NSInteger)hex;

+ (UIColor *)colorWithRGBHex:(NSInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)randomColor;

@end
