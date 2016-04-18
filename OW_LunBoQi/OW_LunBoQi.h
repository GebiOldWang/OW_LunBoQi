//
//  OW_LunBoQi.h
//  OW_LunBoQiExcenple
//
//  Created by 上海银来（集团）有限公司 on 16/4/18.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBlock)(NSInteger index) ;

@interface OW_LunBoQi : UIView

+ (instancetype)ow_turnImage;

/** 图片名字 */
@property (nonatomic, strong) NSArray *ow_imageNames;
/** 其他圆点颜色 */
@property (nonatomic, strong) UIColor *ow_otherColor;
/** 当前圆点颜色 */
@property (nonatomic, strong) UIColor *ow_currentColor;

//@property (nonatomic, copy) void (^ClickBlock)(NSInteger index);
@property (nonatomic, copy) ClickBlock block;

- (void)ow_loadDataSource:(NSArray *)imageArray ClickImg:(ClickBlock)block;

@end
