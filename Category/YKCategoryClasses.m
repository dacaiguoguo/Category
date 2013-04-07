//
//  YKCategoryClasses.m
//  Category
//
//  Created by  yanguo.sun on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKCategoryClasses.h"
#import <QuartzCore/QuartzCore.h>
#define WantUpLine 0
@implementation YKDataMoudleList
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}
- (NSString *)description{
    return  [NSString stringWithFormat:@"dd:%@",self.open?@"YES":@"NO"];
    
}

@end
@implementation YKSectionHeaderView


@synthesize titleLabel=_titleLabel, subTitleLabel=_subTitleLabel,iconImage=_iconImage, delegate=_delegate, section=_section,lineLabel = _lineLabel,lineImage = _lineImage,disclosureButton = _disclosureButton;

- (void)dealloc{
    [_titleLabel release];
    [_subTitleLabel release];
    [_iconImage release];
    _delegate = nil;
    [_lineLabel release];
    [super dealloc];
    
}

-(id)initWithFrame:(CGRect)frame title:(NSString*)title subTitle:(NSString*)subTitle imageUrl:(NSString *)imgaeUrl section:(NSInteger)sectionNumber delegate:(id <YKSectionHeaderViewDelegate>)delegate {
    
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        
        // Set up the tap gesture recognizer.
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
        [self addGestureRecognizer:tapGesture];
        
        _delegate = delegate;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:249.0/255 green:247.0/255 blue:242.0/255 alpha:1.0];
        self.opaque = YES;
        
        // Create and configure the title label.
        _section = sectionNumber;
        CGRect titleLabelFrame = self.bounds;
        //add up line
        CGRect lineRect = titleLabelFrame;
        lineRect.origin.y = 0;
        lineRect.size.height = 1;
        UIImageView *line = [[UIImageView alloc] initWithFrame:lineRect];
        line.image = [UIImage imageNamed:@"fenlei_bg_line"];
        [self addSubview:line];
        _lineImage = line;
        
        UILabel *lineLabelt = [[UILabel alloc] initWithFrame:lineRect];
        lineLabelt.backgroundColor = [UIColor lightGrayColor];
        lineLabelt.hidden = YES;
        [self addSubview:lineLabelt];
        _lineLabel = lineLabelt;
        
        titleLabelFrame.origin.x += 70;
        titleLabelFrame.size.width -= 70;
        titleLabelFrame.size.height-=20;
        CGRectInset(titleLabelFrame, 0.0, 5.0);
        UILabel *label = [[UILabel alloc] initWithFrame:titleLabelFrame];
        label.text = title;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        _titleLabel = label;
        titleLabelFrame.origin.y+=20;
        UILabel *subLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
        subLabel.text = subTitle;
        subLabel.font = [UIFont systemFontOfSize:12];
        subLabel.textColor = [UIColor blackColor];
        subLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:subLabel];
        
        _subTitleLabel = subLabel;
        
        
        // Create and configure the disclosure button.
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10.0, 8.0, 54.0, 54.0);
//        [YKImage queueLoadImageFromUrl:imgaeUrl imageView:button defaultImage:[UIImage imageNamed:@"vancl.png"]];
        imageView.image = [UIImage imageNamed:@"moo.png"];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        _iconImage = imageView;
        
        
        // Create and configure the disclosure button.
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(260, 8.0, 54, 54);
        [button setImage:[UIImage imageNamed:@"carat.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"carat-open.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(toggleOpen:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _disclosureButton = button;
        if (WantUpLine) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUpLineChange:) name:@"_openSectionIndex" object:nil];
        }else{
            
        }
    }
    
    return self;
}


-(IBAction)toggleOpen:(id)sender {
    
    [self toggleOpenWithUserAction:YES];
}
- (void)setUpLineChange:(BOOL)change{
    if ([self.delegate get_OpenSectionIndex]+1==_section) {
        _lineLabel.hidden = NO;
        _lineImage.hidden = YES;
    }else{
        CLog(@"%d:%d",[self.delegate get_OpenSectionIndex]+1,_section);
        _lineLabel.hidden = YES;
        _lineImage.hidden = NO;
    }
    
}

-(void)toggleOpenWithUserAction:(BOOL)userAction {
    
    // Toggle the disclosure button state.
    self.iselected = !self.iselected;
    self.disclosureButton.selected = !self.disclosureButton.selected;
    // If this was a user action, send the delegate the appropriate message.
    if (userAction) {
        if (self.iselected) {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
                [self.delegate sectionHeaderView:self sectionOpened:self.section];
            }
        }
        else {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
                [self.delegate sectionHeaderView:self sectionClosed:self.section];
            }
        }
    }
}



@end


@implementation YKButtonForGategory


- (void)dealloc{
//    [_aCategory release];
    [super dealloc];
}


@end
@implementation YKTableViewCellForGategory

- (void)dealloc{
    [_leftGategory release];
    [_rightGategory release];
    [_leftLabel release];
    [_rightLabel release];
    [super dealloc];
}

@end