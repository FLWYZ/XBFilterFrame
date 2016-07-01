//
//  XBColorDefinition.h
//  XBFilterFrame
//
//  Created by WYZ on 16/7/1.
//  Copyright © 2016年 com.WYZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XBMakeColor(COLOR) [UIColor colorWithRGBHex:COLOR]

extern NSInteger const kXBColorFrontColor;
extern NSInteger const kXBColorTextContent;
extern NSInteger const kXBColorTextComment;
extern NSInteger const kXBColorViewSeparator;

@interface XBColorDefinition : NSObject

@end
