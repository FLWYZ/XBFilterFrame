//
//  XBFilterFrameParamMaker.h
//  XueBa
//
//  Created by WYZ on 16/6/12.
//  Copyright © 2016年 Wenba. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCreateSectionDataModel [XBFilterFrameSectionDataModel createSectionDataModel]

@interface XBFilterFrameSelectItemModel : NSObject

@property (copy, nonatomic) NSIndexPath * indexPath;

@property (copy, nonatomic) NSString * titleString;

@end


@interface XBFilterFrameSectionDataModel : NSObject

@property (copy, nonatomic) NSString * sectionHeaderString;

@property (copy, nonatomic) NSArray * sectionCellTitleArray;

@property (strong, nonatomic) NSMutableArray * sectionSelectCellTitleArray;

@property (assign, nonatomic) NSInteger numberOfItemsInLine;

@property (assign, nonatomic) UIEdgeInsets sectionInset;

@property (assign, nonatomic) CGFloat lineSpace;

@property (assign, nonatomic, readonly) CGFloat interItemSpace;

@property (assign, nonatomic) NSInteger lineNumber;

@property (strong, nonatomic) NSMutableArray * tempararySelectItemArray;

@property (assign, nonatomic) CGSize cellSize;

/**
 *  the height for section header = 15 + sectionHeaderHeightPlus , defaultlf sectionHeaderHeightPlus is equal to sectionInset.top
 */
@property (assign, nonatomic) CGFloat sectionHeaderHeightPlus;

/**
 * the height for section footer = 1 + sectionFooterHeightPlus , defaultly sectionFooterHeightPlus isequal to zero
 */
@property (assign, nonatomic) CGFloat sectionFooterHeightPlus;

@property (assign, nonatomic) CGFloat cellTextSize;

/**
 *  是否支持多选，默认每个section是不支持多选的
 */
@property (assign, nonatomic) BOOL  multipleChoose;

@property (assign, nonatomic) BOOL hasSectionFooter;

/**
 *  内部计算时使用，外部不需要设置
 */
@property (assign, nonatomic) NSInteger section;

@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_SectionHeader) (NSString *sectionHeader);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_SectionFooter) (BOOL hasSectionFooter);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_CellTitles) (NSArray * cellTitles);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_SelectCellTitles) (NSArray * selectCellTitles);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_NumberOfItemInLine) (NSInteger numberOfItemsInLine);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_SectionInset) (UIEdgeInsets sectionInset);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_LineSpace) (CGFloat lineSpace);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_MultipleChoose) (BOOL mChoose);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_SectionHeaderHeight) (CGFloat extraPlus);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_SectionFooterHeight) (CGFloat extraPlus);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_CellTextSize) (CGFloat size);
@property (copy, nonatomic, readonly) XBFilterFrameSectionDataModel * (^SectionModel_CellSize) (CGSize size);

+ (instancetype)createSectionDataModel;

- (void)reset;

@end

@class XBFilterFrame;
typedef void (^ShowAnimation) (XBFilterFrame * filterframe);
typedef void (^DismissAnimation) (XBFilterFrame * filterframe);
typedef NS_ENUM(NSUInteger, ResetResult) {
    ResetResult_Add,
    ResetResult_Remove,
    ResetResult_Default
};

@interface XBFilterFrameParamMaker : NSObject

/**
 *  default is NO
 */
@property (assign, nonatomic) BOOL showSubmitButton;

/**
 *  U must set one of this three properties so I can calculate the display frame —— baseViewController , baseView , displayArea
 *  priority displayArea > baseView > baseViewController
 */
@property (weak, nonatomic) UIViewController * baseViewController;

@property (weak, nonatomic) UIView * baseView;

@property (weak, nonatomic) UIView * belowView;

@property (assign, nonatomic) CGRect displayArea;

@property (copy, nonatomic) NSMutableArray * sectionDataArray;

@property (copy, nonatomic) NSString * submitButtonTitle;

@property (copy, nonatomic) ShowAnimation showAnimationBlock;

@property (copy, nonatomic) DismissAnimation dismissAnimationBlock;

@property (copy, nonatomic, readonly) XBFilterFrameParamMaker * (^FilterFrame_ShowSubmitButton) (BOOL showSubmitButton);
@property (copy, nonatomic, readonly) XBFilterFrameParamMaker * (^FilterFrame_BaseVC) (UIViewController * baseVC);
@property (copy, nonatomic, readonly) XBFilterFrameParamMaker * (^FilterFrame_DisplayArea) (CGRect displayArea);
@property (copy, nonatomic, readonly) XBFilterFrameParamMaker * (^FilterFrame_ShowAnimation) (ShowAnimation animation);
@property (copy, nonatomic, readonly) XBFilterFrameParamMaker * (^FilterFrame_DismissAnimation) (DismissAnimation dismissAnimation);
@property (copy, nonatomic, readonly) XBFilterFrameParamMaker * (^FilterFrame_BaseView) (UIView * baseView);
@property (copy, nonatomic, readonly) XBFilterFrameParamMaker * (^FilterFrame_AddSectionData) (XBFilterFrameSectionDataModel * dataModel);
@property (copy, nonatomic, readonly) XBFilterFrameParamMaker * (^FilterFrame_SubmitButton) (NSString * title);
@property (copy, nonatomic, readonly) XBFilterFrameParamMaker * (^FilterFrame_BelowView) (UIView * title);

- (ResetResult)resetSelectTitle:(NSIndexPath *)newSelectTileIndexPath;

- (XBFilterFrameSectionDataModel *)dataModelInSection:(NSInteger)section;

- (NSArray *)selectItems;

/**
 *  重置某些数据
 */
//可能会出现这样的场景 —— 在有“确定”按钮的情况下，用户点击空白处，筛选匡收回。此时，用户再次点击筛选匡的话，则上一次的选择应该被重置
- (void)reset;

- (void)mergeSelectArray_TempArray;

@end
