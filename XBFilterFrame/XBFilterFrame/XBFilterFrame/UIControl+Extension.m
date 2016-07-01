//
//  UIControl+Extension.m
//  XBFilterFrame
//
//  Created by WYZ on 16/7/1.
//  Copyright © 2016年 com.WYZ. All rights reserved.
//

#import "UIControl+Extension.h"
#import <objc/runtime.h>
@interface UIControlWarper : NSObject<NSCopying>
@property (assign, nonatomic) UIControlEvents controlEvent;
@property (copy, nonatomic) void (^invokeBlock)(UIControl * control,UIControlEvents events);
@end

@implementation UIControlWarper

- (instancetype)initWithControlEvent:(UIControlEvents)event invokeBlock:(void(^)(UIControl *control,UIControlEvents events))block{
    if (self = [super init]) {
        self.invokeBlock = block;
        self.controlEvent = event;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    return [[UIControlWarper alloc]initWithControlEvent:self.controlEvent invokeBlock:self.invokeBlock];
}

- (void)invoke:(id)sender{
    if (self.invokeBlock) {
        self.invokeBlock(sender,self.controlEvent);
    }
}

@end

@interface UIControl()
@property (strong, nonatomic) NSMutableDictionary * actionDictionary;
@end

static char kActionDictionaryKey = '\0';

@implementation UIControl (Extension)

- (void)addActionBlock:(void (^)(UIControl *, UIControlEvents))block forControlerEvent:(UIControlEvents)event{
    NSString * eventKey = [@(event) stringValue];
    NSMutableSet * actionSet = self.actionDictionary[eventKey];
    if (actionSet == nil) {
        actionSet = [NSMutableSet set];
        self.actionDictionary[eventKey] = actionSet;
    }
    UIControlWarper * warper = [[UIControlWarper alloc]initWithControlEvent:event invokeBlock:block];
    [actionSet addObject:warper];
    [self addTarget:warper action:@selector(invoke:) forControlEvents:event];
}

- (NSMutableDictionary *)actionDictionary{
    if (objc_getAssociatedObject(self, &kActionDictionaryKey) == nil) {
        self.actionDictionary = [NSMutableDictionary dictionary];
    }
    return objc_getAssociatedObject(self, &kActionDictionaryKey);
}

- (void)setActionDictionary:(NSMutableDictionary *)actionDictionary{
    objc_setAssociatedObject(self, &kActionDictionaryKey, actionDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
