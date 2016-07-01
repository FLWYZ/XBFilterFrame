//
//  XBFilterFrameParamMaker.m
//  XueBa
//
//  Created by WYZ on 16/6/12.
//  Copyright © 2016年 Wenba. All rights reserved.
//

#import "XBFilterFrameParamMaker.h"

@interface XBFilterFrameSectionDataModel()
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_SectionHeader) (NSString *sectionHeader);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_CellTitles) (NSArray * cellTitles);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_SelectCellTitles) (NSArray * selectCellTitles);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_NumberOfItemInLine) (NSInteger numberOfItemsInLine);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_SectionInset) (UIEdgeInsets sectionInset);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_LineSpace) (CGFloat lineSpace);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_InterItemSpace) (CGFloat interItemSpace);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_SectionFooter) (BOOL hasSectionFooter);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_MultipleChoose) (BOOL mChoose);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_SectionHeaderHeight) (CGFloat extraPlus);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_SectionFooterHeight) (CGFloat extraPlus);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_CellTextSize) (CGFloat size);
@property (copy, nonatomic, readwrite) XBFilterFrameSectionDataModel * (^SectionModel_CellSize) (CGSize size);
@property (assign, nonatomic,readwrite) CGFloat interItemSpace;

@end

@implementation XBFilterFrameSectionDataModel

- (instancetype)init{
    if (self = [super init]) {
        _sectionSelectCellTitleArray = [NSMutableArray array];
        self.numberOfItemsInLine = 3;
        self.lineSpace = 18.0;
        self.interItemSpace = (kShareBasicParams.screenWidth - 20 - 20 - kShareBasicParams.screenWidth * 90.0 / 375.0 * 3) / 2.0;
        self.hasSectionFooter = NO;
        self.multipleChoose = NO;
        self.sectionHeaderHeightPlus = 0.0;
        self.sectionFooterHeightPlus = 0.0;
        self.sectionInset = (UIEdgeInsetsMake(20, 20, 20, 20));
        self.cellSize = CGSizeMake(kShareBasicParams.screenWidth * 90.0 / 375.0, 30.0);
        self.cellTextSize = 15.0;
    }
    return self;
}

+ (instancetype)createSectionDataModel{
    return [[XBFilterFrameSectionDataModel alloc]init];
}

- (void)reset{
    [_tempararySelectItemArray removeAllObjects];
    _tempararySelectItemArray = nil;
}

- (NSInteger)lineNumber{
    NSInteger extra = 0;
    if (self.sectionCellTitleArray.count % self.numberOfItemsInLine != 0) {
        extra = 1;
    }
    return self.sectionCellTitleArray.count / self.numberOfItemsInLine + extra;
}

- (XBFilterFrameSectionDataModel *(^)(NSString *))SectionModel_SectionHeader{
    return ^(NSString * sectionHeader){
        self.sectionHeaderString = sectionHeader;
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(NSArray *))SectionModel_CellTitles{
    return ^(NSArray * cellTitles){
        if (cellTitles == nil) {
            return self;
        }
        if ([cellTitles isKindOfClass:[NSArray class]] == NO) {
            self.sectionCellTitleArray = @[cellTitles];
            return self;
        }
        self.sectionCellTitleArray = cellTitles;
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(NSArray *))SectionModel_SelectCellTitles{
    return ^(NSArray * selectCellTitles){
        if (selectCellTitles == nil) {
            return self;
        }
        if ([selectCellTitles isKindOfClass:[NSArray class]] == NO) {
            self.sectionSelectCellTitleArray = [NSMutableArray arrayWithArray:@[selectCellTitles]];
            return self;
        }
        self.sectionSelectCellTitleArray = [NSMutableArray arrayWithArray:selectCellTitles];
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(NSInteger))SectionModel_NumberOfItemInLine{
    return ^(NSInteger numberOfItemInLine){
        self.numberOfItemsInLine = numberOfItemInLine;
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(UIEdgeInsets))SectionModel_SectionInset{
    return ^(UIEdgeInsets sectionInset){
        self.sectionInset = sectionInset;
        if (self.sectionHeaderHeightPlus == 0) {
            self.sectionHeaderHeightPlus = sectionInset.top;
        }
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(CGFloat))SectionModel_LineSpace{
    return ^(CGFloat lineSpace){
        self.lineSpace = lineSpace;
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(BOOL))SectionModel_SectionFooter{
    return ^(BOOL hasSectionFooter){
        self.hasSectionFooter = hasSectionFooter;
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(BOOL))SectionModel_MultipleChoose{
    return ^(BOOL mChoose){
        self.multipleChoose = mChoose;
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(CGFloat))SectionModel_CellTextSize{
    return ^(CGFloat textSize){
        self.cellTextSize = textSize;
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(CGFloat))SectionModel_SectionHeaderHeight{
    return ^(CGFloat extraHeaderHeight){
        self.sectionHeaderHeightPlus = extraHeaderHeight;
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(CGFloat))SectionModel_SectionFooterHeight{
    return ^(CGFloat extraFooterHeight){
        self.sectionFooterHeightPlus = extraFooterHeight;
        return self;
    };
}

- (XBFilterFrameSectionDataModel *(^)(CGSize))SectionModel_CellSize{
    return ^(CGSize cellSize){
        self.cellSize = cellSize;
        return self;
    };
}

- (NSMutableArray *)tempararySelectItemArray{
    if (_tempararySelectItemArray == nil) {
        _tempararySelectItemArray = [NSMutableArray arrayWithArray:self.sectionSelectCellTitleArray];
    }
    return _tempararySelectItemArray;
}

- (void)setCellSize:(CGSize)cellSize{
    [self willChangeValueForKey:@"cellSize"];
    _cellSize = cellSize;
    [self didChangeValueForKey:@"cellSize"];
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset{
    [self willChangeValueForKey:@"sectionInset"];
    _sectionInset = sectionInset;
    [self didChangeValueForKey:@"sectionInset"];
}

- (void)setNumberOfItemsInLine:(NSInteger)numberOfItemsInLine{
    [self willChangeValueForKey:@"numberOfItemsInLine"];
    _numberOfItemsInLine = numberOfItemsInLine;
    [self didChangeValueForKey:@"numberOfItemsInLine"];
}

- (void)setSectionSelectCellTitleArray:(NSMutableArray *)sectionSelectCellTitleArray{
    _sectionSelectCellTitleArray = sectionSelectCellTitleArray;
    [self reset];
}

- (void)didChangeValueForKey:(NSString *)key{
    if ([key isEqualToString:@"sectionInset"] ||
        [key isEqualToString:@"numberOfItemsInLine"] ||
        [key isEqualToString:@"cellSize"]) {
        if (self.numberOfItemsInLine > 1) {
            self.interItemSpace = (kShareBasicParams.screenWidth - self.numberOfItemsInLine * self.cellSize.width - self.sectionInset.left - self.sectionInset.right) * 1.0 / (self.numberOfItemsInLine - 1);
        }
        else{
            self.interItemSpace = (kShareBasicParams.screenWidth - self.sectionInset.left - self.sectionInset.right - self.cellSize.width) / 2.0;
        }
    }
}

@end


@interface XBFilterFrameParamMaker()

@property (copy, nonatomic, readwrite) XBFilterFrameParamMaker * (^filterframe_ShowSubmitButton) (BOOL showSubmitButton);
@property (copy, nonatomic, readwrite) XBFilterFrameParamMaker * (^filterframe_BaseVC) (UIViewController * baseVC);
@property (copy, nonatomic, readwrite) XBFilterFrameParamMaker * (^filterframe_DisplayArea) (CGRect displayArea);
@property (copy, nonatomic, readwrite) XBFilterFrameParamMaker * (^filterframe_ShowAnimation) (ShowAnimation animation);
@property (copy, nonatomic, readwrite) XBFilterFrameParamMaker * (^filterframe_DismissAnimation) (DismissAnimation dismissAnimation);
@property (copy, nonatomic, readwrite) XBFilterFrameParamMaker * (^filterframe_BaseView) (UIView * baseView);
@property (copy, nonatomic, readwrite) XBFilterFrameParamMaker * (^filterframe_AddSectionData) (XBFilterFrameSectionDataModel * dataModel);
@property (copy, nonatomic, readwrite) XBFilterFrameParamMaker * (^FilterFrame_SubmitButton) (NSString * title);
@property (copy, nonatomic, readwrite) XBFilterFrameParamMaker * (^FilterFrame_BelowView) (UIView * title);
@end

@implementation XBFilterFrameParamMaker

- (instancetype)init{
    if (self = [super init]) {
        self.showSubmitButton = NO;
        self.displayArea = CGRectZero;
        self.submitButtonTitle = @"确认";
    }
    return self;
}

- (ResetResult)resetSelectTitle:(NSIndexPath *)newSelectTileIndexPath{
    XBFilterFrameSectionDataModel * model = [self dataModelInSection:newSelectTileIndexPath.section];
    NSString * newTitle = model.sectionCellTitleArray[newSelectTileIndexPath.row];
    ResetResult result = ResetResult_Default;
    if (model.multipleChoose == YES) {// 支持多选
        NSInteger index = [model.tempararySelectItemArray indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            return [newTitle isEqualToString:obj];
        }];
        if (index != NSNotFound) {
            [model.tempararySelectItemArray removeObjectAtIndex:index];
            result = ResetResult_Remove;
        }else{
            [model.tempararySelectItemArray addObject:newTitle];
            result = ResetResult_Add;
        }
    }else{//单选
        if ([model.tempararySelectItemArray containsObject:newTitle]== NO) {
            model.tempararySelectItemArray = [NSMutableArray arrayWithObject:newTitle];
            result = ResetResult_Add;
        }
    }
    return result;
}

- (NSArray *)selectItems{
    NSMutableArray * selectItems = [NSMutableArray arrayWithCapacity:3];
    for (XBFilterFrameSectionDataModel * model in self.sectionDataArray) {
        for (NSInteger index = 0; index < model.sectionSelectCellTitleArray.count; index++) {
            XBFilterFrameSelectItemModel * selectModel = [[XBFilterFrameSelectItemModel alloc]init];
            NSString * title = model.sectionSelectCellTitleArray[index];
            selectModel.titleString = title;
            selectModel.indexPath = [NSIndexPath indexPathForRow:[model.sectionCellTitleArray indexOfObject:title] inSection:model.section];
            [selectItems addObject:selectModel];
        }
    }
    return selectItems;
}

- (void)reset{
    for (XBFilterFrameSectionDataModel * sectionModel in self.sectionDataArray) {
        [sectionModel reset];
    }
}

- (void)mergeSelectArray_TempArray{
    for (XBFilterFrameSectionDataModel * sectionModel in self.sectionDataArray) {
        if ([sectionModel.tempararySelectItemArray isEqualToArray:sectionModel.sectionSelectCellTitleArray] == NO) {
            sectionModel.sectionSelectCellTitleArray = [NSMutableArray arrayWithArray:sectionModel.tempararySelectItemArray];
        }
    }
}

- (XBFilterFrameSectionDataModel *)dataModelInSection:(NSInteger)section{
    return self.sectionDataArray[section];
}

#pragma mark - setter / getter

- (XBFilterFrameParamMaker *(^)(BOOL))FilterFrame_ShowSubmitButton{
    return ^(BOOL showSubmitButton){
        self.showSubmitButton = showSubmitButton;
        return self;
    };
}

- (XBFilterFrameParamMaker *(^)(UIViewController *))FilterFrame_BaseVC{
    return ^(UIViewController * baseVC){
        self.baseViewController = baseVC;
        return self;
    };
}

- (XBFilterFrameParamMaker *(^)(UIView *))FilterFrame_BaseView{
    return ^(UIView * baseView){
        self.baseView = baseView;
        return self;
    };
}

- (XBFilterFrameParamMaker *(^)(CGRect))FilterFrame_DisplayArea{
    return ^(CGRect displayArea){
        self.displayArea = displayArea;
        return self;
    };
}

- (XBFilterFrameParamMaker *(^)(ShowAnimation))FilterFrame_ShowAnimation{
    return ^(ShowAnimation animation){
        self.showAnimationBlock = animation;
        return self;
    };
}

- (XBFilterFrameParamMaker *(^)(DismissAnimation))FilterFrame_DismissAnimation{
    return ^(DismissAnimation dismissAnimation){
        self.dismissAnimationBlock = dismissAnimation;
        return self;
    };
}

- (XBFilterFrameParamMaker *(^)(XBFilterFrameSectionDataModel *))FilterFrame_AddSectionData{
    return ^(XBFilterFrameSectionDataModel * model){
        model.section = self.sectionDataArray.count;
        [self.sectionDataArray addObject:model];
        return self;
    };
}

- (XBFilterFrameParamMaker *(^)(NSString *))FilterFrame_SubmitButton{
    return ^(NSString *title){
        self.submitButtonTitle = title;
        return self;
    };
}

- (XBFilterFrameParamMaker *(^)(UIView *))FilterFrame_BelowView{
    return ^(UIView *belowView){
        self.belowView = belowView;
        return self;
    };
}

- (NSMutableArray *)sectionDataArray{
    if (_sectionDataArray == nil) {
        _sectionDataArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _sectionDataArray;
}

- (CGRect)displayArea{
    if (CGRectEqualToRect(CGRectZero, _displayArea) == NO) {
        return _displayArea;
    }else if (_baseView != nil){
        return _baseView.bounds;
    }else if (_baseViewController != nil){
        return _baseViewController.view.bounds;
    }else{
        return CGRectZero;
    }
}

@end

@implementation XBFilterFrameSelectItemModel

@end

