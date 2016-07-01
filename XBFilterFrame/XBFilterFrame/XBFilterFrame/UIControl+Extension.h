//
//  UIControl+Extension.h
//  XBFilterFrame
//
//  Created by WYZ on 16/7/1.
//  Copyright © 2016年 com.WYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Extension)
- (void)addActionBlock:(void(^)(UIControl * control,UIControlEvents events))block
     forControlerEvent:(UIControlEvents)event;
@end
