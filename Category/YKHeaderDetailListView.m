//
//  YKHeaderDetailListView.m
//  Category
//
//  Created by  yanguo.sun on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKHeaderDetailListView.h"
#import "YKCategoryClasses.h"

@interface YKHeaderDetailListView()<UITableViewDataSource,UITableViewDelegate,YKSectionHeaderViewDelegate>
@property (nonatomic, retain) UITableView *interTable;
/*!@var openSectionIndex 当前打开的Section*/
@property (nonatomic, assign) NSInteger openSectionIndex;
/*!@var openSectionIndex 当前打开的Section*/
@property (nonatomic, assign) NSInteger numberOfColumn;
/*!@var sectionInfoArray 分类信息数组*/
@property (nonatomic, retain) NSMutableDictionary* sectionInfoDic;

@property (assign) CGRect orgFrame;
- (void)delegateAction:(UIButton*)sender;
@end
@implementation YKHeaderDetailListView
- (void)dealloc{
    [super dealloc];
    _datasource = nil;
    _delegate = nil;
    [_sectionInfoDic release];
    [_interTable release];
}
- (id)initWithFrame:(CGRect)frame
{
    _orgFrame = frame;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.sectionInfoDic = [NSMutableDictionary dictionary];
        [self reloadData];
    }
    return self;
}

- (UITableView*)interTable{
    if (!_interTable) {
           _interTable = [[UITableView alloc] initWithFrame:_orgFrame style:UITableViewStylePlain] ;
        _interTable.dataSource = self;
        _interTable.delegate = self;
        [self addSubview:_interTable];
        [_interTable release];
    }
    return _interTable;
}

- (NSInteger)numberOfColumn{
    NSInteger ret = 1;
    if (self.datasource) {
        ret = [self.datasource numOfColumn];
    }else{
        ret = 1;
    }
    return ret;
    
}
-(void) reloadData{
    _openSectionIndex = NSNotFound;
    [self.interTable reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.datasource heightForRow];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.datasource heightForHeader];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.datasource numOfTop];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YKDataMoudleList *sectionInfo = [self changeSubFromDatasourceItemsAtRow:section];
    assert(sectionInfo);
    NSInteger numStoriesInSection  = 0;
    numStoriesInSection = [[sectionInfo subArray] count];
//    CGFloat to = ceilf((CGFloat)numStoriesInSection/[self numberOfLie]) ;
//    CLog(@"toto:%d,%f,%d",numStoriesInSection,to,[self numberOfLie]);
    numStoriesInSection = [sectionInfo open] ? (NSInteger)ceilf((CGFloat)numStoriesInSection/[self numberOfColumn]) : 0;
//    CLog(@"numStoriesInSection::%d,:%d",numStoriesInSection,[self numberOfColumn]);
    return numStoriesInSection;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *idfi = @"YKTableViewCellForGategory";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfi];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idfi] autorelease];
        int width = self.bounds.size.width/self.numberOfColumn;
        for (int i=0; i<self.numberOfColumn; ++i) {
            UIButton *addB = [UIButton buttonWithType:UIButtonTypeCustom];
            addB.frame = CGRectMake(i*width, 0, width, 40);
            [addB addTarget:self action:@selector(delegateAction:) forControlEvents:UIControlEventTouchUpInside];
            addB.tag = 2013+i;
            [addB setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cell addSubview:addB];
        }
        cell.backgroundView = nil;
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_zhankai.png"]];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    YKDataMoudleList *list = [self changeSubFromDatasourceItemsAtRow:indexPath.section];
    assert(list);
    assert([list isKindOfClass:[YKDataMoudleList class] ]);
    for (int i=0; i<self.numberOfColumn; ++i) {
        UIButton *formB = (UIButton *)[cell viewWithTag:2013+i];
        int getN = indexPath.row*self.numberOfColumn+i;
        if (getN>=list.subArray.count) {
            formB.hidden = YES;
        }else{
            formB.hidden = NO;
            assert([formB isKindOfClass:[UIButton class]]);
            [formB setTitle:list.subArray[getN] forState:UIControlStateNormal];
        }
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  YKDataMoudleList *mod =   [self changeSubFromDatasourceItemsAtRow:section];
    if (!mod.headerView_cate) {
        mod.headerView_cate = [[[YKSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 70) title:[self.datasource titleAtTopRow:section] subTitle:[self.datasource subTitleAtTopRow:section] imageUrl:nil section:section delegate:self] autorelease];
    }
    assert(mod.headerView_cate);
    return mod.headerView_cate;
}

- (NSIndexPath *)fixIndex:(NSIndexPath *)_index fromButton:(UIButton *)_orgButton{
    int section = _index.section;
    int row = _index.row;
    row = (_orgButton.tag-2013)+row*self.numberOfColumn;
    
    return [NSIndexPath indexPathForRow:row inSection:section];
}
- (void)delegateAction:(UIButton*)sender{

    assert([sender.superview isKindOfClass:[UITableViewCell class]]);
    UITableViewCell *cell = (UITableViewCell*)sender.superview;
    NSIndexPath *index =  [self.interTable indexPathForCell:cell];
    [self.delegate headerDetailList:self didTapItemAtIndex:[self fixIndex:index fromButton:sender]];
}
#pragma mark Section header delegate
- (int)get_OpenSectionIndex{
    return _openSectionIndex;
}
- (YKDataMoudleList  *)changeSubFromDatasourceItemsAtRow:(int)row{
    
  YKDataMoudleList *dataMoudle  =   [self.sectionInfoDic objectForKey:[NSString stringWithFormat:@"%d",row]];


    if (!dataMoudle) {
        NSArray *ret = [self.datasource itemsAtRow:row];
        YKDataMoudleList *dataMoudle = [[YKDataMoudleList alloc] init];
        dataMoudle.subArray = ret;
        dataMoudle.open = NO;
        assert(dataMoudle);
        [self.sectionInfoDic setObject:dataMoudle forKey:[NSString stringWithFormat:@"%d",row]];
        [dataMoudle release];
    }
    
    return  [self.sectionInfoDic objectForKey:[NSString stringWithFormat:@"%d",row]];
}
-(void)sectionHeaderView:(YKSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	
    YKDataMoudleList *subdata = [self changeSubFromDatasourceItemsAtRow:sectionOpened];
    assert(subdata);
    assert([subdata isKindOfClass:[YKDataMoudleList class] ]);

	subdata.open = YES;
    NSInteger countOfRowsToInsert = (NSInteger)ceilf((CGFloat)[subdata.subArray count]/self.numberOfColumn);
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    CLog(@"indexPathsToInsert:%d",countOfRowsToInsert);
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
		
		YKDataMoudleList *previousOpenSection = [self changeSubFromDatasourceItemsAtRow:previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView_cate toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = (NSInteger)ceilf((CGFloat)[previousOpenSection.subArray count]/self.numberOfColumn);
        CLog(@"countOfRowsToDelete:%d",countOfRowsToDelete);
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    [self.interTable beginUpdates];
    [self.interTable insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.interTable deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.interTable endUpdates];
    [indexPathsToDelete release];
    [indexPathsToInsert release];
    
    
    self.openSectionIndex = sectionOpened;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"_openSectionIndex" object:nil];
    if ([self.interTable numberOfRowsInSection:_openSectionIndex]>0) {
        [self.interTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_openSectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


-(void)sectionHeaderView:(YKSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	YKDataMoudleList *sectionInfo = [self changeSubFromDatasourceItemsAtRow:sectionClosed];
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.interTable numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.interTable deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
        [indexPathsToDelete release];
    }
    self.openSectionIndex = NSNotFound;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"_openSectionIndex" object:nil];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self reloadData];
}


@end
