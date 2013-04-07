//
//  YKViewController.m
//  Category
//
//  Created by  yanguo.sun on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKViewController.h"

#import "YKSubViewController.h"

@interface YKViewController ()

@end

@implementation YKViewController

- (CGFloat)heightForHeader{
    return 70;
}
- (CGFloat)heightForRow{
    return 40;
}
- (int)numOfTop{
    return self.dataSource.count;
}
- (NSString *)titleAtTopRow:(int)row{
    return [NSString stringWithFormat:@"title:%@",self.dataSource[row]];
}
- (NSString *)subTitleAtTopRow:(int)row{
    return [NSString stringWithFormat:@"subTitle:%@",self.dataSource[row]];
;
}
- (NSArray*)itemsAtRow:(int)row{
    return @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
}

- (NSInteger)numOfColumn{
    return 3;
}
- (void)headerDetailList:(YKHeaderDetailListView *)_headerList didTapItemAtIndex:(NSIndexPath *)_index{
    NSLog(@"didTapItemAtRow:%@",_index);
    YKSubViewController *sub = [[YKSubViewController alloc] initWithNibName:@"YKSubViewController" bundle:nil];
    sub.threeCateArray = @[@"11",@"22",@"33",@"44"];
    sub.title = [NSString stringWithFormat:@"%d:%d",_index.section,_index.row];
    [self.navigationController pushViewController:sub animated:YES];
    [sub release];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    YKHeaderDetailListView *header = [[YKHeaderDetailListView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-46)];
    header.datasource = self;
    header.delegate = self;
    [self.view addSubview:header];
//    [header reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
