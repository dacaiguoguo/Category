//
//  YKCategoryClasses.h
//  Category
//
//  Created by  yanguo.sun on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//


@class YKSectionHeaderView;
@interface YKDataMoudleList : NSObject
@property (assign) BOOL open;
@property (nonatomic, retain) YKSectionHeaderView *headerView_cate;
@property (nonatomic, retain) NSArray *subArray;

@end

@protocol YKSectionHeaderViewDelegate;


@interface YKSectionHeaderView : UIView

@property (nonatomic, assign) UILabel *titleLabel;
@property (nonatomic, assign) UILabel *subTitleLabel;
@property (nonatomic, assign) UIImageView *iconImage;
@property (nonatomic, assign) UIImageView *lineImage;
@property (nonatomic, assign) UIButton *disclosureButton;
@property (nonatomic, assign)  UILabel *lineLabel;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) id <YKSectionHeaderViewDelegate> delegate;
@property (nonatomic, assign) BOOL iselected;
-(id)initWithFrame:(CGRect)frame title:(NSString*)title subTitle:(NSString*)subTitle imageUrl:(NSString *)imgaeUrl section:(NSInteger)sectionNumber delegate:(id <YKSectionHeaderViewDelegate>)delegate;

-(void)toggleOpenWithUserAction:(BOOL)userAction;
- (void)setUpLineChange:(BOOL)change;
@end





/*
 Protocol to be adopted by the section header's delegate; the section header tells its delegate when the section should be opened and closed.
 */
@protocol YKSectionHeaderViewDelegate <NSObject>

@optional
-(void)sectionHeaderView:(YKSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(YKSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;
- (int)get_OpenSectionIndex;

@end


/*!
 @class YKButtonForGategory
 @discussion 带有YKVanclCategory信息的button
 @superclass UIButton
 */
@interface YKButtonForGategory : UIButton
//@property(nonatomic, retain) YKDataMode* aCategory;
@end

/*!
 @class YKTableViewCellForGategory
 @discussion 带有两个YKButtonForGategory，分类信息显示两列用Cell
 @superclass UITableViewCell
 */
@interface YKTableViewCellForGategory : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *leftLabel;
@property (retain, nonatomic) IBOutlet UILabel *rightLabel;
@property (retain, nonatomic) IBOutlet YKButtonForGategory *leftGategory;
@property (retain, nonatomic) IBOutlet YKButtonForGategory *rightGategory;

@end