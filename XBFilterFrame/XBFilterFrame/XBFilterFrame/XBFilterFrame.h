//
//  XBFilterFrame.h
//  XueBa
//
//  Created by WYZ on 16/6/12.
//  Copyright © 2016年 Wenba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBFilterFrameParamMaker.h"

@protocol XBFilterFrameDelegate <NSObject>

@optional
- (void) filterframe:(XBFilterFrame *)filterframe didSelectItemAtIndexPath:(NSIndexPath *)indexPath itemTitle:(NSString *)title;

- (void) filterframe:(XBFilterFrame *)filterframe didTapSubmitButton:(NSArray *)selectDataArray;

- (void) filterframeTapBlankSpace:(XBFilterFrame *)filterframe;

@end

/**
 *  if U set the base viewcontroller or baseview I will add XBFilterFrame into that view 
 *  and defaultly XBFilterFrame's alpha == 0
 */
@interface XBFilterFrame : UIView

@property (assign, nonatomic) BOOL isShowing;

@property (strong, nonatomic) XBFilterFrameParamMaker * paramMaker;

@property (weak, nonatomic) id<XBFilterFrameDelegate> delegate;

@property (strong, nonatomic, readonly) UIButton * submitButton;

@property (strong, nonatomic, readonly) UICollectionView * filterCollection;

@property (strong, nonatomic, readonly) UIView * whiteBaseView;

@property (copy, nonatomic) void (^selectItemBlock) (XBFilterFrame * filterframe, NSIndexPath * itemIndexPath, NSString * itemTitle);

@property (copy, nonatomic) void (^tapSubmitBlock) (XBFilterFrame * filterframe, NSArray * selectDataArray);

@property (copy, nonatomic) void (^tapBlankSpaceBlock) (XBFilterFrame * filterframe);

- (instancetype)initWithParamMaker:(void(^)(XBFilterFrameParamMaker *maker))paramBlock;

/**
 *  convince function ,最终 collectionview 中有几个section 是由 cellTitles来决定的
 */
- (instancetype)initWithBaseView:(UIViewController *)baseViewController
                     displayArea:(CGRect)displayArea
                      cellTitles:(NSArray *)cellTitles
                selectCellTitles:(NSArray *)selectCellTitles
                  sectionHeaders:(NSArray *)sectionTitles
                showSubmitButton:(BOOL)showSubmitButton;

- (void)setSubmitButtonTtile:(NSString *)title;

- (void)show;

- (void)dismiss;

- (void)updateUI;

@end
