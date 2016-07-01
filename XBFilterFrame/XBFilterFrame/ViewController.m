//
//  ViewController.m
//  XBFilterFrame
//
//  Created by WYZ on 16/7/1.
//  Copyright © 2016年 com.WYZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<XBFilterFrameDelegate>

@property (strong, nonatomic) XBFilterFrame * filterframe;
@property (strong, nonatomic) NSArray * section_1_title_array;
@property (strong, nonatomic) NSArray * section_2_title_array;
@property (copy, nonatomic) NSString * section_1_select_title;
@property (copy, nonatomic) NSString * section_2_select_title;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.section_1_select_title = @"全部体裁";
    self.section_2_select_title = @"高中";
    
}

- (IBAction)showFilterAction:(UIBarButtonItem *)sender {
    if (self.filterframe.isShowing) {
        [self.filterframe dismiss];
    }else{
        [self.filterframe show];
    }
}

#pragma mark - filter frame delegate

- (void)filterframe:(XBFilterFrame *)filterframe didSelectItemAtIndexPath:(NSIndexPath *)indexPath itemTitle:(NSString *)title{
    NSLog(@"---------- %@+++++++++ %@",indexPath,title);
}

- (void)filterframe:(XBFilterFrame *)filterframe didTapSubmitButton:(NSArray *)selectDataArray{//点击确定按钮
    XBFilterFrameSelectItemModel * section_1 = selectDataArray.firstObject;
    XBFilterFrameSelectItemModel * section_2 = selectDataArray.lastObject;
    self.section_1_select_title = section_1.titleString;
    self.section_2_select_title = section_2.titleString;
    NSLog(@"*** %@",selectDataArray);
}

#pragma mark - setter / getter

- (XBFilterFrame *)filterframe{
    if (_filterframe == nil) {
        _filterframe = [[XBFilterFrame alloc]initWithParamMaker:^(XBFilterFrameParamMaker *maker) {
            maker.FilterFrame_BaseVC(self).FilterFrame_DisplayArea(CGRectMake(0, 64, kShareBasicParams.screenWidth, kShareBasicParams.screenHeight - 64.0));
                XBFilterFrameSectionDataModel * model1 = kCreateSectionDataModel.SectionModel_SectionHeader(@"选择题材").SectionModel_SectionFooter(YES).SectionModel_CellTitles(self.section_1_title_array).SectionModel_SelectCellTitles(@[self.section_1_select_title]);
                XBFilterFrameSectionDataModel * model2 = kCreateSectionDataModel.SectionModel_SectionHeader(@"年级选择").SectionModel_SectionFooter(YES).SectionModel_CellTitles(self.section_2_title_array).SectionModel_SelectCellTitles(@[self.section_2_select_title]);
                maker.FilterFrame_AddSectionData(model1).FilterFrame_AddSectionData(model2).FilterFrame_ShowSubmitButton(YES);
        }];
        _filterframe.delegate = self;
    }
    return _filterframe;
}

- (NSArray *)section_1_title_array{
    if (_section_1_title_array == nil) {
        _section_1_title_array = @[@"全部题材",@"议论文",@"记叙文",@"说明文",@"应用文",@"散文",@"读后感",@"写人",@"写景",@"状物文"];
    }
    return _section_1_title_array;
}

- (NSArray *)section_2_title_array{
    if (_section_2_title_array == nil) {
        _section_2_title_array = @[@"高中",@"初中",@"小学"];
    }
    return _section_2_title_array;
}

@end
