//
//  ViewController.m
//  DDTabControl
//
//  Created by bright on 14/11/26.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "ViewController.h"
#import "DDTabControl.h"
#import "DDPagedScrollView.h"
#import "UIColor+Random.h"


@interface DDPageView: UIView
@property (nonatomic,strong) UILabel *label;
@end

@implementation DDPageView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor randomColor];
        _label.textAlignment = NSTextAlignmentCenter;
        
        _label.font = [UIFont boldSystemFontOfSize:50];
        
        [self addSubview:_label];
    }
    return self;
}

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface ViewController ()<DDPagedScrollViewDelegate>
{
    DDPagedScrollView *scrollView;
    DDTabControl      *tabControl;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.title = @"App Store";
    
    self.view.backgroundColor = [UIColor whiteColor];
    tabControl = [[DDTabControl alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    [self.view addSubview:tabControl];
    

    tabControl.itemTitles = @[@"All Categorys",@"Books",
                              @"Business",@"Catalogs",@"Education",
                              @"Enterainment",@"Finance",@"Food & Drink",
                              @"Games",@"Health & Fitness",
                              @"Kids",@"Lifestyle",@"Sports"];
    
    tabControl.backgroundColor = [UIColor lightGrayColor];
    [tabControl addTarget:self action:@selector(controlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    scrollView = [[DDPagedScrollView alloc] initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height - 108)];
    scrollView.delegate = self;
    scrollView.continuous = NO;
    [self.view addSubview:scrollView];
    
    [scrollView setCurrentPage:2];
}

- (NSUInteger)numberOfPagesInPagedView:(DDPagedScrollView *)pagedView{
    return [tabControl.itemTitles count];
}

- (UIView *)pagedView:(DDPagedScrollView *)pagedView viewForPageAtIndex:(NSUInteger)index{
    
    DDPageView *_page = (DDPageView *) [pagedView dequeueReusableViewWithTag:0];
    if (!_page) {
        _page = [[DDPageView alloc] initWithFrame:pagedView.frame];
        _page.userInteractionEnabled = YES;
        _page.backgroundColor = [UIColor randomColor];
    }

    _page.label.text = tabControl.itemTitles[index];
    return _page;
}

- (void)pagedView:(DDPagedScrollView *)pagedView didScrollToPageAtIndex:(NSUInteger)index{
    tabControl.selectedIndex = index;
}

-(void)controlValueChanged:(DDTabControl *)sender{

    NSLog(@"selectedIndex = %ld",sender.selectedIndex);
    [scrollView setCurrentPage:sender.selectedIndex];
    
}

@end
