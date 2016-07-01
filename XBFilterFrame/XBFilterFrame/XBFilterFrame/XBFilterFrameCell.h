//
//  XBFilterFrameCell.h
//  XueBa
//
//  Created by WYZ on 16/6/12.
//  Copyright © 2016年 Wenba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBFilterFrameCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (copy, nonatomic) NSIndexPath * indexPath;

- (void)active;

- (void)inactive;

@end
