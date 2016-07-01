//
//  XBFilterFrameCell.m
//  XueBa
//
//  Created by WYZ on 16/6/12.
//  Copyright © 2016年 Wenba. All rights reserved.
//

#import "XBFilterFrameCell.h"

@implementation XBFilterFrameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.layer.cornerRadius = 15.0;
    
}

- (void)active{
    self.titleLabel.textColor = XBMakeColor(kXBColorFrontColor);
    self.titleLabel.layer.borderColor = XBMakeColor(kXBColorFrontColor).CGColor;
    self.titleLabel.layer.borderWidth = kShareBasicParams.singleLineHeight * 2;
}

- (void)inactive{
    self.titleLabel.textColor = XBMakeColor(kXBColorTextContent);
    self.titleLabel.layer.borderColor = XBMakeColor(kXBColorTextComment).CGColor;
    self.titleLabel.layer.borderWidth = kShareBasicParams.singleLineHeight;
}

@end
