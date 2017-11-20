//
//  XRWaterfallLayout.h
//  启示页
//
//  Created by slcf888 on 2017/8/29.
//  Copyright © 2017年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XRWaterfallLayout;

@protocol XRWaterfallLayoutDelegate <NSObject>

@required

-(CGFloat)waterfallLayout:(XRWaterfallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *) indexpath;

@end


@interface XRWaterfallLayout : UICollectionViewLayout

#pragma mark - 属性
//列数
@property(nonatomic,assign)NSInteger columnCount;
//间距数
@property(nonatomic,assign)NSInteger columnSpacing;

@property(nonatomic,assign)NSInteger rowSpacing;

@property(nonatomic,assign)UIEdgeInsets sectionInset;

-(void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger) rowSpacing sectionInset:(UIEdgeInsets)sectionInset;




@property(nonatomic,weak) id<XRWaterfallLayoutDelegate>delegate;


@property(nonatomic,strong)CGFloat(^itemHeightBlock)(CGFloat itemHeight,NSIndexPath *indexpath);

#pragma mark- 构造方法
+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount;
- (instancetype)initWithColumnCount:(NSInteger)columnCount;

@end
