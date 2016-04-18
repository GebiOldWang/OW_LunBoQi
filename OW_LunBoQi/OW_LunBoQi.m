//
//  OW_LunBoQi.m
//  OW_LunBoQiExcenple
//
//  Created by 上海银来（集团）有限公司 on 16/4/18.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define Frame [UIScreen mainScreen].bounds

#import "OW_LunBoQi.h"

@interface OW_LunBoQi ()<UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation OW_LunBoQi

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        // 添加子控件代码
        self.pageControl = [[UIPageControl alloc] init];
        [self addSubview:self.pageControl];
    }
    return self;
}
/**
 * 初始化代码
 */
- (void)setup
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor redColor];
    [self addSubview:self.scrollView];
    
    // 开启定时器
    [self startTimer];
}

+ (instancetype)ow_turnImage
{
    return [[self alloc]initWithFrame:CGRectMake(0, 0, Frame.size.width, Frame.size.width/3)];
}
/**
 * 当控件的尺寸发生改变的时候，会自动调用这个方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置scrollView的frame
    self.scrollView.frame = self.bounds;
    
    // 获得scrollview的尺寸
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat scrollH = self.scrollView.frame.size.height;
    
    // 设置pageControl
    CGFloat pageW = 100;
    CGFloat pageH = 20;
    CGFloat pageX = (scrollW - pageW)/2;
    CGFloat pageY = scrollH - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    // 设置内容大小
    self.scrollView.contentSize = CGSizeMake(self.ow_imageNames.count * scrollW, 0);
    
    // 设置所有imageView的frame
    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        imageView.frame = CGRectMake(i * scrollW, 0, scrollW, scrollH);
    }
}

- (void)ow_loadDataSource:(NSArray *)imageNames ClickImg:(ClickBlock)block
{
    self.block = block;
    
    _ow_imageNames = imageNames;
    
    // 移除之前的所有imageView
    // 让subviews数组中的所有对象都执行removeFromSuperview方法
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 根据图片名创建对应个数的imageView
    for (int i = 0; i<imageNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageNames[i]];
        
        [self.scrollView addSubview:imageView];
        [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)]];
    }
    // 设置总页数
    self.pageControl.numberOfPages = imageNames.count;
}

- (void)clickImage:(UIGestureRecognizer *)gesture {
    if (self.block != nil) {
        self.block(self.pageControl.currentPage);
    }
}

- (void)setCurrentColor:(UIColor *)currentColor
{
    _ow_currentColor = currentColor;
    
    self.pageControl.currentPageIndicatorTintColor = currentColor;
}

- (void)setOtherColor:(UIColor *)otherColor
{
    _ow_otherColor = otherColor;
    
    self.pageControl.pageIndicatorTintColor = otherColor;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark - 定时器控制
- (void)startTimer
{
    // 创建一个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

/**
 * 下一页
 */
- (void)nextPage
{
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == self.pageControl.numberOfPages) {
        page = 0;
    }
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
}


@end
