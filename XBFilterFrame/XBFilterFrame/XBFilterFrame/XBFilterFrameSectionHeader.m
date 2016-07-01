//
//  XBFilterFrameSectionHeader.m
//  XueBa
//
//  Created by WYZ on 16/6/12.
//  Copyright © 2016年 Wenba. All rights reserved.
//

#import "XBFilterFrameSectionHeader.h"

@interface XBFilterFrameSectionHeader()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;


@end

@implementation XBFilterFrameSectionHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = XBMakeColor(kXBColorTextComment);
}

- (void)updateInset:(UIEdgeInsets)sectionInset{
    self.leading.constant = sectionInset.left;
    self.trailing.constant = sectionInset.right;
    self.top.constant = sectionInset.top;
}

@end
