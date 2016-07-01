//
//  XBFilterFrameSectionFooter.m
//  XueBa
//
//  Created by WYZ on 16/6/12.
//  Copyright © 2016年 Wenba. All rights reserved.
//

#import "XBFilterFrameSectionFooter.h"

@interface XBFilterFrameSectionFooter ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;


@end

@implementation XBFilterFrameSectionFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = XBMakeColor(kXBColorViewSeparator);
}

- (void)updateInset:(UIEdgeInsets)sectionInset{
    self.leading.constant = sectionInset.left;
    self.trailing.constant = sectionInset.right;
}

@end
