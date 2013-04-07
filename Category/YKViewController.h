//
//  YKViewController.h
//  Category
//
//  Created by  yanguo.sun on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKHeaderDetailListView.h"
@interface YKViewController : UIViewController<YKHeaderDetailListViewDataSource,YKHeaderDetailListViewDelegate>
@property (nonatomic, retain) NSArray *dataSource;

@end
