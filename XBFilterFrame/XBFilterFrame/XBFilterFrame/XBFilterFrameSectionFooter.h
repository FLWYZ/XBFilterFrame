//
//  XBFilterFrameSectionFooter.h
//  XueBa
//
//  Created by WYZ on 16/6/12.
//  Copyright © 2016年 Wenba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBFilterFrameSectionFooter : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIView *contentView;

- (void)updateInset:(UIEdgeInsets)sectionInset;

@end
