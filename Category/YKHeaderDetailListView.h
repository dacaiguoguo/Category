//
//  YKHeaderDetailListView.h
//  Category
//
//  Created by  yanguo.sun on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
    @protocol YKHeaderDetailListViewDataSource
    @Description The YKHeaderDetailListViewDataSource protocol is adopted by an object that mediates the application’?s data model for a YKHeaderDetailListView object. The data source provides the YKHeaderDetailListView object with the information it needs to construct and modify a YKHeaderDetailListView.
 */
@protocol YKHeaderDetailListViewDataSource <NSObject>
/**
    @Declaration - (int)numOfTop
    @Description Asks the data source to return the number of sections in the view.
    @Return number of sections.
 */
- (int)numOfTop;
/**
    @Declaration - (NSString *)titleAtTopRow:(int)row
    @Description Asks the data source to return the title of sections in the row of view.
    @Return title of row.
 */
- (NSString *)titleAtTopRow:(int)row;
/**
    @Declaration - (NSArray *)itemsAtRow:(int)row
    @Description Asks the data source to return the sub data of section.
    @Return the sub data of section.
 */
- (NSArray *)itemsAtRow:(int)row;
/**
 @Declaration - (NSArray *)itemsAtRow:(int)row
 @Description Asks the data source to return the sub data of section.
 @Return the sub data of section.
 */
- (NSString *)subTitleAtTopRow:(int)row;
/**
 @Declaration - (NSInteger)numOfColumn
 @Description Asks the data source to return the sub data of section.
 @Return the sub data of section.
 */
- (NSInteger)numOfColumn;
/**
 @Declaration - (CGFloat)heightForHeader
 @Description Asks the data source to return the number of column.
 @Return the number of column.
 */
- (CGFloat)heightForHeader;
/**
 @Declaration - (CGFloat)heightForRow
 @Description Asks the data source to return the height For Header.
 @Return the height For Header.
 */
- (CGFloat)heightForRow;
@end

@class YKHeaderDetailListView;
@protocol YKHeaderDetailListViewDelegate <NSObject>

- (void)headerDetailList:(YKHeaderDetailListView *)_headerList didTapItemAtIndex:(NSIndexPath*)_index;

@end
/*
    @class YKHeaderDetailListView
    @superClass UIView
    @description 用tableView的header 点击向下展开Cell
 */
@interface YKHeaderDetailListView : UIView
@property (assign) id<YKHeaderDetailListViewDataSource> datasource;
@property (assign) id<YKHeaderDetailListViewDelegate> delegate;
-(void) reloadData;
@end
