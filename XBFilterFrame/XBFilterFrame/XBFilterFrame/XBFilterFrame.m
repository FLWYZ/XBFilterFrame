//
//  XBFilterFrame.m
//  XueBa
//
//  Created by WYZ on 16/6/12.
//  Copyright © 2016年 Wenba. All rights reserved.
//

#import "XBFilterFrame.h"
#import "XBFilterFrameCell.h"
#import "XBFilterFrameSectionHeader.h"
#import "XBFilterFrameSectionFooter.h"

@interface XBFilterFrame()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray * activeCells;

@property (strong, nonatomic) CALayer * bgColorLayer;

@property (assign, nonatomic) CGFloat whiteBaseHeight;

@property (assign, nonatomic) CGFloat filterCollectionHeight;

@property (strong, nonatomic, readwrite) UIButton * submitButton;

@property (strong, nonatomic, readwrite) UICollectionView * filterCollection;

@property (strong, nonatomic, readwrite) UIView * whiteBaseView;

@end

@implementation XBFilterFrame

#pragma mark - life cycle
- (instancetype)initWithParamMaker:(void (^)(XBFilterFrameParamMaker *))paramBlock{
    if (self = [super init]) {
        paramBlock(self.paramMaker);
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithBaseView:(UIViewController *)baseViewController displayArea:(CGRect)displayArea cellTitles:(NSArray *)cellTitles selectCellTitles:(NSArray *)selectCellTitles sectionHeaders:(NSArray *)sectionTitles showSubmitButton:(BOOL)showSubmitButton{
    if (baseViewController == nil || cellTitles.count <= 0) {
        return nil;
    }else{
        self = [super init];
        self.paramMaker.FilterFrame_BaseVC(baseViewController).FilterFrame_DisplayArea(displayArea).FilterFrame_ShowSubmitButton(showSubmitButton);
        for (NSInteger index = 0; index < cellTitles.count; index++) {
            XBFilterFrameSectionDataModel * model = kCreateSectionDataModel;
            model.SectionModel_CellTitles(cellTitles[index]).SectionModel_SelectCellTitles(selectCellTitles.count > index ? selectCellTitles[index] : @[]).SectionModel_SectionHeader(sectionTitles.count > index ? sectionTitles[index] : @"").SectionModel_SectionFooter(cellTitles.count > 1 );
            self.paramMaker.FilterFrame_AddSectionData(model);
        }
        [self setupUI];
    }
    return self;
}

- (void)setSubmitButtonTtile:(NSString *)title{
    if (self.paramMaker.showSubmitButton) {
        [self.submitButton setTitle:title];
    }
}

#pragma mark - public method

- (void)show{
    if (self.isShowing == NO) {
        if (self.paramMaker.baseView != nil) {
            [self.paramMaker.baseView addSubview:self];
        }else if (self.paramMaker.baseViewController != nil) {
             [self.paramMaker.baseViewController.view addSubview:self];
        }else{
            return;
        }
        if (self.paramMaker.belowView != nil) {
            [self.superview insertSubview:self belowSubview:self.paramMaker.belowView];
        }
        self.isShowing = YES;
        [self.filterCollection reloadData];
        
        if (self.paramMaker.showAnimationBlock) {
            self.paramMaker.showAnimationBlock(self);
        }else{
            self.whiteBaseView.y = -self.whiteBaseView.height;
            [UIView animateWithDuration:0.25 animations:^{
                self.whiteBaseView.y = 0;
                self.bgColorLayer.opacity = 1.0;
            }];
        }
    }
}

- (void)dismiss{
    if (self.isShowing == YES) {
        self.isShowing = NO;
        [self.activeCells removeAllObjects];
        [self.paramMaker reset];
        if (self.paramMaker.dismissAnimationBlock) {
            self.paramMaker.dismissAnimationBlock(self);
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                self.whiteBaseView.y = -self.whiteBaseView.height;
                self.bgColorLayer.opacity = 0.0;
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
    }
}

- (void)updateUI{
    CGFloat whiteBaseHeight = self.whiteBaseHeight;
    self.whiteBaseView.frame = CGRectMake(0, 0, self.width, whiteBaseHeight);
    self.filterCollection.frame = CGRectMake(0, 0, self.width, whiteBaseHeight - (self.paramMaker.showSubmitButton ? 74.0 : 0));
    if (self.paramMaker.showSubmitButton == YES) {
        self.submitButton.frame = CGRectMake(20, whiteBaseHeight - 15 - 44.0, self.width - 40, 44.0);
    }
    [self layoutSubviews];
    [self.filterCollection reloadData];
}

#pragma mark - collection delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.paramMaker.sectionDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    XBFilterFrameSectionDataModel * dataModel = self.paramMaker.sectionDataArray[section];
    return dataModel.sectionCellTitleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XBFilterFrameCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[XBFilterFrameCell description] forIndexPath:indexPath];
    XBFilterFrameSectionDataModel * model = self.paramMaker.sectionDataArray[indexPath.section];
    cell.titleLabel.font = [UIFont systemFontOfSize:model.cellTextSize];
    NSString * cellTitle = model.sectionCellTitleArray[indexPath.row];
    cell.indexPath = indexPath;
    [cell inactive];
    if ([model.tempararySelectItemArray containsObject:cellTitle]) {
        [cell active];
        if ([self.activeCells containsObject:cell] == NO) {
            [self.activeCells addObject:cell];
        }
    }
    cell.titleLabel.text = model.sectionCellTitleArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    XBFilterFrameSectionDataModel * model = self.paramMaker.sectionDataArray[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XBFilterFrameSectionHeader * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[XBFilterFrameSectionHeader description] forIndexPath:indexPath];
        header.titleLabel.text = model.sectionHeaderString;
        [header updateInset:model.sectionInset];
        return header;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        XBFilterFrameSectionFooter * footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[XBFilterFrameSectionFooter description] forIndexPath:indexPath];
        [footer updateInset:model.sectionInset];
        return footer;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.paramMaker dataModelInSection:indexPath.section].cellSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    XBFilterFrameSectionDataModel * model = [self.paramMaker dataModelInSection:section];
    if (model.hasSectionFooter) {
        return CGSizeMake(self.width - 40.0, kShareBasicParams.singleLineHeight + model.sectionFooterHeightPlus );
    }else{
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    XBFilterFrameSectionDataModel * model = [self.paramMaker dataModelInSection:section];
    if (model.sectionHeaderString.isNotEmpty) {
        return CGSizeMake(self.width - 40.0, 15 + model.sectionHeaderHeightPlus + model.sectionInset.top);
    }else{
        return CGSizeZero;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return [self.paramMaker dataModelInSection:section].lineSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return [self.paramMaker dataModelInSection:section].interItemSpace;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return [self.paramMaker dataModelInSection:section].sectionInset;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    XBFilterFrameSectionDataModel * model = [self.paramMaker dataModelInSection:indexPath.section];
    NSString * title = model.sectionCellTitleArray[indexPath.row];
    
    XBFilterFrameCell * cell = (XBFilterFrameCell *)[collectionView cellForItemAtIndexPath:indexPath];
    ResetResult result = [self.paramMaker resetSelectTitle:indexPath];
    
    if (result == ResetResult_Add) {
        [cell active];
        if (model.multipleChoose == NO) {
            for (NSInteger index = self.activeCells.count - 1; index >= 0 ; index--) {
                XBFilterFrameCell * currentActiveCell = self.activeCells[index];
                if (currentActiveCell.indexPath.section == indexPath.section) {
                    [currentActiveCell inactive];
                    [self.activeCells removeObjectAtIndex:index];
                }
            }
        }
        [self.activeCells addObject:cell];
    }else if(result == ResetResult_Remove){
        [cell inactive];
        if ([self.activeCells containsObject:cell]) {
            [self.activeCells removeObject:cell];
        }
    }
    if (self.paramMaker.showSubmitButton == NO) {// 一般这种情况，只会出现在单选的情况下
        [self.paramMaker mergeSelectArray_TempArray];
        [self dismiss];
    }
    if (self.selectItemBlock) {
        self.selectItemBlock(self,indexPath,title);
    }else if ([self.delegate respondsToSelector:@selector(filterframe:didSelectItemAtIndexPath:itemTitle:)]){
        [self.delegate filterframe:self didSelectItemAtIndexPath:indexPath itemTitle:title];
    }
}

#pragma mark - private method

- (void)setupUI{
    self.frame = self.paramMaker.displayArea;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    self.bgColorLayer.opacity = 0.0;
    [self.layer addSublayer:self.bgColorLayer];
    
    self.whiteBaseView.frame = CGRectMake(0, 0, self.width, self.whiteBaseHeight);
    [self.whiteBaseView addSubview:self.filterCollection];
    
    if (self.paramMaker.showSubmitButton) {
        [self.whiteBaseView addSubview:self.submitButton];
    }
    [self addSubview:self.whiteBaseView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.tapBlankSpaceBlock) {
        self.tapBlankSpaceBlock(self);
    }else if ([self.delegate respondsToSelector:@selector(filterframeTapBlankSpace:)]){
        [self.delegate filterframeTapBlankSpace:self];
    }
    [self dismiss];
}

- (CGFloat)filterCollectionHeight{
    CGFloat height = 0;
    for (NSInteger index = 0; index < self.paramMaker.sectionDataArray.count; index++) {
        XBFilterFrameSectionDataModel * model = self.paramMaker.sectionDataArray[index];
        height += model.sectionInset.top + model.sectionInset.bottom;
        height += model.hasSectionFooter ?  (1.0 + model.sectionFooterHeightPlus) : 0;
        height += model.sectionHeaderString.isNotEmpty ? (15.0 + model.sectionHeaderHeightPlus + model.sectionInset.top): 0;
        height += model.lineNumber * model.cellSize.height;
        height += (model.lineNumber - 1) * model.lineSpace;
    }
    return height;
}

- (CGFloat)whiteBaseHeight{
    CGFloat height = self.filterCollectionHeight;
    if (self.paramMaker.showSubmitButton) {
        height += 74;
    }
    if (height > 7.0 / 8.0 * self.height) {
        height = 7.0 / 8.0 * self.height;
    }
    return height;
}

#pragma mark - setter / getter
- (XBFilterFrameParamMaker *)paramMaker{
    if (_paramMaker == nil) {
        _paramMaker = [[XBFilterFrameParamMaker alloc]init];
    }
    return _paramMaker;
}

- (UICollectionView *)filterCollection{
    if (_filterCollection == nil) {
        _filterCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.whiteBaseHeight - (self.paramMaker.showSubmitButton ? 74.0 : 0)) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        [_filterCollection registerNib:[UINib nibWithNibName:[XBFilterFrameCell description] bundle:nil] forCellWithReuseIdentifier:[XBFilterFrameCell description]];
        [_filterCollection registerNib:[UINib nibWithNibName:[XBFilterFrameSectionHeader description] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[XBFilterFrameSectionHeader description]];
        [_filterCollection registerNib:[UINib nibWithNibName:[XBFilterFrameSectionFooter description] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[XBFilterFrameSectionFooter description]];
        _filterCollection.backgroundColor = [UIColor whiteColor];
        _filterCollection.dataSource = self;
        _filterCollection.delegate = self;
    }
    return _filterCollection;
}

- (NSMutableArray *)activeCells{
    if (_activeCells == nil) {
        _activeCells = [NSMutableArray array];
    }
    return _activeCells;
}

- (UIButton *)submitButton{
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.frame = CGRectMake(20, self.whiteBaseHeight - 15 - 44.0, self.width - 40, 44.0);
        [_submitButton setTitle:self.paramMaker.submitButtonTitle];
        _submitButton.backgroundColor = XBMakeColor(kXBColorFrontColor);
        _submitButton.layer.cornerRadius = 5.0;
        __weak typeof(self) weakself = self;
        [_submitButton addActionBlock:^(UIControl *button, UIControlEvents events) {
            [weakself.paramMaker mergeSelectArray_TempArray];
            [weakself dismiss];
            if (weakself.tapSubmitBlock) {
                weakself.tapSubmitBlock(weakself,weakself.paramMaker.selectItems);
            }else if([weakself.delegate respondsToSelector:@selector(filterframe:didTapSubmitButton:)]){
                [weakself.delegate filterframe:weakself didTapSubmitButton:weakself.paramMaker.selectItems];
            }
        } forControlerEvent:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (CALayer *)bgColorLayer{
    if (_bgColorLayer == nil) {
        _bgColorLayer = [CALayer layer];
        _bgColorLayer.frame = CGRectMake(0, 0, self.width, self.height);
        _bgColorLayer.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.65].CGColor;
    }
    return _bgColorLayer;
}

- (UIView *)whiteBaseView{
    if (_whiteBaseView == nil) {
        _whiteBaseView = [[UIView alloc]init];
        _whiteBaseView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBaseView;
}

@end
